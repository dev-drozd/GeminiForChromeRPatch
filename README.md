# Gemini for Chrome - Region Patch

## 🌐 Multilingual Documentation

[🇺🇸 English](README.md) | [🇷🇺 Русский](docs/README.ru.md) | [🇺🇦 Українська](docs/README.uk.md) | [🇧🇬 Български](docs/README.bg.md) | [🇪🇸 Español](docs/README.es.md) | [🇫🇷 Français](docs/README.fr.md) | [🇩🇪 Deutsch](docs/README.de.md) | [🇵🇱 Polski](docs/README.pl.md)

![Gemini for Chrome](img/gemini-for-chrome.webp)

A tool for citizens of Gemini-supported countries temporarily traveling abroad who lost access due to automatic region detection. Restores Chrome's regional settings to match your country of citizenship.

## Usage

### Windows

Open PowerShell and run:

```powershell
irm https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.ps1 | iex
```

### Linux / macOS

Open Terminal and run:

```bash
curl -fsSL https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.sh | bash
```

The script will:
1. Close Chrome
2. Create a backup in `%USERPROFILE%\ChromeGeminiBackup`
3. Patch Chrome configuration
4. Ask you to confirm VPN is enabled
5. Apply the patch and launch Chrome

## Restoring Backup

Run the same command and select option **[2]** when prompted.

## Troubleshooting

### Windows

**"Cannot be loaded because running scripts is disabled"**

Run this first:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

**Chrome won't close**

Check Task Manager (Ctrl+Shift+Esc) for background Chrome processes.

### Linux / macOS

**"Permission denied" or "curl: command not found"**

For Linux:
```bash
# Install curl if needed
sudo apt install curl  # Debian/Ubuntu
sudo dnf install curl  # Fedora
sudo pacman -S curl    # Arch

# Make script executable
chmod +x gemini_for_chrome_patch.sh
```

For macOS:
```bash
# curl is pre-installed, just run the command
```

**"Python3 not found"**

For Linux:
```bash
sudo apt install python3  # Debian/Ubuntu
sudo dnf install python3  # Fedora
sudo pacman -S python     # Arch
```

For macOS:
```bash
# Python3 is pre-installed on macOS 10.15+
# For older versions, install from python.org
```

**Chrome won't close**

```bash
# Manually kill Chrome processes
pkill -9 -f Chrome
# Or use Activity Monitor (macOS) / System Monitor (Linux)
```

**Script says "No Chrome config found"**

Make sure Chrome is installed:
- Linux: `/usr/bin/google-chrome`
- macOS: `/Applications/Google Chrome.app`

### All Platforms

**Gemini doesn't appear**

- Make sure VPN is connected to US server during first launch
- Wait 2-3 minutes with Chrome open
- Clear browsing data and try again

### is_glic_eligible key not found

Update Chrome to the latest version.

## What It Does

1. Backs up Chrome config to `%USERPROFILE%\ChromeGeminiBackup`
2. Changes regional settings to US
3. Clears variations cache
4. Enables `is_glic_eligible` flag
5. Verifies changes

The script only modifies Chrome's configuration file. No binaries, no network requests, no system changes.

## Disclaimer

This tool is for legitimate users who have authorized access to Gemini in their home country and are experiencing temporary access issues while traveling.

## Author

Oleksandr Drozd (<dev.drozd@gmail.com>)

---

## Support the Project

If this tool helped you, consider supporting its development:

[![Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Q2D521U4BT)

**Other ways to support:**
- [PayPal](https://www.paypal.com/donate/?hosted_button_id=UQGNYDVPER2TJ)
- [Revolut](https://revolut.me/devdrozd)
- ⭐ Star this repository on GitHub

Your support helps maintain and improve this tool. Thank you!

## License

MIT License

---

## Tags

#gemini #chrome #gemini-chrome #google-gemini #gemini-ai #chrome-extension #region-patch #vpn #gemini-access #gemini-enable #chrome-patch #gemini-not-available #gemini-fix #enable-gemini #activate-gemini #gemini-abroad #gemini-traveling #chrome-config #local-state #variations-country #gemini-unavailable #gemini-region #unlock-gemini #gemini-workaround #chrome-ai #google-ai #bard-gemini
