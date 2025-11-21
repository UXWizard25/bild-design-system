# 🚀 Quick Start Guide

Quick guide for developers to test and use design tokens from this package.

## 📦 Installation

```bash
npm install @marioschmidt/design-system-tokens
```

No authentication required - it's a public package! ✅

---

## 🎨 Using Color Tokens

### Option 1: CSS (Easiest for testing)

Import the CSS file in your HTML or main CSS file:

```html
<!-- In your HTML -->
<link rel="stylesheet" href="node_modules/@marioschmidt/design-system-tokens/css/semantic/bild/color/color-bild-light.css">
```

```css
/* Or in your main.css */
@import '@marioschmidt/design-system-tokens/css/semantic/bild/color/color-bild-light.css';
```

**Use the tokens:**

```css
.button {
  background-color: var(--color-brand-primary);
  color: var(--color-text-inverse);
}

.header {
  background-color: var(--color-surface-primary);
  border-bottom: 1px solid var(--color-border-default);
}
```

### Option 2: SCSS

```scss
@import '@marioschmidt/design-system-tokens/scss/semantic/bild/color/color-bild-light';

.button {
  background-color: $color-brand-primary;
  color: $color-text-inverse;
}
```

### Option 3: JavaScript/TypeScript

```javascript
import tokens from '@marioschmidt/design-system-tokens/json/semantic/bild/color/color-bild-light.json';

// Access token values
const primaryColor = tokens.color.brand.primary; // "#de0000"
console.log('Primary brand color:', primaryColor);

// Use in your code
document.body.style.backgroundColor = tokens.color.surface.primary;
```

---

## 🌍 CDN (No installation needed!)

Perfect for quick testing in CodePen, JSFiddle, or prototypes:

```html
<!DOCTYPE html>
<html>
<head>
  <!-- Import tokens via CDN -->
  <link rel="stylesheet" href="https://unpkg.com/@marioschmidt/design-system-tokens/css/semantic/bild/color/color-bild-light.css">

  <style>
    .demo-button {
      background-color: var(--color-brand-primary);
      color: var(--color-text-inverse);
      padding: 12px 24px;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
    }

    .demo-card {
      background-color: var(--color-surface-primary);
      border: 1px solid var(--color-border-default);
      padding: 20px;
      margin: 20px;
    }
  </style>
</head>
<body>
  <div class="demo-card">
    <h2>Testing BILD Design Tokens</h2>
    <button class="demo-button">Click Me!</button>
  </div>
</body>
</html>
```

**Alternative CDN:** Use jsdelivr instead:
```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@marioschmidt/design-system-tokens/css/semantic/bild/color/color-bild-light.css">
```

---

## 📂 Available Token Files

### **Color Tokens:**

**BILD:**
- `css/semantic/bild/color/color-bild-light.css` - Light mode
- `css/semantic/bild/color/color-bild-dark.css` - Dark mode

**SportBILD:**
- `css/semantic/sportbild/color/color-sportbild-light.css` - Light mode
- `css/semantic/sportbild/color/color-sportbild-dark.css` - Dark mode

**Advertorial:**
- `css/semantic/advertorial/color/color-advertorial-light.css` - Light mode
- `css/semantic/advertorial/color/color-advertorial-dark.css` - Dark mode

### **Other Token Types:**

- **Breakpoints:** `css/semantic/{brand}/breakpoints/` - Responsive breakpoints
- **Density:** `css/density/` - Spacing variations (compact, default, spacious)
- **Primitive Tokens:** `css/base/` - Raw design values (colors, sizes, fonts, spacing)

All tokens are available in multiple formats: **CSS**, **SCSS**, **JavaScript**, **JSON**

---

## 🎯 Common Color Token Examples

Here are the most commonly used color tokens:

```css
/* Brand Colors */
var(--color-brand-primary)      /* Main brand color */
var(--color-brand-secondary)    /* Secondary brand color */

/* Text Colors */
var(--color-text-primary)       /* Main text color */
var(--color-text-secondary)     /* Secondary text color */
var(--color-text-inverse)       /* Text on dark backgrounds */

/* Surface/Background Colors */
var(--color-surface-primary)    /* Main background */
var(--color-surface-secondary)  /* Secondary background */

/* Border Colors */
var(--color-border-default)     /* Standard borders */
var(--color-border-subtle)      /* Lighter borders */

/* Interactive States */
var(--color-interactive-hover)   /* Hover states */
var(--color-interactive-active)  /* Active/pressed states */
var(--color-interactive-focus)   /* Focus states */

/* Semantic Colors */
var(--color-semantic-success)    /* Success messages */
var(--color-semantic-warning)    /* Warnings */
var(--color-semantic-error)      /* Errors */
var(--color-semantic-info)       /* Info messages */
```

---

## 🔍 Inspecting Available Tokens

To see all available tokens, you can inspect the CSS file or JSON:

**Using Browser DevTools:**
1. Import the CSS file
2. Open DevTools → Elements
3. Select `:root` or `[data-theme]`
4. View all CSS custom properties

**Using JavaScript:**
```javascript
import tokens from '@marioschmidt/design-system-tokens/json/semantic/bild/color/color-bild-light.json';
console.log('All tokens:', tokens);
console.log('Color tokens:', tokens.color);
```

**View JSON directly:**
```bash
# After npm install
cat node_modules/@marioschmidt/design-system-tokens/json/semantic/bild/color/color-bild-light.json
```

---

## 💡 Tips

- **Start with light mode:** `color-bild-light.css` is the easiest to test
- **Use CDN for prototyping:** No build setup needed
- **Check the manifest:** `dist/manifest.json` contains a complete list of all generated files
- **Mix with frameworks:** Works with React, Vue, Angular, Svelte, etc.

---

## 🆘 Need Help?

- **Documentation:** See [NPM_PUBLISHING.md](NPM_PUBLISHING.md) for full guide
- **Issues:** https://github.com/UXWizard25/vv-token-test-v3/issues
- **Package on npm:** https://www.npmjs.com/package/@marioschmidt/design-system-tokens

---

**Happy coding!** 🎨✨
