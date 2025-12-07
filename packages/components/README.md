# @marioschmidt/design-system-components

BILD Design System Web Components - Stencil-based component library that consumes design tokens.

## Installation

```bash
npm install @marioschmidt/design-system-components
```

**Recommended:** Install together with design tokens:

```bash
npm install @marioschmidt/design-system-tokens @marioschmidt/design-system-components
```

## Usage

### Option 1: Lazy Loading (Recommended)

```javascript
import { defineCustomElements } from '@marioschmidt/design-system-components/loader';

// Register all components (lazy-loaded on first use)
defineCustomElements();
```

### Option 2: Custom Elements (Auto-Define)

```javascript
// Import and auto-register all components
import '@marioschmidt/design-system-components/components';
```

### Option 3: Individual Components

```javascript
import { DsButton, DsCard } from '@marioschmidt/design-system-components';
```

## HTML Usage

```html
<!DOCTYPE html>
<html>
<head>
  <!-- Load design tokens CSS -->
  <link rel="stylesheet" href="node_modules/@marioschmidt/design-system-tokens/dist/css/bundles/bild.css">

  <!-- Load components -->
  <script type="module" src="node_modules/@marioschmidt/design-system-components/dist/esm/index.js"></script>
</head>
<body data-color-brand="bild" data-content-brand="bild" data-theme="light" data-density="default">

  <ds-button variant="primary">Click me</ds-button>

  <ds-card>
    <h2>Card Title</h2>
    <p>Card content goes here.</p>
  </ds-card>

</body>
</html>
```

## Available Components

| Component | Tag | Description |
|-----------|-----|-------------|
| Button | `<ds-button>` | Primary, secondary, ghost variants |
| Card | `<ds-card>` | Content container with styling |

## Brand Switching

Components automatically adapt to brand/theme changes via CSS Custom Properties:

```html
<!-- BILD Brand -->
<body data-color-brand="bild" data-content-brand="bild" data-theme="light">
  <ds-button variant="primary">BILD Button</ds-button>
</body>

<!-- SportBILD Brand -->
<body data-color-brand="sportbild" data-content-brand="sportbild" data-theme="dark">
  <ds-button variant="primary">Sport Button</ds-button>
</body>

<!-- Advertorial in BILD context -->
<body data-color-brand="bild" data-content-brand="advertorial" data-theme="light">
  <ds-button variant="primary">Advertorial Button</ds-button>
</body>
```

## Data Attributes

| Attribute | Values | Purpose |
|-----------|--------|---------|
| `data-color-brand` | `bild`, `sportbild` | Colors & effects |
| `data-content-brand` | `bild`, `sportbild`, `advertorial` | Typography & spacing |
| `data-theme` | `light`, `dark` | Color mode |
| `data-density` | `default`, `dense`, `spacious` | Spacing density |

## Shadow DOM

All components use Shadow DOM for style encapsulation. Design tokens are inherited through CSS Custom Properties:

```
Light DOM                          Shadow DOM
─────────────────────────────────────────────────────
<body data-color-brand="bild">     <ds-button>
  │                                  #shadow-root
  │  CSS Variables set here:           .button {
  │  --button-primary-bg: #DD0000      background: var(--button-primary-bg);
  │                                    /* Inherits from body! */
  └────────────────────────────►     }
```

## TypeScript

Full TypeScript support with type definitions:

```typescript
import type { Components } from '@marioschmidt/design-system-components';

const button: Components.DsButton = document.querySelector('ds-button');
button.variant = 'primary';
```

## Peer Dependencies

- `@marioschmidt/design-system-tokens` (optional but recommended)

## Development

```bash
# In monorepo root
npm run dev:stencil    # Start dev server (port 3333)
npm run storybook      # Start Storybook (port 6006)
```

## Related Packages

- [@marioschmidt/design-system-tokens](https://www.npmjs.com/package/@marioschmidt/design-system-tokens) - Design tokens
- [@marioschmidt/design-system-icons](https://www.npmjs.com/package/@marioschmidt/design-system-icons) - Icon library

## License

MIT
