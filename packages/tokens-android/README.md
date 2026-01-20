# BILD Design System Tokens for Android

Design tokens for Android applications using Jetpack Compose.

## Installation

### 1. Add GitHub Packages Repository

Add to your `settings.gradle.kts`:

```kotlin
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://maven.pkg.github.com/UXWizard25/bild-design-system")
            credentials {
                username = providers.gradleProperty("gpr.user").orNull
                    ?: System.getenv("GITHUB_USERNAME")
                password = providers.gradleProperty("gpr.token").orNull
                    ?: System.getenv("GITHUB_TOKEN")
            }
        }
    }
}
```

### 2. Add Dependency

Add to your module's `build.gradle.kts`:

```kotlin
dependencies {
    implementation("de.bild.design:tokens:1.0.0")
}
```

### 3. Configure Credentials

Create or edit `~/.gradle/gradle.properties`:

```properties
gpr.user=YOUR_GITHUB_USERNAME
gpr.token=YOUR_GITHUB_PERSONAL_ACCESS_TOKEN
```

The token needs `read:packages` scope. Generate at: GitHub → Settings → Developer settings → Personal access tokens

## Usage

### Theme Setup (Dual-Axis Architecture)

```kotlin
import com.bild.designsystem.shared.*

@Composable
fun MyApp() {
    DesignSystemTheme(
        colorBrand = ColorBrand.Bild,           // Colors & Effects
        contentBrand = ContentBrand.Bild,       // Sizing & Typography
        darkTheme = isSystemInDarkTheme(),
        sizeClass = WindowSizeClass.Compact,
        density = Density.Default
    ) {
        MyScreen()
    }
}
```

### Accessing Tokens

```kotlin
@Composable
fun MyScreen() {
    val colors = DesignSystemTheme.colors
    val sizing = DesignSystemTheme.sizing

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(colors.bgColorPrimary)
            .padding(sizing.gridSpaceRespBase)
    ) {
        // Brand-colored headline
        Text(
            text = "BILD",
            color = colors.textColorBrand,
            fontSize = 32.sp
        )

        // Primary text
        Text(
            text = "Hello World",
            color = colors.textColorPrimary
        )

        // Secondary text
        Text(
            text = "Subtitle",
            color = colors.textColorSecondary
        )

        // Button with brand color
        Button(
            onClick = { },
            colors = ButtonDefaults.buttonColors(
                containerColor = colors.bgColorBrandSolid
            )
        ) {
            Text("Click me")
        }
    }
}
```

## Dual-Axis Architecture

The design system uses a **Dual-Axis Architecture** that separates color and content concerns:

| Axis | Controls | Options |
|------|----------|---------|
| **ColorBrand** | Colors, Effects | `Bild`, `Sportbild` |
| **ContentBrand** | Sizing, Typography | `Bild`, `Sportbild`, `Advertorial` |

This enables use cases like "Advertorial content with SportBILD colors":

```kotlin
DesignSystemTheme(
    colorBrand = ColorBrand.Sportbild,      // Blue colors
    contentBrand = ContentBrand.Advertorial  // Advertorial typography
) {
    AdvertorialContent()
}
```

## Available Tokens

### Colors (`DesignSystemTheme.colors`)

```kotlin
// Text Colors
colors.textColorBrand          // Brand color (BILD Red / SportBILD Blue)
colors.textColorPrimary        // Primary text
colors.textColorSecondary      // Secondary text
colors.textColorTertiary       // Tertiary text
colors.textColorSuccess        // Success state
colors.textColorError          // Error state
colors.textColorWarning        // Warning state

// Background Colors
colors.bgColorPrimary          // Primary background
colors.bgColorSecondary        // Secondary background
colors.bgColorTertiary         // Tertiary background
colors.bgColorBrandSolid       // Brand color as background
colors.bgColorBrandTint        // Light tint of brand color
colors.bgColorSuccessSolid     // Success background
colors.bgColorSuccessTint      // Success tint
colors.bgColorErrorSolid       // Error background
colors.bgColorErrorTint        // Error tint

// Border Colors
colors.borderColorLowContrast
colors.borderColorMediumContrast
colors.borderColorHighContrast
```

### Sizing (`DesignSystemTheme.sizing`)

```kotlin
// Grid Spacing (responsive)
sizing.gridSpaceRespBase
sizing.gridSpaceRespSm
sizing.gridSpaceRespMd
sizing.gridSpaceRespLg

// Page Layout
sizing.pageInlineSpace
sizing.sectionSpaceBase
```

### Density-Aware Spacing

Spacing that adapts to both WindowSizeClass and Density:

```kotlin
// Responsive (varies by WindowSizeClass AND Density)
DesignSystemTheme.stackSpaceRespSm   // Small responsive space
DesignSystemTheme.stackSpaceRespMd   // Medium responsive space
DesignSystemTheme.stackSpaceRespLg   // Large responsive space
DesignSystemTheme.stackSpaceRespXl   // Extra large responsive space

// Constant (same across WindowSizeClasses, varies by Density)
DesignSystemTheme.stackSpaceConstSm  // Small constant space
DesignSystemTheme.stackSpaceConstMd  // Medium constant space
DesignSystemTheme.stackSpaceConstLg  // Large constant space
```

### Typography (`DesignSystemTheme.typography`)

```kotlin
typography.display1            // Largest display text
typography.display2
typography.display3
typography.headline1           // Headlines
typography.headline2
typography.headline3
typography.headline4
typography.subheadline1
typography.body                // Body text
typography.bodyBold
typography.kicker1             // Kicker text
typography.kicker2
typography.label1              // Labels
typography.label2
```

### Effects (`DesignSystemTheme.effects`)

```kotlin
effects.shadowSoftSm           // Small soft shadow
effects.shadowSoftMd           // Medium soft shadow
effects.shadowSoftLg           // Large soft shadow
effects.shadowHardSm           // Small hard shadow
effects.shadowHardMd           // Medium hard shadow
effects.shadowHardLg           // Large hard shadow
```

## Component Tokens

Component-specific tokens with automatic Light/Dark mode resolution:

```kotlin
// Button tokens
val buttonColors = ButtonTokens.Colors.current()
buttonColors.buttonPrimaryBgColorIdle
buttonColors.buttonPrimaryBgColorHover
buttonColors.buttonPrimaryLabelColor

// Alert tokens
val alertColors = AlertTokens.Colors.current()
alertColors.alertBgColor
alertColors.alertTextColor
```

## Window Size Classes (Material 3)

| Size Class | Width | Devices | Figma Breakpoint |
|------------|-------|---------|------------------|
| `Compact` | < 600dp | Phones | xs, sm |
| `Medium` | 600-839dp | Foldables, small tablets | md |
| `Expanded` | ≥ 840dp | Tablets, desktop | lg |

## Density Modes

| Mode | Use Case | Effect |
|------|----------|--------|
| `Density.Default` | Standard UI | Normal spacing |
| `Density.Dense` | Data tables, lists | Reduced spacing |
| `Density.Spacious` | Hero sections, marketing | Increased spacing |

## Complete Example

```kotlin
@Composable
fun BildArticleCard(
    title: String,
    subtitle: String,
    onReadMore: () -> Unit
) {
    val colors = DesignSystemTheme.colors
    val sizing = DesignSystemTheme.sizing

    Card(
        modifier = Modifier.fillMaxWidth(),
        colors = CardDefaults.cardColors(
            containerColor = colors.bgColorPrimary
        )
    ) {
        Column(
            modifier = Modifier.padding(sizing.gridSpaceRespBase),
            verticalArrangement = Arrangement.spacedBy(
                DesignSystemTheme.stackSpaceRespSm
            )
        ) {
            // Kicker
            Text(
                text = "BREAKING",
                color = colors.textColorBrand,
                style = MaterialTheme.typography.labelSmall
            )

            // Title
            Text(
                text = title,
                color = colors.textColorPrimary,
                style = MaterialTheme.typography.headlineSmall
            )

            // Subtitle
            Text(
                text = subtitle,
                color = colors.textColorSecondary,
                style = MaterialTheme.typography.bodyMedium
            )

            // Button
            Button(
                onClick = onReadMore,
                colors = ButtonDefaults.buttonColors(
                    containerColor = colors.bgColorBrandSolid
                )
            ) {
                Text("Read More")
            }
        }
    }
}
```

## Requirements

- Android SDK 21+ (minSdk)
- Jetpack Compose 1.6.0+
- Kotlin 1.9.22+

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "Could not resolve de.bild.design:tokens" | Check GitHub credentials in `gradle.properties` |
| "Unresolved reference: DesignSystemTheme" | Run Gradle Sync, Rebuild Project |
| Tokens not updating | File → Invalidate Caches → Restart |

## License

Proprietary - Axel Springer Deutschland GmbH
