# Implementierungsplan: Saubere Density Token Pipeline

## Ziel

Refactoring der Density-Token-Generierung für Native Platforms (Android/iOS), um die Style Dictionary Pipeline korrekt zu nutzen – analog zur Effects-Implementierung.

---

## Aktueller Zustand (Probleme)

```
flattenTokens() → "2px" → .replace('px','') → "2.dp"
                    ↑
            Für JS/CSS gedacht, nicht für Native
```

- `generateSharedDensityObjectsForAndroid()` und `generateSharedDensityObjectsForIOS()` umgehen Style Dictionary
- Manuelle "px"-Suffix-Entfernung ist ein Anti-Pattern
- Duplizierte Logik neben der existierenden Style Dictionary Pipeline

---

## Ziel-Zustand (Sauber)

```
Style Dictionary → custom/compose Transform → size/custom/compose → "2.dp"
                                                      ↑
                                              Korrekte Native-Transformation
```

---

## Implementierungsschritte

### Schritt 1: Neue Config-Funktion erstellen

**Datei:** `scripts/tokens/build.js`

**Aktion:** Neue Funktion `createSharedDensityConfig(densityMode)` erstellen (analog zu Effects-Config Zeile 710-788)

```javascript
/**
 * Creates platform config for shared (brand-independent) density tokens
 * Similar pattern to Effects - density values are identical across all brands
 *
 * @param {string} densityMode - 'default', 'dense', or 'spacious'
 */
function createSharedDensityConfig(densityMode) {
  // Source: Use bild as reference (values identical across brands)
  const sourceFile = path.join(TOKENS_DIR, 'brands', 'bild', 'density', `density-${densityMode}.json`);

  if (!fs.existsSync(sourceFile)) {
    return null;
  }

  const modePascal = densityMode.charAt(0).toUpperCase() + densityMode.slice(1);

  return {
    source: [sourceFile],
    platforms: {
      // Android: Jetpack Compose
      ...(COMPOSE_ENABLED ? {
        compose: {
          transformGroup: 'custom/compose',
          buildPath: `${DIST_DIR}/android/compose/shared/`,
          files: [{
            destination: `Density${modePascal}.kt`,
            format: 'compose/shared-density',  // Neues Format
            options: {
              packageName: 'com.bild.designsystem.shared',
              densityMode: modePascal
            }
          }]
        }
      } : {}),

      // iOS: SwiftUI
      ...(SWIFTUI_ENABLED ? {
        swiftui: {
          transformGroup: 'custom/ios-swift',
          buildPath: `${DIST_DIR}/ios/shared/`,
          files: [{
            destination: `Density${modePascal}.swift`,
            format: 'swiftui/shared-density',  // Neues Format
            options: {
              densityMode: modePascal
            }
          }]
        }
      } : {})
    }
  };
}
```

---

### Schritt 2: Neues Format für Android erstellen

**Datei:** `build-config/tokens/style-dictionary.config.js`

**Aktion:** Neues Format `compose/shared-density` hinzufügen

```javascript
/**
 * Format: Shared Density Object for Jetpack Compose
 * Brand-independent density tokens (like Effects)
 * Output: DensityDefault, DensityDense, DensitySpacious
 */
const composeSharedDensityFormat = ({ dictionary, options, file }) => {
  const { packageName, densityMode } = options;

  let output = generateFileHeader({
    fileName: file.destination,
    commentStyle: 'block',
    platform: 'android',
    context: `Shared Density${densityMode} Object\nBrand-independent semantic density tokens`
  });

  output += `package ${packageName}

import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

/**
 * ${densityMode} density spacing tokens (brand-independent)
 *
 * Semantic density tokens for spacing adjustments.
 * Same values across all brands (BILD, SportBILD, Advertorial).
 */
object Density${densityMode} : DesignDensityScheme {
`;

  // Tokens sind bereits durch custom/compose transformiert (size/custom/compose → X.dp)
  dictionary.allTokens.forEach(token => {
    const name = token.name;  // Bereits camelCase durch name/custom/compose
    const value = token.value;  // Bereits "X.dp" durch size/custom/compose
    output += `    override val ${name}: Dp = ${value}\n`;
  });

  output += `}\n`;
  return output;
};
```

---

### Schritt 3: Neues Format für iOS erstellen

**Datei:** `build-config/tokens/style-dictionary.config.js`

**Aktion:** Neues Format `swiftui/shared-density` hinzufügen

```javascript
/**
 * Format: Shared Density Struct for SwiftUI
 * Brand-independent density tokens (like Effects)
 * Output: DensityDefault, DensityDense, DensitySpacious
 */
const swiftuiSharedDensityFormat = ({ dictionary, options, file }) => {
  const { densityMode } = options;

  let output = generateFileHeader({
    fileName: file.destination,
    commentStyle: 'line',
    platform: 'ios',
    context: `Shared Density${densityMode} Struct\nBrand-independent semantic density tokens`
  });

  output += `import SwiftUI

/// ${densityMode} density spacing tokens (brand-independent)
///
/// Semantic density tokens for spacing adjustments.
/// Same values across all brands (BILD, SportBILD, Advertorial).
public struct Density${densityMode}: DesignDensityScheme {
    public static let shared = Density${densityMode}()
    private init() {}

`;

  // Tokens sind bereits durch custom/ios-swift transformiert
  dictionary.allTokens.forEach(token => {
    const name = token.name;  // Bereits camelCase
    const value = token.value;  // Numerischer Wert (CGFloat-kompatibel)
    output += `    public let ${name}: CGFloat = ${value}\n`;
  });

  output += `}\n`;
  return output;
};
```

---

### Schritt 4: Formate registrieren

**Datei:** `build-config/tokens/style-dictionary.config.js`

**Aktion:** In `formats` Object hinzufügen (ca. Zeile 4514)

```javascript
formats: {
  // ... existing formats ...

  // Shared Density Formats (brand-independent)
  'compose/shared-density': composeSharedDensityFormat,
  'swiftui/shared-density': swiftuiSharedDensityFormat,
}
```

---

### Schritt 5: Build-Funktion für Shared Density erstellen

**Datei:** `scripts/tokens/build.js`

**Aktion:** Neue Funktion `buildSharedDensityTokens()` erstellen

```javascript
/**
 * Builds shared (brand-independent) density tokens
 * Similar to Effects - density values are identical across all brands
 * Output: dist/android/compose/shared/Density{Mode}.kt
 *         dist/ios/shared/Density{Mode}.swift
 */
async function buildSharedDensityTokens() {
  console.log('\n🎛️  Building Shared Density Tokens:\n');

  const densityModes = ['default', 'dense', 'spacious'];
  let successful = 0;

  for (const mode of densityModes) {
    const config = createSharedDensityConfig(mode);

    if (!config) {
      console.warn(`     ⚠️ Density config not found for mode: ${mode}`);
      continue;
    }

    try {
      const sd = new StyleDictionary(config);
      await sd.buildAllPlatforms();
      console.log(`     ✅ Density${mode.charAt(0).toUpperCase() + mode.slice(1)}`);
      successful++;
    } catch (error) {
      console.error(`     ❌ Density ${mode}: ${error.message}`);
    }
  }

  return { total: densityModes.length, successful };
}
```

---

### Schritt 6: Manuelle Funktionen entfernen

**Datei:** `scripts/tokens/build.js`

**Aktion:** Folgende Funktionen entfernen:

1. `generateSharedDensityObjectsForAndroid()` (ca. Zeile 4760-4815)
2. `generateSharedDensityObjectsForIOS()` (ca. Zeile 4820-4870)

**Aktion:** Aufrufe dieser Funktionen entfernen:

```javascript
// ENTFERNEN in generateSharedAndroidFiles() (ca. Zeile 3750-3760):
// Shared Density objects (brand-independent, like Effects)
const densityObjectsAndroid = generateSharedDensityObjectsForAndroid();
for (const [mode, content] of Object.entries(densityObjectsAndroid)) {
  // ...
}

// ENTFERNEN in generateSharedIOSFiles():
const densityObjectsIOS = generateSharedDensityObjectsForIOS();
for (const [mode, content] of Object.entries(densityObjectsIOS)) {
  // ...
}
```

---

### Schritt 7: Build-Aufruf integrieren

**Datei:** `scripts/tokens/build.js`

**Aktion:** `buildSharedDensityTokens()` in Main-Build-Funktion aufrufen

```javascript
// In main() oder buildAllTokens():
// Nach buildSharedPrimitives(), vor generateSharedAndroidFiles()

const sharedDensityResult = await buildSharedDensityTokens();
```

---

### Schritt 8: Per-Brand Density für Native deaktivieren

**Datei:** `scripts/tokens/build.js`

**Aktion:** In `createStandardPlatformConfig()` Native-Output für Density-Tokens überspringen

```javascript
// In createStandardPlatformConfig() für compose/swiftui Plattformen:
// Density-Tokens nicht per-brand generieren, da sie jetzt shared sind

// Bedingung hinzufügen:
...((cssOptions.modeType === 'density') ? {} : {
  compose: { /* existing config */ }
})
```

---

## Datei-Änderungen Zusammenfassung

| Datei | Änderung |
|-------|----------|
| `scripts/tokens/build.js` | + `createSharedDensityConfig()` |
| `scripts/tokens/build.js` | + `buildSharedDensityTokens()` |
| `scripts/tokens/build.js` | - `generateSharedDensityObjectsForAndroid()` |
| `scripts/tokens/build.js` | - `generateSharedDensityObjectsForIOS()` |
| `scripts/tokens/build.js` | ~ `createStandardPlatformConfig()` - Density für Native überspringen |
| `build-config/tokens/style-dictionary.config.js` | + `composeSharedDensityFormat` |
| `build-config/tokens/style-dictionary.config.js` | + `swiftuiSharedDensityFormat` |
| `build-config/tokens/style-dictionary.config.js` | ~ `formats` Object erweitern |

---

## Erwartetes Ergebnis

### Vorher (Workaround)
```
flattenTokens() → "2px" → replace('px','') → manual string concat → "2.dp"
```

### Nachher (Sauber)
```
Style Dictionary → custom/compose → size/custom/compose → "2.dp"
                                            ↑
                                    Standard-Pipeline
```

### Output-Dateien (unverändert)
```
dist/android/compose/shared/
├── DensityDefault.kt
├── DensityDense.kt
└── DensitySpacious.kt

dist/ios/shared/
├── DensityDefault.swift
├── DensityDense.swift
└── DensitySpacious.swift
```

---

## Testplan

1. `npm run build:tokens` ausführen
2. Prüfen ob Density-Dateien in `shared/` generiert werden
3. Prüfen ob Werte korrekt sind (`.dp` für Kotlin, numerisch für Swift)
4. Prüfen ob keine per-brand Density-Dateien für Native generiert werden
5. Prüfen ob CSS/JS Density-Output weiterhin funktioniert
