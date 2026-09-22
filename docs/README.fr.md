# Gemini pour Chrome - Correctif Régional

## 🌐 Documentation multilingue

[🇺🇸 English](../README.md) | [🇷🇺 Русский](README.ru.md) | [🇺🇦 Українська](README.uk.md) | [🇧🇬 Български](README.bg.md) | [🇪🇸 Español](README.es.md) | [🇫🇷 Français](README.fr.md) | [🇩🇪 Deutsch](README.de.md) | [🇵🇱 Polski](README.pl.md)

![Gemini pour Chrome](../img/gemini-for-chrome.webp)

Un outil pour les citoyens des pays prenant en charge Gemini voyageant temporairement à l'étranger qui ont perdu l'accès en raison de la détection automatique de région. Restaure les paramètres régionaux de Chrome pour correspondre à votre pays de citoyenneté.

## Utilisation

### Windows

Ouvrez PowerShell et exécutez :

```powershell
irm https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.ps1 | iex
```

### Linux / macOS

Ouvrez Terminal et exécutez :

```bash
curl -fsSL https://raw.githubusercontent.com/dev-drozd/GeminiForChromeRPatch/main/gemini_for_chrome_patch.sh | bash
```

Le script va :
1. Fermer Chrome
2. Créer une sauvegarde dans `%USERPROFILE%\ChromeGeminiBackup`
3. Corriger la configuration de Chrome
4. Demander confirmation que le VPN est activé
5. Appliquer le correctif et lancer Chrome

## Restauration

Exécutez la même commande et sélectionnez l'option **[2]**.

## Dépannage

### "Impossible de charger car l'exécution de scripts est désactivée"

Exécutez d'abord :
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### Chrome ne se ferme pas

Vérifiez le Gestionnaire des tâches (Ctrl+Shift+Esc) pour les processus Chrome en arrière-plan.

### Gemini n'apparaît pas

- Assurez-vous que le VPN est connecté à un serveur américain lors du premier lancement
- Attendez 2-3 minutes avec Chrome ouvert
- Effacez les données de navigation et réessayez

### is_glic_eligible key not found

Mettez à jour Chrome vers la dernière version.

## Ce que fait le script

1. Crée une sauvegarde de la configuration dans `%USERPROFILE%\ChromeGeminiBackup`
2. Modifie les paramètres régionaux en US
3. Efface le cache des variations
4. Active le drapeau `is_glic_eligible`
5. Vérifie les modifications

Le script modifie uniquement le fichier de configuration de Chrome. Aucune modification des binaires, requêtes réseau ou paramètres système.

## Avertissement

Cet outil est destiné aux utilisateurs légitimes ayant un accès autorisé à Gemini dans leur pays et rencontrant des problèmes d'accès temporaires lors de voyages.

## Auteur

Oleksandr Drozd (<dev.drozd@gmail.com>)

---

## Soutenir le projet

Si cet outil vous a aidé, soutenez son développement :

[![Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Q2D521U4BT)

**Autres moyens de soutenir :**
- [PayPal](https://www.paypal.com/donate/?hosted_button_id=UQGNYDVPER2TJ)
- [Revolut](https://revolut.me/devdrozd)
- ⭐ Mettez une étoile à ce dépôt sur GitHub

Votre soutien aide à maintenir et améliorer cet outil. Merci !

## Licence

MIT License

---

## Tags

#gemini #chrome #gemini-chrome #google-gemini #gemini-ai #extension-chrome #correctif-region #vpn #acces-gemini #activer-gemini #correctif-chrome #gemini-indisponible #correction-gemini #activer-gemini #gemini-a-l-etranger #gemini-voyage #configuration-chrome #local-state #variations-country #gemini-ne-fonctionne-pas #region-gemini #debloquer-gemini #contournement-gemini #chrome-ai #google-ai #bard-gemini
