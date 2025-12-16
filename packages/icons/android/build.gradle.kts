/**
 * BILD Design System Icons - Android Library
 *
 * Publishes vector drawable icons to GitHub Packages (Maven).
 *
 * Usage:
 *   ./gradlew build                    # Build AAR
 *   ./gradlew publish -PVERSION=1.0.0  # Publish to GitHub Packages
 *
 * Consumer:
 *   repositories {
 *       maven { url = uri("https://maven.pkg.github.com/UXWizard25/vv-token-test-v3") }
 *   }
 *   dependencies {
 *       implementation("de.bild.design:icons:1.0.0")
 *   }
 */

plugins {
    id("com.android.library") version "8.2.0"
    id("maven-publish")
}

android {
    namespace = "de.bild.design.icons"
    compileSdk = 34

    defaultConfig {
        minSdk = 21
        consumerProguardFiles("consumer-rules.pro")
    }

    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }

    sourceSets {
        getByName("main") {
            res.srcDirs("src/main/res")
            manifest.srcFile("src/main/AndroidManifest.xml")
        }
    }

    publishing {
        singleVariant("release") {
            withSourcesJar()
        }
    }
}

publishing {
    publications {
        create<MavenPublication>("release") {
            groupId = "de.bild.design"
            artifactId = "icons"
            version = providers.gradleProperty("VERSION").getOrElse("1.0.0")

            afterEvaluate {
                from(components["release"])
            }

            pom {
                name.set("BILD Design System Icons")
                description.set("Vector drawable icons for Android from the BILD Design System")
                url.set("https://github.com/UXWizard25/vv-token-test-v3")

                licenses {
                    license {
                        name.set("MIT License")
                        url.set("https://opensource.org/licenses/MIT")
                    }
                }

                developers {
                    developer {
                        id.set("bild-design-system")
                        name.set("BILD Design System Team")
                    }
                }

                scm {
                    connection.set("scm:git:git://github.com/UXWizard25/vv-token-test-v3.git")
                    developerConnection.set("scm:git:ssh://github.com/UXWizard25/vv-token-test-v3.git")
                    url.set("https://github.com/UXWizard25/vv-token-test-v3")
                }
            }
        }
    }

    repositories {
        maven {
            name = "GitHubPackages"
            url = uri("https://maven.pkg.github.com/UXWizard25/vv-token-test-v3")
            credentials {
                username = System.getenv("GITHUB_ACTOR") ?: providers.gradleProperty("gpr.user").getOrElse("")
                password = System.getenv("GITHUB_TOKEN") ?: providers.gradleProperty("gpr.token").getOrElse("")
            }
        }
    }
}
