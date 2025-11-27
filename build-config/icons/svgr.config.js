/**
 * SVGR Configuration for React Component Generation
 *
 * Generates accessible React components with:
 * - TypeScript support
 * - forwardRef for DOM access
 * - Accessibility props (aria-label, aria-hidden)
 * - Size prop for easy scaling
 * - currentColor inheritance
 */

module.exports = {
  // TypeScript output
  typescript: true,

  // Use named exports
  exportType: 'named',

  // Generate .tsx files
  ext: 'tsx',

  // Component configuration
  ref: true,           // Enable forwardRef
  memo: true,          // Wrap in React.memo for performance

  // SVG props
  svgProps: {
    role: 'img',
    'aria-hidden': '{ariaHidden}',
  },

  // Replace hardcoded colors with currentColor
  replaceAttrValues: {
    '#000': 'currentColor',
    '#000000': 'currentColor',
    '#fff': 'currentColor',
    '#ffffff': 'currentColor',
    'black': 'currentColor',
    'white': 'currentColor',
  },

  // Icon dimensions
  icon: false,  // Don't use 1em default
  dimensions: true,

  // SVGO integration (use our config)
  svgo: true,
  svgoConfig: require('./svgo.config.js'),

  // Custom template for accessible components
  template: (variables, { tpl }) => {
    return tpl`
import * as React from 'react';

export interface ${variables.componentName}Props extends React.SVGProps<SVGSVGElement> {
  /**
   * Icon size (width and height)
   * @default 24
   */
  size?: number | string;
  /**
   * Accessible label for screen readers
   * If provided, aria-hidden will be set to false
   */
  'aria-label'?: string;
  /**
   * Hide icon from screen readers (decorative icon)
   * @default true
   */
  'aria-hidden'?: boolean;
  /**
   * Optional title element for tooltip/accessibility
   */
  title?: string;
}

const ${variables.componentName} = React.forwardRef<SVGSVGElement, ${variables.componentName}Props>(
  ({ size = 24, 'aria-label': ariaLabel, 'aria-hidden': ariaHidden = true, title, ...props }, ref) => {
    // If aria-label is provided, icon is meaningful (not decorative)
    const isDecorative = !ariaLabel && ariaHidden;

    return (
      ${variables.jsx}
    );
  }
);

${variables.componentName}.displayName = '${variables.componentName}';

export { ${variables.componentName} };
`;
  },

  // Index file template
  indexTemplate: (filePaths) => {
    const exportEntries = filePaths.map((filePath) => {
      const basename = filePath.replace(/\.tsx$/, '');
      const componentName = basename.replace(/^\.\//, '');
      return `export { ${componentName} } from './${componentName}';`;
    });
    return exportEntries.join('\n');
  },
};
