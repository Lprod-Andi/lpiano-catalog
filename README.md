# LPiano — Song-/Instrument-Katalog

> **Das ist der öffentliche Online-Katalog der App „LPiano".** Alles, was in diesem
> Ordner liegt, wird über GitHub Pages unter **https://lpiano-catalog.lprod.de/**
> ins Internet gestellt und von der App geladen. Wer hier Lieder hinzufügt,
> veröffentlicht sie für **alle** LPiano-Nutzer — **ohne** dass ein App-Update nötig ist.

---

## Was ist LPiano?

LPiano ist eine Android-App zum **Keyboard-Lernen und -Mitspielen** im Lobpreis-/
Anbetungs-Kontext (Gemeinde). Zwei Wege, ein Lied zu nutzen:

- **MIDI-Üben** — eine Melodielinie (`.mid`) als fallende Noten lernen (Tempo, Transponieren, Wait-Mode).
- **MP3-Jam** — zu einer fertigen Aufnahme (`.mp3`) mitspielen; der Klavierpart fehlt bewusst in der Aufnahme, den spielst *du* auf der App-Klaviatur.

Die App hat einen Reiter **„Laden"**, der genau diesen Katalog hier anzeigt. Neue Lieder,
die hier veröffentlicht werden, erscheinen dort automatisch zum Download.

## Was ist dieser Ordner (dieses Repo)?

Ein **eigenes, öffentliches** Git-Repo (`Lprod-Andi/lpiano-catalog`), getrennt vom
privaten App-Code. Es spiegelt 1:1 das, was online liegt:

```
lpiano-catalog/
├─ songs.json        ← DIE Liste der Lieder — das Einzige, was du von Hand bearbeitest
├─ audio/            ← hier kommen MP3-Dateien rein  (Mitspielen / Jam)
├─ midi/             ← hier kommen MID-Dateien rein   (Üben)
├─ catalog.json      ← wird ERZEUGT (nie von Hand anfassen) — das lädt die App
├─ instruments.json  ← Instrument-Katalog (separat, s. unten)
├─ CNAME, .nojekyll  ← Technik für die Domain (nicht anfassen)
└─ publish.ps1       ← veröffentlicht den Katalog (ein Befehl)
```

---

## 🎵 Ein Lied hinzufügen — in 3 Schritten

### Schritt 1: Datei ablegen
- **MP3** (zum Mitspielen) → in den Ordner **`audio/`**
- **MID** (zum Üben) → in den Ordner **`midi/`**

Dateiname-Regeln: nur Buchstaben, Ziffern, `_` und `-`, plus die Endung (z. B.
`amazing_grace.mp3`). **Keine** Leerzeichen, Umlaute oder Sonderzeichen im Dateinamen.

### Schritt 2: Eintrag in `songs.json` ergänzen
Öffne `songs.json` und füge pro Lied ein Objekt ins `songs`-Array ein — **nur die
menschlichen Angaben**:

```json
{
  "version": 1,
  "songs": [
    {
      "fileName": "amazing_grace.mp3",
      "title": "Amazing Grace",
      "category": "Anbetung",
      "difficulty": "EASY"
    }
  ]
}
```

Bei mehreren Liedern die Objekte mit Komma trennen. Achte auf gültiges JSON
(kein Komma nach dem letzten Objekt).

### Schritt 3: Bauen & veröffentlichen
Das eigentliche `catalog.json` (mit Dateigrößen + Prüfsummen) wird **automatisch**
vom Builder erzeugt — der liegt im **App-Repo** nebenan (`Z:\Android\LPiano_agent`):

```powershell
# 1) Katalog bauen (validiert + erzeugt catalog.json)
cd Z:\Android\LPiano_agent
.\gradlew.bat :tools:song-catalog-builder:run --args="build --dir Z:\Android\lpiano-catalog"

# 2) Veröffentlichen (committen + pushen -> live)
cd Z:\Android\lpiano-catalog
.\publish.ps1
```

Nach ~1 Minute ist das Lied unter https://lpiano-catalog.lprod.de/catalog.json
und im „Laden"-Reiter der App verfügbar.

---

## Feld-Referenz für `songs.json`

| Feld | Pflicht | Bedeutung / erlaubte Werte |
|---|---|---|
| `fileName` | ✅ | Dateiname **exakt** wie in `audio/` bzw. `midi/`. Bestimmt auch den Typ: `.mp3` → Mitspielen, `.mid`/`.midi` → Üben. |
| `title` | ✅ | Anzeigetitel in der App (frei, darf Leerzeichen/Umlaute haben). |
| `category` | ✅ | Freier Text, z. B. `Anbetung`, `Lobpreis`, `Weihnachten`, `andere`. |
| `difficulty` | ✅ | Genau eines von `EASY`, `MEDIUM`, `HARD` (Großbuchstaben). |
| `id` | – | Eindeutige Kennung; wird sonst aus dem Dateinamen abgeleitet. Nur `A–Z a–z 0–9 _ -`. **Nie zwei Lieder mit gleicher id.** |
| `composer` | – | Komponist (Text) oder weglassen. |
| `congregation` | – | Gemeinde-Herkunft (Text) oder weglassen. |

Vom Builder **automatisch** ergänzt (nicht von Hand eintragen): `type`, `fileSize`, `sha256`.

---

## ⚖️ Lizenz — wichtig!

Dieser Katalog ist **öffentlich** und die App ist **kommerziell**. Stelle nur Lieder ein, die du
verteilen **darfst**:
- **Eigene** Aufnahmen/Arrangements, oder
- **gemeinfreie** Werke (z. B. alte Hymnen) in **eigener** Aufnahme, oder
- **CC0 / CC-BY** (mit Namensnennung).

**Nicht** erlaubt: NC-Lizenzen (nicht-kommerziell) und moderne Worship-Songs, die
i. d. R. **CCLI-geschützt** sind. Im Zweifel: nicht hochladen.

---

## Instrumente (Randnotiz)

Dieser Katalog hostet auch Instrumente (`instruments.json` + `instruments/`). Die werden
**nicht** hier von Hand gepflegt, sondern mit einem eigenen Werkzeug
(`:tools:instrument-packager` im App-Repo) gebaut. Für Lieder ist ausschließlich der
Ablauf oben relevant.

---

## Wie es technisch live geht (Hintergrund)

- Hosting: **GitHub Pages** aus diesem Repo. Domain **lpiano-catalog.lprod.de** (DNS bei
  Cloudflare: CNAME `lpiano-catalog` → `lprod-andi.github.io`, „DNS only"). HTTPS von GitHub.
- Die App liest `https://lpiano-catalog.lprod.de/catalog.json` beim Öffnen des „Laden"-Reiters
  und lädt Dateien aus `audio/` bzw. `midi/`. Die `catalog.base.url` ist in der App fest
  hinterlegt — die Domain bleibt stabil, auch bei einem späteren Umzug (nur DNS umbiegen).

## Für KI-Agenten (Claude Code, Codex u. a.)
Kurzanleitung siehe **`AGENTS.md`** in diesem Ordner. Wichtigste Regel: Commits in diesem
Repo **ohne** `Co-Authored-By: Claude` (kein Claude als GitHub-Contributor).

**Kontakt:** contact@lindenberg.dev
