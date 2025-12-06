import type { Preview } from '@storybook/web-components';
import { html } from 'lit';

// Import custom themes for UI styling
import { bildLightTheme, bildDarkTheme } from './manager';

// Stencil components are loaded via script tag in preview-head.html
// This ensures they're available before stories render

// Dark mode sync is handled in preview-body.html via localStorage polling

/**
 * 4-Axis Design Token Decorator
 *
 * Wraps stories with the correct data attributes for the Dual-Axis architecture:
 * - data-color-brand: Controls colors and effects (bild, sportbild)
 * - data-content-brand: Controls typography, spacing, density (bild, sportbild, advertorial)
 * - data-theme: Light/dark mode (synced with storybook-dark-mode via preview-body.html)
 * - data-density: Spacing density (default, dense, spacious)
 */
const withDesignTokens = (Story: () => unknown, context: { globals: Record<string, string> }) => {
  const { colorBrand, contentBrand, density } = context.globals;

  // Set attributes on document.body for global CSS inheritance
  // Note: data-theme is managed by preview-body.html in sync with storybook-dark-mode addon
  if (typeof document !== 'undefined' && document.body) {
    document.body.setAttribute('data-color-brand', colorBrand);
    document.body.setAttribute('data-content-brand', contentBrand);
    document.body.setAttribute('data-density', density);
  }

  // Note: data-theme is NOT set on the wrapper div - it inherits from body
  // which is synced with storybook-dark-mode addon via preview-body.html
  return html`
    <div
      data-color-brand=${colorBrand}
      data-content-brand=${contentBrand}
      data-density=${density}
      style="padding: 1rem; min-height: 100px;"
    >
      ${Story()}
    </div>
  `;
};

const preview: Preview = {
  // Global decorators
  decorators: [withDesignTokens],

  // Toolbar controls for 4-axis switching
  globalTypes: {
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
    // Note: theme is controlled by storybook-dark-mode toggle (moon icon in toolbar)
    // which syncs both UI and content via preview-body.html
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

    // storybook-dark-mode: Custom BILD themes for UI
    darkMode: {
      dark: bildDarkTheme,
      light: bildLightTheme,
      stylePreview: true,
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
