#!/usr/bin/env node

/**
 * Compare Token Builds
 *
 * Compares two built token directories (old vs new) and generates
 * a detailed diff report with categorization and impact analysis.
 *
 * Usage:
 *   node scripts/compare-token-builds.js \
 *     --old tokens-old/ \
 *     --new tokens/ \
 *     --output token-diff.json
 */

const fs = require('fs');
const path = require('path');

// ============================================================================
// CONFIGURATION
// ============================================================================

const TOKEN_CATEGORIES = {
  color: { icon: '🎨', label: 'Colors', patterns: [/color/i, /fill/i, /stroke/i, /background/i, /border.*color/i] },
  typography: { icon: '🔤', label: 'Typography', patterns: [/font/i, /text/i, /typography/i, /letter/i, /line.*height/i] },
  spacing: { icon: '📐', label: 'Spacing', patterns: [/space/i, /gap/i, /padding/i, /margin/i] },
  sizing: { icon: '📏', label: 'Sizing', patterns: [/size/i, /width/i, /height/i, /radius/i] },
  effects: { icon: '✨', label: 'Effects', patterns: [/shadow/i, /blur/i, /effect/i, /elevation/i] },
  opacity: { icon: '🌫️', label: 'Opacity', patterns: [/opacity/i, /alpha/i] },
  other: { icon: '🔹', label: 'Other', patterns: [] }
};

const BRANDS = ['bild', 'sportbild', 'advertorial', 'shared'];

// ============================================================================
// FILE UTILITIES
// ============================================================================

/**
 * Recursively find all JSON files in a directory
 */
function findJsonFiles(dir, files = []) {
  if (!fs.existsSync(dir)) {
    return files;
  }

  const entries = fs.readdirSync(dir, { withFileTypes: true });

  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);

    if (entry.isDirectory()) {
      findJsonFiles(fullPath, files);
    } else if (entry.name.endsWith('.json')) {
      files.push(fullPath);
    }
  }

  return files;
}

/**
 * Get relative path from base directory
 */
function getRelativePath(filePath, baseDir) {
  return path.relative(baseDir, filePath);
}

/**
 * Extract brand from file path
 */
function extractBrand(filePath) {
  const lowerPath = filePath.toLowerCase();

  if (lowerPath.includes('/shared/')) return 'shared';
  if (lowerPath.includes('/bild/') && !lowerPath.includes('/sportbild/')) return 'bild';
  if (lowerPath.includes('/sportbild/')) return 'sportbild';
  if (lowerPath.includes('/advertorial/')) return 'advertorial';

  return 'shared';
}

/**
 * Extract mode from file path (light/dark, breakpoint, etc.)
 */
function extractMode(filePath) {
  const fileName = path.basename(filePath, '.json').toLowerCase();

  if (fileName.includes('light')) return 'light';
  if (fileName.includes('dark')) return 'dark';
  if (fileName.includes('-xs')) return 'xs';
  if (fileName.includes('-sm')) return 'sm';
  if (fileName.includes('-md')) return 'md';
  if (fileName.includes('-lg')) return 'lg';

  return 'default';
}

/**
 * Extract component name from file path
 */
function extractComponent(filePath) {
  const match = filePath.match(/components\/([^/]+)\//i);
  return match ? match[1] : null;
}

// ============================================================================
// TOKEN PARSING
// ============================================================================

/**
 * Flatten nested token structure into a flat map
 */
function flattenTokens(obj, prefix = '', result = {}) {
  for (const [key, value] of Object.entries(obj)) {
    const newKey = prefix ? `${prefix}.${key}` : key;

    // Check if this is a token (has $value or value property)
    if (value && typeof value === 'object') {
      if ('$value' in value || 'value' in value) {
        result[newKey] = {
          value: value.$value ?? value.value,
          type: value.$type ?? value.type ?? 'unknown',
          comment: value.comment ?? value.description ?? '',
          variableId: value.$extensions?.['com.figma']?.variableId ?? null
        };
      } else {
        // Recurse into nested structure
        flattenTokens(value, newKey, result);
      }
    }
  }

  return result;
}

/**
 * Load and flatten all tokens from a directory
 */
function loadTokensFromDir(dir) {
  const allTokens = new Map();
  const jsonFiles = findJsonFiles(dir);

  for (const filePath of jsonFiles) {
    try {
      const content = fs.readFileSync(filePath, 'utf8');
      const json = JSON.parse(content);
      const relativePath = getRelativePath(filePath, dir);
      const flatTokens = flattenTokens(json);

      const brand = extractBrand(relativePath);
      const mode = extractMode(relativePath);
      const component = extractComponent(relativePath);

      for (const [tokenPath, tokenData] of Object.entries(flatTokens)) {
        // Create unique key including file context
        const uniqueKey = `${relativePath}::${tokenPath}`;

        allTokens.set(uniqueKey, {
          ...tokenData,
          tokenPath,
          filePath: relativePath,
          brand,
          mode,
          component
        });
      }
    } catch (error) {
      console.warn(`Warning: Could not parse ${filePath}: ${error.message}`);
    }
  }

  return allTokens;
}

// ============================================================================
// CATEGORIZATION
// ============================================================================

/**
 * Determine token category based on path and type
 */
function categorizeToken(tokenPath, tokenType) {
  const lowerPath = tokenPath.toLowerCase();

  // First check by type
  if (tokenType === 'color') return 'color';

  // Then check by path patterns
  for (const [category, config] of Object.entries(TOKEN_CATEGORIES)) {
    if (category === 'other') continue;

    for (const pattern of config.patterns) {
      if (pattern.test(lowerPath)) {
        return category;
      }
    }
  }

  return 'other';
}

/**
 * Format value for display
 */
function formatValue(value) {
  if (value === null || value === undefined) return 'null';
  if (typeof value === 'object') return JSON.stringify(value);
  return String(value);
}

/**
 * Check if two values are equal
 */
function valuesEqual(a, b) {
  if (a === b) return true;
  if (typeof a !== typeof b) return false;
  if (typeof a === 'object') {
    return JSON.stringify(a) === JSON.stringify(b);
  }
  return false;
}

// ============================================================================
// DIFF GENERATION
// ============================================================================

/**
 * Compare two token maps and generate diff
 */
function compareTokenMaps(oldTokens, newTokens) {
  const changes = {
    added: [],
    modified: [],
    deleted: []
  };

  // Find added and modified tokens
  for (const [key, newToken] of newTokens) {
    const oldToken = oldTokens.get(key);

    if (!oldToken) {
      changes.added.push({
        key,
        ...newToken,
        category: categorizeToken(newToken.tokenPath, newToken.type)
      });
    } else if (!valuesEqual(oldToken.value, newToken.value)) {
      changes.modified.push({
        key,
        ...newToken,
        oldValue: oldToken.value,
        newValue: newToken.value,
        category: categorizeToken(newToken.tokenPath, newToken.type)
      });
    }
  }

  // Find deleted tokens
  for (const [key, oldToken] of oldTokens) {
    if (!newTokens.has(key)) {
      changes.deleted.push({
        key,
        ...oldToken,
        category: categorizeToken(oldToken.tokenPath, oldToken.type)
      });
    }
  }

  return changes;
}

/**
 * Calculate impact level based on changes
 */
function calculateImpact(changes) {
  const { added, modified, deleted } = changes;
  const total = added.length + modified.length + deleted.length;

  // Breaking: Tokens deleted
  if (deleted.length > 0) {
    return {
      level: 'breaking',
      emoji: '🔴',
      label: 'Breaking Changes',
      reason: `${deleted.length} Token(s) entfernt`
    };
  }

  // Moderate: Many changes or color/typography changes
  const hasColorChanges = modified.some(c => c.category === 'color');
  const hasTypographyChanges = modified.some(c => c.category === 'typography');

  if (total > 20 || (hasColorChanges && modified.filter(c => c.category === 'color').length > 5)) {
    return {
      level: 'moderate',
      emoji: '🟡',
      label: 'Moderate Update',
      reason: `${total} Änderungen`
    };
  }

  // Minor: Few changes
  if (total === 0) {
    return {
      level: 'none',
      emoji: '⚪',
      label: 'No Changes',
      reason: 'Keine Token-Änderungen erkannt'
    };
  }

  return {
    level: 'minor',
    emoji: '🟢',
    label: 'Minor Update',
    reason: `${total} kleine Änderungen`
  };
}

/**
 * Group changes by category
 */
function groupByCategory(changes) {
  const result = {};

  for (const [category, config] of Object.entries(TOKEN_CATEGORIES)) {
    result[category] = {
      ...config,
      added: changes.added.filter(c => c.category === category),
      modified: changes.modified.filter(c => c.category === category),
      deleted: changes.deleted.filter(c => c.category === category)
    };

    result[category].total =
      result[category].added.length +
      result[category].modified.length +
      result[category].deleted.length;
  }

  return result;
}

/**
 * Group changes by brand
 */
function groupByBrand(changes) {
  const result = {};

  for (const brand of BRANDS) {
    result[brand] = {
      added: changes.added.filter(c => c.brand === brand),
      modified: changes.modified.filter(c => c.brand === brand),
      deleted: changes.deleted.filter(c => c.brand === brand)
    };

    result[brand].total =
      result[brand].added.length +
      result[brand].modified.length +
      result[brand].deleted.length;
  }

  return result;
}

/**
 * Group changes by mode
 */
function groupByMode(changes) {
  const modes = ['light', 'dark', 'xs', 'sm', 'md', 'lg', 'default'];
  const result = {};

  for (const mode of modes) {
    const modeChanges = {
      added: changes.added.filter(c => c.mode === mode),
      modified: changes.modified.filter(c => c.mode === mode),
      deleted: changes.deleted.filter(c => c.mode === mode)
    };

    const total = modeChanges.added.length + modeChanges.modified.length + modeChanges.deleted.length;

    if (total > 0) {
      result[mode] = { ...modeChanges, total };
    }
  }

  return result;
}

/**
 * Extract color changes for visual preview
 */
function extractColorChanges(changes) {
  return changes.modified
    .filter(c => c.category === 'color')
    .map(c => ({
      name: c.tokenPath,
      brand: c.brand,
      mode: c.mode,
      oldValue: formatValue(c.oldValue),
      newValue: formatValue(c.newValue)
    }))
    .slice(0, 20); // Limit for readability
}

/**
 * Generate migration hints for deleted tokens
 */
function generateMigrationHints(deletedTokens) {
  return deletedTokens.map(token => ({
    deleted: token.tokenPath,
    brand: token.brand,
    suggestion: `Prüfe ob ein Ersatz-Token existiert oder entferne die Verwendung`
  }));
}

// ============================================================================
// MAIN
// ============================================================================

function generateDiffReport(oldDir, newDir) {
  console.log(`📂 Loading old tokens from: ${oldDir}`);
  const oldTokens = loadTokensFromDir(oldDir);
  console.log(`   Found ${oldTokens.size} tokens`);

  console.log(`📂 Loading new tokens from: ${newDir}`);
  const newTokens = loadTokensFromDir(newDir);
  console.log(`   Found ${newTokens.size} tokens`);

  console.log(`🔍 Comparing tokens...`);
  const changes = compareTokenMaps(oldTokens, newTokens);

  const report = {
    generatedAt: new Date().toISOString(),

    summary: {
      impact: calculateImpact(changes),
      counts: {
        added: changes.added.length,
        modified: changes.modified.length,
        deleted: changes.deleted.length,
        total: changes.added.length + changes.modified.length + changes.deleted.length
      },
      oldTokenCount: oldTokens.size,
      newTokenCount: newTokens.size
    },

    byCategory: groupByCategory(changes),
    byBrand: groupByBrand(changes),
    byMode: groupByMode(changes),

    breakingChanges: {
      deleted: changes.deleted,
      migrations: generateMigrationHints(changes.deleted)
    },

    colorPreview: extractColorChanges(changes),

    // Detailed changes (limited for file size)
    details: {
      added: changes.added.slice(0, 50),
      modified: changes.modified.slice(0, 50),
      deleted: changes.deleted.slice(0, 50)
    }
  };

  console.log(`\n📊 Summary:`);
  console.log(`   Impact: ${report.summary.impact.emoji} ${report.summary.impact.label}`);
  console.log(`   Added: ${report.summary.counts.added}`);
  console.log(`   Modified: ${report.summary.counts.modified}`);
  console.log(`   Deleted: ${report.summary.counts.deleted}`);

  return report;
}

// CLI
if (require.main === module) {
  const args = process.argv.slice(2);
  const options = {};

  for (let i = 0; i < args.length; i += 2) {
    const key = args[i].replace('--', '');
    options[key] = args[i + 1];
  }

  const oldDir = options.old || 'tokens-old';
  const newDir = options.new || 'tokens';
  const outputFile = options.output || 'token-diff.json';

  if (!fs.existsSync(oldDir)) {
    console.log(`⚠️  Old tokens directory not found: ${oldDir}`);
    console.log(`   Generating empty baseline diff (all tokens are "new")`);

    // Create empty old dir for comparison
    fs.mkdirSync(oldDir, { recursive: true });
  }

  const report = generateDiffReport(oldDir, newDir);

  fs.writeFileSync(outputFile, JSON.stringify(report, null, 2));
  console.log(`\n✅ Diff report saved to: ${outputFile}`);
}

module.exports = { generateDiffReport, loadTokensFromDir, compareTokenMaps };
