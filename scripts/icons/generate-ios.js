#!/usr/bin/env node

/**
 * iOS SVG Asset Generation Script
 *
 * Generates optimized SVG assets for iOS with proper asset catalog structure.
 * Modern iOS (13+) supports SVG natively via SF Symbols.
 *
 * Input:  dist/icons/svg/*.svg
 * Output: dist/icons/ios/
 *         - Assets.xcassets/Icons/
 *           - {icon}.imageset/
 *             - {icon}.svg
 *             - Contents.json
 */

const fs = require('fs');
const path = require('path');
const { PATHS: SHARED_PATHS } = require('./paths');
const config = require('../../build-config/tokens/pipeline.config.js');

// ============================================================================
// CONFIGURATION (from pipeline.config.js)
// ============================================================================

const PATHS = {
  input: SHARED_PATHS.svg,
  output: SHARED_PATHS.ios,
  swift: SHARED_PATHS.iosSwift,
};

// Get configuration from central config
const iconConfig = config.icons;
const iosConfig = iconConfig.platforms.ios;
const sizingConfig = iconConfig.sizing;
const namingConfig = iconConfig.naming;

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
// NAME TRANSFORMATIONS
// ============================================================================

/**
 * Convert kebab-case to camelCase for iOS
 * add -> add
 * arrow-left -> arrowLeft
 * 2-liga-logo -> _2LigaLogo (prefixed with underscore for Swift validity)
 *
 * Swift identifiers cannot start with numbers, so we prefix with underscore.
 */
function toiOSName(str) {
  const camelCase = str.replace(/-([a-z0-9])/gi, (_, char) => char.toUpperCase());
  // Swift identifiers cannot start with a number - prefix with underscore
  if (/^[0-9]/.test(camelCase)) {
    return '_' + camelCase;
  }
  return camelCase;
}

/**
 * Get all SVG files from input directory
 */
function getSvgFiles() {
  if (!fs.existsSync(PATHS.input)) {
    log.warn(`Input directory does not exist: ${PATHS.input}`);
    log.info('Run "npm run build:icons:svg" first');
    return [];
  }

  const files = fs.readdirSync(PATHS.input)
    .filter(file => file.endsWith('.svg') && !file.startsWith('.'))
    .sort();

  return files;
}

// ============================================================================
// IOS ASSET GENERATION
// ============================================================================

/**
 * Generate Contents.json for an imageset
 * Uses author and renderingIntent from config
 */
function generateImagesetContents(svgFilename) {
  return {
    images: [
      {
        filename: svgFilename,
        idiom: 'universal',
      },
    ],
    info: {
      author: namingConfig.author,
      version: 1,
    },
    properties: {
      'preserves-vector-representation': true,
      'template-rendering-intent': iosConfig.renderingIntent,
    },
  };
}

/**
 * Generate Contents.json for the Icons folder
 * Uses author from config
 */
function generateFolderContents() {
  return {
    info: {
      author: namingConfig.author,
      version: 1,
    },
    properties: {
      'provides-namespace': true,
    },
  };
}

/**
 * Generate Contents.json for the root xcassets
 * Uses author from config
 */
function generateXcassetsContents() {
  return {
    info: {
      author: namingConfig.author,
      version: 1,
    },
  };
}

/**
 * Process SVG for iOS (add template rendering support)
 */
function processForIOS(svgContent) {
  // Ensure fill is currentColor for template rendering
  let processed = svgContent;

  // Remove any hardcoded colors, replace with currentColor
  processed = processed
    .replace(/fill="#[0-9a-fA-F]+"/g, 'fill="currentColor"')
    .replace(/fill="rgb\([^)]+\)"/g, 'fill="currentColor"')
    .replace(/fill="black"/g, 'fill="currentColor"')
    .replace(/fill="white"/g, 'fill="currentColor"');

  return processed;
}

/**
 * Generate iOS asset for a single icon
 */
function generateIOSAsset(filename) {
  const inputPath = path.join(PATHS.input, filename);
  const iconName = filename.replace(/\.svg$/, '');
  const iosName = toiOSName(iconName);
  const imagesetDir = path.join(PATHS.output, `${iosName}.imageset`);

  try {
    // Create imageset directory
    if (!fs.existsSync(imagesetDir)) {
      fs.mkdirSync(imagesetDir, { recursive: true });
    }

    // Read and process SVG
    const svgContent = fs.readFileSync(inputPath, 'utf8');
    const processedSvg = processForIOS(svgContent);

    // Write SVG to imageset
    const svgPath = path.join(imagesetDir, `${iosName}.svg`);
    fs.writeFileSync(svgPath, processedSvg, 'utf8');

    // Write Contents.json
    const contentsPath = path.join(imagesetDir, 'Contents.json');
    const contents = generateImagesetContents(`${iosName}.svg`);
    fs.writeFileSync(contentsPath, JSON.stringify(contents, null, 2), 'utf8');

    return {
      name: iosName,
      originalName: iconName,
      success: true,
    };
  } catch (error) {
    return {
      name: iosName,
      originalName: iconName,
      success: false,
      error: error.message,
    };
  }
}

/**
 * Generate Swift extension for easy icon access
 * Uses naming, sizing from config
 */
function generateSwiftExtension(icons) {
  // Get dynamic names from config
  const prefix = namingConfig.prefix;  // e.g., 'Bild'
  const iconEnumName = `${prefix}Icon`;  // e.g., 'BildIcon'
  const systemName = config.identity.name;  // e.g., 'BILD Design System'

  // Get size presets from config
  const sizePresets = sizingConfig.presets;
  const defaultSize = sizingConfig.defaultSize;

  const iconCases = icons
    .filter(i => i.success)
    .map(i => `    case ${i.name} = "${i.name}"`)
    .join('\n');

  const iconPreviewCases = icons
    .filter(i => i.success)
    .map(i => `        case .${i.name}: return "${i.originalName}"`)
    .join('\n');

  return { content: `// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated at: ${new Date().toISOString()}
//
// ${systemName} Icons - Swift Extension
// To regenerate, run: npm run build:icons:ios

import SwiftUI

// MARK: - ${iconEnumName} Enum

/// ${systemName} Icon names
///
/// Usage:
/// \`\`\`swift
/// // Simple usage with convenience method
/// ${iconEnumName}.add.icon()
///
/// // With custom size and color
/// ${iconEnumName}.arrowLeft.icon(size: 32, color: .blue)
///
/// // Using the raw Image for more control
/// ${iconEnumName}.menu.image
///     .resizable()
///     .frame(width: ${defaultSize}, height: ${defaultSize})
///     .foregroundColor(.primary)
/// \`\`\`
public enum ${iconEnumName}: String, CaseIterable, Sendable {
${iconCases}

    /// The image for this icon (use for custom configurations)
    public var image: Image {
        Image(rawValue, bundle: .module)
    }

    /// Human-readable name for preview/debugging
    public var displayName: String {
        switch self {
${iconPreviewCases}
        }
    }
}

// MARK: - Convenience Modifiers

public extension ${iconEnumName} {
    /// Standard icon sizes following SF Symbols conventions
    enum Size: CGFloat, Sendable {
        /// Extra small icon (${sizePresets.xs}pt)
        case xs = ${sizePresets.xs}
        /// Small icon (${sizePresets.sm}pt)
        case sm = ${sizePresets.sm}
        /// Medium icon (${sizePresets.md}pt) - Default
        case md = ${sizePresets.md}
        /// Large icon (${sizePresets.lg}pt)
        case lg = ${sizePresets.lg}
        /// Extra large icon (${sizePresets.xl}pt)
        case xl = ${sizePresets.xl}
    }

    /// Creates an icon view with specified size and color
    ///
    /// - Parameters:
    ///   - size: The icon size in points (default: ${defaultSize})
    ///   - color: The icon color (default: .primary)
    /// - Returns: A configured icon view
    ///
    /// Example:
    /// \`\`\`swift
    /// ${iconEnumName}.add.icon(size: 32, color: .blue)
    /// \`\`\`
    @ViewBuilder
    func icon(size: CGFloat = ${defaultSize}, color: Color = .primary) -> some View {
        image
            .resizable()
            .renderingMode(.template)
            .frame(width: size, height: size)
            .foregroundColor(color)
    }

    /// Creates an icon view with a preset size
    ///
    /// - Parameters:
    ///   - size: The preset size (.xs, .sm, .md, .lg, .xl)
    ///   - color: The icon color (default: .primary)
    /// - Returns: A configured icon view
    ///
    /// Example:
    /// \`\`\`swift
    /// ${iconEnumName}.menu.icon(size: .lg, color: .red)
    /// \`\`\`
    @ViewBuilder
    func icon(size: Size, color: Color = .primary) -> some View {
        icon(size: size.rawValue, color: color)
    }
}

// MARK: - Button Convenience

public extension ${iconEnumName} {
    /// Creates a button with this icon
    ///
    /// - Parameters:
    ///   - size: The icon size in points (default: ${defaultSize})
    ///   - color: The icon color (default: .primary)
    ///   - action: The action to perform when tapped
    /// - Returns: A button with the icon
    ///
    /// Example:
    /// \`\`\`swift
    /// ${iconEnumName}.close.button {
    ///     dismiss()
    /// }
    /// \`\`\`
    func button(
        size: CGFloat = ${defaultSize},
        color: Color = .primary,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            icon(size: size, color: color)
        }
    }
}

// MARK: - Accessibility

public extension ${iconEnumName} {
    /// Creates an accessible icon with a label for screen readers
    ///
    /// - Parameters:
    ///   - label: The accessibility label for screen readers
    ///   - size: The icon size in points (default: ${defaultSize})
    ///   - color: The icon color (default: .primary)
    /// - Returns: An accessible icon view
    ///
    /// Example:
    /// \`\`\`swift
    /// ${iconEnumName}.add.accessibleIcon(label: "Add item")
    /// \`\`\`
    @ViewBuilder
    func accessibleIcon(
        label: String,
        size: CGFloat = ${defaultSize},
        color: Color = .primary
    ) -> some View {
        icon(size: size, color: color)
            .accessibilityLabel(label)
    }

    /// Creates a decorative icon hidden from screen readers
    ///
    /// Use for icons that are purely decorative and don't convey meaning.
    ///
    /// - Parameters:
    ///   - size: The icon size in points (default: ${defaultSize})
    ///   - color: The icon color (default: .primary)
    /// - Returns: A decorative icon view hidden from accessibility
    @ViewBuilder
    func decorativeIcon(size: CGFloat = ${defaultSize}, color: Color = .primary) -> some View {
        icon(size: size, color: color)
            .accessibilityHidden(true)
    }
}

#if DEBUG
// MARK: - Previews

/// Preview provider for all icons
struct ${iconEnumName}Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 16) {
                ForEach(${iconEnumName}.allCases, id: \\.self) { icon in
                    VStack(spacing: 8) {
                        icon.icon(size: .md)
                        Text(icon.displayName)
                            .font(.caption2)
                            .lineLimit(1)
                    }
                    .frame(width: 80)
                }
            }
            .padding()
        }
        .previewDisplayName("All Icons")
    }
}

/// Preview for icon sizes
struct ${iconEnumName}SizePreviews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            HStack(spacing: 24) {
                ${iconEnumName}.add.icon(size: .xs)
                ${iconEnumName}.add.icon(size: .sm)
                ${iconEnumName}.add.icon(size: .md)
                ${iconEnumName}.add.icon(size: .lg)
                ${iconEnumName}.add.icon(size: .xl)
            }
            HStack(spacing: 24) {
                ${iconEnumName}.add.icon(size: .md, color: .red)
                ${iconEnumName}.add.icon(size: .md, color: .blue)
                ${iconEnumName}.add.icon(size: .md, color: .green)
            }
        }
        .padding()
        .previewDisplayName("Icon Sizes & Colors")
    }
}
#endif
`, filename: `${iconEnumName}.swift` };
}

// ============================================================================
// MAIN
// ============================================================================

async function main() {
  console.log('\n========================================');
  console.log('  iOS SVG Asset Generation');
  console.log('========================================\n');

  // Get input files
  log.step('Scanning optimized SVGs...');
  const svgFiles = getSvgFiles();

  if (svgFiles.length === 0) {
    log.warn('No optimized SVG files found');
    log.info('Run "npm run build:icons:svg" first');
    return { success: true, count: 0 };
  }

  log.success(`Found ${svgFiles.length} SVG file(s)`);

  // Create output directory structure
  const xcassetsDir = path.dirname(PATHS.output);
  if (!fs.existsSync(PATHS.output)) {
    fs.mkdirSync(PATHS.output, { recursive: true });
    log.success('Created Assets.xcassets structure');
  }

  // Write xcassets Contents.json
  const xcassetsContentsPath = path.join(xcassetsDir, 'Contents.json');
  fs.writeFileSync(
    xcassetsContentsPath,
    JSON.stringify(generateXcassetsContents(), null, 2),
    'utf8'
  );

  // Write Icons folder Contents.json
  const iconsContentsPath = path.join(PATHS.output, 'Contents.json');
  fs.writeFileSync(
    iconsContentsPath,
    JSON.stringify(generateFolderContents(), null, 2),
    'utf8'
  );

  // Generate all iOS assets
  log.step('Generating iOS assets...');
  const results = [];

  for (const file of svgFiles) {
    const result = generateIOSAsset(file);
    results.push(result);

    if (result.success) {
      log.info(`${result.name}.imageset/`);
    } else {
      log.error(`${result.name}: ${result.error}`);
    }
  }

  // Generate Swift extension
  log.step('Generating Swift extension...');
  const swiftResult = generateSwiftExtension(results);
  if (!fs.existsSync(PATHS.swift)) {
    fs.mkdirSync(PATHS.swift, { recursive: true });
  }
  const swiftPath = path.join(PATHS.swift, swiftResult.filename);
  fs.writeFileSync(swiftPath, swiftResult.content, 'utf8');
  log.success(`Created ${swiftResult.filename}`);

  // Summary
  console.log('\n========================================');
  console.log('  Summary');
  console.log('========================================\n');

  const successful = results.filter(r => r.success).length;
  const failed = results.filter(r => !r.success).length;

  log.success(`Generated: ${successful}/${results.length} imagesets`);

  if (failed > 0) {
    log.error(`Failed: ${failed} imageset(s)`);
    return { success: false, count: successful, failed };
  }

  log.info(`Output: ${path.dirname(xcassetsDir)}`);

  return { success: true, count: successful };
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

module.exports = { main, PATHS, toiOSName };
