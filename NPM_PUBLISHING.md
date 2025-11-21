# 📦 NPM Publishing Setup & Wartungsanleitung

Diese Anleitung erklärt Schritt für Schritt, wie du deine Design Tokens als NPM Package veröffentlichst und wartest.

---

## 🎯 Übersicht

Dein Design Token Package ist jetzt konfiguriert als:
- **Package Name:** `@uxwizard25/design-system-tokens`
- **Registry:** GitHub Packages (kostenlos & privat)
- **Versionierung:** Git Tags mit manuellem Approve
- **Auto-Updates:** Dependabot (automatische PR's für Dependency Updates)

---

## 🚀 ERSTMALIGES SETUP

### Schritt 1: GitHub Environment für manuelles Approve einrichten

Das Package wird **erst nach deinem manuellen Approve** veröffentlicht.

**So richtest du das ein:**

1. Gehe zu deinem GitHub Repository: https://github.com/UXWizard25/vv-token-test-v3
2. Klicke auf **Settings** (⚙️ oben rechts)
3. In der linken Sidebar: **Environments**
4. Klicke auf **New environment**
5. Name: `npm-publish` (exakt so schreiben!)
6. Klicke auf **Configure environment**
7. Aktiviere **Required reviewers**
8. Füge dich selbst als Reviewer hinzu (`UXWizard25`)
9. Klicke auf **Save protection rules**

**Was bewirkt das?**
- Bei jedem Release-Versuch musst du manuell auf "Approve" klicken
- Verhindert versehentliches Publishing
- Du hast volle Kontrolle über Releases

---

## 📝 PACKAGE VERÖFFENTLICHEN (Release Workflow)

### Schritt 1: Tokens aktualisieren

```bash
# Ändere deine Tokens in Figma oder lokal
# ...

# Committe die Änderungen
git add src/design-tokens/
git commit -m "feat: add new color tokens for dark mode"
git push
```

### Schritt 2: Version entscheiden

Wähle die neue Version nach **Semantic Versioning**:

| Änderung | Version Bump | Beispiel |
|----------|-------------|----------|
| 🐛 Bug Fix | Patch | `1.0.0` → `1.0.1` |
| ✨ Neues Feature (kompatibel) | Minor | `1.0.0` → `1.1.0` |
| 💥 Breaking Change | Major | `1.0.0` → `2.0.0` |

**Beispiele:**
- Neue Farbe hinzugefügt → Minor (`1.1.0`)
- Farbnamen geändert → Major (`2.0.0`)
- Falsche Farbwerte gefixt → Patch (`1.0.1`)

### Schritt 3: Git Tag erstellen

```bash
# Format: v{MAJOR}.{MINOR}.{PATCH}

# Beispiel für Patch Release:
git tag v1.0.1

# Beispiel für Minor Release:
git tag v1.1.0

# Beispiel für Major Release:
git tag v2.0.0

# Tag pushen (triggert den Workflow!)
git push --tags
```

### Schritt 4: Workflow überwachen

1. Gehe zu GitHub: **Actions** Tab
2. Du siehst einen Workflow: **"Publish to GitHub Packages"**
3. Der Workflow läuft in 3 Phasen:

   **Phase 1: Build** ✅ (automatisch)
   - Dependencies installieren
   - Tokens bauen
   - Tests durchführen
   - Artifacts hochladen

   **Phase 2: Publish** ⏸️ (wartet auf dein Approve)
   - ⚠️ Workflow pausiert hier
   - Du bekommst eine Benachrichtigung
   - Du musst manuell approven

   **Phase 3: Release** ✅ (automatisch nach Approve)
   - GitHub Release erstellen
   - Release Notes generieren
   - Download-Artifacts bereitstellen

### Schritt 5: Manuell approven

1. Gehe zum **Actions** Tab in GitHub
2. Klicke auf den wartenden Workflow
3. Du siehst: **"Review pending"** oder **"Waiting for approval"**
4. Klicke auf **"Review deployments"**
5. Aktiviere die Checkbox bei `npm-publish`
6. Klicke auf **"Approve and deploy"**

**Jetzt wird das Package veröffentlicht!** 🎉

### Schritt 6: Verify Release

1. Gehe zu: https://github.com/UXWizard25/vv-token-test-v3/packages
2. Du siehst dein Package: `@uxwizard25/design-system-tokens`
3. Klicke drauf → du siehst alle veröffentlichten Versionen

---

## 📥 PACKAGE INSTALLIEREN (In anderen Projekten)

### Einmalige Konfiguration (pro Projekt)

Erstelle/bearbeite `.npmrc` im Projekt-Root:

```bash
@uxwizard25:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=${GITHUB_TOKEN}
```

**Authentifizierung:**

**Option A: Persönlicher Access Token (empfohlen)**

1. Gehe zu: https://github.com/settings/tokens
2. Klicke auf **"Generate new token (classic)"**
3. Name: `npm-packages-read`
4. Aktiviere Scope: `read:packages`
5. Klicke auf **Generate token**
6. Kopiere das Token (zeigt nur einmal!)
7. Füge Token in `.npmrc` ein:
   ```
   //npm.pkg.github.com/:_authToken=ghp_DEIN_TOKEN_HIER
   ```

**Option B: Umgebungsvariable (für CI/CD)**

```bash
# In ~/.bashrc oder ~/.zshrc
export GITHUB_TOKEN="ghp_DEIN_TOKEN_HIER"
```

### Package installieren

```bash
# Neueste Version
npm install @uxwizard25/design-system-tokens

# Spezifische Version
npm install @uxwizard25/design-system-tokens@1.2.3

# Als Dev Dependency
npm install --save-dev @uxwizard25/design-system-tokens
```

### Package nutzen

```javascript
// CSS importieren (in deiner main.css oder main.js)
import '@uxwizard25/design-system-tokens/css/semantic/bild/color/color-bild-light.css';

// SCSS importieren
@import '@uxwizard25/design-system-tokens/scss/semantic/bild/color/color-bild-light';

// JavaScript/JSON
import tokens from '@uxwizard25/design-system-tokens/json/semantic/bild/color/color-bild-light.json';
console.log(tokens.color.brand.primary); // "#de0000"
```

---

## 🤖 DEPENDABOT (Automatische Updates)

### Was macht Dependabot?

Dependabot prüft **automatisch jede Woche (Montags 9:00 Uhr)**:
- NPM Dependencies (style-dictionary, nodemon, etc.)
- GitHub Actions Versionen

**Wenn Updates verfügbar sind:**
1. Dependabot erstellt automatisch einen Pull Request
2. Du wirst benachrichtigt
3. Du reviewst den PR
4. Du mergst den PR (oder lehnst ab)

### Dependabot PR's verwalten

**Automatisch generierte PR's sehen so aus:**

```
Title: chore(deps): bump style-dictionary from 4.2.0 to 4.3.0

Description:
Bumps style-dictionary from 4.2.0 to 4.3.0

Release notes: ...
Changelog: ...
```

**Was du tun solltest:**

1. **Prüfe den PR:**
   - Schau dir die Changes an
   - Lies Release Notes/Changelog
   - Prüfe ob Breaking Changes dabei sind

2. **Teste lokal (optional):**
   ```bash
   gh pr checkout 123  # PR Nummer
   npm install
   npm run build
   npm run test  # falls vorhanden
   ```

3. **Merge oder Ablehnen:**
   - ✅ **Merge**: Klicke auf "Merge pull request"
   - ❌ **Ablehnen**: Klicke auf "Close pull request"
   - ⏸️ **Später**: Kommentiere `@dependabot rebase` für Rebase

**Dependabot Kommandos (in PR Kommentaren):**

```bash
@dependabot rebase        # PR rebasen
@dependabot recreate      # PR neu erstellen
@dependabot merge         # Auto-merge (wenn Tests grün)
@dependabot cancel merge  # Auto-merge abbrechen
@dependabot close         # PR schließen
@dependabot ignore        # Dieses Update ignorieren
```

### Dependabot Settings anpassen

In `.github/dependabot.yml`:

```yaml
# Häufigkeit ändern
schedule:
  interval: "daily"     # Täglich statt wöchentlich
  # oder: "weekly", "monthly"

# Mehr/weniger PR's gleichzeitig
open-pull-requests-limit: 10  # Standard: 5

# Bestimmte Dependencies ignorieren
ignore:
  - dependency-name: "style-dictionary"
    versions: ["5.x"]  # Ignoriere Major Version 5
```

---

## 🔧 WARTUNG & TROUBLESHOOTING

### Package-Version in package.json synchronisieren

**WICHTIG:** Die Version in `package.json` wird automatisch vom GitHub Actions Workflow gesetzt!

Aber wenn du lokal testen willst:

```bash
# Version in package.json setzen (ohne Git Tag)
npm version 1.2.3 --no-git-tag-version
```

### Package lokal testen (vor Veröffentlichung)

```bash
# Package packen (ohne zu publishen)
npm pack

# Output: uxwizard25-design-system-tokens-1.2.3.tgz

# In anderem Projekt installieren
cd ../mein-anderes-projekt
npm install ../vv-token-test-v3/uxwizard25-design-system-tokens-1.2.3.tgz
```

### Package-Inhalt prüfen

```bash
# Zeige alle Dateien, die ins Package kommen
npm pack --dry-run

# Extrahiere .tgz und inspiziere
tar -xzf uxwizard25-design-system-tokens-1.2.3.tgz
cd package
ls -la
```

### Workflow manuell triggern (Testing)

Du kannst den Workflow auch manuell starten (ohne Git Tag):

1. Gehe zu **Actions** Tab
2. Klicke auf **"Publish to GitHub Packages"** (links)
3. Klicke auf **"Run workflow"** (rechts)
4. Wähle Branch: `main` oder `develop`
5. Klicke auf **"Run workflow"**

**⚠️ Achtung:** Das triggered nur den Build, nicht das Publishing (weil kein Git Tag).

### Häufige Fehler

#### ❌ Error: "Failed to publish package"

**Ursache:** Keine Permissions oder Token fehlt

**Lösung:**
1. Prüfe in GitHub: **Settings → Actions → General**
2. Unter **Workflow permissions**: Aktiviere **"Read and write permissions"**
3. Aktiviere **"Allow GitHub Actions to create and approve pull requests"**

#### ❌ Error: "Version already exists"

**Ursache:** Du versuchst eine Version zu publishen, die schon existiert

**Lösung:**
1. Lösche den Git Tag: `git tag -d v1.2.3 && git push --delete origin v1.2.3`
2. Erhöhe die Version: `git tag v1.2.4 && git push --tags`

#### ❌ Error: "Build failed"

**Ursache:** Token-Build schlägt fehl

**Lösung:**
1. Teste lokal: `npm run build`
2. Prüfe Logs in GitHub Actions
3. Fixe Fehler in `src/design-tokens/` oder `scripts/`

#### ❌ Error: "Cannot find module dist/index.js"

**Ursache:** Entry Point fehlt

**Lösung:**
Erstelle `dist/index.js` manuell oder passe `package.json` an:
```json
{
  "main": "dist/css/index.css",  // oder anderer Pfad
  "module": "dist/js/index.js"
}
```

---

## 📚 WEITERE RESSOURCEN

### GitHub Packages Dokumentation
- [Publishing packages](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-npm-registry)
- [Installing packages](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-npm-registry#installing-a-package)

### Dependabot Dokumentation
- [Configuration options](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file)
- [Managing pull requests](https://docs.github.com/en/code-security/dependabot/working-with-dependabot/managing-pull-requests-for-dependency-updates)

### Semantic Versioning
- [Semantic Versioning Specification](https://semver.org/)

### GitHub Actions
- [Workflow syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Environment protection rules](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#environment-protection-rules)

---

## 🎓 ZUSAMMENFASSUNG

### Tägliche Arbeit
1. ✅ Tokens in Figma/lokal ändern
2. ✅ Committen und pushen
3. ✅ Tests laufen automatisch (GitHub Actions)

### Release erstellen
1. ✅ Git Tag erstellen: `git tag v1.2.3`
2. ✅ Tag pushen: `git push --tags`
3. ✅ Workflow beobachten auf GitHub
4. ✅ Manuell approven wenn bereit
5. ✅ Package wird veröffentlicht 🎉

### Updates verwalten
1. ✅ Dependabot erstellt automatisch PR's
2. ✅ Du reviewst und mergst PR's
3. ✅ Fertig!

---

## 💡 TIPPS

✅ **DO's:**
- Teste immer lokal mit `npm run build` vor dem Release
- Schreibe aussagekräftige Git Commit Messages
- Nutze Semantic Versioning korrekt
- Reviewe Dependabot PR's regelmäßig
- Halte README.md aktuell

❌ **DON'Ts:**
- Version nicht manuell in `package.json` ändern (Workflow macht das)
- Keine sensiblen Daten in Tokens committen
- Git Tags nicht löschen nach Publishing
- Dependencies nicht lange ignorieren

---

## 🆘 HILFE BENÖTIGT?

Erstelle ein Issue auf GitHub:
https://github.com/UXWizard25/vv-token-test-v3/issues

---

**Viel Erfolg mit deinem Design Token Package! 🚀**
