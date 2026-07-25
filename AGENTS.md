# AGENTS.md — LPiano-Katalog (für Claude Code, Codex & andere Agenten)

Du bist im **öffentlichen LPiano-Song-/Instrument-Katalog** (`Lprod-Andi/lpiano-catalog`).
Inhalt hier wird über GitHub Pages unter **https://lpiano-catalog.lprod.de/** ausgeliefert
und von der App geladen. Vollständige Erklärung + Konzept: **`README.md`** (zuerst lesen).

## Aufgabe: neue Lieder veröffentlichen
Wenn der User sagt „ich habe neue Lieddateien reingelegt" oder „veröffentliche die Songs":

1. **Dateien prüfen:** MP3 liegen in `audio/`, MID in `midi/`. Dateinamen nur `A–Z a–z 0–9 _ -` + Endung.
2. **`songs.json` pflegen:** pro Datei ein Objekt mit Pflichtfeldern `fileName`, `title`,
   `category`, `difficulty` (`EASY`|`MEDIUM`|`HARD`); optional `id`, `composer`, `congregation`.
   Fehlende Infos beim User erfragen (mindestens Titel, Kategorie, Schwierigkeit je Lied).
3. **Bauen** (der Builder liegt im App-Repo nebenan):
   ```powershell
   cd Z:\Android\LPiano_agent
   .\gradlew.bat :tools:song-catalog-builder:run --args="build --dir Z:\Android\lpiano-catalog"
   ```
   Er validiert hart (eindeutige id, gültige Namen/Enums, Datei existiert) und schreibt
   `catalog.json` (mit `fileSize`+`sha256`). Bei Fehlern: melden + nicht veröffentlichen.
4. **Veröffentlichen:**
   ```powershell
   cd Z:\Android\lpiano-catalog
   .\publish.ps1
   ```

## Feste Regeln
- **Commits ohne `Co-Authored-By: Claude`** (der User will Claude NICHT als GitHub-Contributor).
  Git-Autor bleibt `Lprod-Andi`.
- `catalog.json`, `instruments.json`, `CNAME`, `.nojekyll` **nie von Hand** editieren
  (`catalog.json` erzeugt der Builder; der Rest ist Domain-Technik).
- **Lizenz:** nur eigene / gemeinfreie / CC0 / CC-BY — **kein** NC, **keine** CCLI-Songs.
- Kein `git add -A` mit Fremd-/Müll-Dateien; nur die bewusst abgelegten Song-Dateien + `songs.json` + `catalog.json`.
- Bauen immer über **PowerShell** `.\gradlew.bat …` (aus dem App-Repo).
