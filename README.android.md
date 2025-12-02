# Android Jetpack Compose - Design System Tokens

> **Kotlin-basierte Design Tokens für Jetpack Compose**
>
> Type-safe, theme-aware, multi-brand ready.

---

## Inhaltsverzeichnis

- [Quick Start](#quick-start)
- [Architektur](#architektur)
- [Theme Provider](#theme-provider)
- [Token-Zugriff](#token-zugriff)
- [Multi-Brand Apps](#multi-brand-apps)
- [Dateistruktur](#dateistruktur)
- [API-Referenz](#api-referenz)

---

## Quick Start

### 1. Dateien kopieren

```bash
# Compose-Output in dein Android-Projekt kopieren
cp -r dist/android/compose/* app/src/main/java/com/bild/designsystem/
```

### 2. Theme einbinden

```kotlin
import com.bild.designsystem.bild.theme.BildTheme
import com.bild.designsystem.shared.WindowSizeClass
import com.bild.designsystem.shared.Density

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            BildTheme(
                darkTheme = isSystemInDarkTheme(),
                sizeClass = WindowSizeClass.Compact,
                density = Density.Default
            ) {
                MyApp()
            }
        }
    }
}
```

### 3. Tokens verwenden

```kotlin
@Composable
fun MyScreen() {
    // Semantic Tokens (via Theme)
    Text(
        text = "Headline",
        color = BildTheme.colors.textColorPrimary,
        fontSize = BildTheme.sizing.headline1FontSize
    )

    // Component Tokens (via current() Accessors)
    Button(
        colors = ButtonDefaults.buttonColors(
            containerColor = ButtonTokens.Colors.current().buttonPrimaryBgColorIdle
        )
    ) {
        Text("Click me")
    }
}
```

---

## Architektur

```
┌─────────────────────────────────────────────────────────────────┐
│  SHARED (brand-unabhängig)                                      │
│  ─────────────────────────────────────────────────────────────  │
│  Density          │ Dense, Default, Spacious                    │
│  WindowSizeClass  │ Compact, Regular                            │
│  Brand            │ Bild, Sportbild, Advertorial                │
│  DesignSystemTheme│ Multi-Brand Theme Provider                  │
│  DesignTokenPrimitives │ Farben, Spacing, Sizes, Fonts          │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  BRAND-SPEZIFISCH (z.B. Bild)                                   │
│  ─────────────────────────────────────────────────────────────  │
│  BildTheme        │ CompositionLocal Theme Provider             │
│    .colors        │ → BildColorScheme (Light/Dark)              │
│    .sizing        │ → BildSizingScheme (Compact/Regular)        │
│    .density       │ → Density Enum                              │
│    .sizeClass     │ → WindowSizeClass Enum                      │
│    .isDarkTheme   │ → Boolean                                   │
├─────────────────────────────────────────────────────────────────┤
│  COMPONENT TOKENS                                               │
│  ─────────────────────────────────────────────────────────────  │
│  ButtonTokens, CardTokens, TeaserTokens, ...                    │
│    .Colors.current()      │ → ColorTokens (Light/Dark)          │
│    .Sizing.current()      │ → SizingTokens (Compact/Regular)    │
│    .Typography.current()  │ → TypographyTokens (Compact/Regular)│
│    .Density.current()     │ → DensityTokens (Dense/Default/...) │
└─────────────────────────────────────────────────────────────────┘
```

---

## Theme Provider

### BildTheme (Single-Brand)

```kotlin
import com.bild.designsystem.bild.theme.BildTheme
import com.bild.designsystem.shared.WindowSizeClass
import com.bild.designsystem.shared.Density

@Composable
fun MyApp() {
    BildTheme(
        darkTheme = isSystemInDarkTheme(),
        sizeClass = WindowSizeClass.Compact,  // oder .Regular
        density = Density.Default              // oder .Dense, .Spacious
    ) {
        // Dein App-Content
    }
}
```

### Parameter

| Parameter | Typ | Default | Beschreibung |
|-----------|-----|---------|--------------|
| `darkTheme` | `Boolean` | `isSystemInDarkTheme()` | Light/Dark Mode |
| `sizeClass` | `WindowSizeClass` | `Compact` | Responsive Layout |
| `density` | `Density` | `Default` | UI-Dichte |
| `lightColors` | `BildColorScheme` | `BildLightColors` | Custom Light Colors |
| `darkColors` | `BildColorScheme` | `BildDarkColors` | Custom Dark Colors |

### WindowSizeClass berechnen

```kotlin
import androidx.compose.material3.windowsizeclass.calculateWindowSizeClass
import androidx.compose.material3.windowsizeclass.WindowWidthSizeClass

@Composable
fun rememberDesignSystemSizeClass(activity: Activity): WindowSizeClass {
    val windowSizeClass = calculateWindowSizeClass(activity)
    return when (windowSizeClass.widthSizeClass) {
        WindowWidthSizeClass.Compact -> WindowSizeClass.Compact
        else -> WindowSizeClass.Regular
    }
}
```

---

## Token-Zugriff

### Semantic Tokens (via BildTheme)

Für globale Design-Entscheidungen:

```kotlin
@Composable
fun SemanticExample() {
    // Farben - automatisch Light/Dark
    val textColor = BildTheme.colors.textColorPrimary
    val bgColor = BildTheme.colors.surfaceColorPrimary
    val accentColor = BildTheme.colors.textColorAccent

    // Sizing - automatisch Compact/Regular
    val headlineSize = BildTheme.sizing.headline1FontSize
    val bodySize = BildTheme.sizing.body1FontSize

    // Theme-State abfragen
    val isDark = BildTheme.isDarkTheme
    val sizeClass = BildTheme.sizeClass
    val density = BildTheme.density
}
```

### Component Tokens (via current())

Für component-spezifische Tokens mit automatischer Theme-Auswahl:

```kotlin
import com.bild.designsystem.bild.components.ButtonTokens
import com.bild.designsystem.bild.components.CardTokens
import com.bild.designsystem.bild.components.TeaserTokens

@Composable
fun ComponentExample() {
    // Colors - automatisch Light/Dark
    val buttonBg = ButtonTokens.Colors.current().buttonPrimaryBgColorIdle
    val buttonHover = ButtonTokens.Colors.current().buttonPrimaryBgColorHover

    // Sizing - automatisch Compact/Regular
    val buttonHeight = ButtonTokens.Sizing.current().buttonContentMinHeightSize
    val cardRadius = CardTokens.Sizing.current().cardBorderRadius

    // Typography - automatisch Compact/Regular
    val fontFamily = ButtonTokens.Typography.current().buttonLabelFontFamily
    val fontSize = ButtonTokens.Typography.current().buttonLabelFontSize
    val fontWeight = ButtonTokens.Typography.current().buttonLabelFontWeight

    // Density - automatisch Dense/Default/Spacious
    val gap = ButtonTokens.Density.current().denseButtonContentGapSpace
}
```

### Statischer Zugriff (ohne Theme)

Wenn du explizit einen Mode brauchst:

```kotlin
// Direkt Light/Dark
val lightColor = ButtonTokens.Colors.Light.buttonPrimaryBgColorIdle
val darkColor = ButtonTokens.Colors.Dark.buttonPrimaryBgColorIdle

// Direkt Compact/Regular
val compactSize = ButtonTokens.Sizing.Compact.buttonLabelFontSize
val regularSize = ButtonTokens.Sizing.Regular.buttonLabelFontSize

// Direkt Dense/Default/Spacious
val denseGap = ButtonTokens.Density.Dense.denseButtonContentGapSpace
val defaultGap = ButtonTokens.Density.Default.denseButtonContentGapSpace
```

### Primitives (Basis-Werte)

```kotlin
import com.bild.designsystem.shared.DesignTokenPrimitives

// Farben
val red = DesignTokenPrimitives.Colors.bildred
val gray = DesignTokenPrimitives.Colors.bild050

// Spacing
val space2x = DesignTokenPrimitives.Space.space2x
val space4x = DesignTokenPrimitives.Space.space4x

// Sizes
val size4x = DesignTokenPrimitives.Size.size4x
```

---

## Multi-Brand Apps

### DesignSystemTheme (Zentraler Entry Point)

Für Apps die mehrere Brands unterstützen:

```kotlin
import com.bild.designsystem.shared.Brand
import com.bild.designsystem.shared.DesignSystemTheme
import com.bild.designsystem.shared.WindowSizeClass
import com.bild.designsystem.shared.Density

@Composable
fun MultiB­randApp(brand: Brand) {
    DesignSystemTheme(
        brand = brand,
        darkTheme = isSystemInDarkTheme(),
        sizeClass = WindowSizeClass.Compact,
        density = Density.Default
    ) {
        // Content verwendet automatisch die richtigen Brand-Tokens
        MyAppContent()
    }
}
```

### White-Label App

```kotlin
// Brand aus Build-Config oder Remote-Config
val brand = Brand.valueOf(BuildConfig.BRAND_NAME)  // "Bild", "Sportbild", "Advertorial"

DesignSystemTheme(brand = brand) {
    MyWhiteLabelApp()
}
```

### Runtime Brand-Switching

```kotlin
@Composable
fun BrandSwitcherDemo() {
    var currentBrand by remember { mutableStateOf(Brand.Bild) }

    Column {
        // Brand-Auswahl
        Row {
            Brand.values().forEach { brand ->
                Button(onClick = { currentBrand = brand }) {
                    Text(brand.name)
                }
            }
        }

        // Content mit gewählter Brand
        DesignSystemTheme(brand = currentBrand) {
            BrandedContent()
        }
    }
}
```

---

## Dateistruktur

```
com/bild/designsystem/
├── shared/                              # Brand-unabhängig
│   ├── DesignTokenPrimitives.kt         # Alle Primitives
│   ├── Density.kt                       # Dense/Default/Spacious
│   ├── WindowSizeClass.kt               # Compact/Regular
│   ├── Brand.kt                         # Bild/Sportbild/Advertorial
│   └── DesignSystemTheme.kt             # Multi-Brand Theme
│
├── bild/                                # Brand: BILD
│   ├── theme/
│   │   └── BildTheme.kt                 # Theme Provider
│   ├── semantic/
│   │   ├── BildSemanticTokens.kt        # Aggregierte Semantic Tokens
│   │   ├── color/
│   │   │   ├── ColorsLight.kt           # BildColorScheme + BildLightColors
│   │   │   └── ColorsDark.kt            # BildDarkColors
│   │   └── sizeclass/
│   │       ├── SizingCompact.kt         # BildSizingScheme + BildSizingCompact
│   │       └── SizingRegular.kt         # BildSizingRegular
│   └── components/
│       ├── Button/
│       │   └── ButtonTokens.kt          # Colors/Sizing/Typography/Density
│       ├── Card/
│       │   └── CardTokens.kt
│       ├── Teaser/
│       │   └── TeaserTokens.kt
│       └── ... (50+ Components)
│
├── sportbild/                           # Brand: SportBILD
│   └── ... (gleiche Struktur)
│
└── advertorial/                         # Brand: Advertorial
    └── ... (gleiche Struktur)
```

---

## API-Referenz

### Shared Enums

```kotlin
package com.bild.designsystem.shared

enum class Density {
    Dense,      // Kompakte UI
    Default,    // Standard
    Spacious    // Großzügige UI
}

enum class WindowSizeClass {
    Compact,    // Phones (Portrait)
    Regular     // Tablets, Phones (Landscape)
}

enum class Brand {
    Bild,
    Sportbild,
    Advertorial
}
```

### Theme Object

```kotlin
object BildTheme {
    val colors: BildColorScheme      // Aktuelle Farben (Light/Dark)
    val sizing: BildSizingScheme     // Aktuelle Sizes (Compact/Regular)
    val density: Density             // Aktuelle Density
    val sizeClass: WindowSizeClass   // Aktuelle SizeClass
    val isDarkTheme: Boolean         // Dark Mode aktiv?
}
```

### Component Token Accessors

```kotlin
object ButtonTokens {
    object Colors {
        fun current(): ColorTokens    // Theme-aware (Light/Dark)
        object Light : ColorTokens
        object Dark : ColorTokens
    }
    object Sizing {
        fun current(): SizingTokens   // Theme-aware (Compact/Regular)
        object Compact : SizingTokens
        object Regular : SizingTokens
    }
    object Typography {
        fun current(): TypographyTokens  // Theme-aware (Compact/Regular)
        object Compact : TypographyTokens
        object Regular : TypographyTokens
    }
    object Density {
        fun current(): DensityTokens  // Theme-aware (Dense/Default/Spacious)
        object Dense : DensityTokens
        object Default : DensityTokens
        object Spacious : DensityTokens
    }
}
```

---

## Best Practices

### 1. Semantic vs Component Tokens

```kotlin
// ✅ Semantic Tokens für globale UI-Elemente
Text(color = BildTheme.colors.textColorPrimary)

// ✅ Component Tokens für spezifische Components
Button(containerColor = ButtonTokens.Colors.current().buttonPrimaryBgColorIdle)
```

### 2. current() für automatische Auswahl

```kotlin
// ✅ Theme-aware - passt sich automatisch an
val color = ButtonTokens.Colors.current().buttonPrimaryBgColorIdle

// ⚠️ Statisch - nur wenn explizit ein Mode gebraucht wird
val lightColor = ButtonTokens.Colors.Light.buttonPrimaryBgColorIdle
```

### 3. WindowSizeClass für Responsive Layouts

```kotlin
@Composable
fun ResponsiveLayout() {
    when (BildTheme.sizeClass) {
        WindowSizeClass.Compact -> PhoneLayout()
        WindowSizeClass.Regular -> TabletLayout()
    }
}
```

### 4. Density für Accessibility

```kotlin
// Density wird im Theme gesetzt und automatisch angewendet
BildTheme(density = Density.Spacious) {
    // Alle Density-Tokens haben größere Werte
}
```

---

## Abhängigkeiten

```kotlin
// build.gradle.kts
dependencies {
    implementation("androidx.compose.foundation:foundation")
    implementation("androidx.compose.runtime:runtime")
    implementation("androidx.compose.ui:ui")

    // Optional für WindowSizeClass-Berechnung
    implementation("androidx.compose.material3:material3-window-size-class")
}
```

---

## Verwandte Dokumentation

| Dokument | Beschreibung |
|----------|--------------|
| [README.md](./README.md) | Projekt-Übersicht |
| [README.tokens.md](./README.tokens.md) | Alle Plattformen |
| [CLAUDE.md](./CLAUDE.md) | Build-Pipeline Details |

---

**Generated by BILD Design System Token Pipeline**
