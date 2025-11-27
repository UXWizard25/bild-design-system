#!/usr/bin/env node

/**
 * Release Notes Generator v2
 *
 * Generates layered release notes with progressive disclosure:
 * - Layer 1: Executive Summary (5 second scan)
 * - Layer 2: Change Categories (30 second scan)
 * - Layer 3: Detailed Changes (2 minute review)
 * - Layer 4: Technical Details (on demand)
 *
 * Usage:
 *   node scripts/generate-release-notes.js \
 *     --diff-file token-diff.json \
 *     --commit-sha "abc1234" \
 *     --build-success true \
 *     --successful-builds 969 \
 *     --total-builds 969 \
 *     --run-id 12345678
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// ============================================================================
// CONFIGURATION
// ============================================================================

const DIST_DIR = path.join(__dirname, '../dist');
const SOURCE_PATH = path.join(__dirname, '../src/design-tokens/bild-design-system-raw-data.json');

// ============================================================================
// UTILITIES
// ============================================================================

function exec(command) {
  try {
    return execSync(command, { encoding: 'utf8' }).trim();
  } catch (error) {
    return '';
  }
}

function countFiles(pattern) {
  const result = exec(`find ${DIST_DIR} -name '${pattern}' 2>/dev/null | wc -l`);
  return parseInt(result) || 0;
}

function getDirSize(dir) {
  try {
    const result = exec(`du -sh ${dir} 2>/dev/null | cut -f1`);
    return result || '0';
  } catch (error) {
    return '0';
  }
}

function tableRow(...cells) {
  return `| ${cells.join(' | ')} |`;
}

function loadDiffFile(diffFilePath) {
  try {
    if (fs.existsSync(diffFilePath)) {
      return JSON.parse(fs.readFileSync(diffFilePath, 'utf8'));
    }
  } catch (error) {
    console.warn(`Warning: Could not load diff file: ${error.message}`);
  }
  return null;
}

// ============================================================================
// LAYER 1: EXECUTIVE SUMMARY
// ============================================================================

function generateExecutiveSummary(diff, options) {
  const { commitSha, buildSuccess, successfulBuilds, totalBuilds } = options;
  const timestamp = new Date().toISOString().replace('T', ' ').substring(0, 16) + ' UTC';

  if (!diff) {
    return `# 🎨 Design Token Update

**Status**: ${buildSuccess ? '✅ Build Successful' : '❌ Build Failed'} (${successfulBuilds}/${totalBuilds})
**Commit**: \`${commitSha}\`
**Date**: ${timestamp}

> ℹ️ Token-Diff nicht verfügbar. Details siehe Build-Statistiken unten.

---
`;
  }

  const { impact, counts } = diff.summary;
  const changesSummary = [];
  if (counts.added > 0) changesSummary.push(`+${counts.added}`);
  if (counts.modified > 0) changesSummary.push(`~${counts.modified}`);
  if (counts.deleted > 0) changesSummary.push(`-${counts.deleted}`);

  let markdown = `# ${impact.emoji} ${impact.label}

`;

  // Breaking changes warning
  if (impact.level === 'breaking') {
    markdown += `> ⚠️ **Achtung:** ${impact.reason}. Migration erforderlich!

`;
  }

  markdown += `**${changesSummary.join(' | ')} Tokens** | `;
  markdown += `${buildSuccess ? '✅' : '❌'} Build (${successfulBuilds}/${totalBuilds}) | `;
  markdown += `\`${commitSha}\`

---
`;

  return markdown;
}

// ============================================================================
// LAYER 2: CHANGE CATEGORIES
// ============================================================================

function generateCategoryOverview(diff) {
  if (!diff) return '';

  const { byCategory, byBrand } = diff;

  let markdown = `## 📊 Änderungen nach Kategorie

`;

  // Category table
  const categoriesWithChanges = Object.entries(byCategory)
    .filter(([_, data]) => data.total > 0)
    .sort((a, b) => b[1].total - a[1].total);

  if (categoriesWithChanges.length === 0) {
    markdown += `Keine Token-Änderungen erkannt.

`;
    return markdown;
  }

  markdown += `${tableRow('Kategorie', 'Hinzugefügt', 'Modifiziert', 'Entfernt')}
${tableRow(':-------', ':----------:', ':----------:', ':-------:')}
`;

  for (const [category, data] of categoriesWithChanges) {
    const added = data.added.length > 0 ? `+${data.added.length}` : '-';
    const modified = data.modified.length > 0 ? `~${data.modified.length}` : '-';
    const deleted = data.deleted.length > 0 ? `-${data.deleted.length}` : '-';

    markdown += `${tableRow(`${data.icon} ${data.label}`, added, modified, deleted)}
`;
  }

  // Brand summary
  const brandsWithChanges = Object.entries(byBrand)
    .filter(([_, data]) => data.total > 0)
    .map(([brand, data]) => `${brand} (${data.total})`)
    .join(', ');

  if (brandsWithChanges) {
    markdown += `
**Betroffene Brands:** ${brandsWithChanges}
`;
  }

  // Mode summary
  if (diff.byMode) {
    const modesWithChanges = Object.entries(diff.byMode)
      .filter(([_, data]) => data.total > 0)
      .map(([mode, data]) => `${mode} (${data.total})`)
      .join(', ');

    if (modesWithChanges) {
      markdown += `**Betroffene Modes:** ${modesWithChanges}
`;
    }
  }

  markdown += `
---
`;

  return markdown;
}

// ============================================================================
// LAYER 3: DETAILED CHANGES
// ============================================================================

function generateDetailedChanges(diff) {
  if (!diff) return '';

  let markdown = `## 📝 Detaillierte Änderungen

`;

  const { byCategory, breakingChanges, colorPreview } = diff;

  // Breaking changes first (if any)
  if (breakingChanges && breakingChanges.deleted.length > 0) {
    markdown += `<details>
<summary>⚠️ <b>Breaking Changes</b> (${breakingChanges.deleted.length} Tokens entfernt)</summary>

> Diese Tokens wurden entfernt. Bitte prüfe deine Codebase auf Verwendung.

${tableRow('Token', 'Typ', 'Brand')}
${tableRow(':----', ':--', ':----')}
`;

    for (const token of breakingChanges.deleted.slice(0, 20)) {
      markdown += `${tableRow(`\`${token.tokenPath}\``, token.type || '-', token.brand || '-')}
`;
    }

    if (breakingChanges.deleted.length > 20) {
      markdown += `
*... und ${breakingChanges.deleted.length - 20} weitere*
`;
    }

    markdown += `
</details>

`;
  }

  // Color changes with preview
  if (colorPreview && colorPreview.length > 0) {
    markdown += `<details>
<summary>🎨 <b>Farb-Änderungen</b> (${colorPreview.length})</summary>

${tableRow('Token', 'Vorher', 'Nachher', 'Mode')}
${tableRow(':----', ':-----', ':------', ':---')}
`;

    for (const color of colorPreview) {
      markdown += `${tableRow(`\`${color.name}\``, `\`${color.oldValue}\``, `\`${color.newValue}\``, color.mode)}
`;
    }

    markdown += `
</details>

`;
  }

  // Other categories
  for (const [category, data] of Object.entries(byCategory)) {
    if (category === 'color' || data.total === 0) continue;

    const hasDetails = data.modified.length > 0 || data.added.length > 0;
    if (!hasDetails) continue;

    markdown += `<details>
<summary>${data.icon} <b>${data.label}</b> (+${data.added.length} | ~${data.modified.length})</summary>

`;

    // Added tokens
    if (data.added.length > 0) {
      markdown += `**Neue Tokens:**
`;
      for (const token of data.added.slice(0, 10)) {
        markdown += `- \`${token.tokenPath}\`: \`${formatValue(token.value)}\`
`;
      }
      if (data.added.length > 10) {
        markdown += `- *... und ${data.added.length - 10} weitere*
`;
      }
      markdown += `
`;
    }

    // Modified tokens
    if (data.modified.length > 0) {
      markdown += `**Geänderte Tokens:**

${tableRow('Token', 'Vorher', 'Nachher')}
${tableRow(':----', ':-----', ':------')}
`;
      for (const token of data.modified.slice(0, 10)) {
        markdown += `${tableRow(`\`${token.tokenPath}\``, `\`${formatValue(token.oldValue)}\``, `\`${formatValue(token.newValue)}\``)}
`;
      }
      if (data.modified.length > 10) {
        markdown += `
*... und ${data.modified.length - 10} weitere*
`;
      }
    }

    markdown += `
</details>

`;
  }

  markdown += `---
`;

  return markdown;
}

function formatValue(value) {
  if (value === null || value === undefined) return 'null';
  if (typeof value === 'object') return JSON.stringify(value);
  const str = String(value);
  return str.length > 30 ? str.substring(0, 27) + '...' : str;
}

// ============================================================================
// LAYER 4: TECHNICAL DETAILS
// ============================================================================

function generateTechnicalDetails(options, diff) {
  const { runId, successfulBuilds, totalBuilds } = options;
  const repo = process.env.GITHUB_REPOSITORY || options.repository || 'UXWizard25/vv-token-test-v3';

  const platforms = [
    { name: 'CSS', pattern: '*.css' },
    { name: 'SCSS', pattern: '*.scss' },
    { name: 'JavaScript', pattern: '*.js' },
    { name: 'JSON', pattern: '*.json' },
    { name: 'iOS Swift', pattern: '*.swift' },
    { name: 'Android XML', pattern: '*.xml' },
    { name: 'Flutter Dart', pattern: '*.dart' }
  ];

  let markdown = `<details>
<summary>⚙️ <b>Build & Pipeline Details</b></summary>

### 📦 Build Output

${tableRow('Platform', 'Files', 'Size')}
${tableRow(':-------', '----:', ':---')}
`;

  let totalFiles = 0;
  for (const platform of platforms) {
    const files = countFiles(platform.pattern);
    totalFiles += files;
    if (files > 0) {
      markdown += `${tableRow(`**${platform.name}**`, files, '-')}
`;
    }
  }

  markdown += `${tableRow('**Total**', totalFiles, getDirSize(DIST_DIR))}

### 📥 Downloads

`;

  if (runId) {
    markdown += `- ⬇️ [**Build Artifacts herunterladen**](https://github.com/${repo}/actions/runs/${runId})
`;
  }

  markdown += `- 📄 [Source-Änderungen anzeigen](https://github.com/${repo}/compare/main...figma-tokens)

### 🔧 Pipeline Info

- **Node.js**: 20.x
- **Style Dictionary**: 4.x
- **Platforms**: ${platforms.filter(p => countFiles(p.pattern) > 0).length}/7
- **Total Files**: ${totalFiles}
- **Artifact Retention**: 30 Tage

</details>

`;

  return markdown;
}

// ============================================================================
// AFTER MERGE INFO
// ============================================================================

function generateAfterMergeInfo() {
  return `<details>
<summary>🚀 <b>Was passiert nach dem Merge?</b></summary>

1. ✅ **Fresh Build** — Tokens werden neu gebaut
2. 📦 **Version Bump** — Automatische Patch-Version
3. 📤 **NPM Publish** — Package wird veröffentlicht
4. 🏷️ **GitHub Release** — Tag mit Release Notes

</details>

`;
}

// ============================================================================
// QUICK ACTIONS
// ============================================================================

function generateQuickActions(diff) {
  const hasBreaking = diff?.breakingChanges?.deleted?.length > 0;

  let markdown = `## ⚡ Review Checklist

`;

  if (hasBreaking) {
    markdown += `- [ ] ⚠️ Breaking Changes geprüft
- [ ] Migration-Plan erstellt
`;
  }

  markdown += `- [ ] Token-Änderungen geprüft
- [ ] Betroffene Komponenten identifiziert
`;

  if (diff?.summary?.counts?.modified > 0) {
    markdown += `- [ ] Visuelle Änderungen validiert
`;
  }

  markdown += `
---
`;

  return markdown;
}

// ============================================================================
// MAIN GENERATOR
// ============================================================================

function generateReleaseNotes(options = {}) {
  const {
    diffFile,
    commitSha = exec('git rev-parse HEAD').substring(0, 7),
    buildSuccess = true,
    successfulBuilds = 969,
    totalBuilds = 969,
    runId = ''
  } = options;

  // Load diff if available
  const diff = diffFile ? loadDiffFile(diffFile) : null;

  let markdown = '';

  // Layer 1: Executive Summary
  markdown += generateExecutiveSummary(diff, {
    commitSha,
    buildSuccess,
    successfulBuilds,
    totalBuilds
  });

  // Layer 2: Category Overview
  markdown += generateCategoryOverview(diff);

  // Layer 3: Detailed Changes
  markdown += generateDetailedChanges(diff);

  // Quick Actions / Checklist
  markdown += generateQuickActions(diff);

  // Layer 4: Technical Details (collapsed)
  markdown += generateTechnicalDetails({ runId, successfulBuilds, totalBuilds }, diff);

  // After Merge Info (collapsed)
  markdown += generateAfterMergeInfo();

  // Footer
  const repo = process.env.GITHUB_REPOSITORY || options.repository || 'UXWizard25/vv-token-test-v3';
  markdown += `---

**Fragen?** [Troubleshooting Guide](https://github.com/${repo}#-troubleshooting) | [Issue erstellen](https://github.com/${repo}/issues)
`;

  return markdown;
}

// ============================================================================
// CLI
// ============================================================================

if (require.main === module) {
  const args = process.argv.slice(2);
  const options = {};

  for (let i = 0; i < args.length; i += 2) {
    const key = args[i]?.replace('--', '').replace(/-/g, '_');
    const value = args[i + 1];

    if (!key || value === undefined) continue;

    if (key === 'successful_builds' || key === 'total_builds') {
      options[key === 'successful_builds' ? 'successfulBuilds' : 'totalBuilds'] = parseInt(value);
    } else if (key === 'build_success') {
      options.buildSuccess = value === 'true';
    } else if (key === 'diff_file') {
      options.diffFile = value;
    } else if (key === 'commit_sha') {
      options.commitSha = value;
    } else if (key === 'run_id') {
      options.runId = value;
    } else {
      options[key] = value;
    }
  }

  const markdown = generateReleaseNotes(options);
  console.log(markdown);
}

module.exports = { generateReleaseNotes };
