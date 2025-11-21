# 🧪 Workflow Testing Guide

Vollständige Anleitung zum sicheren Testen des automatisierten Publishing-Workflows.

---

## 🎯 Was getestet wird

Der komplette Workflow:
```
1. Figma VV Plugin Push → figma-tokens Branch
2. Auto PR Creation
3. PR Merge
4. Automatisches Publishing
```

---

## ⚙️ VORAUSSETZUNGEN

Bevor du testest, stelle sicher:

1. ✅ Du hast diesen Branch gemerged:
   ```
   Branch: claude/token-pipeline-npm-package-setup-01LDZGnEBSEFLUF9u82Shofd
   → main
   ```

2. ✅ GitHub Actions Permissions sind korrekt:
   - Gehe zu: Settings → Actions → General
   - Aktiviere: "Read and write permissions"
   - Aktiviere: "Allow GitHub Actions to create and approve pull requests"

3. ✅ Token-Dateien existieren in `src/design-tokens/`

---

## 🧪 TEST 1: Auto PR Creation (ohne Figma)

### Schritt 1: Test-Branch erstellen

```bash
# Checkout main und pull latest
git checkout main
git pull

# Erstelle figma-tokens Branch
git checkout -b figma-tokens

# Mache kleine Test-Änderung in Token-Datei
echo "// Test change $(date)" >> src/design-tokens/colormode/light-bild.json

# Commit und push
git add src/design-tokens/
git commit -m "test: trigger auto PR workflow"
git push -u origin figma-tokens
```

### Schritt 2: Workflow beobachten

1. Gehe zu: https://github.com/UXWizard25/vv-token-test-v3/actions
2. Du solltest sehen: **"Auto PR from Figma Tokens"** Workflow läuft
3. Warte bis Workflow fertig ist (~2-3 Minuten)

### Schritt 3: Erwartetes Ergebnis

✅ **Erfolg wenn:**
- Workflow Status: ✅ Success (grün)
- Neuer Pull Request erstellt: "🎨 Update design tokens from Figma"
- PR enthält Build-Statistiken
- Build war erfolgreich (30/30)

❌ **Fehler wenn:**
- Workflow Status: ❌ Failed (rot)
- Kein PR erstellt
- Build-Fehler im Log

### Schritt 4: PR prüfen

Gehe zu: https://github.com/UXWizard25/vv-token-test-v3/pulls

**Prüfe im PR:**
- ✅ Titel: "🎨 Update design tokens from Figma"
- ✅ Build Results angezeigt
- ✅ Changed Files listed
- ✅ "What Happens After Merge" Sektion vorhanden

### Schritt 5: Cleanup (PR NICHT mergen!)

```bash
# PR schließen ohne zu mergen
gh pr close <PR_NUMBER> --comment "Test PR - closing without merge"

# Oder in GitHub UI: Close pull request (nicht Merge!)

# Lokalen Branch löschen
git checkout main
git branch -D figma-tokens

# Remote Branch löschen
git push origin --delete figma-tokens
```

---

## 🚀 TEST 2: Publish Workflow (vollständiger Test)

**⚠️ ACHTUNG:** Dieser Test published ein echtes Package zu GitHub Packages!

### Schritt 1: Test-Branch vorbereiten

```bash
git checkout main
git pull

# Erstelle figma-tokens Branch
git checkout -b figma-tokens

# Mache kleine Änderung
echo "// Test publish $(date)" >> src/design-tokens/colormode/light-bild.json

git add src/design-tokens/
git commit -m "test: trigger publish workflow"
git push -u origin figma-tokens
```

### Schritt 2: Warte auf Auto-PR

1. Gehe zu Actions → "Auto PR from Figma Tokens" sollte laufen
2. Warte bis fertig (~2-3 Min)
3. PR sollte automatisch erstellt werden

### Schritt 3: PR mergen

1. Gehe zu: https://github.com/UXWizard25/vv-token-test-v3/pulls
2. Öffne den neuen PR
3. Klicke **"Merge pull request"**
4. Klicke **"Confirm merge"**

### Schritt 4: Publish Workflow beobachten

1. Gehe zu Actions → "Publish Package on Merge" sollte starten
2. Beobachte die Schritte:
   - ✅ Checkout Repository
   - ✅ Install Dependencies
   - ✅ Bump Version
   - ✅ Build Tokens
   - ✅ Create Git Tag
   - ✅ Push Tag
   - ✅ Publish to GitHub Packages
   - ✅ Create GitHub Release

### Schritt 5: Erwartetes Ergebnis

✅ **Erfolg wenn:**
- Workflow Status: ✅ Success
- Git Tag erstellt: `v1.0.1` (oder höher)
- GitHub Release erstellt
- Package published zu GitHub Packages

✅ **Prüfe Package:**
- Gehe zu: https://github.com/UXWizard25/vv-token-test-v3/packages
- Du solltest sehen: `@uxwizard25/design-system-tokens@1.0.1`

✅ **Prüfe Release:**
- Gehe zu: https://github.com/UXWizard25/vv-token-test-v3/releases
- Du solltest sehen: "Release v1.0.1"
- Release Notes vorhanden
- Download Assets (.zip, .tar.gz) vorhanden

### Schritt 6: Package installieren (optional)

```bash
# In einem anderen Projekt
npm config set @uxwizard25:registry https://npm.pkg.github.com

# Authentifizierung (siehe NPM_PUBLISHING.md)
# Token erstellen und in .npmrc einfügen

npm install @uxwizard25/design-system-tokens@1.0.1
```

✅ **Erfolg wenn:** Installation funktioniert ohne Fehler

---

## 🧪 TEST 3: Mit echtem Figma Variable Visualizer

### Schritt 1: Plugin konfigurieren

Im Figma Variable Visualizer Plugin:

```
Repository:      UXWizard25/vv-token-test-v3
Path:            src/design-tokens/
Target branch:   figma-tokens  ← WICHTIG!
Commit message:  Test from Figma VV Plugin
```

### Schritt 2: Push aus Figma

1. Öffne Figma
2. Mache kleine Token-Änderung (z.B. Farbe anpassen)
3. Öffne Variable Visualizer Plugin
4. Klicke "Push to GitHub"

### Schritt 3: Workflow beobachten

Wie in TEST 1:
1. Auto-PR sollte erstellt werden
2. Review PR
3. Merge PR
4. Publishing läuft automatisch

---

## 🆘 TROUBLESHOOTING

### ❌ Fehler: "could not add label"

**Ursache:** Labels existieren noch nicht im Repo

**Fix:** Bereits gefixt! Workflow nutzt keine Labels mehr.

### ❌ Fehler: "push rejected (fetch first)"

**Ursache:** Race condition beim Push zu main

**Fix:** Bereits gefixt! Version Bump wird nicht mehr committed.

### ❌ Fehler: "Build failed"

**Mögliche Ursachen:**
1. Token-Dateien sind fehlerhaft
2. Dependencies fehlen
3. Scripts-Fehler

**Debug:**
```bash
# Teste Build lokal
npm run build

# Prüfe Logs
cat build-output.log
```

### ❌ Fehler: "Publish failed: 403 Forbidden"

**Ursache:** Keine Package-Permissions

**Fix:**
1. Settings → Actions → General
2. Workflow permissions → "Read and write permissions"
3. ✅ "Allow GitHub Actions to create and approve pull requests"

### ❌ Fehler: "PR not created"

**Mögliche Ursachen:**
1. Workflow hat keine PR-Permissions
2. GitHub Token fehlt
3. Branch falsch benannt

**Fix:**
1. Prüfe Permissions (siehe oben)
2. Branch muss "figma-tokens" heißen
3. Prüfe Workflow-Logs für Details

### ❌ Fehler: "Tag already exists"

**Ursache:** Version-Tag existiert bereits

**Fix:**
```bash
# Tag lokal löschen
git tag -d v1.0.1

# Tag remote löschen
git push origin --delete v1.0.1

# Workflow erneut starten (merge PR nochmal)
```

---

## ✅ TEST CHECKLISTE

### Vor dem Merge zu main:

- [ ] YAML Syntax validiert
- [ ] Permissions konfiguriert
- [ ] Test 1 erfolgreich (Auto PR)
- [ ] Test 2 erfolgreich (Publishing)
- [ ] Test 3 optional (Figma VV)
- [ ] Package installierbar
- [ ] Release erstellt
- [ ] Dokumentation gelesen

### Nach dem Merge zu main:

- [ ] Figma VV Plugin konfiguriert
- [ ] Target branch = "figma-tokens"
- [ ] Erste echte Token-Änderung gepusht
- [ ] PR erstellt automatisch
- [ ] PR gemerged
- [ ] Package published
- [ ] Team kann Package nutzen

---

## 📊 ERWARTETE WORKFLOW-ZEITEN

| Workflow | Dauer | Schritte |
|----------|-------|----------|
| Auto PR from Figma | 2-3 Min | Build + PR Create |
| Publish on Merge | 3-4 Min | Build + Publish + Release |
| **Total** | **5-7 Min** | Push → Published |

---

## 🎓 TIPPS FÜR TESTS

1. **Starte mit Test 1** (Auto PR ohne Publishing)
   - Sicherer, published nichts
   - Teste PR-Erstellung isoliert

2. **Dann Test 2** (Full Publishing)
   - Published echtes Package
   - Teste kompletten Workflow

3. **Dann Test 3** (Figma VV)
   - Teste echte Integration
   - Finaler Integrations-Test

4. **Cleanup zwischen Tests**
   - Lösche Test-Branches
   - Schließe Test-PR's
   - Dokumentiere Ergebnisse

5. **Logs aufbewahren**
   - Screenshot von erfolgreichen Runs
   - Kopiere Fehler-Logs
   - Hilfreich für Debugging

---

## 📝 TEST PROTOKOLL

Dokumentiere deine Tests:

```
TEST 1: Auto PR Creation
Datum: ___________
Status: ✅ / ❌
PR Link: ___________
Notizen: ___________

TEST 2: Publishing
Datum: ___________
Status: ✅ / ❌
Package Version: ___________
Release Link: ___________
Notizen: ___________

TEST 3: Figma VV
Datum: ___________
Status: ✅ / ❌
Notizen: ___________
```

---

## 🚀 NACH ERFOLGREICHEN TESTS

Wenn alle Tests erfolgreich:

1. ✅ Merge Branch zu main
2. ✅ Lösche Test-Branches
3. ✅ Konfiguriere Figma VV Plugin
4. ✅ Informiere Team über neues Workflow
5. ✅ Teile NPM_PUBLISHING.md Dokumentation

**Dein automatisierter Token-Pipeline ist ready! 🎉**
