#!/usr/bin/env node

/**
 * Pipeline Configuration Validator
 *
 * Validates pipeline.config.js for:
 * - Required fields and correct types in rawConfig sections
 * - Derived values are correctly computed
 * - Cross-references between sections (brands ↔ modes, etc.)
 * - File/directory existence (optional, with --check-paths flag)
 * - Figma ID format consistency
 * - No hyphens in mode/brand names (breaks CSS custom property parsing)
 *
 * Usage:
 *   node scripts/validate-pipeline-config.js              # Structure validation only
 *   node scripts/validate-pipeline-config.js --check-paths # Also check file paths exist
 *
 * Config Structure (rawConfig + derived):
 *   rawConfig sections: identity, brands, modes, figma, css, platforms, paths, packages, stencil, deployment, validation
 *   derived values: allBrands, colorBrands, contentBrands, colorModes, densityModes, breakpoints, etc.
 */

const fs = require('fs');
const path = require('path');

const CONFIG_PATH = path.join(__dirname, '../build-config/pipeline.config.js');
const ROOT_DIR = path.join(__dirname, '..');

let errors = [];
let warnings = [];

function error(msg) { errors.push(`❌ ${msg}`); }
function warn(msg) { warnings.push(`⚠️  ${msg}`); }
function ok(msg) { console.log(`  ✅ ${msg}`); }

// ─── Type Helpers ────────────────────────────────────────────────────────────

function assertString(val, path, minLen = 1) {
  if (typeof val !== 'string') return error(`${path}: expected string, got ${typeof val}`);
  if (val.length < minLen) return error(`${path}: must be at least ${minLen} characters`);
}

function assertArray(val, path, minLen = 1) {
  if (!Array.isArray(val)) return error(`${path}: expected array, got ${typeof val}`);
  if (val.length < minLen) return error(`${path}: must have at least ${minLen} element(s)`);
}

function assertObject(val, path) {
  if (!val || typeof val !== 'object' || Array.isArray(val)) {
    return error(`${path}: expected object, got ${Array.isArray(val) ? 'array' : typeof val}`);
  }
}

function assertBoolean(val, path) {
  if (typeof val !== 'boolean') return error(`${path}: expected boolean, got ${typeof val}`);
}

function assertNumber(val, path, min = 0) {
  if (typeof val !== 'number') return error(`${path}: expected number, got ${typeof val}`);
  if (val < min) return error(`${path}: must be >= ${min}`);
}

/**
 * Validates that a name does not contain hyphens.
 *
 * Hyphens are forbidden in mode/brand names because they are used as segments
 * in CSS custom property names (e.g., --density-{mode}-stack-space-resp-md).
 * A hyphenated mode name like "extra-large" would make it impossible to
 * distinguish mode boundaries from token name segments in the generated output.
 * It also breaks camelCase conversion for JS/Swift/Kotlin platforms.
 */
function assertNoHyphens(val, path) {
  if (typeof val === 'string' && val.includes('-')) {
    error(`${path}: must not contain hyphens ('-'). Use camelCase or single words. Hyphens break CSS custom property parsing and native camelCase conversion.`);
  }
}

// ─── Section Validators ──────────────────────────────────────────────────────

function validateIdentity(config) {
  console.log('\n📋 identity:');
  const id = config.identity;
  if (!id) return error('identity: section missing');

  assertString(id.name, 'identity.name');
  assertString(id.shortName, 'identity.shortName');
  assertString(id.copyright, 'identity.copyright');
  assertString(id.repositoryUrl, 'identity.repositoryUrl');

  if (id.repositoryUrl && !id.repositoryUrl.startsWith('https://')) {
    warn('identity.repositoryUrl: should start with https://');
  }

  ok('identity section valid');
}

function validateBrands(config) {
  console.log('\n📋 brands (rawConfig):');
  const brands = config.brands;
  if (!brands) return error('brands: section missing');

  // Validate each brand definition
  const brandKeys = Object.keys(brands);
  if (brandKeys.length === 0) return error('brands: must have at least one brand');

  let hasDefault = false;
  for (const key of brandKeys) {
    assertNoHyphens(key, `brands.${key}`);
    const brand = brands[key];
    assertObject(brand, `brands.${key}`);
    if (!brand) continue;

    assertString(brand.figmaName, `brands.${key}.figmaName`);
    assertArray(brand.axes, `brands.${key}.axes`, 1);

    if (brand.axes) {
      for (const axis of brand.axes) {
        if (!['color', 'content'].includes(axis)) {
          error(`brands.${key}.axes: '${axis}' must be 'color' or 'content'`);
        }
      }
    }

    if (brand.isDefault) {
      if (hasDefault) error('brands: only one brand can have isDefault: true');
      hasDefault = true;
    }
  }

  if (!hasDefault) warn('brands: no brand has isDefault: true');

  ok('brands section valid');
}

function validateDerivedBrands(config) {
  console.log('\n📋 brands (derived):');

  // Check derived arrays exist
  assertArray(config.allBrands, 'allBrands', 1);
  assertArray(config.colorBrands, 'colorBrands', 1);
  assertArray(config.contentBrands, 'contentBrands', 1);
  assertString(config.defaultBrand, 'defaultBrand');
  assertObject(config.brandToFigmaName, 'brandToFigmaName');
  assertObject(config.figmaNameToBrand, 'figmaNameToBrand');
  assertObject(config.brandDisplayNames, 'brandDisplayNames');

  // Cross-reference checks
  if (config.allBrands && config.defaultBrand) {
    if (!config.allBrands.includes(config.defaultBrand)) {
      error(`defaultBrand '${config.defaultBrand}' not in allBrands`);
    }
  }

  if (config.allBrands && config.colorBrands) {
    for (const b of config.colorBrands) {
      if (!config.allBrands.includes(b)) {
        error(`colorBrands: '${b}' not in allBrands`);
      }
    }
  }

  if (config.allBrands && config.contentBrands) {
    for (const b of config.contentBrands) {
      if (!config.allBrands.includes(b)) {
        error(`contentBrands: '${b}' not in allBrands`);
      }
    }
  }

  // Validate derived matches rawConfig
  if (config.brands && config.allBrands) {
    const rawBrandKeys = Object.keys(config.brands);
    if (rawBrandKeys.length !== config.allBrands.length) {
      error(`allBrands length (${config.allBrands.length}) doesn't match brands keys (${rawBrandKeys.length})`);
    }
    for (const key of rawBrandKeys) {
      if (!config.allBrands.includes(key)) {
        error(`allBrands missing brand key '${key}'`);
      }
    }
  }

  ok('derived brands valid');
}

function validateModes(config) {
  console.log('\n📋 modes (rawConfig):');
  const modes = config.modes;
  if (!modes) return error('modes: section missing');

  // Validate color modes
  assertObject(modes.color, 'modes.color');
  if (modes.color) {
    const colorKeys = Object.keys(modes.color);
    if (colorKeys.length < 2) error('modes.color: need at least 2 color modes (light/dark)');

    let hasDefault = false;
    for (const key of colorKeys) {
      assertNoHyphens(key, `modes.color.${key}`);
      const mode = modes.color[key];
      assertObject(mode, `modes.color.${key}`);
      if (mode) {
        assertString(mode.figmaId, `modes.color.${key}.figmaId`);
        if (mode.isDefault) {
          if (hasDefault) error('modes.color: only one mode can have isDefault: true');
          hasDefault = true;
        }
      }
    }
    if (!hasDefault) warn('modes.color: no mode has isDefault: true');
  }

  // Validate density modes
  assertObject(modes.density, 'modes.density');
  if (modes.density) {
    const densityKeys = Object.keys(modes.density);
    if (densityKeys.length < 1) error('modes.density: need at least 1 density mode');

    let hasDefault = false;
    for (const key of densityKeys) {
      assertNoHyphens(key, `modes.density.${key}`);
      const mode = modes.density[key];
      assertObject(mode, `modes.density.${key}`);
      if (mode) {
        assertString(mode.figmaId, `modes.density.${key}.figmaId`);
        if (mode.isDefault) {
          if (hasDefault) error('modes.density: only one mode can have isDefault: true');
          hasDefault = true;
        }
      }
    }
    if (!hasDefault) warn('modes.density: no mode has isDefault: true');
  }

  // Validate breakpoints
  assertObject(modes.breakpoints, 'modes.breakpoints');
  if (modes.breakpoints) {
    const bpKeys = Object.keys(modes.breakpoints);
    if (bpKeys.length < 2) error('modes.breakpoints: need at least 2 breakpoints');

    let prevWidth = 0;
    let hasBase = false;
    for (const key of bpKeys) {
      assertNoHyphens(key, `modes.breakpoints.${key}`);
      const bp = modes.breakpoints[key];
      assertObject(bp, `modes.breakpoints.${key}`);
      if (bp) {
        assertNumber(bp.minWidth, `modes.breakpoints.${key}.minWidth`, 1);
        assertString(bp.figmaId, `modes.breakpoints.${key}.figmaId`);

        if (bp.minWidth <= prevWidth) {
          error(`modes.breakpoints.${key}.minWidth (${bp.minWidth}) must be > previous (${prevWidth})`);
        }
        prevWidth = bp.minWidth;

        if (bp.isBase) {
          if (hasBase) error('modes.breakpoints: only one breakpoint can have isBase: true');
          hasBase = true;
        }
      }
    }
    if (!hasBase) warn('modes.breakpoints: no breakpoint has isBase: true (first will be used)');
  }

  ok('modes section valid');
}

function validateDerivedModes(config) {
  console.log('\n📋 modes (derived):');

  // Check derived arrays exist
  assertArray(config.colorModes, 'colorModes', 2);
  assertString(config.defaultColorMode, 'defaultColorMode');
  assertObject(config.colorModeIds, 'colorModeIds');
  assertObject(config.colorModeDisplayNames, 'colorModeDisplayNames');

  assertArray(config.densityModes, 'densityModes', 1);
  assertString(config.defaultDensity, 'defaultDensity');
  assertObject(config.densityModeIds, 'densityModeIds');
  assertObject(config.densityDisplayNames, 'densityDisplayNames');

  assertArray(config.breakpoints, 'breakpoints', 2);
  assertString(config.baseBreakpoint, 'baseBreakpoint');
  assertObject(config.breakpointModeIds, 'breakpointModeIds');
  assertObject(config.breakpointMinWidths, 'breakpointMinWidths');

  // Cross-reference checks
  if (config.colorModes && config.defaultColorMode) {
    if (!config.colorModes.includes(config.defaultColorMode)) {
      error(`defaultColorMode '${config.defaultColorMode}' not in colorModes`);
    }
  }

  if (config.densityModes && config.defaultDensity) {
    if (!config.densityModes.includes(config.defaultDensity)) {
      error(`defaultDensity '${config.defaultDensity}' not in densityModes`);
    }
  }

  if (config.breakpoints && config.baseBreakpoint) {
    if (!config.breakpoints.includes(config.baseBreakpoint)) {
      error(`baseBreakpoint '${config.baseBreakpoint}' not in breakpoints`);
    }
  }

  ok('derived modes valid');
}

function validateFigma(config) {
  console.log('\n📋 figma:');
  const figma = config.figma;
  if (!figma) return error('figma: section missing');

  assertString(figma.inputFile, 'figma.inputFile');
  assertString(figma.componentPrefix, 'figma.componentPrefix');

  // Validate collections
  assertObject(figma.collections, 'figma.collections');
  if (figma.collections) {
    const requiredCollections = [
      'FONT_PRIMITIVE', 'COLOR_PRIMITIVE', 'SIZE_PRIMITIVE', 'SPACE_PRIMITIVE',
      'DENSITY', 'BRAND_TOKEN_MAPPING', 'BRAND_COLOR_MAPPING',
      'BREAKPOINT_MODE', 'COLOR_MODE',
    ];
    for (const col of requiredCollections) {
      if (!figma.collections[col]) {
        error(`figma.collections.${col}: missing`);
      } else if (!figma.collections[col].startsWith('VariableCollectionId:')) {
        warn(`figma.collections.${col}: expected to start with 'VariableCollectionId:'`);
      }
    }
  }

  ok('figma section valid');
}

function validateCss(config) {
  console.log('\n📋 css:');
  const css = config.css;
  if (!css) return error('css: section missing');

  assertString(css.fontSizeUnit, 'css.fontSizeUnit');
  if (css.fontSizeUnit && !['px', 'rem'].includes(css.fontSizeUnit)) {
    error("css.fontSizeUnit: must be 'px' or 'rem'");
  }

  assertNumber(css.remBase, 'css.remBase', 1);

  assertObject(css.dataAttributes, 'css.dataAttributes');
  if (css.dataAttributes) {
    const required = ['colorBrand', 'contentBrand', 'theme', 'density'];
    for (const attr of required) {
      assertString(css.dataAttributes[attr], `css.dataAttributes.${attr}`);
      if (css.dataAttributes[attr] && !css.dataAttributes[attr].startsWith('data-')) {
        warn(`css.dataAttributes.${attr}: should start with 'data-'`);
      }
    }
  }

  // fallbackStrategy is optional
  if (css.fallbackStrategy) {
    assertObject(css.fallbackStrategy, 'css.fallbackStrategy');
    assertBoolean(css.fallbackStrategy.primitiveRefs, 'css.fallbackStrategy.primitiveRefs');
    assertBoolean(css.fallbackStrategy.semanticRefs, 'css.fallbackStrategy.semanticRefs');
    assertBoolean(css.fallbackStrategy.componentRefs, 'css.fallbackStrategy.componentRefs');
  }

  ok('css section valid');
}

function validatePlatforms(config, checkPaths) {
  console.log('\n📋 platforms:');
  const platforms = config.platforms;
  if (!platforms) return error('platforms: section missing');

  // CSS Platform (only enabled flag, settings are in css section)
  if (platforms.css) {
    assertBoolean(platforms.css.enabled, 'platforms.css.enabled');
  }

  // iOS Platform
  if (platforms.ios) {
    assertBoolean(platforms.ios.enabled, 'platforms.ios.enabled');
    if (platforms.ios.enabled) {
      assertString(platforms.ios.moduleName, 'platforms.ios.moduleName');
      assertObject(platforms.ios.sizeClasses, 'platforms.ios.sizeClasses');

      // Validate sizeClass references valid breakpoints
      if (platforms.ios.sizeClasses && config.breakpoints) {
        for (const [cls, bp] of Object.entries(platforms.ios.sizeClasses)) {
          if (!config.breakpoints.includes(bp)) {
            error(`platforms.ios.sizeClasses.${cls}: '${bp}' not in breakpoints`);
          }
        }
      }
    }
  }

  // Android Platform
  if (platforms.android) {
    assertBoolean(platforms.android.enabled, 'platforms.android.enabled');
    if (platforms.android.enabled) {
      assertString(platforms.android.packageName, 'platforms.android.packageName');
      assertObject(platforms.android.sizeClasses, 'platforms.android.sizeClasses');

      // Validate sizeClass references valid breakpoints
      if (platforms.android.sizeClasses && config.breakpoints) {
        for (const [cls, bp] of Object.entries(platforms.android.sizeClasses)) {
          if (!config.breakpoints.includes(bp)) {
            error(`platforms.android.sizeClasses.${cls}: '${bp}' not in breakpoints`);
          }
        }
      }
    }
  }

  ok('platforms section valid');
}

function validatePaths(config, checkPaths) {
  console.log('\n📋 paths:');
  const paths = config.paths;
  if (!paths) return error('paths: section missing');

  assertString(paths.tokensInput, 'paths.tokensInput');
  assertString(paths.tokensIntermediate, 'paths.tokensIntermediate');
  assertString(paths.tokensDist, 'paths.tokensDist');
  assertString(paths.iosOutput, 'paths.iosOutput');
  assertString(paths.androidOutput, 'paths.androidOutput');
  assertString(paths.componentsSrc, 'paths.componentsSrc');

  if (checkPaths) {
    const inputPath = path.join(ROOT_DIR, paths.tokensInput);
    if (!fs.existsSync(inputPath)) {
      warn(`paths.tokensInput: ${inputPath} does not exist`);
    }

    // Check if input file exists
    if (config.figma && config.figma.inputFile) {
      const inputFilePath = path.join(ROOT_DIR, paths.tokensInput, config.figma.inputFile);
      if (!fs.existsSync(inputFilePath)) {
        warn(`figma.inputFile: ${inputFilePath} does not exist`);
      }
    }

    const componentsSrcPath = path.join(ROOT_DIR, paths.componentsSrc);
    if (!fs.existsSync(componentsSrcPath)) {
      warn(`paths.componentsSrc: ${componentsSrcPath} does not exist`);
    }
  }

  ok('paths section valid');
}

function validatePackages(config) {
  console.log('\n📋 packages:');
  const packages = config.packages;
  if (!packages) return error('packages: section missing');

  const requiredPackages = ['tokens', 'components', 'react', 'vue'];
  const optionalPackages = ['icons', 'iconsReact'];

  for (const pkg of requiredPackages) {
    if (!packages[pkg]) {
      error(`packages.${pkg}: missing`);
    } else {
      assertString(packages[pkg], `packages.${pkg}`);
      if (packages[pkg] && !packages[pkg].startsWith('@')) {
        warn(`packages.${pkg}: scoped package names should start with '@'`);
      }
    }
  }

  for (const pkg of optionalPackages) {
    if (packages[pkg]) {
      assertString(packages[pkg], `packages.${pkg}`);
      if (!packages[pkg].startsWith('@')) {
        warn(`packages.${pkg}: scoped package names should start with '@'`);
      }
    }
  }

  ok('packages section valid');
}

function validateStencil(config) {
  console.log('\n📋 stencil:');
  const stencil = config.stencil;
  if (!stencil) return error('stencil: section missing');

  assertString(stencil.namespace, 'stencil.namespace');
  assertString(stencil.componentPrefix, 'stencil.componentPrefix');

  // devServerPort is optional
  if (stencil.devServerPort !== undefined) {
    assertNumber(stencil.devServerPort, 'stencil.devServerPort', 1024);
  }

  if (stencil.namespace && !/^[a-z][a-z0-9-]*$/.test(stencil.namespace)) {
    warn('stencil.namespace: should be lowercase alphanumeric with hyphens');
  }

  if (stencil.componentPrefix && !stencil.componentPrefix.endsWith('-')) {
    warn("stencil.componentPrefix: should end with '-' (e.g., 'ds-')");
  }

  ok('stencil section valid');
}

function validateDeployment(config) {
  console.log('\n📋 deployment:');
  const deployment = config.deployment;
  if (!deployment) return error('deployment: section missing');

  assertString(deployment.storybookBasePath, 'deployment.storybookBasePath');
  if (deployment.storybookBasePath && !deployment.storybookBasePath.startsWith('/')) {
    error("deployment.storybookBasePath: must start with '/'");
  }
  if (deployment.storybookBasePath && !deployment.storybookBasePath.endsWith('/')) {
    error("deployment.storybookBasePath: must end with '/'");
  }

  ok('deployment section valid');
}

function validateValidationSection(config) {
  console.log('\n📋 validation:');
  const validation = config.validation;
  if (!validation) {
    warn('validation: section missing (optional)');
    return;
  }

  if (validation.strict !== undefined) {
    assertBoolean(validation.strict, 'validation.strict');
  }

  if (validation.warnUnknownFigmaModes !== undefined) {
    assertBoolean(validation.warnUnknownFigmaModes, 'validation.warnUnknownFigmaModes');
  }

  ok('validation section valid');
}

// ─── Main ────────────────────────────────────────────────────────────────────

function main() {
  const checkPaths = process.argv.includes('--check-paths');

  console.log('🔍 Validating pipeline.config.js...');
  console.log('   Config structure: rawConfig + derived values');
  if (checkPaths) console.log('   (with file path checks)');

  // Load config
  let config;
  try {
    config = require(CONFIG_PATH);
  } catch (e) {
    console.error(`\n❌ FATAL: Cannot load config: ${e.message}`);
    process.exit(1);
  }

  // Run all validators
  // rawConfig sections
  validateIdentity(config);
  validateBrands(config);
  validateModes(config);
  validateFigma(config);
  validateCss(config);
  validatePlatforms(config, checkPaths);
  validatePaths(config, checkPaths);
  validatePackages(config);
  validateStencil(config);
  validateDeployment(config);
  validateValidationSection(config);

  // derived values
  validateDerivedBrands(config);
  validateDerivedModes(config);

  // Report results
  console.log('\n' + '═'.repeat(60));

  if (warnings.length > 0) {
    console.log(`\n⚠️  Warnings (${warnings.length}):`);
    for (const w of warnings) console.log(`   ${w}`);
  }

  if (errors.length > 0) {
    console.log(`\n❌ Errors (${errors.length}):`);
    for (const e of errors) console.log(`   ${e}`);
    console.log(`\n❌ Validation FAILED with ${errors.length} error(s)`);
    process.exit(1);
  }

  console.log(`\n✅ Validation PASSED (${warnings.length} warning(s))`);
}

main();
