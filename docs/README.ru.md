# Активация Gemini в Chrome - Патч региона

## 🌐 Мультиязычная документация

[🇺🇸 English](../README.md) | [🇷🇺 Русский](README.ru.md) | [🇺🇦 Українська](README.uk.md) | [🇧🇬 Български](README.bg.md) | [🇪🇸 Español](README.es.md) | [🇫🇷 Français](README.fr.md) | [🇩🇪 Deutsch](README.de.md) | [🇵🇱 Polski](README.pl.md)

![Gemini для Chrome](../img/gemini-for-chrome.webp)

Инструмент для граждан стран с поддержкой Gemini, временно находящихся за границей, которые потеряли доступ из-за автоматического определения региона. Восстанавливает региональные настройки Chrome в соответствии с вашей страной гражданства.

## Использование

### Windows

Откройте PowerShell и выполните:

```powershell
irm https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.ps1 | iex
```

### Linux / macOS

Откройте Terminal и выполните:

```bash
curl -fsSL https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.sh | bash
```

Скрипт:
1. Закроет Chrome
2. Создаст резервную копию в `%USERPROFILE%\ChromeGeminiBackup`
3. Пропатчит конфигурацию Chrome
4. Попросит подтвердить что VPN включен
5. Применит патч и запустит Chrome

## Восстановление

Запустите ту же команду и выберите вариант **[2]**.

## Решение проблем

### Windows

**"Невозможно загрузить, так как выполнение скриптов отключено"**

Сначала выполните:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

**Chrome не закрывается**

Проверьте Диспетчер задач (Ctrl+Shift+Esc) на фоновые процессы Chrome.

### Linux / macOS

**"Permission denied" или "curl: command not found"**

Для Linux:
```bash
# Установите curl если нужно
sudo apt install curl  # Debian/Ubuntu
sudo dnf install curl  # Fedora
sudo pacman -S curl    # Arch

# Сделайте скрипт исполняемым
chmod +x gemini_for_chrome_patch.sh
```

Для macOS:
```bash
# curl предустановлен, просто выполните команду
```

**"Python3 not found"**

Для Linux:
```bash
sudo apt install python3  # Debian/Ubuntu
sudo dnf install python3  # Fedora
sudo pacman -S python     # Arch
```

Для macOS:
```bash
# Python3 предустановлен на macOS 10.15+
# Для старых версий установите с python.org
```

**Chrome не закрывается**

```bash
# Принудительно завершите процессы Chrome
pkill -9 -f Chrome
# Или используйте Мониторинг системы (macOS) / Системный монитор (Linux)
```

**Скрипт сообщает "No Chrome config found"**

Убедитесь что Chrome установлен:
- Linux: `/usr/bin/google-chrome`
- macOS: `/Applications/Google Chrome.app`

### Все платформы

**Gemini не появляется**

- Убедитесь что VPN подключен к серверу США при первом запуске
- Подождите 2-3 минуты с открытым Chrome
- Очистите данные браузера и попробуйте снова

### is_glic_eligible key not found

Обновите Chrome до последней версии.

## Что делает скрипт

1. Создаёт резервную копию конфигурации в `%USERPROFILE%\ChromeGeminiBackup`
2. Меняет региональные настройки на US
3. Очищает кэш variations
4. Включает флаг `is_glic_eligible`
5. Проверяет изменения

Скрипт изменяет только конфигурационный файл Chrome. Никаких изменений бинарников, сетевых запросов или системных настроек.

## Отказ от ответственности

Этот инструмент для легитимных пользователей, имеющих авторизованный доступ к Gemini в своей стране и испытывающих временные проблемы с доступом во время путешествий.

## Автор

Александр Дрозд (<dev.drozd@gmail.com>)

---

## Поддержать проект

Если этот инструмент помог вам, поддержите его развитие:

[![Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Q2D521U4BT)

**Другие способы поддержки:**
- [PayPal](https://www.paypal.com/donate/?hosted_button_id=UQGNYDVPER2TJ)
- [Revolut](https://revolut.me/devdrozd)
- ⭐ Поставьте звезду этому репозиторию на GitHub

Ваша поддержка помогает развивать и улучшать этот инструмент. Спасибо!

## Лицензия

MIT License

---

## Теги

#gemini #chrome #gemini-chrome #google-gemini #gemini-ai #расширение-chrome #патч-региона #vpn #доступ-gemini #включить-gemini #патч-chrome #gemini-недоступен #исправление-gemini #активировать-gemini #gemini-за-границей #gemini-в-путешествии #конфигурация-chrome #local-state #variations-country #gemini-не-работает #регион-gemini #разблокировать-gemini #обход-gemini #chrome-ai #google-ai #bard-gemini #гугл-гемини #гемини-хром
