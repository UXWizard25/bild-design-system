# CLAUDE.md - BILD Design System Token Pipeline

> Context document for AI assistants. Describes architecture, decisions, and structures.

---

## Quick Reference

```bash
npm run build:tokens    # Full build (preprocess + style-dictionary)
npm run build:bundles   # Regenerate CSS bundles only
npm run build           # Everything (tokens + bundles)
npm run clean           # Delete dist/ and tokens/
```

**Source of Truth:** `src/design-tokens/bild-design-system-raw-data.json` (Figma Export via TokenSync Plugin)

**Platform Documentation:** `README.tokens.md`, `README.android.md`, `README.ios.md`

---

## Design System Architecture Overview

### The 4-Layer Token Hierarchy

The BILD Design System uses a **4-layer token architecture** where each layer references the layer below it. This creates a clear chain of abstraction from raw values to component-specific tokens.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  LAYER 4: COMPONENT TOKENS                                                  │
│  ═══════════════════════════════════════════════════════════════════════   │
│                                                                             │
│  Purpose: Component-specific design decisions                               │
│  Examples: Button, Card, Teaser, Alert, InputField, Navigation, etc.        │
│                                                                             │
│  Collections (per component):                                               │
│  ┌─────────────────┬─────────────────┬─────────────────┬─────────────────┐  │
│  │ {Component}     │ {Component}     │ {Component}     │ {Component}     │  │
│  │ ColorMode       │ Density         │ Breakpoint      │ Typography      │  │
│  │ (light/dark)    │ (3 modes)       │ (4 modes)       │ (4 modes)       │  │
│  └────────┬────────┴────────┬────────┴────────┬────────┴────────┬────────┘  │
│           │                 │                 │                 │           │
│           └─────────────────┴────────┬────────┴─────────────────┘           │
│                                      │                                      │
│                          References LAYER 3                                 │
│                                      ▼                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  LAYER 3: SEMANTIC TOKENS                                                   │
│  ═══════════════════════════════════════════════════════════════════════   │
│                                                                             │
│  Purpose: Meaningful design intent tokens (context-independent)             │
│  Examples: text-color-primary, surface-color-secondary, border-color-*      │
│                                                                             │
│  Collections:                                                               │
│  ┌─────────────────────────────┬─────────────────────────────┐              │
│  │ SemanticColorMode           │ SemanticBreakpoint          │              │
│  │ Modes: light, dark          │ Modes: xs, sm, md, lg       │              │
│  │                             │                             │              │
│  │ + Effects (shadows)         │ + Typography (font sizes)   │              │
│  └─────────────┬───────────────┴─────────────┬───────────────┘              │
│                │                             │                              │
│                └──────────────┬──────────────┘                              │
│                               │                                             │
│                   References LAYER 2                                        │
│                               ▼                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  LAYER 2: BRAND MAPPING + DENSITY                                           │
│  ═══════════════════════════════════════════════════════════════════════   │
│                                                                             │
│  Purpose: Map primitives to brand-specific values                           │
│                                                                             │
│  Collections:                                                               │
│  ┌─────────────────────────────┬─────────────────────────────┐              │
│  │ BrandColorMapping           │ Density                     │              │
│  │ Modes: BILD, SportBILD      │ Modes: default, dense,      │              │
│  │        (NOT Advertorial!)   │        spacious             │              │
│  │                             │                             │              │
│  │ Maps color primitives to    │ UI spacing/sizing variants  │              │
│  │ brand-specific palette      │                             │              │
│  ├─────────────────────────────┤                             │              │
│  │ BrandTokenMapping           │                             │              │
│  │ Modes: BILD, SportBILD,     │                             │              │
│  │        Advertorial          │                             │              │
│  │                             │                             │              │
│  │ Maps non-color primitives   │                             │              │
│  │ (spacing, sizing, fonts)    │                             │              │
│  └─────────────┬───────────────┴─────────────┬───────────────┘              │
│                │                             │                              │
│                └──────────────┬──────────────┘                              │
│                               │                                             │
│                   References LAYER 1                                        │
│                               ▼                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  LAYER 1: PRIMITIVES (Global, Brand-Independent)                            │
│  ═══════════════════════════════════════════════════════════════════════   │
│                                                                             │
│  Purpose: Raw, absolute design values - the foundation                      │
│                                                                             │
│  Collections:                                                               │
│  ┌───────────────┬───────────────┬───────────────┬───────────────┐          │
│  │ ColorPrimitive│ SpacePrimitive│ SizePrimitive │ FontPrimitive │          │
│  │               │               │               │               │          │
│  │ bildred       │ space1x (8px) │ size1x (8px)  │ font-family-  │          │
│  │ bild015       │ space2x (16px)│ size2x (16px) │   gotham      │          │
│  │ bild050       │ space3x (24px)│ size4x (32px) │ font-weight-  │          │
│  │ alpha-*       │ space4x (32px)│ ...           │   bold        │          │
│  │ ...           │ ...           │               │ ...           │          │
│  └───────────────┴───────────────┴───────────────┴───────────────┘          │
│                                                                             │
│  NO MODES - These are absolute values shared across all brands              │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Figma Collections & Modes

### Collection Overview

| Collection | Layer | Modes | Purpose |
|------------|-------|-------|---------|
| **ColorPrimitive** | 1 | None | Raw color values (#DD0000, #232629, etc.) |
| **SpacePrimitive** | 1 | None | Spacing scale (8px, 16px, 24px, etc.) |
| **SizePrimitive** | 1 | None | Size scale for dimensions |
| **FontPrimitive** | 1 | None | Font families, weights, styles |
| **BrandColorMapping** | 2 | BILD, SportBILD | Maps colors to brand palette |
| **BrandTokenMapping** | 2 | BILD, SportBILD, Advertorial | Maps non-color tokens to brands |
| **Density** | 2 | default, dense, spacious | UI density variants |
| **ColorMode** | 3 | light, dark | Light/dark theme colors |
| **BreakpointMode** | 3 | xs, sm, md, lg | Responsive sizing |
| **{Component}*** | 4 | varies | Component-specific tokens |

### Mode Dependencies

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          MODE DEPENDENCY MATRIX                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  Token Type        Depends On          Output Scope                         │
│  ──────────────────────────────────────────────────────────────────────────│
│  Primitives        (none)              Global (:root)                       │
│                                                                             │
│  Semantic Colors   Brand + ColorMode   [data-brand][data-theme]             │
│                                                                             │
│  Semantic Sizing   Brand + Breakpoint  [data-brand] + @media                │
│                                                                             │
│  Density           Brand + Density     [data-brand][data-density]           │
│                                                                             │
│  Component Colors  Brand + ColorMode   [data-brand][data-theme]             │
│                                                                             │
│  Component Sizing  Brand + Breakpoint  [data-brand] + @media                │
│                                                                             │
│  Typography        Brand + Breakpoint  [data-brand] .className              │
│                                                                             │
│  Effects           Brand + ColorMode   [data-brand][data-theme] .className  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Brands Deep Dive

### Brand Characteristics

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              BRAND MATRIX                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                    BILD          SportBILD       Advertorial                │
│  ────────────────────────────────────────────────────────────────────────  │
│                                                                             │
│  Own Colors?       ✅ Yes         ✅ Yes          ❌ NO                      │
│                    (bildred,      (sport colors)  (uses BILD or             │
│                     bild palette)                  SportBILD colors)        │
│                                                                             │
│  Own Sizing?       ✅ Yes         ✅ Yes          ✅ Yes                     │
│                                                                             │
│  Own Typography?   ✅ Yes         ✅ Yes          ✅ Yes                     │
│                                                                             │
│  Own Effects?      ✅ Yes         ✅ Yes          ❌ NO                      │
│                    (shadows)      (shadows)       (uses BILD or             │
│                                                    SportBILD effects)       │
│                                                                             │
│  Components?       ✅ Full set    ✅ Full set     ⚠️ Partial set            │
│                    (~55)          (~55)           (subset)                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### The Advertorial Problem → Dual-Axis Solution

**Problem:** Advertorial content needs its own sizing/typography but should use BILD or SportBILD colors depending on context.

**Solution:** Separate brand selection into two independent axes:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       DUAL-AXIS ARCHITECTURE                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  AXIS 1: ColorBrand (determines colors + effects)                           │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                                                                     │    │
│  │    ┌─────────────┐          ┌─────────────┐                         │    │
│  │    │    BILD     │          │  SportBILD  │     (only 2 options)    │    │
│  │    │             │          │             │                         │    │
│  │    │  bildred    │          │  sport-red  │                         │    │
│  │    │  bild015    │          │  sport-015  │                         │    │
│  │    │  shadows    │          │  shadows    │                         │    │
│  │    └─────────────┘          └─────────────┘                         │    │
│  │                                                                     │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│  AXIS 2: ContentBrand (determines sizing + typography)                      │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                                                                     │    │
│  │    ┌─────────────┐   ┌─────────────┐   ┌─────────────┐              │    │
│  │    │    BILD     │   │  SportBILD  │   │ Advertorial │  (3 options) │    │
│  │    │             │   │             │   │             │              │    │
│  │    │  spacing    │   │  spacing    │   │  spacing    │              │    │
│  │    │  font-sizes │   │  font-sizes │   │  font-sizes │              │    │
│  │    │  typography │   │  typography │   │  typography │              │    │
│  │    └─────────────┘   └─────────────┘   └─────────────┘              │    │
│  │                                                                     │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│  COMBINATION EXAMPLES:                                                      │
│  ──────────────────────────────────────────────────────────────────────    │
│                                                                             │
│  ColorBrand: BILD      + ContentBrand: BILD        = Standard BILD app      │
│  ColorBrand: SportBILD + ContentBrand: SportBILD   = Standard SportBILD app │
│  ColorBrand: BILD      + ContentBrand: Advertorial = Advertorial in BILD    │
│  ColorBrand: SportBILD + ContentBrand: Advertorial = Advertorial in Sport   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Modes In Detail

### Color Modes

| Mode | Purpose | CSS Selector |
|------|---------|--------------|
| `light` | Default light theme | `[data-theme="light"]` |
| `dark` | Dark theme | `[data-theme="dark"]` |

### Breakpoint Modes

| Mode | Min-Width | Device Class | Native Mapping |
|------|-----------|--------------|----------------|
| `xs` | 320px | Mobile (default) | `compact` |
| `sm` | 390px | Large mobile | `compact` |
| `md` | 600px | Tablet | `regular` |
| `lg` | 1024px | Desktop | `regular` |

```
Web Breakpoints              Native SizeClass
═══════════════              ════════════════

    xs (320px) ─────┐
                    ├──────────────→  compact
    sm (390px) ─────┘

    md (600px) ─────┐
                    ├──────────────→  regular
    lg (1024px) ────┘
```

### Density Modes

| Mode | Purpose | Use Case |
|------|---------|----------|
| `default` | Standard spacing | Normal UI |
| `dense` | Compact spacing | Data-heavy views, lists |
| `spacious` | Generous spacing | Hero sections, marketing |

---

## Token Reference Chain (Alias Resolution)

Tokens reference each other through aliases. Here's how a button color token resolves:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         ALIAS RESOLUTION CHAIN                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  LAYER 4: Component Token                                                   │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │  button-primary-bg-color                                            │    │
│  │  └──→ references: core-color-primary                                │    │
│  └────────────────────────────────────────────────────────────────┬────┘    │
│                                                                   │         │
│                                                                   ▼         │
│  LAYER 3: Semantic Token                                                    │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │  core-color-primary                                                 │    │
│  │  └──→ references: {BrandColorMapping.primary}                       │    │
│  └────────────────────────────────────────────────────────────────┬────┘    │
│                                                                   │         │
│                                                                   ▼         │
│  LAYER 2: Brand Mapping (resolves per brand mode)                           │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │  BrandColorMapping.primary                                          │    │
│  │  ├── Mode BILD:      → bildred                                      │    │
│  │  └── Mode SportBILD: → sportred                                     │    │
│  └────────────────────────────────────────────────────────────────┬────┘    │
│                                                                   │         │
│                                                                   ▼         │
│  LAYER 1: Primitive (final value)                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │  bildred = #DD0000                                                  │    │
│  │  sportred = #E30613                                                 │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│  CSS OUTPUT (preserves chain with var() fallbacks):                         │
│  ──────────────────────────────────────────────────────────────────────    │
│                                                                             │
│  :root {                                                                    │
│    --bildred: #DD0000;                                                      │
│  }                                                                          │
│                                                                             │
│  [data-brand="bild"][data-theme="light"] {                                  │
│    --core-color-primary: var(--bildred, #DD0000);                           │
│    --button-primary-bg-color: var(--core-color-primary, #DD0000);           │
│  }                                                                          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Platform Output Patterns

### Web (CSS)

```html
<html data-brand="bild" data-theme="light" data-density="default">
```

| Token Type | CSS Selector Pattern |
|------------|---------------------|
| Primitives | `:root { --token: value; }` |
| Semantic Colors | `[data-brand][data-theme] { --token: var(...); }` |
| Breakpoint Sizing | `[data-brand] { } @media (...) { }` |
| Density | `[data-brand][data-density] { }` |
| Typography | `[data-brand] .className { }` |
| Effects | `[data-brand][data-theme] .className { }` |

### iOS (SwiftUI)

```swift
// Theme setup
.designSystemTheme(
    colorBrand: .bild,
    contentBrand: .bild,
    darkTheme: false,
    sizeClass: .compact,
    density: .default
)

// Polymorphic access via protocols
@Environment(\.designSystemTheme) var theme
theme.colors.textColorPrimary     // any DesignColorScheme
theme.sizing.gridSpaceRespBase    // any DesignSizingScheme
theme.effects.shadowSoftMd        // any DesignEffectsScheme
```

### Android (Jetpack Compose)

```kotlin
// Theme setup
DesignSystemTheme(
    colorBrand = ColorBrand.Bild,
    contentBrand = ContentBrand.Bild,
    darkTheme = isSystemInDarkTheme(),
    sizeClass = WindowSizeClass.Compact,
    density = Density.Default
) {
    // Polymorphic access via interfaces
    DesignSystemTheme.colors.textColorPrimary  // DesignColorScheme
    DesignSystemTheme.sizing.gridSpaceRespBase // DesignSizingScheme

    // Component tokens via current()
    ButtonTokens.Colors.current().buttonPrimaryBgColorIdle
}
```

---

## Unified Interfaces (Native Platforms)

For polymorphic brand access, all brand-specific implementations conform to unified interfaces:

| Interface/Protocol | Properties | Implementations |
|--------------------|------------|-----------------|
| `DesignColorScheme` | 80+ color tokens | `BildLightColors`, `BildDarkColors`, `SportbildLightColors`, `SportbildDarkColors` |
| `DesignSizingScheme` | 180+ sizing tokens | `BildSizingCompact`, `BildSizingRegular`, `SportbildSizing*`, `AdvertorialSizing*` |
| `DesignEffectsScheme` | Shadow tokens (iOS) | `BildEffectsLight`, `BildEffectsDark`, `SportbildEffects*` |

**Benefit:** Code can work with `any DesignColorScheme` without knowing the specific brand.

---

## Build Pipeline

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              BUILD PIPELINE                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  FIGMA (Source of Truth)                                                    │
│  └── Variables with scopes, modes, and aliases                              │
│              │                                                              │
│              │ TokenSync Plugin Export                                      │
│              ▼                                                              │
│  src/design-tokens/bild-design-system-raw-data.json (~1MB)                  │
│              │                                                              │
│              │ preprocess.js                                                │
│              │ • Parse Figma JSON structure                                 │
│              │ • Resolve aliases per brand × mode context                   │
│              │ • Detect component tokens from naming                        │
│              │ • Extract composite tokens (typography, effects)             │
│              ▼                                                              │
│  tokens/ (~920 JSON files in Style Dictionary format)                       │
│  ├── shared/primitives (colorprimitive, spaceprimitive, etc.)               │
│  └── brands/{brand}/ (color, density, semantic, components)                 │
│              │                                                              │
│              │ build.js + style-dictionary.config.js                        │
│              │ • Platform-specific transforms                               │
│              │ • Custom format functions                                    │
│              │ • Native theme provider generation                           │
│              ▼                                                              │
│  dist/ (Platform outputs)                                                   │
│  ├── css/, scss/, js/, json/                                                │
│  ├── ios/ (Swift)                                                           │
│  └── android/compose/ (Kotlin)                                              │
│              │                                                              │
│              │ bundles.js                                                   │
│              ▼                                                              │
│  dist/css/bundles/ (Convenience CSS bundles per brand)                      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Key Files

| File | Purpose |
|------|---------|
| `scripts/tokens/preprocess.js` | Figma JSON → Style Dictionary format |
| `scripts/tokens/build.js` | Orchestrates Style Dictionary builds |
| `build-config/tokens/style-dictionary.config.js` | Custom transforms & formats |
| `scripts/tokens/bundles.js` | CSS bundle generation |

---

## Architecture Decisions

| Decision | Rationale |
|----------|-----------|
| **@media over data-breakpoint** | Native browser support, no JS required, SSR-compatible |
| **var() with fallbacks** | Robustness if variables missing, easier debugging |
| **Separate mode files** | Lazy loading, better caching, easier debugging |
| **Dual-Axis architecture** | Enables Advertorial + brand colors combination |
| **Unified interfaces** | Polymorphic access, type-safety, runtime brand switching |
| **Typography as classes** | Groups related properties (font-size, weight, line-height) |
| **4→2 breakpoint mapping** | Native apps typically need only 2 layouts |

---

## Change Guide

| Task | Files to Modify |
|------|-----------------|
| Change token values | In Figma (Source of Truth) |
| Modify output format | `style-dictionary.config.js` |
| Change alias resolution | `preprocess.js` |
| Add new brand | `preprocess.js`, `build.js`, `bundles.js` |
| Add new breakpoint | `preprocess.js`, `build.js` |
| Enable/disable platform | `build.js` (toggle flags) |
| Modify component token pattern | `style-dictionary.config.js` |

---

## Common Issues

| Problem | Likely Cause | Solution |
|---------|--------------|----------|
| Empty CSS files | Figma Collection ID changed | Check COLLECTION_IDS in preprocess.js |
| Missing aliases | Figma mode name changed | Verify mode names in Figma |
| Native build errors | Interface out of sync | Check unified interface generation |
| Wrong colors | ColorBrand/ContentBrand mismatch | Verify Dual-Axis configuration |
| Missing tokens | Scope not assigned in Figma | Add appropriate scope in Figma |
