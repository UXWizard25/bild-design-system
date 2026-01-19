// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

/**
 * BILD Design System - Swift Package
 *
 * This monorepo provides two iOS packages:
 *
 * 1. BildDesignTokens - Design tokens (colors, typography, spacing, effects)
 * 2. BildIcons - Icon library
 *
 * Installation:
 *   1. In Xcode: File > Add Package Dependencies
 *   2. Enter: https://github.com/UXWizard25/bild-design-system
 *   3. Select the product(s) you need:
 *      - BildDesignTokens (for design tokens)
 *      - BildIcons (for icons)
 *
 * Usage (Tokens):
 *   import BildDesignTokens
 *
 *   .designSystemTheme(
 *       colorBrand: .bild,
 *       contentBrand: .bild,
 *       darkTheme: false,
 *       sizeClass: .compact,
 *       density: .default
 *   )
 *
 *   @Environment(\.designSystemTheme) var theme
 *   theme.colors.textColorPrimary
 *
 * Usage (Icons):
 *   import BildIcons
 *
 *   BildIcon.add.image
 *       .foregroundColor(.primary)
 */

import PackageDescription

let package = Package(
    name: "BildDesignSystem",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "BildDesignTokens",
            targets: ["BildDesignTokens"]
        ),
        .library(
            name: "BildIcons",
            targets: ["BildIcons"]
        )
    ],
    targets: [
        .target(
            name: "BildDesignTokens",
            path: "packages/tokens-ios/Sources/BildDesignTokens"
        ),
        .target(
            name: "BildIcons",
            path: "packages/icons/ios/Sources/BildIcons",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
