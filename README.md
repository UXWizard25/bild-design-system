# BILD Design Ops Pipeline

> **Note:** This pipeline is under active development. Generated packages are for **testing purposes only**.

A comprehensive design operations pipeline for the BILD Design System. Transforms Figma exports into production-ready assets across multiple platforms using the **CodeBridge Plugin**.

[![Build Tokens](https://github.com/UXWizard25/vv-token-test-v3/workflows/Build%20Design%20Tokens/badge.svg)](https://github.com/UXWizard25/vv-token-test-v3/actions)
[![Build Icons](https://github.com/UXWizard25/vv-token-test-v3/workflows/Build%20Icons/badge.svg)](https://github.com/UXWizard25/vv-token-test-v3/actions)
[![npm tokens](https://img.shields.io/npm/v/@marioschmidt/design-system-tokens.svg?label=tokens)](https://www.npmjs.com/package/@marioschmidt/design-system-tokens)
[![npm icons](https://img.shields.io/npm/v/@marioschmidt/design-system-icons.svg?label=icons)](https://www.npmjs.com/package/@marioschmidt/design-system-icons)
[![npm components](https://img.shields.io/npm/v/@marioschmidt/design-system-components.svg?label=components)](https://www.npmjs.com/package/@marioschmidt/design-system-components)

---

## Packages

| Package | Description | Documentation |
|---------|-------------|---------------|
| **@marioschmidt/design-system-tokens** | Multi-platform design tokens (CSS, JS, iOS, Android) | [README](./packages/tokens/README.md) |
| **@marioschmidt/design-system-icons** | Multi-platform icon assets (React, iOS, Android, Flutter) | [README](./packages/icons/README.md) |
| **@marioschmidt/design-system-components** | Stencil Web Components | [README](./packages/components/README.md) |

### Platform Documentation

| Platform | Documentation |
|----------|---------------|
| CSS/Web | [packages/tokens/docs/css.md](./packages/tokens/docs/css.md) |
| JavaScript/React | [packages/tokens/docs/js.md](./packages/tokens/docs/js.md) |
| Android Compose | [packages/tokens/docs/android.md](./packages/tokens/docs/android.md) |
| iOS SwiftUI | [packages/tokens/docs/ios.md](./packages/tokens/docs/ios.md) |

---

## Quick Start

### Installation

```bash
# Design Tokens
npm install @marioschmidt/design-system-tokens

# Icons
npm install @marioschmidt/design-system-icons

# Web Components
npm install @marioschmidt/design-system-components
```

### Usage Examples

```css
/* CSS */
@import '@marioschmidt/design-system-tokens/css/bundles/bild.css';

.button {
  background: var(--button-primary-brand-bg-color-idle);
  color: var(--button-primary-label-color);
}
```

```javascript
// JavaScript
import { createTheme } from '@marioschmidt/design-system-tokens/themes';
const theme = createTheme({ colorBrand: 'bild', colorMode: 'light' });
```

```tsx
// React Icons
import { IconAdd, IconSearch } from '@marioschmidt/design-system-icons/react';
<IconAdd size={24} />
```

```html
<!-- Web Components -->
<script type="module" src="@marioschmidt/design-system-components/dist/esm/index.js"></script>
<ds-button variant="primary">Click me</ds-button>
```

See the [package documentation](#packages) for complete usage guides.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              FIGMA                                          │
│  ┌─────────────────────┐              ┌─────────────────────┐              │
│  │  Variables          │              │  Icons (SVG)        │              │
│  └──────────┬──────────┘              └──────────┬──────────┘              │
└─────────────┼───────────────────────────────────┼──────────────────────────┘
              │                                   │
              │  CodeBridge Plugin                │  CodeBridge Plugin
              ▼                                   ▼
┌─────────────────────────────┐    ┌─────────────────────────────┐
│  figma-tokens branch        │    │  figma-icons branch         │
└──────────────┬──────────────┘    └──────────────┬──────────────┘
               │                                  │
               │  GitHub Actions                  │  GitHub Actions
               ▼                                  ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│  MONOREPO (npm workspaces)                                                   │
│                                                                              │
│  packages/                                                                   │
│  ├── tokens/              → @marioschmidt/design-system-tokens               │
│  │   └── dist/ (css, js, ios, android)                                       │
│  ├── icons/               → @marioschmidt/design-system-icons                │
│  │   └── dist/ (svg, react, ios, android, flutter)                           │
│  └── components/          → @marioschmidt/design-system-components           │
│      └── dist/ (stencil web components)                                      │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## Build Commands

```bash
# Full build
npm run build:all          # Tokens + Icons + Components

# Individual builds
npm run build:tokens       # Design tokens only
npm run build:icons        # Icons only
npm run build:components   # Stencil components only

# Development
npm run dev:stencil        # Stencil dev server (port 3333)
npm run storybook          # Storybook (port 6006)

# Publishing (via workspace)
npm run publish:tokens
npm run publish:icons
npm run publish:components

# Clean
npm run clean              # Remove all dist/ and tokens/
```

---

## CI/CD Workflows

| Workflow | Trigger | Action |
|----------|---------|--------|
| `build-tokens.yml` | Push to main/develop | Build + upload artifacts |
| `build-icons.yml` | Push to main/develop | Build + upload artifacts |
| `auto-pr-from-figma.yml` | Push to `figma-tokens` | Create/update PR |
| `auto-pr-from-figma-icons.yml` | Push to `figma-icons` | Create/update PR |
| `publish-on-merge.yml` | Merge to main (tokens/components) | npm publish |
| `publish-icons-on-merge.yml` | Merge to main (icons) | npm publish |

---

## Project Structure

```
vv-token-test-v3/
├── packages/
│   ├── tokens/           # @marioschmidt/design-system-tokens
│   │   ├── README.md     # Token documentation
│   │   ├── docs/         # Platform guides (css, js, ios, android)
│   │   └── dist/
│   ├── icons/            # @marioschmidt/design-system-icons
│   │   ├── README.md
│   │   └── dist/
│   └── components/       # @marioschmidt/design-system-components
│       ├── README.md
│       └── dist/
├── src/
│   ├── design-tokens/    # Figma token export
│   ├── icons/            # Figma icon export
│   ├── components/       # Stencil source
│   └── docs/             # Storybook pages
├── scripts/              # Build scripts
├── build-config/         # Configuration files
├── .github/workflows/    # CI/CD
├── README.md             # This file
└── CLAUDE.md             # AI assistant context
```

---

## Contributing

> **Important:** Figma is the Single Source of Truth. Design assets must be edited in Figma and exported via CodeBridge Plugin.

**Allowed:**
- Changes to build scripts (`scripts/`)
- Configuration changes (`build-config/`)
- Workflow adjustments (`.github/workflows/`)
- Documentation updates

**Not Allowed:**
- Direct changes to `src/design-tokens/*.json`
- Direct changes to `src/icons/*.svg`
- Manual commits to `figma-tokens` or `figma-icons` branch

---

## License

MIT

---

**Built for the BILD Design System**
