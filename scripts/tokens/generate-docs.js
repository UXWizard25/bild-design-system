#!/usr/bin/env node

/**
 * Generate Storybook Documentation from Token JSON
 *
 * This script reads token JSON files and generates MDX documentation
 * that automatically includes all tokens. When new tokens are added
 * in Figma and built, the docs update automatically.
 *
 * Run: node scripts/tokens/generate-docs.js
 */

const fs = require('fs');
const path = require('path');

const TOKENS_DIR = path.join(__dirname, '../../packages/tokens/.tokens');
const DOCS_DIR = path.join(__dirname, '../../packages/components/docs');

/**
 * Convert camelCase token name to kebab-case CSS variable name
 */
function toKebabCase(str) {
  return str
    .replace(/([a-z])(\d)/g, '$1-$2')
    .replace(/(\d)([a-z])/g, '$1-$2')
    .replace(/([a-z])([A-Z])/g, '$1-$2')
    .toLowerCase();
}

/**
 * Generate human-readable name from token key
 */
function toDisplayName(str) {
  return str
    .replace(/([a-z])([A-Z])/g, '$1 $2')
    .replace(/([a-z])(\d)/g, '$1 $2')
    .replace(/(\d)([a-z])/g, '$1 $2')
    .replace(/^./, c => c.toUpperCase());
}

/**
 * Load and parse JSON token file
 */
function loadTokens(filePath) {
  try {
    const content = fs.readFileSync(filePath, 'utf8');
    return JSON.parse(content);
  } catch (error) {
    console.error(`Error loading ${filePath}:`, error.message);
    return null;
  }
}

/**
 * Extract tokens from a category object
 */
function extractTokensFromCategory(category, prefix = '') {
  const tokens = [];

  for (const [key, value] of Object.entries(category)) {
    if (value && typeof value === 'object') {
      // If it has $value, it's a token
      if (value.$value !== undefined || value.value !== undefined) {
        const cssVar = `--${toKebabCase(prefix ? `${prefix}-${key}` : key)}`;
        tokens.push({
          name: key,
          displayName: toDisplayName(key),
          cssVar,
          value: value.$value || value.value,
          comment: value.comment || '',
          alias: value.$alias?.token || null
        });
      } else {
        // It's a nested category, recurse
        tokens.push(...extractTokensFromCategory(value, key));
      }
    }
  }

  return tokens;
}

/**
 * Generate color token table rows
 */
function generateColorTableRows(tokens) {
  return tokens.map(token => {
    const usage = token.comment
      ? token.comment.split('.')[0].replace(/^[A-Z]/, c => c.toLowerCase())
      : toDisplayName(token.name);

    return `    <tr>
      <td><code>${token.cssVar}</code></td>
      <td><span className="color-swatch" style={{background: 'var(${token.cssVar})'}}></span></td>
      <td>${usage}</td>
    </tr>`;
  }).join('\n');
}

/**
 * Generate the colors.mdx documentation
 */
function generateColorsDocs() {
  // Load semantic color tokens
  const lightTokensPath = path.join(TOKENS_DIR, 'brands/bild/color/colormode-light.json');
  const lightTokens = loadTokens(lightTokensPath);

  if (!lightTokens || !lightTokens.Semantic) {
    console.error('Could not load semantic color tokens');
    return null;
  }

  const semantic = lightTokens.Semantic;

  // Load primitive colors
  const primitivePath = path.join(TOKENS_DIR, 'shared/colorprimitive.json');
  const primitives = loadTokens(primitivePath);

  // Build sections dynamically from JSON structure keys
  // Skip internal/documentation-only categories
  const skipCategories = ['TextLabels', 'LayerOpacity'];

  let semanticSections = '';

  // Iterate over all top-level keys in the semantic object
  for (const [categoryKey, categoryValue] of Object.entries(semantic)) {
    if (skipCategories.includes(categoryKey)) continue;
    if (!categoryValue || typeof categoryValue !== 'object') continue;

    const tokens = extractTokensFromCategory(categoryValue);
    if (tokens.length > 0) {
      // Generate human-readable title from key (e.g., "Text" -> "Text Colors")
      const title = `${toDisplayName(categoryKey)} Colors`;

      semanticSections += `
<div className="category-header">${title}</div>

<table className="color-table">
  <thead>
    <tr>
      <th>Token</th>
      <th>Preview</th>
      <th>Usage</th>
    </tr>
  </thead>
  <tbody>
${generateColorTableRows(tokens)}
  </tbody>
</table>
`;
    }
  }

  // Generate primitive color grid dynamically from JSON structure
  let primitiveGrid = '';
  if (primitives) {
    // Helper to extract color tokens from a group
    function extractColorTokensFromGroup(obj) {
      const tokens = [];
      for (const [key, value] of Object.entries(obj)) {
        if (value && typeof value === 'object') {
          // Skip TextLabels (documentation-only)
          if (key === 'TextLabels') continue;

          // If it has $value and is a color type, it's a token
          if ((value.$value || value.value) && value.$type === 'color') {
            tokens.push({
              name: key,
              displayName: toDisplayName(key),
              cssVar: `--${toKebabCase(key)}`,
              value: value.$value || value.value
            });
          } else {
            // Recurse into nested objects (e.g., "red", "neutrals" subcategories)
            tokens.push(...extractColorTokensFromGroup(value));
          }
        }
      }
      return tokens;
    }

    const generateColorCards = (tokens) => tokens.map(t => `  <div className="color-card">
    <div className="color-card-swatch" style={{background: 'var(${t.cssVar})'}}></div>
    <div className="color-card-info">
      <div className="color-card-name">${t.displayName}</div>
      <div className="color-card-token">${t.cssVar}</div>
    </div>
  </div>`).join('\n');

    // Iterate over top-level groups in primitives JSON (BILD, Shared, Partner, SportBILD, Opacity, etc.)
    for (const [groupKey, groupValue] of Object.entries(primitives)) {
      // Skip documentation-only groups
      if (groupKey === 'TextLabels') continue;
      if (!groupValue || typeof groupValue !== 'object') continue;

      const tokens = extractColorTokensFromGroup(groupValue);
      if (tokens.length > 0) {
        // Generate readable title from group key
        const title = toDisplayName(groupKey);

        primitiveGrid += `
### ${title}

<div className="color-grid">
${generateColorCards(tokens)}
</div>
`;
      }
    }
  }

  // Final MDX content
  const mdxContent = `import { Meta } from '@storybook/blocks';

<Meta title="Foundations/Colors" />

{/*
  AUTO-GENERATED FILE - DO NOT EDIT MANUALLY
  Generated by: scripts/tokens/generate-docs.js
  To update: run npm run build:docs or npm run build:tokens
*/}

<style>
  {\`
    .color-section {
      margin-bottom: 2rem;
    }
    .color-table {
      width: 100%;
      border-collapse: collapse;
      margin: 1rem 0 2rem;
    }
    .color-table th, .color-table td {
      padding: 0.75rem;
      text-align: left;
      border-bottom: 1px solid var(--border-color-low-contrast);
    }
    .color-table th {
      background: var(--surface-color-secondary);
      font-weight: 600;
      color: var(--text-color-primary);
    }
    .color-table td {
      color: var(--text-color-primary);
    }
    .color-table code {
      background: var(--surface-color-tertiary);
      padding: 0.2rem 0.4rem;
      border-radius: 3px;
      font-size: 0.85em;
    }
    .color-swatch {
      display: inline-block;
      width: 24px;
      height: 24px;
      border-radius: 4px;
      border: 1px solid var(--border-color-low-contrast);
      vertical-align: middle;
      margin-right: 8px;
    }
    .color-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
      gap: 16px;
      margin: 1rem 0 2rem;
    }
    .color-card {
      border-radius: 8px;
      overflow: hidden;
      border: 1px solid var(--border-color-low-contrast);
      background: var(--surface-color-primary);
    }
    .color-card-swatch {
      height: 64px;
    }
    .color-card-info {
      padding: 12px;
      background: var(--surface-color-primary);
    }
    .color-card-name {
      font-weight: 600;
      font-size: 13px;
      color: var(--text-color-primary);
      margin-bottom: 2px;
    }
    .color-card-token {
      font-size: 11px;
      color: var(--text-color-secondary);
      font-family: monospace;
    }
    .hint-box {
      padding: 12px 16px;
      background: var(--surface-color-tertiary);
      border-radius: 8px;
      border-left: 4px solid var(--core-color-primary);
      margin: 1rem 0;
      font-size: 14px;
      color: var(--text-color-primary);
    }
    .category-header {
      font-size: 14px;
      font-weight: 600;
      color: var(--text-color-secondary);
      text-transform: uppercase;
      letter-spacing: 0.5px;
      margin-top: 2rem;
      margin-bottom: 1rem;
      padding-bottom: 0.5rem;
      border-bottom: 1px solid var(--border-color-low-contrast);
    }
  \`}
</style>

# Colors

The BILD Design System uses a **4-layer token architecture** for colors.

<div className="hint-box">
  <strong>Live Preview:</strong> All color swatches use CSS custom properties. Switch brands and themes using the <strong>toolbar above</strong> to see values change in real-time.
</div>

---

## Color Primitives

These are the raw color values from Layer 0 (no modes).
${primitiveGrid}
---

## Semantic Colors (ColorMode Collection)

These are meaning-based tokens from Layer 2 that adapt to light/dark mode.
${semanticSections}
---

## Usage

\`\`\`css
/* Using semantic color tokens */
.my-component {
  color: var(--text-color-primary);
  background: var(--surface-color-primary);
  border: 1px solid var(--border-color-low-contrast);
}

/* Highlight text */
.highlight {
  color: var(--text-color-accent);
}

/* Success state */
.success-message {
  color: var(--text-color-success-constant);
  background: var(--surface-color-success);
  border: 1px solid var(--border-color-success);
}
\`\`\`
`;

  return mdxContent;
}

/**
 * Main execution
 */
function main() {
  console.log('Generating Storybook documentation from tokens...\n');

  // Ensure docs directory exists
  if (!fs.existsSync(DOCS_DIR)) {
    fs.mkdirSync(DOCS_DIR, { recursive: true });
  }

  // Generate colors documentation
  console.log('Generating colors.mdx...');
  const colorsDocs = generateColorsDocs();
  if (colorsDocs) {
    const colorsPath = path.join(DOCS_DIR, 'colors.mdx');
    fs.writeFileSync(colorsPath, colorsDocs);
    console.log(`  Written: ${colorsPath}`);
  }

  console.log('\nDocumentation generation complete!');
}

main();
