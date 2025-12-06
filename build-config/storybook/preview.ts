import type { Preview } from '@storybook/web-components';
import { html } from 'lit';
import { addons } from '@storybook/preview-api';
import { DARK_MODE_EVENT_NAME, UPDATE_DARK_MODE_EVENT_NAME } from 'storybook-dark-mode';

// Import custom themes
import { bildLightTheme, bildDarkTheme } from './manager';

// Stencil components are loaded via script tag in preview-head.html
// This ensures they're available before stories render

/**
 * Sync dark mode addon with our theme global
 *
 * When the dark mode toggle is clicked, we update the 'theme' global
 * which triggers a re-render of all stories with the new theme.
 */
const channel = addons.getChannel();

// Listen for dark mode changes and update the theme global
channel.on(DARK_MODE_EVENT_NAME, (isDark: boolean) => {
  const theme = isDark ? 'dark' : 'light';

  // Update body attribute immediately for CSS
  if (typeof document !== 'undefined' && document.body) {
    document.body.setAttribute('data-theme', theme);
  }

  // Update the global to trigger story re-render
  channel.emit('updateGlobals', { globals: { theme } });
});

/**
 * 4-Axis Design Token Decorator
 *
 * Wraps stories with the correct data attributes for the Dual-Axis architecture:
 * - data-color-brand: Controls colors and effects (bild, sportbild)
 * - data-content-brand: Controls typography, spacing, density (bild, sportbild, advertorial)
 * - data-theme: Light/dark mode (synced with storybook-dark-mode addon)
 * - data-density: Spacing density (default, dense, spacious)
 */
const withDesignTokens = (Story: () => unknown, context: { globals: Record<string, string> }) => {
  const { colorBrand, contentBrand, theme, density } = context.globals;

  // Set attributes on document.body for global CSS inheritance
  if (typeof document !== 'undefined' && document.body) {
    document.body.setAttribute('data-color-brand', colorBrand);
    document.body.setAttribute('data-content-brand', contentBrand);
    document.body.setAttribute('data-theme', theme);
    document.body.setAttribute('data-density', density);
  }

  return html`
    <div
      data-color-brand=${colorBrand}
      data-content-brand=${contentBrand}
      data-theme=${theme}
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
    theme: {
      description: 'Color theme (synced with dark mode toggle)',
      toolbar: {
        title: 'Theme',
        icon: 'sun',
        items: [
          { value: 'light', title: 'Light', icon: 'sun' },
          { value: 'dark', title: 'Dark', icon: 'moon' },
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
    colorBrand: 'bild',
    contentBrand: 'bild',
    theme: 'light',
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

    // storybook-dark-mode configuration
    darkMode: {
      dark: bildDarkTheme,
      light: bildLightTheme,
      current: 'light',
      stylePreview: true,
    },

    // Backgrounds addon - disabled since we use darkMode addon
    backgrounds: { disable: true },

    // Docs configuration
    docs: {
      toc: true,
    },
  },
};

export default preview;
