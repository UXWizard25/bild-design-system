import { addons } from '@storybook/manager-api';
import { create } from '@storybook/theming';

/**
 * BILD Design System - Custom Storybook UI Theme
 *
 * Styles the Storybook UI (sidebar, toolbar, etc.)
 * to match the BILD Design System look and feel.
 */

const bildTheme = create({
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

// Configure Storybook with custom BILD theme
addons.setConfig({
  theme: bildTheme,
});
