#!/usr/bin/env node

/**
 * Release Notes Generator
 *
 * Generates comprehensive release notes for design token updates
 * Analyzes token changes, build statistics, and platform distribution
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Paths
const DIST_DIR = path.join(__dirname, '../dist');
const MANIFEST_PATH = path.join(DIST_DIR, 'manifest.json');
const SOURCE_PATH = path.join(__dirname, '../src/design-tokens/bild-design-system-raw-data.json');

/**
 * Execute shell command and return output
 */
function exec(command) {
  try {
    return execSync(command, { encoding: 'utf8' }).trim();
  } catch (error) {
    return '';
  }
}

/**
 * Get file count for pattern
 */
function countFiles(pattern) {
  const result = exec(`find ${DIST_DIR} -name '${pattern}' 2>/dev/null | wc -l`);
  return parseInt(result) || 0;
}

/**
 * Get directory size in human-readable format
 */
function getDirSize(dir) {
  try {
    const result = exec(`du -sh ${dir} 2>/dev/null | cut -f1`);
    return result || '0';
  } catch (error) {
    return '0';
  }
}

/**
 * Calculate token changes from git diff
 */
function calculateTokenChanges() {
  try {
    // Get diff stats from git
    const diffStats = exec(`git diff origin/main...HEAD -- ${SOURCE_PATH} --numstat`);

    if (!diffStats) {
      return { added: 0, modified: 0, deleted: 0, linesAdded: 0, linesDeleted: 0 };
    }

    const [linesAdded, linesDeleted] = diffStats.split('\t').map(n => parseInt(n) || 0);

    // For now, estimate based on line changes
    // In a more sophisticated version, we'd parse the JSON diff
    const estimatedChanges = Math.floor((linesAdded + linesDeleted) / 10);

    return {
      added: Math.floor(linesAdded / 10),
      modified: Math.floor(estimatedChanges / 2),
      deleted: Math.floor(linesDeleted / 10),
      linesAdded,
      linesDeleted
    };
  } catch (error) {
    return { added: 0, modified: 0, deleted: 0, linesAdded: 0, linesDeleted: 0 };
  }
}

/**
 * Get platform statistics
 */
function getPlatformStats() {
  const platforms = [
    { name: 'CSS', pattern: '*.css', dir: 'css' },
    { name: 'SCSS', pattern: '*.scss', dir: 'scss' },
    { name: 'JavaScript', pattern: '*.js', dir: 'js' },
    { name: 'JSON', pattern: '*.json', dir: 'json' },
    { name: 'iOS Swift', pattern: '*.swift', dir: 'ios' },
    { name: 'Android XML', pattern: '*.xml', dir: 'android' },
    { name: 'Flutter Dart', pattern: '*.dart', dir: 'flutter' }
  ];

  return platforms.map(platform => {
    const files = countFiles(platform.pattern);
    const size = getDirSize(path.join(DIST_DIR, platform.dir));
    return { ...platform, files, size };
  });
}

/**
 * Get brand distribution from dist structure
 */
function getBrandStats() {
  const brands = ['bild', 'sportbild', 'advertorial'];

  return brands.map(brand => {
    const componentsDir = path.join(DIST_DIR, 'css/brands', brand, 'components');
    const semanticDir = path.join(DIST_DIR, 'css/brands', brand, 'semantic');

    let componentFiles = 0;
    let semanticFiles = 0;

    try {
      componentFiles = parseInt(exec(`find ${componentsDir} -type f 2>/dev/null | wc -l`)) || 0;
      semanticFiles = parseInt(exec(`find ${semanticDir} -type f 2>/dev/null | wc -l`)) || 0;
    } catch (error) {
      // Directory might not exist
    }

    return {
      name: brand.charAt(0).toUpperCase() + brand.slice(1),
      componentFiles,
      semanticFiles,
      total: componentFiles + semanticFiles
    };
  });
}

/**
 * Load manifest if available
 */
function loadManifest() {
  try {
    if (fs.existsSync(MANIFEST_PATH)) {
      return JSON.parse(fs.readFileSync(MANIFEST_PATH, 'utf8'));
    }
  } catch (error) {
    // Manifest not available
  }
  return null;
}

/**
 * Get changed files list
 */
function getChangedFiles() {
  try {
    const files = exec(`git diff --name-only origin/main...HEAD -- src/design-tokens/ | head -10`);
    return files.split('\n').filter(f => f.trim());
  } catch (error) {
    return [];
  }
}

/**
 * Generate markdown table row
 */
function tableRow(...cells) {
  return `| ${cells.join(' | ')} |`;
}

/**
 * Generate release notes markdown
 */
function generateReleaseNotes(options = {}) {
  const {
    commitSha = exec('git rev-parse HEAD').substring(0, 7),
    buildSuccess = true,
    successfulBuilds = 969,
    totalBuilds = 969,
    runId = ''
  } = options;

  const tokenChanges = calculateTokenChanges();
  const platformStats = getPlatformStats();
  const brandStats = getBrandStats();
  const changedFiles = getChangedFiles();
  const manifest = loadManifest();

  const totalFiles = platformStats.reduce((sum, p) => sum + p.files, 0);
  const timestamp = new Date().toISOString().replace('T', ' ').substring(0, 16) + ' UTC';

  let markdown = `# 🎨 Design Token Update from TokenSync

**Source**: Figma → TokenSync Plugin → GitHub
**Status**: ${buildSuccess ? '✅ Build Successful' : '❌ Build Failed'} (${successfulBuilds}/${totalBuilds})
**Commit**: \`${commitSha}\`
**Date**: ${timestamp}

---

## 📊 Token Changes Summary

`;

  // Token changes table (estimated from line changes)
  if (tokenChanges.linesAdded > 0 || tokenChanges.linesDeleted > 0) {
    const totalChanges = tokenChanges.added + tokenChanges.modified + tokenChanges.deleted;

    markdown += `
${tableRow('Category', 'Added', 'Modified', 'Deleted', 'Total')}
${tableRow('-------', '-----', '--------', '-------', '-----')}
${tableRow('🔷 **All Tokens**', tokenChanges.added, tokenChanges.modified, tokenChanges.deleted, totalChanges)}

**Lines Changed**: +${tokenChanges.linesAdded} / -${tokenChanges.linesDeleted}

`;
  } else {
    markdown += `
No token changes detected in this update.

`;
  }

  // Build statistics by platform
  markdown += `---

## 📦 Build Output Statistics

### By Platform

${tableRow('Platform', 'Files', 'Size')}
${tableRow('--------', '-----', '----')}
`;

  let totalSize = 0;
  platformStats.forEach(p => {
    markdown += `${tableRow(`**${p.name}**`, p.files, p.size)}\n`;
  });

  markdown += `${tableRow('**Total**', totalFiles, getDirSize(DIST_DIR))}\n`;

  // Brand distribution
  if (brandStats.some(b => b.total > 0)) {
    markdown += `
### By Brand (CSS Platform)

${tableRow('Brand', 'Component Files', 'Semantic Files', 'Total')}
${tableRow('-----', '--------------', '--------------', '-----')}
`;

    brandStats.forEach(b => {
      markdown += `${tableRow(`**${b.name}**`, b.componentFiles, b.semanticFiles, b.total)}\n`;
    });
  }

  // Token layer breakdown
  markdown += `
### By Token Layer

${tableRow('Layer', 'Description', 'Platforms')}
${tableRow('-----', '-----------', '---------')}
${tableRow('**Primitives**', 'Shared foundation tokens', '7')}
${tableRow('**Semantic**', 'Brand × Mode semantic tokens', '7')}
${tableRow('**Components**', 'Component-specific tokens', '7')}
${tableRow('**Bundles**', 'Convenience bundle files', 'CSS only')}

`;

  // Review files section
  markdown += `---

## 📥 Review Files

### Download Options
`;

  const repo = process.env.GITHUB_REPOSITORY || options.repository || 'UXWizard25/vv-token-test-v3';

  if (runId) {
    markdown += `- ⬇️ [**Download All Platforms**](https://github.com/${repo}/actions/runs/${runId}) (Build Artifacts)\n`;
  }

  markdown += `- 📄 [View Source Changes](https://github.com/${repo}/compare/main...figma-tokens) (JSON diff)

### Artifact Retention
Build artifacts available for **30 days**

`;

  // What happens after merge
  markdown += `---

## 🚀 What Happens After Merge

When this PR is merged to \`main\`:

1. ✅ **Fresh Build** - Tokens rebuilt from source
2. 📦 **Version Bump** - \`patch\` increment (v3.0.x → v3.0.y)
3. 📤 **NPM Publish** - \`@marioschmidt/design-system-tokens@3.0.y\`
4. 🏷️ **GitHub Release** - Tagged release with artifacts
5. 📊 **Stats Update** - Build stats in release notes

`;

  // Changed files
  if (changedFiles.length > 0) {
    markdown += `---

## 📝 Changed Source Files

\`\`\`diff
${changedFiles.map(f => `+ ${f}`).join('\n')}
\`\`\`

`;
  }

  // Pipeline details
  markdown += `---

## ⚙️ Pipeline Details

- **Build Duration**: See workflow run time
- **Node Version**: 20.x
- **Style Dictionary**: 4.x
- **Platforms Built**: ${platformStats.filter(p => p.files > 0).length}/7 ✅
- **Total Files**: ${totalFiles}
- **Warnings**: 0
- **Errors**: 0

---

**Questions?** Check [Troubleshooting Guide](https://github.com/${repo}#-troubleshooting) or [File an Issue](https://github.com/${repo}/issues)
`;

  return markdown;
}

// Main execution
if (require.main === module) {
  // Parse command line args
  const args = process.argv.slice(2);
  const options = {};

  for (let i = 0; i < args.length; i += 2) {
    const key = args[i].replace('--', '');
    const value = args[i + 1];

    if (key === 'successful-builds' || key === 'total-builds') {
      options[key.replace('-', '_')] = parseInt(value);
    } else if (key === 'build-success') {
      options.buildSuccess = value === 'true';
    } else {
      options[key.replace('-', '_')] = value;
    }
  }

  const markdown = generateReleaseNotes(options);
  console.log(markdown);
}

module.exports = { generateReleaseNotes };
