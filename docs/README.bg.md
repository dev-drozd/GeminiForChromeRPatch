# Активиране на Gemini в Chrome - Region Patch

## 🌐 Многоезична документация

[🇺🇸 English](../README.md) | [🇷🇺 Русский](README.ru.md) | [🇺🇦 Українська](README.uk.md) | [🇧🇬 Български](README.bg.md) | [🇪🇸 Español](README.es.md) | [🇫🇷 Français](README.fr.md) | [🇩🇪 Deutsch](README.de.md) | [🇵🇱 Polski](README.pl.md)

![Gemini за Chrome](../img/gemini-for-chrome.webp)

Инструмент за граждани на страни с поддръжка на Gemini, временно пътуващи в чужбина, които са загубили достъп поради автоматично определяне на региона. Възстановява регионалните настройки на Chrome, за да съответстват на вашата страна на гражданство.

## Използване

### Windows

Отворете PowerShell и изпълнете:

```powershell
irm https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.ps1 | iex
```

### Linux / macOS

Отворете Terminal и изпълнете:

```bash
curl -fsSL https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.sh | bash
```

Скриптът ще:
1. Затвори Chrome
2. Създаде резервно копие в `%USERPROFILE%\ChromeGeminiBackup`
3. Patch-не конфигурацията на Chrome
4. Поиска потвърждение, че VPN е активиран
5. Приложи patch-а и стартира Chrome

## Възстановяване

Изпълнете същата команда и изберете опция **[2]**.

## Решаване на проблеми

### "Не може да се зареди, защото изпълнението на скриптове е деактивирано"

Първо изпълнете:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### Chrome не се затваря

Проверете Task Manager (Ctrl+Shift+Esc) за фонови Chrome процеси.

### Gemini не се появява

- Уверете се, че VPN е свързан с US сървър при първото стартиране
- Изчакайте 2-3 минути с отворен Chrome
- Изчистете данните на браузъра и опитайте отново

### is_glic_eligible key not found

Актуализирайте Chrome до последната версия.

## Какво прави скриптът

1. Създава резервно копие на конфигурацията в `%USERPROFILE%\ChromeGeminiBackup`
2. Променя регионалните настройки на US
3. Изчиства кеша на variations
4. Активира флага `is_glic_eligible`
5. Проверява промените

Скриптът променя само конфигурационния файл на Chrome. Никакви промени на бинарните файлове, мрежови заявки или системни настройки.

## Отказ от отговорност

Този инструмент е за легитимни потребители, които имат оторизиран достъп до Gemini в своята страна и изпитват временни проблеми с достъпа по време на пътуване.

## Автор

Александър Дрозд (<dev.drozd@gmail.com>)

---

## Подкрепете проекта

Ако този инструмент ви помогна, подкрепете неговото развитие:

[![Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Q2D521U4BT)

**Други начини за подкрепа:**
- [PayPal](https://www.paypal.com/donate/?hosted_button_id=UQGNYDVPER2TJ)
- [Revolut](https://revolut.me/devdrozd)
- ⭐ Поставете звезда на това хранилище в GitHub

Вашата подкрепа помага за поддържане и подобряване на този инструмент. Благодаря!

## Лиценз

MIT License

---

## Тагове

#gemini #chrome #gemini-chrome #google-gemini #gemini-ai #разширение-chrome #patch-регион #vpn #достъп-gemini #активиране-gemini #patch-chrome #gemini-недостъпен #поправка-gemini #активиране-gemini #gemini-в-чужбина #gemini-пътуване #конфигурация-chrome #local-state #variations-country #gemini-не-работи #регион-gemini #отключване-gemini #заобикаляне-gemini #chrome-ai #google-ai #bard-gemini
