import type { Preview } from '@storybook/web-components';
import { html } from 'lit';

// Stencil components are loaded via script tag in preview-head.html
// This ensures they're available before stories render

/**
 * Design Token Decorator
 *
 * Sets data attributes for the Dual-Axis architecture:
 * - data-theme: Light/dark mode (light, dark)
 * - data-color-brand: Controls colors and effects (bild, sportbild)
 * - data-content-brand: Controls typography, spacing, density (bild, sportbild, advertorial)
 * - data-density: Spacing density (default, dense, spacious)
 *
 * All attributes are set on document.documentElement (html) for CSS selector matching:
 * [data-color-brand="bild"][data-theme="light"] { ... }
 */
const withDesignTokens = (Story: () => unknown, context: { globals: Record<string, string> }) => {
  const { theme, colorBrand, contentBrand, density } = context.globals;

  // Set all attributes on document.documentElement (html) for CSS selector matching
  if (typeof document !== 'undefined' && document.documentElement) {
    document.documentElement.setAttribute('data-theme', theme);
    document.documentElement.setAttribute('data-color-brand', colorBrand);
    document.documentElement.setAttribute('data-content-brand', contentBrand);
    document.documentElement.setAttribute('data-density', density);
  }

  return html`
    <div
      style="padding: 1rem; min-height: 100px;"
    >
      ${Story()}
    </div>
  `;
};

const preview: Preview = {
  decorators: [withDesignTokens],

  // Toolbar controls - order here determines toolbar order
  globalTypes: {
    theme: {
      description: 'Color theme (light/dark)',
      toolbar: {
        title: 'Theme',
        icon: 'mirror',
        items: [
          { value: 'light', title: 'Light', icon: 'sun' },
          { value: 'dark', title: 'Dark', icon: 'moon' },
        ],
        dynamicTitle: true,
      },
    },
    colorBrand: {
      description: 'Color brand (colors & effects)',
      toolbar: {
        title: 'Color Brand',
        icon: 'paintbrush',
        items: [
          { value: 'bild', title: 'BILD', icon: 'circle' },
          { value: 'sportbild', title: 'SportBILD', icon: 'circle' },
        ],
        dynamicTitle: true,
      },
    },
    contentBrand: {
      description: 'Content brand (typography, spacing)',
      toolbar: {
        title: 'Content Brand',
        icon: 'document',
        items: [
          { value: 'bild', title: 'BILD' },
          { value: 'sportbild', title: 'SportBILD' },
          { value: 'advertorial', title: 'Advertorial' },
        ],
        dynamicTitle: true,
      },
    },
    density: {
      description: 'Spacing density',
      toolbar: {
        title: 'Density',
        icon: 'component',
        items: [
          { value: 'default', title: 'Default' },
          { value: 'dense', title: 'Dense' },
          { value: 'spacious', title: 'Spacious' },
        ],
        dynamicTitle: true,
      },
    },
  },

  // Initial global values
  initialGlobals: {
    theme: 'light',
    colorBrand: 'bild',
    contentBrand: 'bild',
    density: 'default',
  },

  // Default parameters
  parameters: {
    // Actions configuration
    actions: { argTypesRegex: '^on[A-Z].*' },

    // Controls configuration
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },

    // Backgrounds addon - use canvas background
    backgrounds: {
      default: 'canvas',
      values: [
        { name: 'canvas', value: 'var(--surface-color-canvas, #F0F2F4)' },
        { name: 'white', value: '#ffffff' },
        { name: 'dark', value: '#232629' },
      ],
    },

    // Docs configuration
    docs: {
      toc: true,
    },
  },
};

export default preview;
