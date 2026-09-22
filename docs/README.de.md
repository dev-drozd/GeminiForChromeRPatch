# Gemini für Chrome - Regions-Patch

## 🌐 Mehrsprachige Dokumentation

[🇺🇸 English](../README.md) | [🇷🇺 Русский](README.ru.md) | [🇺🇦 Українська](README.uk.md) | [🇧🇬 Български](README.bg.md) | [🇪🇸 Español](README.es.md) | [🇫🇷 Français](README.fr.md) | [🇩🇪 Deutsch](README.de.md) | [🇵🇱 Polski](README.pl.md)

![Gemini für Chrome](../img/gemini-for-chrome.webp)

Ein Tool für Bürger von Gemini-unterstützten Ländern, die vorübergehend ins Ausland reisen und den Zugang aufgrund automatischer Regionserkennung verloren haben. Stellt die regionalen Einstellungen von Chrome wieder her, um Ihrem Staatsangehörigkeitsland zu entsprechen.

## Verwendung

### Windows

Öffnen Sie PowerShell und führen Sie aus:

```powershell
irm https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.ps1 | iex
```

### Linux / macOS

Öffnen Sie Terminal und führen Sie aus:

```bash
curl -fsSL https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.sh | bash
```

Das Skript wird:
1. Chrome schließen
2. Ein Backup in `%USERPROFILE%\ChromeGeminiBackup` erstellen
3. Die Chrome-Konfiguration patchen
4. Um Bestätigung bitten, dass VPN aktiviert ist
5. Den Patch anwenden und Chrome starten

## Wiederherstellung

Führen Sie denselben Befehl aus und wählen Sie Option **[2]**.

## Fehlerbehebung

### "Kann nicht geladen werden, da die Skriptausführung deaktiviert ist"

Führen Sie zuerst aus:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### Chrome schließt sich nicht

Überprüfen Sie den Task-Manager (Strg+Shift+Esc) auf Chrome-Hintergrundprozesse.

### Gemini erscheint nicht

- Stellen Sie sicher, dass VPN beim ersten Start mit einem US-Server verbunden ist
- Warten Sie 2-3 Minuten mit geöffnetem Chrome
- Löschen Sie Browserdaten und versuchen Sie es erneut

### is_glic_eligible key not found

Aktualisieren Sie Chrome auf die neueste Version.

## Was das Skript macht

1. Erstellt ein Backup der Konfiguration in `%USERPROFILE%\ChromeGeminiBackup`
2. Ändert die regionalen Einstellungen auf US
3. Löscht den Variations-Cache
4. Aktiviert das Flag `is_glic_eligible`
5. Überprüft die Änderungen

Das Skript ändert nur die Chrome-Konfigurationsdatei. Keine Änderungen an Binärdateien, Netzwerkanfragen oder Systemeinstellungen.

## Haftungsausschluss

Dieses Tool ist für legitime Benutzer gedacht, die autorisierten Zugang zu Gemini in ihrem Land haben und temporäre Zugriffsprobleme während der Reise erleben.

## Autor

Oleksandr Drozd (<dev.drozd@gmail.com>)

---

## Projekt unterstützen

Wenn Ihnen dieses Tool geholfen hat, unterstützen Sie seine Entwicklung:

[![Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Q2D521U4BT)

**Weitere Unterstützungsmöglichkeiten:**
- [PayPal](https://www.paypal.com/donate/?hosted_button_id=UQGNYDVPER2TJ)
- [Revolut](https://revolut.me/devdrozd)
- ⭐ Geben Sie diesem Repository einen Stern auf GitHub

Ihre Unterstützung hilft, dieses Tool zu pflegen und zu verbessern. Vielen Dank!

## Lizenz

MIT License

---

## Tags

#gemini #chrome #gemini-chrome #google-gemini #gemini-ai #chrome-erweiterung #regions-patch #vpn #gemini-zugriff #gemini-aktivieren #chrome-patch #gemini-nicht-verfügbar #gemini-fix #gemini-aktivieren #gemini-im-ausland #gemini-reisen #chrome-konfiguration #local-state #variations-country #gemini-funktioniert-nicht #gemini-region #gemini-freischalten #gemini-workaround #chrome-ai #google-ai #bard-gemini
