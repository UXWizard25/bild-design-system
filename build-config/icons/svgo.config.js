/**
 * SVGO Configuration for Icon Optimization
 *
 * Optimizes SVG icons for all platforms:
 * - Removes unnecessary metadata and editor data
 * - Sets currentColor for theming support
 * - Optimizes paths and precision
 * - Removes hardcoded dimensions (preserves viewBox)
 */

module.exports = {
  multipass: true,

  plugins: [
    // Remove XML declaration, doctype, comments
    'removeXMLProcInst',
    'removeDoctype',
    'removeComments',

    // Remove metadata and editor data
    'removeMetadata',
    'removeTitle',
    'removeDesc',
    'removeEditorsNSData',

    // Clean up structure
    'removeEmptyAttrs',
    'removeEmptyContainers',
    'removeEmptyText',
    'removeUnusedNS',

    // Optimize groups and defs
    'collapseGroups',
    'removeUselessDefs',

    // Remove hidden elements
    'removeHiddenElems',

    // Optimize IDs
    'cleanupIds',

    // Merge and optimize paths
    'mergePaths',
    'convertPathData',

    // Sort and clean attributes
    'sortAttrs',

    // Remove hardcoded dimensions (keep viewBox)
    {
      name: 'removeDimensions',
    },

    // Set precision for path data
    {
      name: 'convertPathData',
      params: {
        floatPrecision: 2,
        transformPrecision: 2,
      },
    },

    // Convert colors to currentColor for theming
    {
      name: 'convertColors',
      params: {
        currentColor: true,
      },
    },

    // Remove fill/stroke if they equal currentColor or none
    {
      name: 'removeAttrs',
      params: {
        attrs: [
          'fill:none',
          'stroke:none',
          'data-*',
          'class',
          'style',
        ],
      },
    },

    // Add fill="currentColor" to root svg if not present
    {
      name: 'addAttributesToSVGElement',
      params: {
        attributes: [
          { fill: 'currentColor' },
        ],
      },
    },

    // Keep viewBox (don't remove it)
    {
      name: 'removeViewBox',
      active: false,
    },

    // Final cleanup
    'cleanupAttrs',
    'cleanupEnableBackground',
    'cleanupListOfValues',
    'cleanupNumericValues',
    'convertStyleToAttrs',
    'removeNonInheritableGroupAttrs',
    'removeUselessStrokeAndFill',
    'removeUnknownsAndDefaults',
    'sortDefsChildren',
  ],
};
