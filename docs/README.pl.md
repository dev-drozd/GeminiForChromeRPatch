# Gemini dla Chrome - Łatka Regionalna

## 🌐 Dokumentacja wielojęzyczna

[🇺🇸 English](../README.md) | [🇷🇺 Русский](README.ru.md) | [🇺🇦 Українська](README.uk.md) | [🇧🇬 Български](README.bg.md) | [🇪🇸 Español](README.es.md) | [🇫🇷 Français](README.fr.md) | [🇩🇪 Deutsch](README.de.md) | [🇵🇱 Polski](README.pl.md)

![Gemini dla Chrome](../img/gemini-for-chrome.webp)

Narzędzie dla obywateli krajów obsługujących Gemini, tymczasowo podróżujących za granicę, którzy stracili dostęp z powodu automatycznego wykrywania regionu. Przywraca ustawienia regionalne Chrome, aby odpowiadały krajowi obywatelstwa.

## Użycie

### Windows

Otwórz PowerShell i wykonaj:

```powershell
irm https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.ps1 | iex
```

### Linux / macOS

Otwórz Terminal i wykonaj:

```bash
curl -fsSL https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.sh | bash
```

Skrypt:
1. Zamknie Chrome
2. Utworzy kopię zapasową w `%USERPROFILE%\ChromeGeminiBackup`
3. Załata konfigurację Chrome
4. Poprosi o potwierdzenie, że VPN jest włączony
5. Zastosuje łatkę i uruchomi Chrome

## Przywracanie

Uruchom tę samą komendę i wybierz opcję **[2]**.

## Rozwiązywanie problemów

### "Nie można załadować, ponieważ wykonywanie skryptów jest wyłączone"

Najpierw wykonaj:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### Chrome się nie zamyka

Sprawdź Menedżera zadań (Ctrl+Shift+Esc) w poszukiwaniu procesów Chrome w tle.

### Gemini się nie pojawia

- Upewnij się, że VPN jest połączony z serwerem w USA podczas pierwszego uruchomienia
- Poczekaj 2-3 minuty z otwartym Chrome
- Wyczyść dane przeglądarki i spróbuj ponownie

### is_glic_eligible key not found

Zaktualizuj Chrome do najnowszej wersji.

## Co robi skrypt

1. Tworzy kopię zapasową konfiguracji w `%USERPROFILE%\ChromeGeminiBackup`
2. Zmienia ustawienia regionalne na US
3. Czyści pamięć podręczną variations
4. Włącza flagę `is_glic_eligible`
5. Weryfikuje zmiany

Skrypt modyfikuje tylko plik konfiguracyjny Chrome. Brak zmian w plikach binarnych, żądaniach sieciowych lub ustawieniach systemowych.

## Zrzeczenie się odpowiedzialności

To narzędzie jest przeznaczone dla legalnych użytkowników, którzy mają autoryzowany dostęp do Gemini w swoim kraju i doświadczają tymczasowych problemów z dostępem podczas podróży.

## Autor

Oleksandr Drozd (<dev.drozd@gmail.com>)

---

## Wesprzyj projekt

Jeśli to narzędzie Ci pomogło, wesprzyj jego rozwój:

[![Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Q2D521U4BT)

**Inne sposoby wsparcia:**
- [PayPal](https://www.paypal.com/donate/?hosted_button_id=UQGNYDVPER2TJ)
- [Revolut](https://revolut.me/devdrozd)
- ⭐ Daj gwiazdkę temu repozytorium na GitHub

Twoje wsparcie pomaga utrzymywać i ulepszać to narzędzie. Dziękuję!

## Licencja

MIT License

---

## Tagi

#gemini #chrome #gemini-chrome #google-gemini #gemini-ai #rozszerzenie-chrome #łatka-regionalna #vpn #dostęp-gemini #włączyć-gemini #łatka-chrome #gemini-niedostępny #naprawa-gemini #aktywować-gemini #gemini-za-granicą #gemini-podróż #konfiguracja-chrome #local-state #variations-country #gemini-nie-działa #region-gemini #odblokować-gemini #obejście-gemini #chrome-ai #google-ai #bard-gemini
