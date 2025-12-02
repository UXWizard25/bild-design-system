# CLAUDE.md - BILD Design System Token Pipeline

> Context-Dokument für AI-Assistenten. Beschreibt Architektur, Entscheidungen und Strukturen.

---

## Quick Reference

```bash
npm run build:tokens    # Vollständiger Build (preprocess + style-dictionary)
npm run build:bundles   # Nur CSS-Bundles neu generieren
npm run build           # Alles (tokens + bundles)
npm run clean           # dist/ und tokens/ löschen
```

**Source of Truth:** `src/design-tokens/bild-design-system-raw-data.json` (Figma Export via TokenSync Plugin)

**Dokumentation:** Detaillierte Platform-Dokumentation in `README.tokens.md`, `README.android.md`, `README.ios.md`

---

## Design System Architektur

### 4-Layer Token Hierarchie

Das Design System verwendet eine 4-schichtige Token-Architektur mit klarer Referenzierung von oben nach unten:

```
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 4: Component Tokens                                      │
│  Button, Card, Teaser, Alert, InputField, etc.                  │
│  → Referenziert Semantic Tokens                                 │
│  → Hat eigene Modes: color, density, breakpoint, typography     │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 3: Semantic Tokens                                       │
│  text-color-primary, surface-color-secondary, border-color-*    │
│  → Referenziert Brand Mapping                                   │
│  → Hat Modes: color (light/dark), breakpoint                    │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 2: Brand Mapping + Density                               │
│  Mappt Primitives auf Brand-spezifische Werte                   │
│  → Modes: BILD, SportBILD, Advertorial                          │
│  → Density: default, dense, spacious                            │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 1: Primitives (Global)                                   │
│  colorprimitive, spaceprimitive, sizeprimitive, fontprimitive   │
│  → Absolute Werte ohne Modes: #DD0000, 16px, etc.               │
└─────────────────────────────────────────────────────────────────┘
```

### Alias-Ketten

Tokens referenzieren sich gegenseitig via Aliase. Im CSS wird dies mit `var()` und Fallback abgebildet:

```css
/* Component → Semantic → Primitive */
--button-primary-bg-color: var(--core-color-primary, #DD0000);
--core-color-primary: var(--bildred, #DD0000);
--bildred: #DD0000;
```

**Entscheidung:** Immer Fallback-Werte verwenden für Robustheit bei fehlenden Variablen.

---

## Multi-Brand & Multi-Mode System

### Brands

| Brand | Beschreibung | Besonderheit |
|-------|--------------|--------------|
| **BILD** | Hauptmarke | Vollständiges Token-Set |
| **SportBILD** | Sport-Marke | Eigene Farben, eigenes Sizing |
| **Advertorial** | Werbung | Eigenes Sizing, KEINE eigenen Farben |

**Wichtig:** Advertorial hat keine eigenen Farben und verwendet die Farben von BILD oder SportBILD (siehe Dual-Axis Architektur).

### Token Modes

| Mode-Typ | Werte | Verwendung |
|----------|-------|------------|
| **Color** | `light`, `dark` | Farbschema |
| **Breakpoint** | `xs`, `sm`, `md`, `lg` | Responsive Sizing/Typography |
| **Density** | `default`, `dense`, `spacious` | UI-Dichte |
| **Typography** | `xs`, `sm`, `md`, `lg` | Schriftgrößen (referenziert Breakpoints) |

### Breakpoint-Werte

| Breakpoint | Min-Width | Geräteklasse |
|------------|-----------|--------------|
| `xs` | 320px | Mobile (Standard) |
| `sm` | 390px | Großes Mobile |
| `md` | 600px | Tablet |
| `lg` | 1024px | Desktop |

---

## Dual-Axis Architektur (Native Platforms)

### Problem

Advertorial hat eigene Sizing/Typography-Tokens, aber KEINE eigenen Farben. Es soll die Farben von BILD oder SportBILD verwenden können.

### Lösung: Zwei unabhängige Achsen

```
┌─────────────────────────────────────────────────────────────────┐
│  DUAL-AXIS THEME ARCHITECTURE                                   │
│                                                                 │
│  Achse 1: ColorBrand (Farbpalette + Effekte)                    │
│  ┌──────────────┬──────────────┐                                │
│  │    BILD      │  SportBILD   │  ← Nur Brands MIT Farben       │
│  └──────────────┴──────────────┘                                │
│                                                                 │
│  Achse 2: ContentBrand (Sizing/Typography)                      │
│  ┌──────────────┬──────────────┬──────────────┐                 │
│  │    BILD      │  SportBILD   │  Advertorial │  ← Alle Brands  │
│  └──────────────┴──────────────┴──────────────┘                 │
│                                                                 │
│  Kombination: Advertorial Content + SportBILD Farben            │
└─────────────────────────────────────────────────────────────────┘
```

### Implementierung

**iOS (SwiftUI):**
```swift
.designSystemTheme(
    colorBrand: .sportbild,      // Farben von SportBILD
    contentBrand: .advertorial   // Sizing von Advertorial
)
```

**Android (Compose):**
```kotlin
DesignSystemTheme(
    colorBrand = ColorBrand.Sportbild,
    contentBrand = ContentBrand.Advertorial
)
```

### Unified Interfaces

Für polymorphen Zugriff implementieren alle Brand-spezifischen Schemes ein gemeinsames Interface:

| Interface | Inhalt | Implementierungen |
|-----------|--------|-------------------|
| `DesignColorScheme` | Alle Farb-Tokens | BildColorScheme, SportbildColorScheme |
| `DesignSizingScheme` | Alle Sizing-Tokens | BildSizingScheme, SportbildSizingScheme, AdvertorialSizingScheme |
| `DesignEffectsScheme` | Shadow/Effect-Tokens (iOS) | BildEffects, SportbildEffects |

**Entscheidung:** Unified Interfaces erlauben brand-agnostischen Code und sichere Polymorphie.

---

## Platform-Patterns

### Web (CSS)

**Pattern:** Data-Attribute für Brand/Theme-Switching, @media für Breakpoints

```html
<html data-brand="bild" data-theme="light" data-density="default">
```

```css
/* Primitives: Global */
:root { --bildred: #DD0000; }

/* Semantic/Component: Brand + Theme scoped */
[data-brand="bild"][data-theme="light"] {
  --text-color-primary: var(--bild015, #232629);
}

/* Breakpoints: @media (nicht data-breakpoint!) */
@media (min-width: 1024px) {
  [data-brand="bild"] { --headline1-font-size: 64px; }
}

/* Typography/Effects: CSS-Klassen */
[data-brand="bild"] .headline1 { font-size: var(--headline1-font-size); }
```

**Entscheidung:** @media statt data-breakpoint, weil @media automatisch funktioniert ohne JS.

### iOS (SwiftUI)

**Pattern:** Environment-basiertes Theme mit @Observable

```swift
@Environment(\.designSystemTheme) var theme

// Polymorphe Zugriffe
theme.colors.textColorPrimary    // any DesignColorScheme
theme.sizing.gridSpaceRespBase   // any DesignSizingScheme
theme.effects.shadowSoftMd       // any DesignEffectsScheme
```

**Entscheidung:** @Observable für reaktives Theme-Management, Environment für Propagation.

### Android (Jetpack Compose)

**Pattern:** CompositionLocal-basiertes Theme

```kotlin
// Polymorphe Zugriffe via DesignSystemTheme object
DesignSystemTheme.colors.textColorPrimary    // DesignColorScheme
DesignSystemTheme.sizing.gridSpaceRespBase   // DesignSizingScheme

// Component Tokens via current() Accessor
ButtonTokens.Colors.current().buttonPrimaryBgColorIdle
```

**Entscheidung:** CompositionLocal für Theme-Propagation, current() für automatische Mode-Selektion.

---

## Native SizeClass Mapping

Web hat 4 Breakpoints, Native hat 2 SizeClasses:

```
Web Breakpoints              Native SizeClass
───────────────              ────────────────
xs (320px) ─────┐
                ├──────────→ compact (small screens)
sm (390px) ─────┘

md (600px) ─────┐
                ├──────────→ regular (large screens)
lg (1024px) ────┘
```

**Entscheidung:** Mapping von 4→2 statt 1:1, weil Native-Apps typischerweise nur 2 Layouts brauchen.

---

## Build Pipeline

```
Figma (Source of Truth)
        ↓ TokenSync Plugin Export
src/design-tokens/bild-design-system-raw-data.json
        ↓ preprocess.js
tokens/ (Style Dictionary Format, ~920 JSON files)
        ↓ build.js + style-dictionary.config.js
dist/ (Platform-spezifische Outputs)
        ↓ bundles.js
dist/css/bundles/ (Convenience CSS Bundles)
```

### Hauptdateien

| Datei | Zweck | LOC |
|-------|-------|-----|
| `preprocess.js` | Figma JSON → Style Dictionary Format, Alias-Resolution | ~2000 |
| `build.js` | Style Dictionary Orchestrierung, Platform Generation | ~1800 |
| `style-dictionary.config.js` | Custom Transforms & Formats | ~2500 |
| `bundles.js` | CSS Bundle Generierung | ~560 |

### Output-Plattformen

| Plattform | Status | Output |
|-----------|--------|--------|
| CSS | Aktiv | `dist/css/` |
| SCSS | Aktiv | `dist/scss/` |
| JavaScript | Aktiv | `dist/js/` |
| JSON | Aktiv | `dist/json/` |
| iOS Swift | Aktiv | `dist/ios/` |
| Android Compose | Aktiv | `dist/android/compose/` |
| Android XML | Deaktiviert | - |
| Flutter | Deaktiviert | - |

---

## Architektur-Entscheidungen

### Warum @media statt data-breakpoint?

```css
/* NICHT verwendet (benötigt JS): */
[data-breakpoint="lg"] { ... }

/* VERWENDET (funktioniert automatisch): */
@media (min-width: 1024px) { ... }
```

**Rationale:** Native Browser-Unterstützung, kein JS-Overhead, SSR-kompatibel.

### Warum var() mit Fallback?

```css
--button-bg: var(--core-color-primary, #DD0000);
```

**Rationale:** Robustheit bei fehlenden Variablen, einfacheres Debugging.

### Warum separate Mode-Dateien?

**Rationale:**
- Lazy Loading möglich (nur light ODER dark laden)
- Besseres Caching (Themes ändern sich unabhängig)
- Einfacheres Debugging

### Warum Dual-Axis statt Single Brand Enum?

**Problem:** Advertorial braucht BILD/SportBILD Farben + eigenes Sizing.
**Lösung:** ColorBrand + ContentBrand als unabhängige Achsen.
**Rationale:** Flexibilität ohne Code-Duplizierung, klare Separation of Concerns.

### Warum Unified Interfaces?

**Rationale:**
- Polymorphe Token-Zugriffe ohne Brand-Kenntnis
- Type-Safety in Swift/Kotlin
- Einfacher Austausch von Brands zur Laufzeit

### Warum Typography als Klassen statt Variablen?

```css
/* Klasse mit multiplen Properties: */
.headline1 {
  font-size: var(--headline1-font-size);
  font-weight: var(--headline1-font-weight);
  line-height: var(--headline1-line-height);
}
```

**Rationale:** Typography besteht aus mehreren zusammengehörigen Properties, Klassen gruppieren diese logisch.

---

## Änderungs-Guide

### Token-Werte ändern
→ **In Figma ändern** (Source of Truth), dann TokenSync Export

### Output-Format ändern
→ `style-dictionary.config.js` (Transforms & Formats)

### Alias-Logik ändern
→ `preprocess.js` (resolveAlias Funktion)

### Neuen Brand hinzufügen
→ `preprocess.js` (BRANDS), `build.js` (BRANDS, COLOR_BRANDS, CONTENT_BRANDS), `bundles.js` (BRANDS)

### Neuen Breakpoint hinzufügen
→ `preprocess.js` (BREAKPOINTS), `build.js` (BREAKPOINT_VALUES)

### Neue Plattform aktivieren
→ `build.js` (FLUTTER_ENABLED, ANDROID_XML_ENABLED)

### Component Token Pattern ändern
→ `style-dictionary.config.js` (compose*Format, iosSwift*Format)

---

## Debug-Tipps

```bash
# Preprocessed Tokens inspizieren
cat tokens/brands/bild/color/colormode-light.json | jq .

# CSS Output prüfen
cat dist/css/bild/theme.css | head -100

# Bundle-Größen
ls -la dist/css/bundles/

# iOS Output prüfen
cat dist/ios/shared/DesignSystemTheme.swift | head -50

# Android Output prüfen
cat dist/android/compose/shared/DesignSystemTheme.kt | head -50
```

---

## Häufige Probleme

| Problem | Mögliche Ursache | Lösung |
|---------|------------------|--------|
| Leere CSS-Dateien | Figma Collection-ID geändert | COLLECTION_IDS in preprocess.js prüfen |
| Fehlende Aliase | Figma Mode-Name geändert | Mode-Namen in Figma prüfen |
| Native Build-Fehler | Interface nicht synchron | Unified Interface Generierung prüfen |
| Falsche Farben | ColorBrand/ContentBrand verwechselt | Dual-Axis Konfiguration prüfen |

---

## Statistiken

| Metrik | Wert |
|--------|------|
| Components | ~55 pro Brand |
| Token-Dateien | ~920 |
| Output-Plattformen | 6 (2 deaktiviert) |
| CSS Bundle Size | ~130 KB pro Brand |
