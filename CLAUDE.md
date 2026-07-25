# CLAUDE.md — LPiano-Katalog

Dies ist der öffentliche LPiano-Song-/Instrument-Katalog (GitHub Pages →
https://lpiano-catalog.lprod.de/).

**Bevor du hier etwas tust, lies `AGENTS.md` (Agenten-Kurzanleitung) und `README.md`
(volles Konzept + Schritt-für-Schritt).**

Wichtigste Regeln:
- Lieder hinzufügen = Datei in `audio/` (MP3) bzw. `midi/` (MID) + Eintrag in `songs.json`,
  dann Builder (im App-Repo `Z:\Android\LPiano_agent`) `build --dir` + `.\publish.ps1`.
- Commits **ohne** `Co-Authored-By: Claude` (kein Claude als GitHub-Contributor).
- `catalog.json` nie von Hand ändern (erzeugt der Builder). Nur eigene/gemeinfreie/CC0/CC-BY-Inhalte.
