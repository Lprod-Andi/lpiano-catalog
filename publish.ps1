# LPiano Song-Katalog veroeffentlichen (in der Katalog-Repo ausfuehren).
# Voraussetzung: catalog.json wurde frisch mit dem Builder erzeugt.
$ErrorActionPreference = "Stop"

if (-not (Test-Path "catalog.json")) { throw "catalog.json fehlt - erst den Builder 'build' laufen lassen." }
if ((Get-Item "songs.json").LastWriteTime -gt (Get-Item "catalog.json").LastWriteTime) {
    throw "songs.json ist neuer als catalog.json - erst 'build' laufen lassen."
}

git add -A
if ($LASTEXITCODE -ne 0) { throw "git add fehlgeschlagen" }

git commit -m "catalog: update $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
if ($LASTEXITCODE -ne 0) { Write-Host "Nichts zu committen."; exit 0 }

git push
if ($LASTEXITCODE -ne 0) { throw "git push fehlgeschlagen" }
Write-Host "OK: veroeffentlicht -> https://catalog.lprod.de/catalog.json (Cache kann ~1 Min brauchen)"
