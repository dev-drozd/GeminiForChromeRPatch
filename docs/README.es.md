# Gemini para Chrome - Parche Regional

## 🌐 Documentación multilingüe

[🇺🇸 English](../README.md) | [🇷🇺 Русский](README.ru.md) | [🇺🇦 Українська](README.uk.md) | [🇧🇬 Български](README.bg.md) | [🇪🇸 Español](README.es.md) | [🇫🇷 Français](README.fr.md) | [🇩🇪 Deutsch](README.de.md) | [🇵🇱 Polski](README.pl.md)

![Gemini para Chrome](../img/gemini-for-chrome.webp)

Una herramienta para ciudadanos de países con soporte de Gemini que viajan temporalmente al extranjero y han perdido el acceso debido a la detección automática de región. Restaura la configuración regional de Chrome para que coincida con su país de ciudadanía.

## Uso

### Windows

Abra PowerShell y ejecute:

```powershell
irm https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.ps1 | iex
```

### Linux / macOS

Abra Terminal y ejecute:

```bash
curl -fsSL https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.sh | bash
```

El script:
1. Cerrará Chrome
2. Creará una copia de seguridad en `%USERPROFILE%\ChromeGeminiBackup`
3. Parcheará la configuración de Chrome
4. Pedirá confirmación de que VPN está activado
5. Aplicará el parche y iniciará Chrome

## Restauración

Ejecute el mismo comando y seleccione la opción **[2]**.

## Solución de problemas

### "No se puede cargar porque la ejecución de scripts está deshabilitada"

Primero ejecute:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### Chrome no se cierra

Verifique el Administrador de tareas (Ctrl+Shift+Esc) para procesos de Chrome en segundo plano.

### Gemini no aparece

- Asegúrese de que VPN esté conectado a un servidor de EE. UU. en el primer inicio
- Espere 2-3 minutos con Chrome abierto
- Borre los datos del navegador e intente nuevamente

### is_glic_eligible key not found

Actualice Chrome a la última versión.

## Qué hace el script

1. Crea una copia de seguridad de la configuración en `%USERPROFILE%\ChromeGeminiBackup`
2. Cambia la configuración regional a US
3. Limpia el caché de variations
4. Habilita el flag `is_glic_eligible`
5. Verifica los cambios

El script solo modifica el archivo de configuración de Chrome. Sin cambios en binarios, solicitudes de red o configuración del sistema.

## Descargo de responsabilidad

Esta herramienta es para usuarios legítimos que tienen acceso autorizado a Gemini en su país y experimentan problemas de acceso temporal mientras viajan.

## Autor

Oleksandr Drozd (<dev.drozd@gmail.com>)

---

## Apoyar el proyecto

Si esta herramienta te ayudó, apoya su desarrollo:

[![Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Q2D521U4BT)

**Otras formas de apoyar:**
- [PayPal](https://www.paypal.com/donate/?hosted_button_id=UQGNYDVPER2TJ)
- [Revolut](https://revolut.me/devdrozd)
- ⭐ Dale una estrella a este repositorio en GitHub

Tu apoyo ayuda a mantener y mejorar esta herramienta. ¡Gracias!

## Licencia

MIT License

---

## Etiquetas

#gemini #chrome #gemini-chrome #google-gemini #gemini-ai #extension-chrome #parche-region #vpn #acceso-gemini #habilitar-gemini #parche-chrome #gemini-no-disponible #arreglo-gemini #activar-gemini #gemini-en-el-extranjero #gemini-viajando #configuracion-chrome #local-state #variations-country #gemini-no-funciona #region-gemini #desbloquear-gemini #solucion-gemini #chrome-ai #google-ai #bard-gemini
