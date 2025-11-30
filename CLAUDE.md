# CLAUDE.md - Design System Token Pipeline Context

> Dieses Dokument dient als Kontext für Claude Code Sessions. Es beschreibt die Architektur, Konventionen und wichtige Details des Design Token Systems.

## Projektübersicht

Dieses Repository enthält die **Design Token Pipeline** für das BILD Design System. Es transformiert Figma Variables in plattformspezifische Token-Formate für Web (CSS/SCSS/JS), iOS (Swift), Android (XML) und Flutter (Dart).

---

## Projektarchitektur

### Token-Layer-Struktur (4 Ebenen)

```
┌─────────────────────────────────────────────────────────────┐
│  LAYER 4: Component Tokens                                  │
│  Button, Card, Teaser, Alert, etc.                          │
│  Referenzieren → Semantic + Density + Breakpoint Tokens     │
├─────────────────────────────────────────────────────────────┤
│  LAYER 3: Semantic Tokens                                   │
│  text-color-primary, surface-color-secondary, etc.          │
│  Referenzieren → Brand Color Mapping                        │
├─────────────────────────────────────────────────────────────┤
│  LAYER 2: Brand Mapping (Color + Token)                     │
│  BrandColorMapping: Weist Primitives zu Brands zu           │
│  BrandTokenMapping: Weist andere Tokens zu Brands zu        │
├─────────────────────────────────────────────────────────────┤
│  LAYER 1: Primitives                                        │
│  Farben, Spacing, Sizes, Fonts (absolute Werte)             │
│  --bildred: #DD0000, --space2x: 16px, etc.                  │
└─────────────────────────────────────────────────────────────┘
```

### Alias-Ketten (var() Referenzen)

```css
/* Component → Semantic → Primitive */
--button-primary-bg-color: var(--core-color-primary, #DD0000);
                                 ↓
--core-color-primary: var(--bildred, #DD0000);
                           ↓
--bildred: #DD0000;
```

---

## Multi-Brand & Multi-Mode Logik

### Brands (3 Marken)

| Brand | Beschreibung |
|-------|--------------|
| `bild` | Hauptmarke BILD |
| `sportbild` | SportBILD |
| `advertorial` | Advertorial/Werbung |

### Modes (Varianten pro Token-Typ)

| Token-Typ | Modes | CSS-Selector |
|-----------|-------|--------------|
| **Color** | `light`, `dark` | `[data-theme="light/dark"]` |
| **Breakpoint** | `xs`, `sm`, `md`, `lg` | `@media (min-width: ...)` |
| **Density** | `compact`, `default`, `spacious` | `[data-density="..."]` |
| **Typography** | `xs`, `sm`, `md`, `lg` | Responsive via `var()` |

### CSS Data-Attribute Struktur

```html
<html data-brand="bild" data-theme="light" data-density="default">
```

```css
/* Primitives - global */
:root { --bildred: #DD0000; }

/* Semantic - brand + theme scoped */
[data-brand="bild"][data-theme="light"] {
  --text-color-primary: var(--bild015, #232629);
}

/* Breakpoints - brand scoped + @media */
[data-brand="bild"] {
  --headline1-font-size: 48px;
}
@media (min-width: 1024px) {
  [data-brand="bild"] {
    --headline1-font-size: 64px;
  }
}

/* Density - brand + density scoped */
[data-brand="bild"][data-density="compact"] {
  --button-inline-space: 16px;
}
```

---

## Technischer Stack

### Build Pipeline

```
Figma Variables API
        ↓
   preprocess.js     (Figma JSON → Normalized Tokens)
        ↓
     build.js        (Style Dictionary Orchestration)
        ↓
style-dictionary.config.js  (22 Format Functions)
        ↓
    bundles.js       (CSS Bundle Generation)
        ↓
     dist/           (Output: CSS, SCSS, JS, Swift, XML, Dart)
```

### Relevante Dateipfade

| Pfad | Beschreibung |
|------|--------------|
| `scripts/tokens/preprocess.js` | Figma-Daten Transformation (~2000 LOC) |
| `scripts/tokens/build.js` | Style Dictionary Build (~1700 LOC) |
| `build-config/tokens/style-dictionary.config.js` | Format-Funktionen (~2500 LOC) |
| `scripts/tokens/bundles.js` | CSS Bundle Generator (~560 LOC) |
| `src/tokens/figma-export.json` | Figma Variables Export (Source) |
| `dist/` | Generierte Token-Dateien |

### Output-Struktur

```
dist/
├── css/
│   ├── shared/primitives.css
│   ├── bild/
│   │   ├── theme.css          (light/dark colors + effects)
│   │   ├── tokens.css         (breakpoints + typography + density)
│   │   └── components/        (per-component tokens)
│   ├── sportbild/
│   ├── advertorial/
│   └── bundles/
│       ├── bild.css           (Full bundle)
│       ├── sportbild.css
│       └── advertorial.css
├── scss/
├── js/
├── ios/
├── android/
└── flutter/
```

---

## Plattformen

| Plattform | Format | Dateiendung |
|-----------|--------|-------------|
| Web | CSS Custom Properties | `.css` |
| Web | SCSS Variables | `.scss` |
| Web | JavaScript ES6 | `.js` |
| iOS | Swift Extensions | `.swift` |
| Android | XML Resources | `.xml` |
| Flutter | Dart Classes | `.dart` |

---

## Naming Conventions

### CSS Variable Namen

```css
/* Primitives: Kurz, keine Präfixe */
--bildred, --space2x, --size4x

/* Semantic: Kategorie-basiert */
--text-color-primary
--surface-color-secondary
--border-color-high-contrast

/* Component: Component-Präfix */
--button-primary-bg-color
--card-border-radius
--teaser-title-font-size
```

### Dateinamen

```
{component}-{mode-type}-{mode}.css

Beispiele:
button-color-light.css
button-color-dark.css
button-density-compact.css
button-breakpoint-responsive.css
button-typography-responsive.css
```

### Figma Collection IDs (Kritisch!)

```javascript
const COLLECTION_IDS = {
  COLOR_PRIMITIVES: 'VariableCollectionId:18038:85',
  SPACE_PRIMITIVES: 'VariableCollectionId:18212:130',
  SIZE_PRIMITIVES: 'VariableCollectionId:18212:133',
  FONT_PRIMITIVES: 'VariableCollectionId:18212:113',
  BRAND_COLOR_MAPPING: 'VariableCollectionId:18212:92',
  BRAND_TOKEN_MAPPING: 'VariableCollectionId:18038:76',
  SEMANTIC_TOKENS: 'VariableCollectionId:18038:80',
  // ... weitere
};
```

---

## Don'ts und Gotchas

### KRITISCH - Nicht ändern ohne tiefes Verständnis

1. **COLLECTION_IDS in preprocess.js**
   - Diese IDs kommen aus Figma und identifizieren Collections eindeutig
   - Änderung bricht die gesamte Pipeline

2. **Mode-Resolution Logik (preprocess.js:226-235)**
   ```javascript
   // Diese Logik resolvet Aliase dynamisch nach Mode-NAME, nicht ID
   const brandMode = collection.modes.find(m => m.name === context.brandName);
   ```

3. **Breakpoint-Werte (style-dictionary.config.js)**
   ```javascript
   const BREAKPOINT_VALUES = {
     xs: '320px', sm: '390px', md: '600px', lg: '1024px'
   };
   ```

### Häufige Fehlerquellen

| Problem | Ursache | Lösung |
|---------|---------|--------|
| Leere CSS-Dateien | Collection-ID falsch | COLLECTION_IDS prüfen |
| Fehlende Aliase | Mode nicht gefunden | Mode-Namen in Figma prüfen |
| Doppelte Variablen | Mehrfache Collection-Zuordnung | preprocess.js Filter prüfen |
| Self-Reference `var(--x, --x)` | Token-Name = Alias-Name | Wird automatisch vermieden (Zeile 2283-2288) |

### CSS-Spezifische Gotchas

1. **Variablennamen mit Zahlen am Anfang**
   ```css
   --700-black-font-weight  /* VS Code Highlighting broken */
   --font-weight-700-black  /* Besser */
   ```

2. **Responsive Typography verwendet var() statt @media**
   ```css
   /* Typography-Klassen referenzieren responsive breakpoint-tokens */
   .headline1 {
     font-size: var(--headline1-font-size, 48px);
   }
   /* Die Variable ändert sich via @media in breakpoint-responsive.css */
   ```

3. **Effects sind CSS-Klassen, keine Variables**
   ```css
   /* Richtig: */
   [data-brand="bild"][data-theme="light"] .shadow-soft-md { ... }

   /* Falsch wäre: */
   --shadow-soft-md: ...;
   ```

---

## Bekannte Einschränkungen

1. **Neue Brands/Breakpoints erfordern Code-Änderungen**
   - `BRANDS` Array in build.js und bundles.js
   - `BREAKPOINTS` Object in preprocess.js
   - Nicht vollautomatisch aus Figma

2. **Typography/Effects sind Composite Tokens**
   - Werden zu CSS-Klassen, nicht einzelne Variables
   - Können nicht per `var()` referenziert werden

3. **Advertorial hat weniger Components**
   - Nicht alle Components haben Advertorial-Varianten in Figma

---

## Wichtige Build-Befehle

```bash
# Vollständiger Build
npm run build:tokens

# Nur Bundles neu generieren (schneller)
node scripts/tokens/bundles.js

# Figma-Export aktualisieren (benötigt FIGMA_TOKEN)
npm run fetch:tokens
```

---

## Architektur-Entscheidungen

### Warum @media statt data-breakpoint?

```css
/* NICHT verwendet (würde JS zum Switchen benötigen): */
[data-brand="bild"][data-breakpoint="lg"] { ... }

/* VERWENDET (funktioniert automatisch): */
@media (min-width: 1024px) {
  [data-brand="bild"] { ... }
}
```

### Warum var() mit Fallback?

```css
/* Immer mit Fallback für Robustheit: */
--button-bg: var(--core-color-primary, #DD0000);

/* Fallback = aufgelöster Wert zur Build-Zeit */
```

### Warum separate Dateien pro Mode?

- **Lazy Loading**: Nur light ODER dark laden
- **Caching**: Themes separat cachen
- **Debugging**: Einfacher zu inspizieren

---

## Für AI-Assistenten

### Bei Token-Änderungen

1. Prüfe ob Änderung in **Figma** oder **Pipeline** erfolgen soll
2. Figma ist Source of Truth für Token-Werte
3. Pipeline ist Source of Truth für Output-Formate

### Bei CSS-Problemen

1. Prüfe Selector-Pattern (`[data-brand]`, `[data-theme]`, etc.)
2. Prüfe ob `var()` Referenzen korrekt aufgelöst werden
3. Prüfe @media Queries bei Breakpoint-Issues

### Bei Build-Fehlern

1. `preprocess.js` - Figma-Daten-Transformation
2. `build.js` - Style Dictionary Konfiguration
3. `style-dictionary.config.js` - Format-Funktionen
4. `bundles.js` - Bundle-Generierung

### Typische Aufgaben

| Aufgabe | Datei(en) |
|---------|-----------|
| Neuen Token-Typ hinzufügen | preprocess.js, style-dictionary.config.js |
| Output-Format ändern | style-dictionary.config.js |
| Bundle-Struktur ändern | bundles.js |
| Neuen Brand hinzufügen | preprocess.js, build.js, bundles.js |
| Alias-Logik ändern | preprocess.js (resolveAlias) |

---

## Letzte Änderungen (Stand: November 2024)

- ✅ Responsive CSS optimiert (nur geänderte Werte in @media)
- ✅ Semantic Breakpoints: `:root` → `[data-brand]`
- ✅ Self-Reference Bug gefixt
- ✅ Component Breakpoint Tokens zu @media konvertiert
- ✅ Typography verwendet var() Referenzen
