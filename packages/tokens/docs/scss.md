# SCSS Token Maps Documentation

> ⚠️ **Aktuell deaktiviert:** Die SCSS-Ausgabe ist deaktiviert (`SCSS_ENABLED=false` in `scripts/tokens/build.js`).
> Diese Dokumentation bleibt als Referenz erhalten für den Fall, dass die Ausgabe später wieder aktiviert wird.

> **BILD Design System Token Pipeline** | [CSS Documentation](./css.md) | [JS Documentation](./js.md)

This document describes the SCSS output of the BILD Design System token pipeline. The SCSS output uses an **optimized Token Map architecture** for modern SCSS development.

---

## Table of Contents

- [Quick Start](#quick-start)
- [Installation](#installation)
- [Directory Structure](#directory-structure)
- [Token Maps](#token-maps)
- [Helper Functions](#helper-functions)
- [Mixins](#mixins)
- [Dual-Axis Architecture](#dual-axis-architecture)
- [Best Practices](#best-practices)

---

## Quick Start

```scss
// Import the convenience bundle for your brand
@use '@marioschmidt/design-system-tokens/scss/bundles/bild' as tokens;

.headline {
  // Get color from the light mode color map
  color: tokens.get-color(tokens.$bild-colors-light, 'heading-headline-text-color');

  // Apply all typography styles for headline-1
  @include tokens.typography(tokens.$bild-typography, 'headline-1');
}

.card {
  // Get spacing from default density
  padding: tokens.get-spacing(tokens.$bild-spacing-default, 'stack-space-resp-md');

  // Get shadow effect
  box-shadow: tokens.get-shadow(tokens.$bild-effects-light, 'shadow-soft-md');
}

// Responsive design
.component {
  padding: tokens.get-spacing(tokens.$bild-spacing-default, 'stack-space-resp-sm');

  @include tokens.breakpoint(md) {
    padding: tokens.get-spacing(tokens.$bild-spacing-default, 'stack-space-resp-md');
  }

  @include tokens.breakpoint(lg) {
    padding: tokens.get-spacing(tokens.$bild-spacing-default, 'stack-space-resp-lg');
  }
}
```

---

## Installation

```bash
npm install @marioschmidt/design-system-tokens
```

Then import in your SCSS:

```scss
// Option 1: Convenience bundle (recommended)
@use '@marioschmidt/design-system-tokens/scss/bundles/bild' as tokens;

// Option 2: Selective imports
@use '@marioschmidt/design-system-tokens/scss/tokens/bild-colors-light' as colors;
@use '@marioschmidt/design-system-tokens/scss/tokens/bild-typography' as typo;
@use '@marioschmidt/design-system-tokens/scss/functions' as fn;
```

---

## Directory Structure

```
packages/tokens/dist/scss/
├── _index.scss                    # Main entry point
├── _functions.scss                # Helper functions (get-color, get-spacing, etc.)
├── _mixins.scss                   # Breakpoint & typography mixins
├── abstracts/
│   └── _breakpoints.scss          # $breakpoints map
├── shared/
│   ├── _colorprimitive.scss       # Primitive color values
│   ├── _spaceprimitive.scss       # Primitive spacing values
│   ├── _sizeprimitive.scss        # Primitive size values
│   └── _fontprimitive.scss        # Font families, weights
├── tokens/
│   ├── _bild-colors-light.scss    # $bild-colors-light map
│   ├── _bild-colors-dark.scss     # $bild-colors-dark map
│   ├── _bild-typography.scss      # $bild-typography map
│   ├── _bild-effects-light.scss   # $bild-effects-light map
│   ├── _bild-effects-dark.scss    # $bild-effects-dark map
│   ├── _bild-spacing-default.scss # $bild-spacing-default map
│   ├── _bild-spacing-dense.scss   # $bild-spacing-dense map
│   ├── _bild-spacing-spacious.scss # $bild-spacing-spacious map
│   ├── _sportbild-*.scss          # SportBILD token maps
│   ├── _advertorial-*.scss        # Advertorial token maps
│   ├── _colors.scss               # Combined @forward for all color maps
│   ├── _typography.scss           # Combined @forward for all typography maps
│   ├── _effects.scss              # Combined @forward for all effects maps
│   └── _spacing.scss              # Combined @forward for all spacing maps
└── bundles/
    ├── bild.scss                  # BILD convenience bundle
    ├── sportbild.scss             # SportBILD convenience bundle
    └── advertorial.scss           # Advertorial convenience bundle
```

**Build Statistics:**

| Metric | Value |
|--------|-------|
| Total Files | 35 |
| Total Size | 128 KB |
| Reduction | 96% fewer files (from 868) |

---

## Token Maps

All token maps use flat kebab-case keys with categorized prefixes.

### Color Maps

Available maps:
- `$bild-colors-light` / `$bild-colors-dark`
- `$sportbild-colors-light` / `$sportbild-colors-dark`

```scss
$bild-colors-light: (
  // Brand colors
  'brand-text-color-brand': #DD0000,
  'brand-bg-color-brand-solid': #DD0000,
  'brand-bg-color-brand-solid-hover': #C10000,
  'brand-bg-color-brand-tint': #FFDADA,

  // Heading colors
  'heading-headline-text-color': #222628,
  'heading-kicker-text-color': #DD0000,

  // Interactive colors
  'interactive-text-color-idle': #565A5F,
  'interactive-text-color-hover': #222628,
  'interactive-text-color-disabled': #A6ABB0,

  // Surface colors
  'surface-bg-color-primary': #FFFFFF,
  'surface-bg-color-secondary': #F2F4F5,

  // Feedback colors
  'feedback-text-color-success': #006E3E,
  'feedback-text-color-error': #C10000,
  'feedback-text-color-warning': #9E4401,

  // ... 80+ color tokens
);
```

### Typography Maps

Available maps:
- `$bild-typography`
- `$sportbild-typography`
- `$advertorial-typography`

```scss
$bild-typography: (
  // Headline 1
  'headline-1-font-family': "Gotham XNarrow",
  'headline-1-font-weight': 700,
  'headline-1-font-size': 40px,
  'headline-1-line-height': 44px,
  'headline-1-letter-spacing': -0.5px,

  // Headline 2
  'headline-2-font-family': "Gotham XNarrow",
  'headline-2-font-weight': 700,
  'headline-2-font-size': 32px,
  'headline-2-line-height': 36px,

  // Body styles
  'body-font-family': "Gotham Condensed",
  'body-font-weight': 400,
  'body-font-size': 16px,
  'body-line-height': 24px,

  // ... typography tokens for all styles
);
```

### Spacing Maps

Available maps (per brand × density):
- `$bild-spacing-default` / `$bild-spacing-dense` / `$bild-spacing-spacious`
- `$sportbild-spacing-default` / `$sportbild-spacing-dense` / `$sportbild-spacing-spacious`
- `$advertorial-spacing-default` / `$advertorial-spacing-dense` / `$advertorial-spacing-spacious`

```scss
$bild-spacing-default: (
  // Stack space (vertical)
  'stack-space-resp-xs': 4px,
  'stack-space-resp-sm': 8px,
  'stack-space-resp-md': 12px,
  'stack-space-resp-lg': 16px,
  'stack-space-resp-xl': 24px,

  // Inline space (horizontal)
  'inline-space-resp-xs': 4px,
  'inline-space-resp-sm': 8px,
  'inline-space-resp-md': 12px,
  'inline-space-resp-lg': 16px,

  // Constant spacing (non-responsive)
  'stack-space-const-sm': 8px,
  'stack-space-const-md': 12px,
  'stack-space-const-lg': 16px,

  // ... spacing tokens
);
```

### Effects Maps

Available maps:
- `$bild-effects-light` / `$bild-effects-dark`
- `$sportbild-effects-light` / `$sportbild-effects-dark`

```scss
$bild-effects-light: (
  'shadow-soft-sm': (
    1: (
      offset-x: 0px,
      offset-y: 1px,
      blur-radius: 2px,
      spread-radius: 0px,
      color: rgba(0, 0, 0, 0.08)
    ),
    2: (
      offset-x: 0px,
      offset-y: 1px,
      blur-radius: 3px,
      spread-radius: 1px,
      color: rgba(0, 0, 0, 0.1)
    )
  ),
  'shadow-soft-md': ( ... ),
  'shadow-soft-lg': ( ... ),
  'shadow-hard-sm': ( ... ),
  // ... shadow tokens
);
```

---

## Helper Functions

### get-color($map, $key)

Safely retrieves a color value from a color map with fallback warning.

```scss
@use '@marioschmidt/design-system-tokens/scss/bundles/bild' as tokens;

.button {
  background: tokens.get-color(tokens.$bild-colors-light, 'brand-bg-color-brand-solid');
  color: tokens.get-color(tokens.$bild-colors-light, 'brand-text-color-brand');
}

// With dark mode
.button--dark {
  background: tokens.get-color(tokens.$bild-colors-dark, 'brand-bg-color-brand-solid');
}
```

### get-spacing($map, $key)

Retrieves a spacing value from a spacing map.

```scss
.card {
  padding: tokens.get-spacing(tokens.$bild-spacing-default, 'stack-space-resp-md');
  gap: tokens.get-spacing(tokens.$bild-spacing-default, 'inline-space-resp-sm');
}

// Dense layout
.card--dense {
  padding: tokens.get-spacing(tokens.$bild-spacing-dense, 'stack-space-resp-md');
}
```

### get-typography($map, $key)

Retrieves individual typography properties.

```scss
.headline {
  font-family: tokens.get-typography(tokens.$bild-typography, 'headline-1-font-family');
  font-size: tokens.get-typography(tokens.$bild-typography, 'headline-1-font-size');
  font-weight: tokens.get-typography(tokens.$bild-typography, 'headline-1-font-weight');
  line-height: tokens.get-typography(tokens.$bild-typography, 'headline-1-line-height');
}
```

### get-shadow($map, $key)

Retrieves shadow definitions.

```scss
.card {
  box-shadow: tokens.get-shadow(tokens.$bild-effects-light, 'shadow-soft-md');
}
```

---

## Mixins

### breakpoint($name)

Mobile-first breakpoint mixin.

```scss
@use '@marioschmidt/design-system-tokens/scss/bundles/bild' as tokens;

.component {
  // Base styles (xs - mobile)
  padding: 8px;

  @include tokens.breakpoint(sm) {
    // 390px and up (large mobile)
    padding: 12px;
  }

  @include tokens.breakpoint(md) {
    // 600px and up (tablet)
    padding: 16px;
  }

  @include tokens.breakpoint(lg) {
    // 1024px and up (desktop)
    padding: 24px;
  }
}
```

**Breakpoint Values:**

| Name | Min-Width | Device |
|------|-----------|--------|
| `xs` | 320px | Mobile (default, no media query) |
| `sm` | 390px | Large mobile |
| `md` | 600px | Tablet |
| `lg` | 1024px | Desktop |

### typography($map, $style)

Applies all typography properties for a style.

```scss
@use '@marioschmidt/design-system-tokens/scss/bundles/bild' as tokens;

.headline {
  @include tokens.typography(tokens.$bild-typography, 'headline-1');
  // Outputs:
  // font-family: "Gotham XNarrow";
  // font-weight: 700;
  // font-size: 40px;
  // line-height: 44px;
  // letter-spacing: -0.5px;
}

.body-text {
  @include tokens.typography(tokens.$bild-typography, 'body');
}
```

---

## Dual-Axis Architecture

The BILD Design System uses a **Dual-Axis Architecture** that separates color selection from content selection.

### Axes

| Axis | Controls | Brands |
|------|----------|--------|
| **Color** | Colors & Effects | `bild`, `sportbild` |
| **Content** | Typography & Spacing | `bild`, `sportbild`, `advertorial` |

### Advertorial Support

Advertorial has its own typography and spacing but **no color tokens** (uses BILD or SportBILD colors):

```scss
// Advertorial content with BILD colors
@use '@marioschmidt/design-system-tokens/scss/tokens/bild-colors-light' as colors;
@use '@marioschmidt/design-system-tokens/scss/tokens/advertorial-typography' as typo;
@use '@marioschmidt/design-system-tokens/scss/tokens/advertorial-spacing-default' as spacing;
@use '@marioschmidt/design-system-tokens/scss/functions' as fn;

.advertorial-article {
  // BILD colors
  color: fn.get-color(colors.$bild-colors-light, 'heading-headline-text-color');

  // Advertorial typography
  @include fn.typography(typo.$advertorial-typography, 'headline-1');

  // Advertorial spacing
  padding: fn.get-spacing(spacing.$advertorial-spacing-default, 'stack-space-resp-md');
}
```

```scss
// Advertorial content with SportBILD colors
@use '@marioschmidt/design-system-tokens/scss/tokens/sportbild-colors-light' as colors;
@use '@marioschmidt/design-system-tokens/scss/tokens/advertorial-typography' as typo;

.advertorial-article--sport {
  color: fn.get-color(colors.$sportbild-colors-light, 'heading-headline-text-color');
  @include fn.typography(typo.$advertorial-typography, 'headline-1');
}
```

---

## Best Practices

### 1. Use Convenience Bundles

For most projects, use the convenience bundle which includes all tokens:

```scss
@use '@marioschmidt/design-system-tokens/scss/bundles/bild' as tokens;
```

### 2. Use Helper Functions

Always use helper functions instead of direct map access for safer token retrieval:

```scss
// ✅ Good - uses helper function
color: tokens.get-color(tokens.$bild-colors-light, 'heading-headline-text-color');

// ❌ Avoid - direct map access without error handling
color: map.get($bild-colors-light, 'heading-headline-text-color');
```

### 3. Mobile-First Responsive Design

Always start with mobile styles and use breakpoint mixin for larger screens:

```scss
.component {
  // Mobile styles first
  padding: tokens.get-spacing(tokens.$bild-spacing-default, 'stack-space-resp-sm');

  @include tokens.breakpoint(md) {
    // Tablet and up
    padding: tokens.get-spacing(tokens.$bild-spacing-default, 'stack-space-resp-md');
  }
}
```

### 4. Use Typography Mixin for Complete Styles

Instead of setting individual properties, use the typography mixin:

```scss
// ✅ Good - complete typography
@include tokens.typography(tokens.$bild-typography, 'headline-1');

// ❌ Avoid - missing properties
font-size: tokens.get-typography(tokens.$bild-typography, 'headline-1-font-size');
// Missing: font-family, font-weight, line-height, letter-spacing
```

### 5. Density for Layout Variations

Use density maps for different layout modes:

```scss
.card {
  padding: tokens.get-spacing(tokens.$bild-spacing-default, 'stack-space-resp-md');
}

.card--dense {
  padding: tokens.get-spacing(tokens.$bild-spacing-dense, 'stack-space-resp-md');
}

.card--spacious {
  padding: tokens.get-spacing(tokens.$bild-spacing-spacious, 'stack-space-resp-md');
}
```

---

## Migration from Old SCSS Structure

If you were using the previous `scss/brands/{brand}/` structure, migrate to the new Token Maps:

```scss
// ❌ Old (deprecated)
@import '@marioschmidt/design-system-tokens/scss/brands/bild/semantic/color/colormode-light';
.button { background-color: $text-color-accent-constant; }

// ✅ New (Token Maps)
@use '@marioschmidt/design-system-tokens/scss/bundles/bild' as tokens;
.button {
  background: tokens.get-color(tokens.$bild-colors-light, 'brand-bg-color-brand-solid');
}
```

**Key Changes:**

| Old | New |
|-----|-----|
| `@import` | `@use ... as tokens` |
| Individual `$variable` | `get-color($map, 'key')` |
| Per-file imports | Single bundle import |
| 868 files | 35 files |

---

## Related Documentation

| Document | Description |
|----------|-------------|
| [CSS Documentation](./css.md) | CSS Custom Properties |
| [JS Documentation](./js.md) | JavaScript/React integration |
| [Main README](../README.md) | Package overview |

---

**Built with the BILD Design System Token Pipeline**
