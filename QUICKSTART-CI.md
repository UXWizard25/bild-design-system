# 🚀 GitHub Actions Quick Start Guide

Schnellstart-Anleitung für die automatische Token-Build-Pipeline.

## 📋 Voraussetzungen

- Repository auf GitHub
- Workflow-Datei ist im Repository: `.github/workflows/build-tokens.yml`
- GitHub Actions sind aktiviert (Settings → Actions → General)

## ✅ Erster Test: Manueller Build

### Schritt 1: Workflow ausführen

1. Gehe zu deinem GitHub Repository
2. Klicke auf **"Actions"** Tab
3. Wähle **"Build Design Tokens"** in der linken Sidebar
4. Klicke **"Run workflow"** (rechts oben)
5. Lass die Standard-Optionen und klicke **"Run workflow"**

### Schritt 2: Build beobachten

- Der Build startet nach wenigen Sekunden
- Klicke auf den laufenden Build um Details zu sehen
- Du siehst alle Schritte in Echtzeit:
  - ✅ Checkout Repository
  - ✅ Setup Node.js
  - ✅ Install Dependencies
  - ✅ Preprocess Figma Tokens
  - ✅ Build Tokens with Style Dictionary
  - ✅ Upload Build Artifacts

### Schritt 3: Build-Results prüfen

Nach erfolgreichem Build:

1. **Build Summary** ansehen:
   - Scrolle nach unten zur Summary
   - Siehe Build-Statistiken
   - Siehe generierte Dateien

2. **Artifacts downloaden**:
   - Scrolle zu "Artifacts"
   - Klicke auf `design-tokens-{commit-sha}`
   - Download ZIP-Datei
   - Entpacke und prüfe generierte Dateien

## 🔄 Automatischer Build testen

### Test 1: Token-Update simulieren

```bash
# Lokales Repository
cd vv-token-test-v3

# Mache eine kleine Änderung (z.B. füge einen Kommentar hinzu)
echo "# Test Update $(date)" >> src/design-tokens/README-TEST.md

# Commit und Push
git add src/design-tokens/
git commit -m "test: trigger automatic token build"
git push

# → Build startet automatisch!
```

Gehe zu GitHub Actions und beobachte den automatischen Build.

### Test 2: Script-Update

```bash
# Ändere ein Build-Script
echo "# Updated $(date)" >> scripts/build-tokens.js

git add scripts/
git commit -m "test: trigger build via script change"
git push

# → Build startet automatisch!
```

## 🧪 Erweiterte Tests

### Test 3: Clean Build

1. Actions → Build Design Tokens → Run workflow
2. Setze **"Clean Build"** auf `true`
3. Run workflow
4. Build läuft mit komplett frischer Installation

### Test 4: Auto-Commit aktivieren

1. Actions → Build Design Tokens → Run workflow
2. Setze **"Commit Outputs"** auf `true`
3. Run workflow
4. Nach erfolgreichem Build wird ein neuer Commit erstellt
5. Prüfe Commit-History für automatischen Commit

### Test 5: Release erstellen

```bash
# Tag erstellen
git tag v1.0.0-test

# Push tag
git push origin v1.0.0-test

# → Release-Workflow startet!
# → GitHub Release wird erstellt
```

Gehe zu Releases und prüfe den automatisch erstellten Release.

## 🎯 Via GitHub CLI

### Installation

```bash
# GitHub CLI installieren
# macOS
brew install gh

# Windows
winget install GitHub.cli

# Linux
# Siehe: https://github.com/cli/cli#installation
```

### Authentifizierung

```bash
gh auth login
```

### Workflow starten

```bash
# Einfacher Build
gh workflow run build-tokens.yml

# Mit Clean Build
gh workflow run build-tokens.yml -f clean_build=true

# Mit Auto-Commit
gh workflow run build-tokens.yml -f commit_outputs=true

# Status prüfen
gh run list --workflow=build-tokens.yml

# Logs ansehen (neuester Run)
gh run view

# Artifacts downloaden
gh run download
```

## 🔍 Troubleshooting

### Workflow wird nicht ausgeführt

**Problem:** Workflow erscheint nicht in Actions

**Lösung:**
1. Prüfe ob `.github/workflows/build-tokens.yml` existiert
2. Prüfe YAML-Syntax: https://www.yamllint.com/
3. Prüfe GitHub Actions Settings → Actions → General
4. Stelle sicher dass Actions "Allow all actions" hat

### Build schlägt fehl

**Problem:** Build failed mit Fehlermeldung

**Lösung:**
1. Klicke auf failed Build
2. Erweitere fehlgeschlagenen Step
3. Lese Error-Message
4. Häufige Fehler:
   - `npm ci` failed → package-lock.json fehlt oder inkorrekt
   - `No successful builds` → Preprocessing oder Build fehlgeschlagen
   - `Permission denied` → Branch Protection oder fehlende Permissions

### Artifacts nicht verfügbar

**Problem:** Keine Artifacts zum Download

**Lösung:**
1. Build muss erfolgreich sein (grüner Haken)
2. Artifacts erscheinen nach Build-Ende
3. Retention: 30 Tage (danach gelöscht)
4. Prüfe ob Artifact-Upload Step erfolgreich war

### Auto-Commit funktioniert nicht

**Problem:** Generierte Dateien werden nicht committed

**Lösung:**
1. Prüfe ob "Commit Outputs" auf `true` gesetzt wurde
2. Prüfe Branch Protection Rules
3. Prüfe Workflow Permissions: `contents: write`
4. Prüfe ob es tatsächlich Änderungen gab

## 📚 Weitere Ressourcen

- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [Workflow-Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [GitHub CLI Manual](https://cli.github.com/manual/)
- [Detaillierte Workflow-Doku](.github/workflows/README.md)

## 💡 Best Practices

1. **Teste lokal zuerst:**
   ```bash
   npm run build
   ```

2. **Nutze Clean Build bei Problemen:**
   - Löscht cached Dependencies
   - Garantiert frische Installation

3. **Artifacts für Reviews:**
   - Teile Build-Artifacts mit Team
   - Vergleiche Outputs zwischen Builds

4. **Tags für Releases:**
   - Nutze semantische Versionierung
   - Nur stable Versionen taggen

5. **Monitor Build-Times:**
   - Optimiere bei langen Build-Zeiten
   - Cache nutzen (automatisch aktiviert)

## ✅ Erfolg!

Wenn alle Tests funktionieren, ist deine CI/CD-Pipeline einsatzbereit! 🎉

**Nächste Schritte:**
1. Automatische Builds bei Figma-Updates einrichten
2. Integration in Design System Website
3. NPM Package veröffentlichen

---

**Fragen?** Siehe [.github/workflows/README.md](.github/workflows/README.md)
