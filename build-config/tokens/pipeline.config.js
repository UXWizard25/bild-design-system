/**
 * Multi-Design-System Pipeline Configuration
 *
 * This file is the SINGLE SOURCE OF TRUTH for all pipeline settings.
 * To adapt for a different design system, modify this file + Figma export JSON.
 *
 * Architecture invariants (NOT configurable - enforced by pipeline):
 * - 4-Layer Hierarchy (Primitives → Mapping → Semantic → Components)
 * - Dual-Axis Architecture (ColorBrand + ContentBrand)
 * - Shadow DOM support (:host() selectors always generated)
 * - Effects are brand-independent (only light/dark)
 * - Density is brand-independent (shared across brands)
 * - lineHeight as unitless ratio (CSS best practice)
 * - var() reference chains with conditional fallbacks
 * - @media queries for responsive breakpoints (mobile-first)
 *
 * File structure:
 * 1. rawConfig - User-configurable values
 * 2. derived - Auto-computed values from rawConfig (no manual sync needed)
 * 3. Runtime functions - Require Figma data (deriveColorBrands, etc.)
 */

// =============================================================================
// RAW CONFIG - User-configurable values
// =============================================================================

const rawConfig = {
  // ===========================================================================
  // IDENTITY
  // Used in generated file headers, documentation, and package metadata.
  // ===========================================================================
  identity: {
    /** Full display name shown in generated file headers and documentation */
    name: 'BILD Design System',

    /** Short identifier used in paths, CSS class prefixes, and IDs */
    shortName: 'bild',

    /** Copyright holder for license headers in generated files */
    copyright: 'Axel Springer Deutschland GmbH',

    /** Repository URL for documentation links and package.json repository field */
    repositoryUrl: 'https://github.com/UXWizard25/bild-design-system',
  },

  // ===========================================================================
  // BRANDS
  // Each key becomes a brand identifier used in:
  // - File paths: brands/{key}/...
  // - CSS selectors: [data-color-brand="{key}"], [data-content-brand="{key}"]
  // - Native enums: ColorBrand.{Key}, ContentBrand.{Key}
  // - JS exports: brands.{key}
  //
  // ⚠️  NAMING CONSTRAINT: Keys must NOT contain hyphens ('-').
  //     Use camelCase or single words (e.g., 'sportbild', 'myBrand').
  //     Reason: Keys become CSS custom property segments where hyphens
  //     are used as delimiters, making parsing ambiguous.
  // ===========================================================================
  brands: {
    /**
     * BILD - Main brand
     * @property {string} figmaName - Exact mode name in Figma (case-sensitive).
     *           Used to match modes across BrandTokenMapping and BrandColorMapping
     *           collections. Must match exactly what appears in Figma.
     * @property {boolean} isDefault - This brand is used for:
     *           - Native CompositionLocal/Environment defaults
     *           - JS createTheme() fallback brand
     *           - Default selection in Storybook toolbar
     */
    bild: {
      figmaName: 'BILD',
      isDefault: true,
    },

    /**
     * SportBILD - Sports brand variant
     */
    sportbild: {
      figmaName: 'SportBILD',
    },

    /**
     * Advertorial - Advertising content brand
     * Note: This brand has NO entry in BrandColorMapping (uses parent colors).
     * The pipeline automatically detects this from Figma data.
     */
    advertorial: {
      figmaName: 'Advertorial',
    },
  },

  // ===========================================================================
  // MODES
  // Defines all theming axes: color themes, density variants, and breakpoints.
  //
  // ⚠️  NAMING CONSTRAINT: All mode keys must NOT contain hyphens ('-').
  //     Use camelCase or single words.
  //     Reason: Mode names are embedded in CSS custom property names
  //     (e.g., --density-{mode}-stack-space-resp-md). Hyphens make it
  //     impossible to distinguish mode boundaries from token segments.
  // ===========================================================================
  modes: {
    /**
     * Color/theme modes (light/dark theming)
     * Controls semantic color tokens and effects.
     *
     * @property {string} figmaId - Mode ID from ColorMode collection in Figma.
     *           Found in Figma: Variables → ColorMode collection → mode settings.
     * @property {boolean} [isDefault] - Initial theme for:
     *           - JS createTheme() default colorMode parameter
     *           - SSR/initial page render
     *           - Storybook initial state
     */
    color: {
      light: { figmaId: '588:0', isDefault: true },
      dark: { figmaId: '592:1' },
    },

    /**
     * Density modes for spacing variants
     * Controls stack-space, inline-space, and component-specific spacing.
     *
     * @property {string} figmaId - Mode ID from Density collection in Figma.
     * @property {boolean} [isDefault] - Initial density for:
     *           - JS createTheme() default density parameter
     *           - Native CompositionLocal defaults
     */
    density: {
      default: { figmaId: '5695:2', isDefault: true },
      dense: { figmaId: '5695:1' },
      spacious: { figmaId: '5695:3' },
    },

    /**
     * Responsive breakpoints for @media queries
     * Order in this object determines the cascade order in CSS.
     * The breakpoint with isBase=true is the mobile-first base (no @media query).
     *
     * @property {string} figmaId - Mode ID from BreakpointMode collection in Figma.
     * @property {number} minWidth - CSS min-width value in pixels for @media query.
     *           Example: minWidth: 600 → @media (min-width: 600px) { }
     * @property {boolean} [isBase] - If true, this breakpoint is the mobile-first base:
     *           - No @media query generated (styles apply by default)
     *           - Used as reference for responsive token comparisons
     *           - Typically the smallest breakpoint (mobile)
     */
    breakpoints: {
      xs: { figmaId: '7017:0', minWidth: 320, isBase: true },
      sm: { figmaId: '16706:1', minWidth: 390 },
      md: { figmaId: '7015:1', minWidth: 600 },
      lg: { figmaId: '7015:2', minWidth: 1024 },
    },
  },

  // ===========================================================================
  // FIGMA
  // Figma-specific identifiers. These are stable references tied to the
  // specific Figma file structure. They change only if collections are
  // renamed or recreated in Figma.
  // ===========================================================================
  figma: {
    /**
     * Figma export filename (CodeBridge Plugin output)
     * This file is placed in paths.tokensInput directory.
     */
    inputFile: 'bild-design-system-raw-data.json',

    /**
     * Figma Variable Collection IDs
     * Found in Figma: Variables panel → Collection settings → ID
     * These IDs are stable unless collections are deleted and recreated.
     */
    collections: {
      /** Font families, weights - Layer 0 primitive */
      FONT_PRIMITIVE: 'VariableCollectionId:470:1450',
      /** Color palette (hex values) - Layer 0 primitive */
      COLOR_PRIMITIVE: 'VariableCollectionId:539:2238',
      /** Size scale (px values) - Layer 0 primitive */
      SIZE_PRIMITIVE: 'VariableCollectionId:4072:1817',
      /** Spacing scale (px values) - Layer 0 primitive */
      SPACE_PRIMITIVE: 'VariableCollectionId:2726:12077',
      /** Density variants - Layer 1 mapping (brand-independent) */
      DENSITY: 'VariableCollectionId:5695:5841',
      /** Brand token mapping (sizing, typography) - Layer 1 mapping */
      BRAND_TOKEN_MAPPING: 'VariableCollectionId:18038:10593',
      /** Brand color mapping - Layer 1 mapping (determines colorBrands) */
      BRAND_COLOR_MAPPING: 'VariableCollectionId:18212:14495',
      /** Responsive breakpoints - Layer 2 semantic */
      BREAKPOINT_MODE: 'VariableCollectionId:7017:25696',
      /** Light/dark themes - Layer 2 semantic */
      COLOR_MODE: 'VariableCollectionId:588:1979',
    },

    /**
     * Token path prefix that identifies Component tokens (Layer 3)
     * Tokens with paths starting with this prefix are treated as component tokens.
     * Example: "Component/Button/primary-bg" → component token for Button
     */
    componentPrefix: 'Component/',
  },

  // ===========================================================================
  // CSS
  // CSS-specific output configuration.
  // ===========================================================================
  css: {
    /**
     * CSS font-size output unit
     * - 'px': Traditional pixel values (e.g., "21px") - predictable, design-accurate
     * - 'rem': Accessibility-friendly relative units (e.g., "1.3125rem") - scales with user preference
     *
     * Note: lineHeight is ALWAYS unitless (ratio) regardless of this setting.
     * Note: Native platforms (iOS/Android) are unaffected - they always use pt/dp.
     */
    fontSizeUnit: 'px',

    /**
     * Base font size for rem calculations (browser default: 16px)
     * Only used when fontSizeUnit is 'rem'.
     * Example: 21px with remBase 16 → 1.3125rem
     */
    remBase: 16,

    /**
     * HTML data-attribute names for CSS selector targeting
     * These appear in generated CSS selectors like [data-color-brand="bild"].
     * Also used in Storybook toolbar controls and native platform bindings.
     */
    dataAttributes: {
      /** Attribute for color/effects brand selection */
      colorBrand: 'data-color-brand',
      /** Attribute for content/sizing/typography brand selection */
      contentBrand: 'data-content-brand',
      /** Attribute for light/dark theme selection */
      theme: 'data-theme',
      /** Attribute for density mode selection */
      density: 'data-density',
    },
  },

  // ===========================================================================
  // PLATFORMS
  // Enable/disable platform outputs and platform-specific settings.
  // ===========================================================================
  platforms: {
    /**
     * CSS/Web output
     * Generates: primitives.css, theme files, component files, bundles
     */
    css: {
      enabled: true,
    },

    /**
     * iOS/Swift output (Swift Package Manager)
     * Generates: Swift structs, protocols, theme provider
     */
    ios: {
      enabled: true,

      /** Swift Package Manager module name (import BildDesignTokens) */
      moduleName: 'BildDesignTokens',

      /**
       * iOS SizeClass to breakpoint mapping (Apple HIG: 2 size classes)
       * Maps UIUserInterfaceSizeClass values to breakpoint keys.
       * Used in DesignSystemTheme for responsive token resolution.
       */
      sizeClasses: {
        /** UIUserInterfaceSizeClass.compact → uses 'sm' breakpoint tokens */
        compact: 'sm',
        /** UIUserInterfaceSizeClass.regular → uses 'lg' breakpoint tokens */
        regular: 'lg',
      },
    },

    /**
     * Android/Kotlin output (Maven/Gradle)
     * Generates: Kotlin objects, interfaces, Compose theme provider
     */
    android: {
      enabled: true,

      /** Kotlin package namespace (package com.bild.designsystem) */
      packageName: 'com.bild.designsystem',

      /**
       * Android WindowSizeClass to breakpoint mapping (Material 3: 3 size classes)
       * Maps WindowSizeClass values to breakpoint keys.
       * Used in DesignSystemTheme for responsive token resolution.
       */
      sizeClasses: {
        /** WindowWidthSizeClass.Compact (<600dp) → uses 'sm' breakpoint tokens */
        compact: 'sm',
        /** WindowWidthSizeClass.Medium (600-839dp) → uses 'md' breakpoint tokens */
        medium: 'md',
        /** WindowWidthSizeClass.Expanded (≥840dp) → uses 'lg' breakpoint tokens */
        expanded: 'lg',
      },
    },
  },

  // ===========================================================================
  // PATHS
  // Directory paths relative to repository root.
  // Centrally defined for consistency across all scripts.
  // ===========================================================================
  paths: {
    /** Input directory containing Figma export JSON */
    tokensInput: 'packages/tokens/src/',

    /** Intermediate directory for preprocessed Style Dictionary tokens */
    tokensIntermediate: 'packages/tokens/.tokens/',

    /** Distribution directory for built token outputs (css/, json/) */
    tokensDist: 'packages/tokens/dist/',

    /** iOS Swift output directory */
    iosOutput: 'packages/tokens-ios/Sources/BildDesignTokens/',

    /** Android Kotlin output directory */
    androidOutput: 'packages/tokens-android/src/main/kotlin/com/bild/designsystem/',

    /** Stencil Web Components source directory */
    componentsSrc: 'packages/components/core/src',
  },

  // ===========================================================================
  // PACKAGES
  // Package identifiers for npm, Maven, and SPM registries.
  // ===========================================================================
  packages: {
    /** npm package: @scope/design-system-tokens */
    tokens: '@marioschmidt/design-system-tokens',

    /** npm package: @scope/design-system-components (Stencil) */
    components: '@marioschmidt/design-system-components',

    /** npm package: @scope/design-system-react (React wrappers) */
    react: '@marioschmidt/design-system-react',

    /** npm package: @scope/design-system-vue (Vue 3 wrappers) */
    vue: '@marioschmidt/design-system-vue',
  },

  // ===========================================================================
  // STENCIL
  // Stencil Web Components library configuration.
  // ===========================================================================
  stencil: {
    /**
     * Web Component namespace
     * Used as: tag prefix (<bds-button>), loader name (bds.esm.js), dist folder
     */
    namespace: 'bds',

    /**
     * Component tag prefix for source files
     * Used to identify component CSS files: ds-button.css, ds-card.css
     */
    componentPrefix: 'ds-',
  },

  // ===========================================================================
  // DEPLOYMENT
  // Hosting and deployment configuration.
  // ===========================================================================
  deployment: {
    /**
     * Base path for Storybook on GitHub Pages
     * Must match the repository name for correct asset loading.
     * Example: '/bild-design-system/' for https://user.github.io/bild-design-system/
     */
    storybookBasePath: '/bild-design-system/',
  },
};

// =============================================================================
// DERIVED VALUES - Auto-computed from rawConfig
// These values are derived automatically - no manual synchronization needed.
// =============================================================================

const allBrands = Object.keys(rawConfig.brands);
const colorModes = Object.keys(rawConfig.modes.color);
const densityModes = Object.keys(rawConfig.modes.density);
const breakpoints = Object.keys(rawConfig.modes.breakpoints);

const derived = {
  // ---------------------------------------------------------------------------
  // Brand-derived values
  // ---------------------------------------------------------------------------

  /** All brand keys: ['bild', 'sportbild', 'advertorial'] */
  allBrands,

  /** Default brand key (has isDefault: true) */
  defaultBrand: allBrands.find(b => rawConfig.brands[b].isDefault) || allBrands[0],

  /** Brand key → Figma display name mapping */
  brandToFigmaName: Object.fromEntries(
    allBrands.map(key => [key, rawConfig.brands[key].figmaName])
  ),

  /** Figma display name → brand key (reverse lookup) */
  figmaNameToBrand: Object.fromEntries(
    allBrands.map(key => [rawConfig.brands[key].figmaName, key])
  ),

  /** Display names for UI (equals figmaName) */
  brandDisplayNames: Object.fromEntries(
    allBrands.map(key => [key, rawConfig.brands[key].figmaName])
  ),

  // ---------------------------------------------------------------------------
  // Color mode-derived values
  // ---------------------------------------------------------------------------

  /** All color mode keys: ['light', 'dark'] */
  colorModes,

  /** Default color mode key (has isDefault: true) */
  defaultColorMode: colorModes.find(m => rawConfig.modes.color[m].isDefault) || colorModes[0],

  /** Color mode key → Figma mode ID mapping */
  colorModeIds: Object.fromEntries(
    colorModes.map(key => [key, rawConfig.modes.color[key].figmaId])
  ),

  /** Display names for color modes */
  colorModeDisplayNames: Object.fromEntries(
    colorModes.map(key => [key, key.charAt(0).toUpperCase() + key.slice(1)])
  ),

  // ---------------------------------------------------------------------------
  // Density mode-derived values
  // ---------------------------------------------------------------------------

  /** All density mode keys: ['default', 'dense', 'spacious'] */
  densityModes,

  /** Default density mode key (has isDefault: true) */
  defaultDensity: densityModes.find(m => rawConfig.modes.density[m].isDefault) || densityModes[0],

  /** Density mode key → Figma mode ID mapping */
  densityModeIds: Object.fromEntries(
    densityModes.map(key => [key, rawConfig.modes.density[key].figmaId])
  ),

  /** Display names for density modes */
  densityDisplayNames: Object.fromEntries(
    densityModes.map(key => [key, key.charAt(0).toUpperCase() + key.slice(1)])
  ),

  // ---------------------------------------------------------------------------
  // Breakpoint-derived values
  // ---------------------------------------------------------------------------

  /** All breakpoint keys in order: ['xs', 'sm', 'md', 'lg'] */
  breakpoints,

  /** Base breakpoint key (has isBase: true, no @media query) */
  baseBreakpoint: breakpoints.find(bp => rawConfig.modes.breakpoints[bp].isBase) || breakpoints[0],

  /** Breakpoint key → Figma mode ID mapping */
  breakpointModeIds: Object.fromEntries(
    breakpoints.map(key => [key, rawConfig.modes.breakpoints[key].figmaId])
  ),

  /** Breakpoint key → minWidth in px */
  breakpointMinWidths: Object.fromEntries(
    breakpoints.map(key => [key, rawConfig.modes.breakpoints[key].minWidth])
  ),
};

// =============================================================================
// RUNTIME FUNCTIONS - Require Figma collection data
// These functions derive colorBrands/contentBrands from actual Figma data.
// =============================================================================

/**
 * Derives colorBrands from Figma collections.
 * ColorBrands are brands that have their own entry in BrandColorMapping.
 * Brands without BrandColorMapping inherit colors from a parent brand.
 *
 * @param {Array} collections - Figma collections array from plugin export
 * @returns {string[]} Brand keys that exist in BrandColorMapping
 *
 * @example
 * const colorBrands = deriveColorBrands(pluginData.collections);
 * // Returns: ['bild', 'sportbild'] (advertorial not included - no own colors)
 */
function deriveColorBrands(collections) {
  const collection = collections.find(c => c.id === rawConfig.figma.collections.BRAND_COLOR_MAPPING);
  if (!collection) return [];
  return allBrands.filter(brandKey =>
    collection.modes.some(m => m.name === rawConfig.brands[brandKey].figmaName)
  );
}

/**
 * Derives contentBrands from Figma collections.
 * ContentBrands are brands that have their own entry in BrandTokenMapping.
 * These brands have their own sizing/typography definitions.
 *
 * @param {Array} collections - Figma collections array from plugin export
 * @returns {string[]} Brand keys that exist in BrandTokenMapping
 *
 * @example
 * const contentBrands = deriveContentBrands(pluginData.collections);
 * // Returns: ['bild', 'sportbild', 'advertorial']
 */
function deriveContentBrands(collections) {
  const collection = collections.find(c => c.id === rawConfig.figma.collections.BRAND_TOKEN_MAPPING);
  if (!collection) return [];
  return allBrands.filter(brandKey =>
    collection.modes.some(m => m.name === rawConfig.brands[brandKey].figmaName)
  );
}

/**
 * Checks if a brand has BrandColorMapping (i.e., is a colorBrand).
 * Used during token processing to skip color generation for inherited brands.
 *
 * @param {Array} collections - Figma collections array
 * @param {string} brandKey - Brand key to check (e.g., 'advertorial')
 * @returns {boolean} True if brand exists in BrandColorMapping
 *
 * @example
 * if (!hasBrandColorMapping(collections, 'advertorial')) {
 *   // Skip color token generation for advertorial
 * }
 */
function hasBrandColorMapping(collections, brandKey) {
  const figmaName = rawConfig.brands[brandKey]?.figmaName || brandKey;
  const collection = collections.find(c => c.id === rawConfig.figma.collections.BRAND_COLOR_MAPPING);
  return collection?.modes.some(m => m.name === figmaName) ?? false;
}

// =============================================================================
// EXPORT - Flat structure for easy destructuring
// =============================================================================

module.exports = {
  // Raw config sections (spread for flat access)
  ...rawConfig,

  // Derived values (spread for flat access)
  ...derived,

  // Runtime functions
  deriveColorBrands,
  deriveContentBrands,
  hasBrandColorMapping,
};
