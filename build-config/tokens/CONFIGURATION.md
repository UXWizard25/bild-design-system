# Pipeline Configuration Guide

> Documentation of Figma dependencies and configuration options for the token pipeline system.

---

## Overview

The token pipeline uses **explicit Mode ID → Key mappings** for stability:

| Source | What is configured |
|--------|-------------------|
| **pipeline.config.js** | Mode ID → Key mappings, Collection IDs, Breakpoints, Platform settings |
| **Figma (validated)** | Token values (validated against configured Mode IDs) |

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       CONFIGURATION ARCHITECTURE                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  pipeline.config.js (Source of Truth for Structure)                         │
│  ════════════════════════════════════════════════════                        │
│  ⚙️  Explicitly configured:                                                  │
│     • Mode ID → Key mappings (stable references)                            │
│       - Brands: '18038:0' → 'bild', '18094:0' → 'sportbild'                 │
│       - Color modes: '588:0' → 'light', '592:1' → 'dark'                    │
│       - Density: '5695:2' → 'default', '5695:1' → 'dense'                   │
│       - Breakpoints: '7017:0' → { key: 'xs', minWidth: 320 }                │
│     • Collection IDs (Figma references)                                     │
│     • Platform settings (CSS unit, native mappings)                         │
│     • Output paths and package names                                        │
│                                                                             │
│  Figma Source (bild-design-system-raw-data.json)                            │
│  ════════════════════════════════════════════════                           │
│  ✅ Validated at build time:                                                 │
│     • Mode IDs must exist in Figma (build fails otherwise)                  │
│     • Unmapped Figma modes trigger warnings                                 │
│     • Token values are processed per configured mappings                    │
│                                                                             │
│  Why Mode IDs instead of Names?                                             │
│  ════════════════════════════════════════════════════                        │
│  • Mode IDs are stable (only change when mode is deleted/recreated)         │
│  • Mode names can be freely renamed by designers                            │
│  • Prevents silent breaking changes from Figma renames                      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Figma Dependencies (Architecture Requirements)

### 1. Collection Structure (CRITICAL)

The pipeline expects these Figma Variable Collections:

| Collection | Purpose | Layer |
|------------|---------|-------|
| `_ColorPrimitive` | Base color values | 0 |
| `_SpacePrimitive` | Spacing scale | 0 |
| `_SizePrimitive` | Size scale | 0 |
| `_FontPrimitive` | Font families, weights | 0 |
| `BrandTokenMapping` | Brand → Sizing/Typography | 1 |
| `BrandColorMapping` | Brand → Colors | 1 |
| `Density` | Density modes | 1 |
| `ColorMode` | Light/Dark theme | 2 |
| `BreakpointMode` | Responsive breakpoints | 2 |

**Important:** Collection names can be anything, but the **Collection IDs** must be correctly configured in `pipeline.config.js`.

### 2. Mode ID → Key Mapping

The pipeline uses **explicit ID → Key mappings** in `pipeline.config.js`:

```javascript
modes: {
  brands: {
    color: {
      '18212:0': 'bild',       // Figma Mode ID → Pipeline Key
      '18212:1': 'sportbild',
    },
    content: {
      '18038:0': 'bild',
      '18094:0': 'sportbild',
      '18094:1': 'advertorial',
    },
    default: 'bild',
  },
  colorModes: {
    '588:0': 'light',
    '592:1': 'dark',
  },
  // ...
}
```

**Why Mode IDs?**
- Mode IDs are stable in Figma (only change when mode is deleted/recreated)
- Mode names can be freely renamed by designers without breaking the build
- Explicit mapping prevents silent breaking changes

**Finding Mode IDs:** Look in `bild-design-system-raw-data.json` under `collections[].modes[].modeId`

### 3. Dual-Axis Brand Configuration

Brands are explicitly configured in two separate mappings:

```javascript
modes: {
  brands: {
    // BrandColorMapping collection — brands with own colors
    color: {
      '18212:0': 'bild',
      '18212:1': 'sportbild',
      // Advertorial NOT here → inherits colors from parent
    },
    // BrandTokenMapping collection — brands with own sizing/typography
    content: {
      '18038:0': 'bild',
      '18094:0': 'sportbild',
      '18094:1': 'advertorial',  // Has own sizing, but no own colors
    },
  },
}
```

**Result:** Advertorial has its own sizing/typography but inherits colors from BILD or SportBILD via Dual-Axis.

### 4. Default Brand Configuration

The default brand is explicitly set in config:

```javascript
modes: {
  brands: {
    // ...mappings...
    default: 'bild',  // Explicitly configured, not auto-detected
  },
}
```

---

## Configurable Options (pipeline.config.js)

### 1. Collection IDs (REQUIRED)

```javascript
source: {
  collections: {
    FONT_PRIMITIVE: 'VariableCollectionId:470:1450',
    COLOR_PRIMITIVE: 'VariableCollectionId:539:2238',
    SIZE_PRIMITIVE: 'VariableCollectionId:4072:1817',
    SPACE_PRIMITIVE: 'VariableCollectionId:2726:12077',
    DENSITY: 'VariableCollectionId:5695:5841',
    BRAND_TOKEN_MAPPING: 'VariableCollectionId:18038:10593',
    BRAND_COLOR_MAPPING: 'VariableCollectionId:18212:14495',
    BREAKPOINT_MODE: 'VariableCollectionId:7017:25696',
    COLOR_MODE: 'VariableCollectionId:588:1979',
  },
}
```

**When to change:** When collections are recreated in Figma (IDs change).

**How to find IDs:** In the Figma export JSON under `collections[].id`.

### 2. Mode ID Mappings (REQUIRED)

All mode mappings use Figma Mode ID → Pipeline Key format:

```javascript
modes: {
  // Brand mappings
  brands: {
    color: {
      '18212:0': 'bild',       // "BILD" in Figma
      '18212:1': 'sportbild',  // "SportBILD" in Figma
    },
    content: {
      '18038:0': 'bild',
      '18094:0': 'sportbild',
      '18094:1': 'advertorial',
    },
    default: 'bild',
  },

  // Color mode mappings
  colorModes: {
    '588:0': 'light',   // "Light" in Figma
    '592:1': 'dark',    // "Dark" in Figma
  },

  // Density mode mappings
  densityModes: {
    '5695:2': 'default',
    '5695:1': 'dense',
    '5695:3': 'spacious',
  },

  // Breakpoint mappings (include minWidth for CSS)
  breakpoints: {
    '7017:0':  { key: 'xs', minWidth: 320, deviceName: 'Mobile (default)' },
    '16706:1': { key: 'sm', minWidth: 390, deviceName: 'Large Mobile' },
    '7015:1':  { key: 'md', minWidth: 600, deviceName: 'Tablet' },
    '7015:2':  { key: 'lg', minWidth: 1024, deviceName: 'Desktop' },
  },
}
```

**When to change:** When modes are deleted and recreated in Figma (IDs change).

**How to find Mode IDs:** In the Figma export JSON under `collections[].modes[].modeId`.

### 3. Platform Settings (OPTIONAL)

#### CSS Settings

```javascript
platforms: {
  css: {
    enabled: true,
    fontSizeUnit: 'px',  // or 'rem'
    remBase: 16,
    dataAttributes: {
      colorBrand: 'data-color-brand',
      contentBrand: 'data-content-brand',
      theme: 'data-theme',
      density: 'data-density',
    },
  },
}
```

#### Native Platform Mappings

```javascript
platforms: {
  ios: {
    enabled: true,
    sizeClasses: {
      compact: 'sm',   // iOS SizeClass → Breakpoint Key
      regular: 'lg',
    },
  },
  android: {
    enabled: true,
    sizeClasses: {
      compact: 'sm',   // WindowSizeClass → Breakpoint Key
      medium: 'md',
      expanded: 'lg',
    },
  },
}
```

### 4. Identity & Packages (OPTIONAL)

```javascript
identity: {
  name: 'BILD Design System',
  shortName: 'bild',
  copyright: 'Axel Springer Deutschland GmbH',
},

packages: {
  tokens: { npm: '@marioschmidt/design-system-tokens' },
  // ...
},
```

---

## What is Validated (Not Configured)

These values are **validated against Figma** at build time:

| Value | Validation |
|-------|------------|
| Mode IDs | Must exist in Figma (build fails if missing) |
| Token values | Processed from Figma per configured mappings |
| Collection structure | Must contain configured mode IDs |

**Build-time warnings:**
- Unmapped Figma modes (modes in Figma not in config) trigger warnings
- This helps detect new modes that may need to be added to config

**Build-time errors:**
- Missing Mode IDs (configured IDs not found in Figma) fail the build
- This prevents silent failures from stale configuration

---

## Naming Constraints

### No Hyphens in Keys

```
✅ Allowed:     bild, sportbild, myBrand, extraDense
❌ Forbidden:   sport-bild, my-brand, extra-dense
```

**Reason:** Keys are embedded in CSS Custom Properties:
```css
--density-{mode}-stack-space-resp-md
```
With hyphens, it would be impossible to determine where the mode ends and the token begins.

### Breakpoint Key Extraction

The pipeline extracts the first letter-block from Figma mode names:

```
"XS - 320px"        →  xs     (first block before " - ")
"SM - 390px (comp)" →  sm     (first block before " - ")
"Mobile"            →  mobile (entire name, lowercase)
```

---

## Troubleshooting

### Problem: "Collection not found"

```
Cause:   Collection ID in pipeline.config.js doesn't match Figma.
Solution: Open bild-design-system-raw-data.json and copy the current ID
         from collections[].id
```

### Problem: "Mode ID not found in Figma"

```
Cause:   A configured Mode ID was deleted/recreated in Figma.
Solution: Find the new Mode ID in bild-design-system-raw-data.json under
         collections[].modes[].modeId and update pipeline.config.js

Example error:
  ❌ Color brands: Mode ID "18212:0" (key: bild) not found in Figma!
```

### Problem: "Figma has unmapped modes" warning

```
Cause:   New mode was added in Figma but not in pipeline.config.js.
Solution: If intentional, add the Mode ID → Key mapping to config.
         If not needed, the warning can be ignored.

Example warning:
  ⚠️  Content brands: Figma has unmapped modes: "NewBrand" (18094:2)
```

### Problem: Advertorial has no colors

```
This is correct! Advertorial is only in modes.brands.content, not in
modes.brands.color. It inherits colors from BILD or SportBILD via the
Dual-Axis architecture (data-color-brand + data-content-brand).
```

---

## Change Matrix

| Change in Figma | Action Required |
|-----------------|-----------------|
| New collection created | Add collection ID to config |
| Collection renamed | None (ID stays stable) |
| Collection deleted/recreated | Update collection ID in config |
| New brand mode | Add Mode ID → Key mapping to config |
| Brand mode renamed | None (Mode ID stays stable) ✅ |
| Brand mode deleted/recreated | Update Mode ID mapping in config |
| New color/density mode | Add Mode ID → Key mapping to config |
| Mode renamed | None (Mode ID stays stable) ✅ |
| New breakpoint mode | Add Mode ID → Key + minWidth to config |
| Token added/changed | None (auto-processed) |

**Key benefit:** Mode renames in Figma don't break the build anymore.

---

## Build Validation

After `npm run build:tokens` you should see:

```
🔗 Loading mode mappings from config...
   ✓ Color modes: light, dark
   ✓ Density modes: default, dense, spacious
   ✓ Breakpoints: xs, sm, md, lg
   ✓ Content brands: bild, sportbild, advertorial (default: bild)
   ✓ Color brands: bild, sportbild
```

This output confirms that all configured Mode IDs were found in Figma.

**If there are problems:**

```
🔗 Loading mode mappings from config...
   ✓ Color modes: light, dark
   ❌ Density modes: Mode ID "INVALID:0" (key: default) not found in Figma!
   ⚠️  Density modes: Figma has unmapped modes: "default" (5695:2)

❌ Build failed: Some configured Mode IDs were not found in Figma.
```
