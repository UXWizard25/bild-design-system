// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

/**
 * BILD Design System Icons - Swift Package
 *
 * Provides SwiftUI-compatible icon assets for iOS and macOS.
 *
 * Usage:
 *   import BildIcons
 *
 *   // Using the enum
 *   Image(BildIcon.add.rawValue)
 *       .foregroundColor(.primary)
 *
 *   // Using the convenience extension
 *   BildIcon.add.image
 *       .foregroundColor(.primary)
 */

import PackageDescription

let package = Package(
    name: "BildDesignSystemIcons",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "BildIcons",
            targets: ["BildIcons"]
        )
    ],
    targets: [
        .target(
            name: "BildIcons",
            path: "Sources/BildIcons",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
