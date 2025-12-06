import { addons } from '@storybook/manager-api';
import { create } from '@storybook/theming';

/**
 * BILD Design System - Custom Storybook Themes
 *
 * These themes style the Storybook UI (sidebar, toolbar, etc.)
 * to match the BILD Design System look and feel.
 */

// Light theme based on BILD design tokens
const bildLightTheme = create({
  base: 'light',

  // Brand
  brandTitle: 'BILD Design System',
  brandUrl: 'https://github.com/UXWizard25/vv-token-test-v3',

  // Colors - based on BILD color primitives
  colorPrimary: '#DD0000', // --color-bild-red-50
  colorSecondary: '#DD0000', // --color-bild-red-50

  // UI colors
  appBg: '#F2F4F5', // --color-neutral-96
  appContentBg: '#FFFFFF', // --color-neutral-100
  appBorderColor: '#CED4DA', // --color-neutral-85
  appBorderRadius: 4,

  // Text colors
  textColor: '#232629', // --color-neutral-15
  textInverseColor: '#FFFFFF', // --color-neutral-100
  textMutedColor: '#666B70', // --color-neutral-45

  // Toolbar
  barTextColor: '#4B525A', // --color-neutral-35
  barSelectedColor: '#DD0000', // --color-bild-red-50
  barHoverColor: '#DD0000', // --color-bild-red-50
  barBg: '#FFFFFF', // --color-neutral-100

  // Form colors
  inputBg: '#FFFFFF',
  inputBorder: '#CED4DA',
  inputTextColor: '#232629',
  inputBorderRadius: 4,
});

// Dark theme based on BILD design tokens
const bildDarkTheme = create({
  base: 'dark',

  // Brand
  brandTitle: 'BILD Design System',
  brandUrl: 'https://github.com/UXWizard25/vv-token-test-v3',

  // Colors - based on BILD color primitives
  colorPrimary: '#DD0000', // --color-bild-red-50
  colorSecondary: '#F52D2D', // --color-bild-red-53 (lighter for dark mode)

  // UI colors
  appBg: '#1C1C1C', // --color-neutral-10
  appContentBg: '#232629', // --color-neutral-15
  appBorderColor: '#343C41', // --color-neutral-25
  appBorderRadius: 4,

  // Text colors
  textColor: '#F2F4F5', // --color-neutral-96
  textInverseColor: '#232629', // --color-neutral-15
  textMutedColor: '#AEB4B9', // --color-neutral-73

  // Toolbar
  barTextColor: '#CED4DA', // --color-neutral-85
  barSelectedColor: '#DD0000', // --color-bild-red-50
  barHoverColor: '#F52D2D', // --color-bild-red-53
  barBg: '#232629', // --color-neutral-15

  // Form colors
  inputBg: '#2C3138', // --color-neutral-20
  inputBorder: '#4B525A', // --color-neutral-35
  inputTextColor: '#F2F4F5',
  inputBorderRadius: 4,
});

// Configure Storybook with custom themes
addons.setConfig({
  theme: bildLightTheme,
});

// Export themes for use with storybook-dark-mode addon
export { bildLightTheme, bildDarkTheme };
