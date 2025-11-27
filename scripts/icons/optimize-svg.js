#!/usr/bin/env node

/**
 * SVG Optimization Script
 *
 * Optimizes all SVG icons using SVGO configuration.
 * This is the foundation for all platform-specific builds.
 *
 * Input:  src/icons/*.svg
 * Output: dist/icons/svg/*.svg
 */

const fs = require('fs');
const path = require('path');

// ============================================================================
// CONFIGURATION
// ============================================================================

const PATHS = {
  input: path.resolve(__dirname, '../../src/icons'),
  output: path.resolve(__dirname, '../../dist/icons/svg'),
  config: path.resolve(__dirname, '../../build-config/icons/svgo.config.js'),
};

// ============================================================================
// LOGGING UTILITIES
// ============================================================================

const log = {
  info: (msg) => console.log(`\u2139\uFE0F  ${msg}`),
  success: (msg) => console.log(`\u2705 ${msg}`),
  warn: (msg) => console.log(`\u26A0\uFE0F  ${msg}`),
  error: (msg) => console.error(`\u274C ${msg}`),
  step: (msg) => console.log(`\n\u27A1\uFE0F  ${msg}`),
};

// ============================================================================
// SVG PROCESSING
// ============================================================================

/**
 * Load SVGO dynamically (ESM module)
 */
async function loadSvgo() {
  const { optimize } = await import('svgo');
  return optimize;
}

/**
 * Get all SVG files from input directory
 */
function getSvgFiles() {
  if (!fs.existsSync(PATHS.input)) {
    log.warn(`Input directory does not exist: ${PATHS.input}`);
    return [];
  }

  const files = fs.readdirSync(PATHS.input)
    .filter(file => file.endsWith('.svg') && !file.startsWith('.'))
    .sort();

  return files;
}

/**
 * Transform icon name: icon-add.svg -> add
 */
function transformIconName(filename) {
  return filename
    .replace(/\.svg$/, '')
    .replace(/^icon-/, '');
}

/**
 * Optimize a single SVG file
 */
async function optimizeSvg(optimize, svgoConfig, filename) {
  const inputPath = path.join(PATHS.input, filename);
  const iconName = transformIconName(filename);
  const outputPath = path.join(PATHS.output, `${iconName}.svg`);

  try {
    const svgContent = fs.readFileSync(inputPath, 'utf8');

    const result = optimize(svgContent, {
      path: inputPath,
      ...svgoConfig,
    });

    if (result.error) {
      throw new Error(result.error);
    }

    fs.writeFileSync(outputPath, result.data, 'utf8');

    const originalSize = Buffer.byteLength(svgContent, 'utf8');
    const optimizedSize = Buffer.byteLength(result.data, 'utf8');
    const savings = Math.round((1 - optimizedSize / originalSize) * 100);

    return {
      name: iconName,
      success: true,
      originalSize,
      optimizedSize,
      savings,
    };
  } catch (error) {
    return {
      name: iconName,
      success: false,
      error: error.message,
    };
  }
}

/**
 * Generate manifest file with optimization results
 */
function generateManifest(results) {
  const manifest = {
    generatedAt: new Date().toISOString(),
    totalIcons: results.length,
    successful: results.filter(r => r.success).length,
    failed: results.filter(r => !r.success).length,
    icons: results.map(r => ({
      name: r.name,
      success: r.success,
      ...(r.success && {
        originalSize: r.originalSize,
        optimizedSize: r.optimizedSize,
        savings: `${r.savings}%`,
      }),
      ...(r.error && { error: r.error }),
    })),
  };

  const manifestPath = path.join(PATHS.output, 'manifest.json');
  fs.writeFileSync(manifestPath, JSON.stringify(manifest, null, 2), 'utf8');

  return manifest;
}

// ============================================================================
// MAIN
// ============================================================================

async function main() {
  console.log('\n========================================');
  console.log('  SVG Icon Optimization (SVGO)');
  console.log('========================================\n');

  log.step('Loading SVGO...');
  const optimize = await loadSvgo();

  // Load config
  let svgoConfig = {};
  if (fs.existsSync(PATHS.config)) {
    svgoConfig = require(PATHS.config);
    log.success('Loaded SVGO configuration');
  } else {
    log.warn('No SVGO config found, using defaults');
  }

  // Get input files
  log.step('Scanning input directory...');
  const svgFiles = getSvgFiles();

  if (svgFiles.length === 0) {
    log.warn('No SVG files found in src/icons/');
    log.info('Add SVG files to src/icons/ to get started');
    return { success: true, count: 0 };
  }

  log.success(`Found ${svgFiles.length} SVG file(s)`);

  // Create output directory
  if (!fs.existsSync(PATHS.output)) {
    fs.mkdirSync(PATHS.output, { recursive: true });
    log.success('Created output directory');
  }

  // Optimize all files
  log.step('Optimizing SVG files...');
  const results = [];

  for (const file of svgFiles) {
    const result = await optimizeSvg(optimize, svgoConfig, file);
    results.push(result);

    if (result.success) {
      log.info(`${result.name}: ${result.originalSize}B -> ${result.optimizedSize}B (-${result.savings}%)`);
    } else {
      log.error(`${result.name}: ${result.error}`);
    }
  }

  // Generate manifest
  log.step('Generating manifest...');
  const manifest = generateManifest(results);

  // Summary
  console.log('\n========================================');
  console.log('  Summary');
  console.log('========================================\n');

  log.success(`Optimized: ${manifest.successful}/${manifest.totalIcons} icons`);

  if (manifest.failed > 0) {
    log.error(`Failed: ${manifest.failed} icon(s)`);
    return { success: false, count: manifest.successful, failed: manifest.failed };
  }

  const totalSavings = results
    .filter(r => r.success)
    .reduce((sum, r) => sum + (r.originalSize - r.optimizedSize), 0);

  log.info(`Total size reduction: ${totalSavings} bytes`);
  log.info(`Output: ${PATHS.output}`);

  return { success: true, count: manifest.totalIcons };
}

// Run if called directly
if (require.main === module) {
  main()
    .then(result => {
      if (!result.success) {
        process.exit(1);
      }
    })
    .catch(error => {
      log.error(error.message);
      process.exit(1);
    });
}

module.exports = { main, PATHS, transformIconName };
