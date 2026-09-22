# Активація Gemini в Chrome - Патч регіону

## 🌐 Мультимовна документація

[🇺🇸 English](../README.md) | [🇷🇺 Русский](README.ru.md) | [🇺🇦 Українська](README.uk.md) | [🇧🇬 Български](README.bg.md) | [🇪🇸 Español](README.es.md) | [🇫🇷 Français](README.fr.md) | [🇩🇪 Deutsch](README.de.md) | [🇵🇱 Polski](README.pl.md)

![Gemini для Chrome](../img/gemini-for-chrome.webp)

Інструмент для громадян країн з підтримкою Gemini, тимчасово перебувають за кордоном, які втратили доступ через автоматичне визначення регіону. Відновлює регіональні налаштування Chrome відповідно до вашої країни громадянства.

## Використання

### Windows

Відкрийте PowerShell і виконайте:

```powershell
irm https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.ps1 | iex
```

### Linux / macOS

Відкрийте Terminal і виконайте:

```bash
curl -fsSL https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.sh | bash
```

Скрипт:
1. Закриє Chrome
2. Створить резервну копію в `%USERPROFILE%\ChromeGeminiBackup`
3. Пропатчить конфігурацію Chrome
4. Попросить підтвердити що VPN увімкнено
5. Застосує патч і запустить Chrome

## Відновлення

Запустіть ту ж команду і виберіть варіант **[2]**.

## Вирішення проблем

### "Неможливо завантажити, оскільки виконання скриптів вимкнено"

Спочатку виконайте:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### Chrome не закривається

Перевірте Диспетчер завдань (Ctrl+Shift+Esc) на фонові процеси Chrome.

### Gemini не з'являється

- Переконайтеся що VPN підключено до сервера США при першому запуску
- Зачекайте 2-3 хвилини з відкритим Chrome
- Очистіть дані браузера і спробуйте знову

### is_glic_eligible key not found

Оновіть Chrome до останньої версії.

## Що робить скрипт

1. Створює резервну копію конфігурації в `%USERPROFILE%\ChromeGeminiBackup`
2. Змінює регіональні налаштування на US
3. Очищає кеш variations
4. Вмикає прапорець `is_glic_eligible`
5. Перевіряє зміни

Скрипт змінює лише конфігураційний файл Chrome. Ніяких змін бінарників, мережевих запитів або системних налаштувань.

## Відмова від відповідальності

Цей інструмент для легітимних користувачів, які мають авторизований доступ до Gemini у своїй країні і відчувають тимчасові проблеми з доступом під час подорожей.

## Автор

Олександр Дрозд (<dev.drozd@gmail.com>)

---

## Підтримати проект

Якщо цей інструмент допоміг вам, підтримайте його розвиток:

[![Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Q2D521U4BT)

**Інші способи підтримки:**
- [PayPal](https://www.paypal.com/donate/?hosted_button_id=UQGNYDVPER2TJ)
- [Revolut](https://revolut.me/devdrozd)
- ⭐ Поставте зірку цьому репозиторію на GitHub

Ваша підтримка допомагає розвивати та покращувати цей інструмент. Дякую!

## Ліцензія

MIT License

---

## Теги

#gemini #chrome #gemini-chrome #google-gemini #gemini-ai #розширення-chrome #патч-регіону #vpn #доступ-gemini #увімкнути-gemini #патч-chrome #gemini-недоступний #виправлення-gemini #активувати-gemini #gemini-за-кордоном #gemini-в-подорожі #конфігурація-chrome #local-state #variations-country #gemini-не-працює #регіон-gemini #розблокувати-gemini #обхід-gemini #chrome-ai #google-ai #bard-gemini #гугл-джеміні #джеміні-хром
