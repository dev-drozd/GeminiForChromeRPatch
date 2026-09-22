# Enable Gemini in Chrome - Multi-Channel / Multilingual
# Patches all Chrome channels, clears variations cache, auto-detects language
# Author: Oleksandr Drozd <dev.drozd@gmail.com>

# Detect system language and console encoding
$systemLang = (Get-Culture).TwoLetterISOLanguageName

# Check if console supports Cyrillic (for Russian, Ukrainian, Bulgarian)
$supportsCyrillic = $false
try {
    $currentEncoding = [Console]::OutputEncoding
    # Check if encoding supports Cyrillic characters (code page 1251, 65001 UTF-8, etc.)
    if ($currentEncoding.CodePage -eq 65001 -or $currentEncoding.CodePage -eq 1251 -or $currentEncoding.CodePage -eq 866) {
        $supportsCyrillic = $true
    }
} catch {
    $supportsCyrillic = $false
}

# Force English if Cyrillic language is detected but Cyrillic is not supported
if (($systemLang -eq "ru" -or $systemLang -eq "uk" -or $systemLang -eq "bg") -and -not $supportsCyrillic) {
    $systemLang = "en"
}

# Language strings
$strings = @{
    en = @{
        title = "Gemini in Chrome Enabler"
        chromeRunning = "Chrome is running. Closing all Chrome processes..."
        chromeClosed = "✓ Chrome closed successfully."
        chromeCloseFailed = "✗ Failed to close Chrome automatically."
        closeManually = "Please close Chrome manually and press Enter to continue..."
        chromeStillRunning = "Chrome is still running. Aborting."
        checkTaskManager = "Tip: Check Task Manager (Ctrl+Shift+Esc) for background Chrome processes."
        foundBackups = "Found existing backups in ChromeGeminiBackup folder."
        options = "Options:"
        runPatch = "[1] Run patch (default)"
        restoreBackup = "[2] Restore from backup"
        choose = "Choose option (1 or 2)"
        availableBackups = "Available backups:"
        selectBackup = "Select backup to restore (number)"
        restoring = "Restoring backup for Chrome"
        closingChrome = "Closing Chrome..."
        backupRestored = "✓ Backup restored"
        cacheCleared = "✓ Cache cleared"
        launching = "✓ Launching Chrome"
        doneRestored = "Done! Backup restored and Chrome launched."
        channelNotFound = "Channel not found. Exiting."
        invalidSelection = "Invalid selection. Exiting."
        invalidInput = "Invalid input. Exiting."
        skipped = "Skipped (not found):"
        processing = "Processing:"
        backupCreated = "Backup created:"
        deletedCache = "Deleted cache:"
        glicEnabled = "is_glic_eligible enabled"
        glicNotFound = "is_glic_eligible key not found (update Chrome)"
        clearedSeeds = "Cleared variations seeds (v1 + v2)"
        okGlic = "OK: is_glic_eligible = true"
        warnGlic = "WARN: is_glic_eligible not changed"
        okCountry = "OK: variations_country = us"
        warnCountry = "WARN: variations_country not changed"
        okPermanent = "OK: permanent_consistency_country = us"
        warnPermanent = "WARN: permanent_consistency_country not changed"
        noConfig = "No Chrome config found."
        donePatched = "Done! Patched: {0}, errors: {1}"
        noExe = "No Chrome executable found. Please launch Chrome manually with flags:"
        patchSuccess = "PATCH APPLIED SUCCESSFULLY!"
        beforeLaunch = "BEFORE LAUNCHING:"
        checkVpn1 = "✓ Make sure your VPN is connected to a US server"
        checkVpn2 = "✓ Verify your VPN connection is active"
        vpnConfirm = "VPN enabled? Press Enter to continue (or type 'exit' to quit)"
        exiting = "Exiting. You can launch Chrome manually later with:"
        applyingPatch = "Applying patch to Chrome channels..."
        launched = "launched"
        waiting = "Waiting 3 seconds for feature registration..."
        closed = "closed"
        failedProcess = "✗ Failed to process"
        allConfigured = "All Chrome channels have been configured."
        useNormally = "You can now use Chrome normally with Gemini enabled."
        pressOne = "Press [1] to launch Chrome now, or any other key to exit"
        selectChannel = "Select Chrome channel to launch:"
        enterNumber = "Enter number"
        starting = "Launching"
        startedSuccess = "started successfully"
        failedLaunch = "✗ Failed to launch:"
        enjoyGemini = "Done! Enjoy Gemini in Chrome."
    }
    ru = @{
        title = "Активатор Gemini для Chrome"
        chromeRunning = "Chrome запущен. Закрытие всех процессов Chrome..."
        chromeClosed = "✓ Chrome успешно закрыт."
        chromeCloseFailed = "✗ Не удалось закрыть Chrome автоматически."
        closeManually = "Закройте Chrome вручную и нажмите Enter для продолжения..."
        chromeStillRunning = "Chrome всё ещё запущен. Прерывание работы."
        checkTaskManager = "Подсказка: Проверьте Диспетчер задач (Ctrl+Shift+Esc) на фоновые процессы Chrome."
        foundBackups = "Найдены существующие резервные копии в папке ChromeGeminiBackup."
        options = "Варианты:"
        runPatch = "[1] Запустить патч (по умолчанию)"
        restoreBackup = "[2] Восстановить из резервной копии"
        choose = "Выберите вариант (1 или 2)"
        availableBackups = "Доступные резервные копии:"
        selectBackup = "Выберите резервную копию для восстановления (номер)"
        restoring = "Восстановление резервной копии для Chrome"
        closingChrome = "Закрытие Chrome..."
        backupRestored = "✓ Резервная копия восстановлена"
        cacheCleared = "✓ Кэш очищен"
        launching = "✓ Запуск Chrome"
        doneRestored = "Готово! Резервная копия восстановлена и Chrome запущен."
        channelNotFound = "Канал не найден. Выход."
        invalidSelection = "Неверный выбор. Выход."
        invalidInput = "Неверный ввод. Выход."
        skipped = "Пропущен (не найден):"
        processing = "Обработка:"
        backupCreated = "Резервная копия создана:"
        deletedCache = "Удалён кэш:"
        glicEnabled = "is_glic_eligible включён"
        glicNotFound = "Ключ is_glic_eligible не найден (обновите Chrome)"
        clearedSeeds = "Очищены variations seeds (v1 + v2)"
        okGlic = "OK: is_glic_eligible = true"
        warnGlic = "ВНИМАНИЕ: is_glic_eligible не изменён"
        okCountry = "OK: variations_country = us"
        warnCountry = "ВНИМАНИЕ: variations_country не изменён"
        okPermanent = "OK: permanent_consistency_country = us"
        warnPermanent = "ВНИМАНИЕ: permanent_consistency_country не изменён"
        noConfig = "Конфигурация Chrome не найдена."
        donePatched = "Готово! Пропатчено: {0}, ошибок: {1}"
        noExe = "Исполняемый файл Chrome не найден. Запустите Chrome вручную с флагами:"
        patchSuccess = "ПАТЧ УСПЕШНО ПРИМЕНЁН!"
        beforeLaunch = "ПЕРЕД ЗАПУСКОМ:"
        checkVpn1 = "✓ Убедитесь что VPN подключен к серверу США"
        checkVpn2 = "✓ Проверьте что VPN-соединение активно"
        vpnConfirm = "VPN включен? Нажмите Enter для продолжения (или введите 'exit' для выхода)"
        exiting = "Выход. Вы можете запустить Chrome вручную позже с:"
        applyingPatch = "Применение патча к каналам Chrome..."
        launched = "запущен"
        waiting = "Ожидание 3 секунды для регистрации функций..."
        closed = "закрыт"
        failedProcess = "✗ Не удалось обработать"
        allConfigured = "Все каналы Chrome настроены."
        useNormally = "Теперь вы можете использовать Chrome с включенным Gemini."
        pressOne = "Нажмите [1] для запуска Chrome, или любую другую клавишу для выхода"
        selectChannel = "Выберите канал Chrome для запуска:"
        enterNumber = "Введите номер"
        starting = "Запуск"
        startedSuccess = "успешно запущен"
        failedLaunch = "✗ Не удалось запустить:"
        enjoyGemini = "Готово! Наслаждайтесь Gemini в Chrome."
    }
    uk = @{
        title = "Активатор Gemini для Chrome"
        chromeRunning = "Chrome запущено. Закриття всіх процесів Chrome..."
        chromeClosed = "✓ Chrome успішно закрито."
        chromeCloseFailed = "✗ Не вдалося закрити Chrome автоматично."
        closeManually = "Закрийте Chrome вручну та натисніть Enter для продовження..."
        chromeStillRunning = "Chrome все ще запущено. Переривання роботи."
        checkTaskManager = "Порада: Перевірте Диспетчер завдань (Ctrl+Shift+Esc) на фонові процеси Chrome."
        foundBackups = "Знайдено існуючі резервні копії у папці ChromeGeminiBackup."
        options = "Варіанти:"
        runPatch = "[1] Запустити патч (за замовчуванням)"
        restoreBackup = "[2] Відновити з резервної копії"
        choose = "Виберіть варіант (1 або 2)"
        availableBackups = "Доступні резервні копії:"
        selectBackup = "Виберіть резервну копію для відновлення (номер)"
        restoring = "Відновлення резервної копії для Chrome"
        closingChrome = "Закриття Chrome..."
        backupRestored = "✓ Резервну копію відновлено"
        cacheCleared = "✓ Кеш очищено"
        launching = "✓ Запуск Chrome"
        doneRestored = "Готово! Резервну копію відновлено та Chrome запущено."
        channelNotFound = "Канал не знайдено. Вихід."
        invalidSelection = "Невірний вибір. Вихід."
        invalidInput = "Невірний ввід. Вихід."
        skipped = "Пропущено (не знайдено):"
        processing = "Обробка:"
        backupCreated = "Резервну копію створено:"
        deletedCache = "Видалено кеш:"
        glicEnabled = "is_glic_eligible увімкнено"
        glicNotFound = "Ключ is_glic_eligible не знайдено (оновіть Chrome)"
        clearedSeeds = "Очищено variations seeds (v1 + v2)"
        okGlic = "OK: is_glic_eligible = true"
        warnGlic = "УВАГА: is_glic_eligible не змінено"
        okCountry = "OK: variations_country = us"
        warnCountry = "УВАГА: variations_country не змінено"
        okPermanent = "OK: permanent_consistency_country = us"
        warnPermanent = "УВАГА: permanent_consistency_country не змінено"
        noConfig = "Конфігурацію Chrome не знайдено."
        donePatched = "Готово! Пропатчено: {0}, помилок: {1}"
        noExe = "Виконуваний файл Chrome не знайдено. Запустіть Chrome вручну з прапорцями:"
        patchSuccess = "ПАТЧ УСПІШНО ЗАСТОСОВАНО!"
        beforeLaunch = "ПЕРЕД ЗАПУСКОМ:"
        checkVpn1 = "✓ Переконайтеся що VPN підключено до сервера США"
        checkVpn2 = "✓ Перевірте що VPN-з'єднання активне"
        vpnConfirm = "VPN увімкнено? Натисніть Enter для продовження (або введіть 'exit' для виходу)"
        exiting = "Вихід. Ви можете запустити Chrome вручну пізніше з:"
        applyingPatch = "Застосування патча до каналів Chrome..."
        launched = "запущено"
        waiting = "Очікування 3 секунди для реєстрації функцій..."
        closed = "закрито"
        failedProcess = "✗ Не вдалося обробити"
        allConfigured = "Всі канали Chrome налаштовано."
        useNormally = "Тепер ви можете використовувати Chrome з увімкненим Gemini."
        pressOne = "Натисніть [1] для запуску Chrome, або будь-яку іншу клавішу для виходу"
        selectChannel = "Виберіть канал Chrome для запуску:"
        enterNumber = "Введіть номер"
        starting = "Запуск"
        startedSuccess = "успішно запущено"
        failedLaunch = "✗ Не вдалося запустити:"
        enjoyGemini = "Готово! Насолоджуйтесь Gemini в Chrome."
    }
    bg = @{
        title = "Gemini активатор за Chrome"
        chromeRunning = "Chrome работи. Затваряне на всички Chrome процеси..."
        chromeClosed = "✓ Chrome успешно затворен."
        chromeCloseFailed = "✗ Неуспешно автоматично затваряне на Chrome."
        closeManually = "Затворете Chrome ръчно и натиснете Enter за продължаване..."
        chromeStillRunning = "Chrome все още работи. Прекъсване."
        checkTaskManager = "Съвет: Проверете Task Manager (Ctrl+Shift+Esc) за фонови Chrome процеси."
        foundBackups = "Намерени съществуващи резервни копия в папка ChromeGeminiBackup."
        options = "Опции:"
        runPatch = "[1] Пускане на patch (по подразбиране)"
        restoreBackup = "[2] Възстановяване от резервно копие"
        choose = "Изберете опция (1 или 2)"
        availableBackups = "Налични резервни копия:"
        selectBackup = "Изберете резервно копие за възстановяване (номер)"
        restoring = "Възстановяване на резервно копие за Chrome"
        closingChrome = "Затваряне на Chrome..."
        backupRestored = "✓ Резервното копие е възстановено"
        cacheCleared = "✓ Кешът е изчистен"
        launching = "✓ Стартиране на Chrome"
        doneRestored = "Готово! Резервното копие е възстановено и Chrome е стартиран."
        channelNotFound = "Каналът не е намерен. Изход."
        invalidSelection = "Невалиден избор. Изход."
        invalidInput = "Невалиден вход. Изход."
        skipped = "Пропуснат (не е намерен):"
        processing = "Обработка:"
        backupCreated = "Резервно копие създадено:"
        deletedCache = "Изтрит кеш:"
        glicEnabled = "is_glic_eligible активиран"
        glicNotFound = "Ключът is_glic_eligible не е намерен (актуализирайте Chrome)"
        clearedSeeds = "Изчистени variations seeds (v1 + v2)"
        okGlic = "OK: is_glic_eligible = true"
        warnGlic = "ВНИМАНИЕ: is_glic_eligible не е променен"
        okCountry = "OK: variations_country = us"
        warnCountry = "ВНИМАНИЕ: variations_country не е променен"
        okPermanent = "OK: permanent_consistency_country = us"
        warnPermanent = "ВНИМАНИЕ: permanent_consistency_country не е променен"
        noConfig = "Chrome конфигурацията не е намерена."
        donePatched = "Готово! Patch-нати: {0}, грешки: {1}"
        noExe = "Chrome изпълним файл не е намерен. Стартирайте Chrome ръчно с флагове:"
        patchSuccess = "PATCH ПРИЛОЖЕН УСПЕШНО!"
        beforeLaunch = "ПРЕДИ СТАРТИРАНЕ:"
        checkVpn1 = "✓ Уверете се че VPN е свързан към US сървър"
        checkVpn2 = "✓ Проверете че VPN връзката е активна"
        vpnConfirm = "VPN активиран? Натиснете Enter за продължаване (или въведете 'exit' за изход)"
        exiting = "Изход. Можете да стартирате Chrome ръчно по-късно с:"
        applyingPatch = "Прилагане на patch към Chrome канали..."
        launched = "стартиран"
        waiting = "Изчакване 3 секунди за регистрация на функции..."
        closed = "затворен"
        failedProcess = "✗ Неуспешна обработка"
        allConfigured = "Всички Chrome канали са конфигурирани."
        useNormally = "Сега можете да използвате Chrome нормално с активиран Gemini."
        pressOne = "Натиснете [1] за стартиране на Chrome, или друг клавиш за изход"
        selectChannel = "Изберете Chrome канал за стартиране:"
        enterNumber = "Въведете номер"
        starting = "Стартиране"
        startedSuccess = "стартиран успешно"
        failedLaunch = "✗ Неуспешно стартиране:"
        enjoyGemini = "Готово! Насладете се на Gemini в Chrome."
    }
    es = @{
        title = "Activador de Gemini para Chrome"
        chromeRunning = "Chrome está ejecutándose. Cerrando todos los procesos de Chrome..."
        chromeClosed = "✓ Chrome cerrado exitosamente."
        chromeCloseFailed = "✗ No se pudo cerrar Chrome automáticamente."
        closeManually = "Cierre Chrome manualmente y presione Enter para continuar..."
        chromeStillRunning = "Chrome aún está en ejecución. Abortando."
        checkTaskManager = "Consejo: Verifique el Administrador de tareas (Ctrl+Shift+Esc) para procesos de Chrome en segundo plano."
        foundBackups = "Se encontraron copias de seguridad existentes en la carpeta ChromeGeminiBackup."
        options = "Opciones:"
        runPatch = "[1] Ejecutar parche (predeterminado)"
        restoreBackup = "[2] Restaurar desde copia de seguridad"
        choose = "Elija una opción (1 o 2)"
        availableBackups = "Copias de seguridad disponibles:"
        selectBackup = "Seleccione la copia de seguridad para restaurar (número)"
        restoring = "Restaurando copia de seguridad para Chrome"
        closingChrome = "Cerrando Chrome..."
        backupRestored = "✓ Copia de seguridad restaurada"
        cacheCleared = "✓ Caché limpiado"
        launching = "✓ Iniciando Chrome"
        doneRestored = "¡Listo! Copia de seguridad restaurada y Chrome iniciado."
        channelNotFound = "Canal no encontrado. Saliendo."
        invalidSelection = "Selección inválida. Saliendo."
        invalidInput = "Entrada inválida. Saliendo."
        skipped = "Omitido (no encontrado):"
        processing = "Procesando:"
        backupCreated = "Copia de seguridad creada:"
        deletedCache = "Caché eliminado:"
        glicEnabled = "is_glic_eligible habilitado"
        glicNotFound = "Clave is_glic_eligible no encontrada (actualice Chrome)"
        clearedSeeds = "Semillas de variaciones limpiadas (v1 + v2)"
        okGlic = "OK: is_glic_eligible = true"
        warnGlic = "ADVERTENCIA: is_glic_eligible no cambió"
        okCountry = "OK: variations_country = us"
        warnCountry = "ADVERTENCIA: variations_country no cambió"
        okPermanent = "OK: permanent_consistency_country = us"
        warnPermanent = "ADVERTENCIA: permanent_consistency_country no cambió"
        noConfig = "Configuración de Chrome no encontrada."
        donePatched = "¡Listo! Parcheados: {0}, errores: {1}"
        noExe = "Ejecutable de Chrome no encontrado. Inicie Chrome manualmente con flags:"
        patchSuccess = "¡PARCHE APLICADO EXITOSAMENTE!"
        beforeLaunch = "ANTES DE INICIAR:"
        checkVpn1 = "✓ Asegúrese de que su VPN esté conectado a un servidor de EE. UU."
        checkVpn2 = "✓ Verifique que su conexión VPN esté activa"
        vpnConfirm = "¿VPN activado? Presione Enter para continuar (o escriba 'exit' para salir)"
        exiting = "Saliendo. Puede iniciar Chrome manualmente más tarde con:"
        applyingPatch = "Aplicando parche a los canales de Chrome..."
        launched = "iniciado"
        waiting = "Esperando 3 segundos para el registro de funciones..."
        closed = "cerrado"
        failedProcess = "✗ No se pudo procesar"
        allConfigured = "Todos los canales de Chrome han sido configurados."
        useNormally = "Ahora puede usar Chrome normalmente con Gemini habilitado."
        pressOne = "Presione [1] para iniciar Chrome ahora, o cualquier otra tecla para salir"
        selectChannel = "Seleccione el canal de Chrome para iniciar:"
        enterNumber = "Ingrese el número"
        starting = "Iniciando"
        startedSuccess = "iniciado exitosamente"
        failedLaunch = "✗ No se pudo iniciar:"
        enjoyGemini = "¡Listo! Disfrute de Gemini en Chrome."
    }
    fr = @{
        title = "Activateur Gemini pour Chrome"
        chromeRunning = "Chrome est en cours d'exécution. Fermeture de tous les processus Chrome..."
        chromeClosed = "✓ Chrome fermé avec succès."
        chromeCloseFailed = "✗ Impossible de fermer Chrome automatiquement."
        closeManually = "Fermez Chrome manuellement et appuyez sur Entrée pour continuer..."
        chromeStillRunning = "Chrome est toujours en cours d'exécution. Abandon."
        checkTaskManager = "Conseil : Vérifiez le Gestionnaire des tâches (Ctrl+Shift+Esc) pour les processus Chrome en arrière-plan."
        foundBackups = "Sauvegardes existantes trouvées dans le dossier ChromeGeminiBackup."
        options = "Options :"
        runPatch = "[1] Exécuter le correctif (par défaut)"
        restoreBackup = "[2] Restaurer à partir d'une sauvegarde"
        choose = "Choisissez une option (1 ou 2)"
        availableBackups = "Sauvegardes disponibles :"
        selectBackup = "Sélectionnez la sauvegarde à restaurer (numéro)"
        restoring = "Restauration de la sauvegarde pour Chrome"
        closingChrome = "Fermeture de Chrome..."
        backupRestored = "✓ Sauvegarde restaurée"
        cacheCleared = "✓ Cache vidé"
        launching = "✓ Lancement de Chrome"
        doneRestored = "Terminé ! Sauvegarde restaurée et Chrome lancé."
        channelNotFound = "Canal introuvable. Sortie."
        invalidSelection = "Sélection invalide. Sortie."
        invalidInput = "Entrée invalide. Sortie."
        skipped = "Ignoré (introuvable) :"
        processing = "Traitement :"
        backupCreated = "Sauvegarde créée :"
        deletedCache = "Cache supprimé :"
        glicEnabled = "is_glic_eligible activé"
        glicNotFound = "Clé is_glic_eligible introuvable (mettez à jour Chrome)"
        clearedSeeds = "Graines de variations effacées (v1 + v2)"
        okGlic = "OK : is_glic_eligible = true"
        warnGlic = "ATTENTION : is_glic_eligible non modifié"
        okCountry = "OK : variations_country = us"
        warnCountry = "ATTENTION : variations_country non modifié"
        okPermanent = "OK : permanent_consistency_country = us"
        warnPermanent = "ATTENTION : permanent_consistency_country non modifié"
        noConfig = "Configuration Chrome introuvable."
        donePatched = "Terminé ! Corrigés : {0}, erreurs : {1}"
        noExe = "Exécutable Chrome introuvable. Lancez Chrome manuellement avec les drapeaux :"
        patchSuccess = "CORRECTIF APPLIQUÉ AVEC SUCCÈS !"
        beforeLaunch = "AVANT LE LANCEMENT :"
        checkVpn1 = "✓ Assurez-vous que votre VPN est connecté à un serveur américain"
        checkVpn2 = "✓ Vérifiez que votre connexion VPN est active"
        vpnConfirm = "VPN activé ? Appuyez sur Entrée pour continuer (ou tapez 'exit' pour quitter)"
        exiting = "Sortie. Vous pouvez lancer Chrome manuellement plus tard avec :"
        applyingPatch = "Application du correctif aux canaux Chrome..."
        launched = "lancé"
        waiting = "Attente de 3 secondes pour l'enregistrement des fonctionnalités..."
        closed = "fermé"
        failedProcess = "✗ Échec du traitement"
        allConfigured = "Tous les canaux Chrome ont été configurés."
        useNormally = "Vous pouvez maintenant utiliser Chrome normalement avec Gemini activé."
        pressOne = "Appuyez sur [1] pour lancer Chrome maintenant, ou toute autre touche pour quitter"
        selectChannel = "Sélectionnez le canal Chrome à lancer :"
        enterNumber = "Entrez le numéro"
        starting = "Lancement"
        startedSuccess = "lancé avec succès"
        failedLaunch = "✗ Échec du lancement :"
        enjoyGemini = "Terminé ! Profitez de Gemini dans Chrome."
    }
    de = @{
        title = "Gemini-Aktivator für Chrome"
        chromeRunning = "Chrome läuft. Alle Chrome-Prozesse werden geschlossen..."
        chromeClosed = "✓ Chrome erfolgreich geschlossen."
        chromeCloseFailed = "✗ Chrome konnte nicht automatisch geschlossen werden."
        closeManually = "Schließen Sie Chrome manuell und drücken Sie Enter, um fortzufahren..."
        chromeStillRunning = "Chrome läuft immer noch. Abbruch."
        checkTaskManager = "Tipp: Überprüfen Sie den Task-Manager (Strg+Shift+Esc) auf Chrome-Hintergrundprozesse."
        foundBackups = "Vorhandene Backups im Ordner ChromeGeminiBackup gefunden."
        options = "Optionen:"
        runPatch = "[1] Patch ausführen (Standard)"
        restoreBackup = "[2] Aus Backup wiederherstellen"
        choose = "Wählen Sie eine Option (1 oder 2)"
        availableBackups = "Verfügbare Backups:"
        selectBackup = "Wählen Sie das wiederherzustellende Backup (Nummer)"
        restoring = "Backup für Chrome wird wiederhergestellt"
        closingChrome = "Chrome wird geschlossen..."
        backupRestored = "✓ Backup wiederhergestellt"
        cacheCleared = "✓ Cache geleert"
        launching = "✓ Chrome wird gestartet"
        doneRestored = "Fertig! Backup wiederhergestellt und Chrome gestartet."
        channelNotFound = "Kanal nicht gefunden. Beenden."
        invalidSelection = "Ungültige Auswahl. Beenden."
        invalidInput = "Ungültige Eingabe. Beenden."
        skipped = "Übersprungen (nicht gefunden):"
        processing = "Verarbeitung:"
        backupCreated = "Backup erstellt:"
        deletedCache = "Cache gelöscht:"
        glicEnabled = "is_glic_eligible aktiviert"
        glicNotFound = "Schlüssel is_glic_eligible nicht gefunden (Chrome aktualisieren)"
        clearedSeeds = "Variationssamen gelöscht (v1 + v2)"
        okGlic = "OK: is_glic_eligible = true"
        warnGlic = "WARNUNG: is_glic_eligible nicht geändert"
        okCountry = "OK: variations_country = us"
        warnCountry = "WARNUNG: variations_country nicht geändert"
        okPermanent = "OK: permanent_consistency_country = us"
        warnPermanent = "WARNUNG: permanent_consistency_country nicht geändert"
        noConfig = "Chrome-Konfiguration nicht gefunden."
        donePatched = "Fertig! Gepatcht: {0}, Fehler: {1}"
        noExe = "Chrome-Ausführungsdatei nicht gefunden. Starten Sie Chrome manuell mit Flags:"
        patchSuccess = "PATCH ERFOLGREICH ANGEWENDET!"
        beforeLaunch = "VOR DEM START:"
        checkVpn1 = "✓ Stellen Sie sicher, dass Ihr VPN mit einem US-Server verbunden ist"
        checkVpn2 = "✓ Überprüfen Sie, ob Ihre VPN-Verbindung aktiv ist"
        vpnConfirm = "VPN aktiviert? Drücken Sie Enter, um fortzufahren (oder geben Sie 'exit' ein, um zu beenden)"
        exiting = "Beenden. Sie können Chrome später manuell starten mit:"
        applyingPatch = "Patch wird auf Chrome-Kanäle angewendet..."
        launched = "gestartet"
        waiting = "Warte 3 Sekunden für die Funktionsregistrierung..."
        closed = "geschlossen"
        failedProcess = "✗ Verarbeitung fehlgeschlagen"
        allConfigured = "Alle Chrome-Kanäle wurden konfiguriert."
        useNormally = "Sie können Chrome jetzt normal mit aktiviertem Gemini verwenden."
        pressOne = "Drücken Sie [1], um Chrome jetzt zu starten, oder eine andere Taste zum Beenden"
        selectChannel = "Wählen Sie den Chrome-Kanal zum Starten:"
        enterNumber = "Nummer eingeben"
        starting = "Starten"
        startedSuccess = "erfolgreich gestartet"
        failedLaunch = "✗ Start fehlgeschlagen:"
        enjoyGemini = "Fertig! Genießen Sie Gemini in Chrome."
    }
    pl = @{
        title = "Aktywator Gemini dla Chrome"
        chromeRunning = "Chrome jest uruchomiony. Zamykanie wszystkich procesów Chrome..."
        chromeClosed = "✓ Chrome zamknięty pomyślnie."
        chromeCloseFailed = "✗ Nie udało się automatycznie zamknąć Chrome."
        closeManually = "Zamknij Chrome ręcznie i naciśnij Enter, aby kontynuować..."
        chromeStillRunning = "Chrome nadal działa. Przerywanie."
        checkTaskManager = "Wskazówka: Sprawdź Menedżera zadań (Ctrl+Shift+Esc) w poszukiwaniu procesów Chrome w tle."
        foundBackups = "Znaleziono istniejące kopie zapasowe w folderze ChromeGeminiBackup."
        options = "Opcje:"
        runPatch = "[1] Uruchom łatkę (domyślnie)"
        restoreBackup = "[2] Przywróć z kopii zapasowej"
        choose = "Wybierz opcję (1 lub 2)"
        availableBackups = "Dostępne kopie zapasowe:"
        selectBackup = "Wybierz kopię zapasową do przywrócenia (numer)"
        restoring = "Przywracanie kopii zapasowej dla Chrome"
        closingChrome = "Zamykanie Chrome..."
        backupRestored = "✓ Kopia zapasowa przywrócona"
        cacheCleared = "✓ Pamięć podręczna wyczyszczona"
        launching = "✓ Uruchamianie Chrome"
        doneRestored = "Gotowe! Kopia zapasowa przywrócona i Chrome uruchomiony."
        channelNotFound = "Kanał nie znaleziony. Wyjście."
        invalidSelection = "Nieprawidłowy wybór. Wyjście."
        invalidInput = "Nieprawidłowe dane wejściowe. Wyjście."
        skipped = "Pominięto (nie znaleziono):"
        processing = "Przetwarzanie:"
        backupCreated = "Kopia zapasowa utworzona:"
        deletedCache = "Usunięto pamięć podręczną:"
        glicEnabled = "is_glic_eligible włączony"
        glicNotFound = "Klucz is_glic_eligible nie znaleziony (zaktualizuj Chrome)"
        clearedSeeds = "Wyczyszczono nasiona wariacji (v1 + v2)"
        okGlic = "OK: is_glic_eligible = true"
        warnGlic = "UWAGA: is_glic_eligible nie zmieniony"
        okCountry = "OK: variations_country = us"
        warnCountry = "UWAGA: variations_country nie zmieniony"
        okPermanent = "OK: permanent_consistency_country = us"
        warnPermanent = "UWAGA: permanent_consistency_country nie zmieniony"
        noConfig = "Nie znaleziono konfiguracji Chrome."
        donePatched = "Gotowe! Załatane: {0}, błędy: {1}"
        noExe = "Plik wykonywalny Chrome nie znaleziony. Uruchom Chrome ręcznie z flagami:"
        patchSuccess = "ŁATKA ZASTOSOWANA POMYŚLNIE!"
        beforeLaunch = "PRZED URUCHOMIENIEM:"
        checkVpn1 = "✓ Upewnij się, że VPN jest połączony z serwerem w USA"
        checkVpn2 = "✓ Sprawdź, czy połączenie VPN jest aktywne"
        vpnConfirm = "VPN włączony? Naciśnij Enter, aby kontynuować (lub wpisz 'exit', aby wyjść)"
        exiting = "Wyjście. Możesz uruchomić Chrome ręcznie później za pomocą:"
        applyingPatch = "Stosowanie łatki do kanałów Chrome..."
        launched = "uruchomiony"
        waiting = "Oczekiwanie 3 sekundy na rejestrację funkcji..."
        closed = "zamknięty"
        failedProcess = "✗ Nie udało się przetworzyć"
        allConfigured = "Wszystkie kanały Chrome zostały skonfigurowane."
        useNormally = "Możesz teraz normalnie używać Chrome z włączonym Gemini."
        pressOne = "Naciśnij [1], aby uruchomić Chrome teraz, lub dowolny inny klawisz, aby wyjść"
        selectChannel = "Wybierz kanał Chrome do uruchomienia:"
        enterNumber = "Wprowadź numer"
        starting = "Uruchamianie"
        startedSuccess = "uruchomiony pomyślnie"
        failedLaunch = "✗ Nie udało się uruchomić:"
        enjoyGemini = "Gotowe! Ciesz się Gemini w Chrome."
    }
}

# Select language (fallback to English)
$lang = if ($strings.ContainsKey($systemLang)) { $systemLang } else { "en" }
$s = $strings[$lang]

Write-Host ""
Write-Host $s.title -ForegroundColor Cyan
Write-Host ""

$channels = @(
    @{ Name = "Stable"; UserData = "$env:LOCALAPPDATA\Google\Chrome\User Data";      ExePath = "C:\Program Files\Google\Chrome\Application\chrome.exe" },
    @{ Name = "Beta";   UserData = "$env:LOCALAPPDATA\Google\Chrome Beta\User Data"; ExePath = "C:\Program Files\Google\Chrome Beta\Application\chrome.exe" },
    @{ Name = "Dev";    UserData = "$env:LOCALAPPDATA\Google\Chrome Dev\User Data";  ExePath = "C:\Program Files\Google\Chrome Dev\Application\chrome.exe" },
    @{ Name = "Canary"; UserData = "$env:LOCALAPPDATA\Google\Chrome SxS\User Data";  ExePath = "$env:LOCALAPPDATA\Google\Chrome SxS\Application\chrome.exe" }
)

# Check for existing backups
$backupDir = Join-Path $env:USERPROFILE "ChromeGeminiBackup"

if ((Test-Path $backupDir) -and (Get-ChildItem $backupDir -Filter "*.bak" | Measure-Object).Count -gt 0) {
    Write-Host $s.foundBackups -ForegroundColor Yellow
    Write-Host ""
    Write-Host "$($s.options)" -ForegroundColor Cyan
    Write-Host "  $($s.runPatch)" -ForegroundColor White
    Write-Host "  $($s.restoreBackup)" -ForegroundColor White
    Write-Host ""
    $backupChoice = Read-Host $s.choose

    if ($backupChoice -eq "2") {
        Write-Host ""
        Write-Host "$($s.availableBackups)" -ForegroundColor Cyan
        Write-Host ""

        $backups = Get-ChildItem $backupDir -Filter "*.bak" | Sort-Object LastWriteTime -Descending
        $backupList = @()

        for ($i = 0; $i -lt $backups.Count; $i++) {
            $backup = $backups[$i]
            if ($backup.Name -match 'Local_State_(.+)_(\d{8})_(\d{6})\.bak') {
                $channelName = $matches[1]
                $date = $matches[2]
                $time = $matches[3]
                $dateFormatted = "{0}-{1}-{2}" -f $date.Substring(0,4), $date.Substring(4,2), $date.Substring(6,2)
                $timeFormatted = "{0}:{1}:{2}" -f $time.Substring(0,2), $time.Substring(2,2), $time.Substring(4,2)

                Write-Host "  [$($i + 1)] Chrome $channelName - $dateFormatted $timeFormatted" -ForegroundColor White
                $backupList += @{ File = $backup; Channel = $channelName }
            }
        }

        Write-Host ""
        $restoreChoice = Read-Host $s.selectBackup

        if ($restoreChoice -match '^\d+$') {
            $index = [int]$restoreChoice - 1
            if ($index -ge 0 -and $index -lt $backupList.Count) {
                $selectedBackup = $backupList[$index]
                $channelToRestore = $channels | Where-Object { $_.Name -eq $selectedBackup.Channel } | Select-Object -First 1

                if ($channelToRestore) {
                    Write-Host ""
                    Write-Host "$($s.restoring) $($selectedBackup.Channel)..." -ForegroundColor Cyan

                    $chromeProcesses = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
                    if ($chromeProcesses) {
                        Write-Host "$($s.closingChrome)" -ForegroundColor Yellow
                        Stop-Process -Name "chrome" -Force -ErrorAction SilentlyContinue
                        Start-Sleep -Seconds 2
                    }

                    $chromeStatePath = "$($channelToRestore.UserData)\Local State"
                    Copy-Item -Path $selectedBackup.File.FullName -Destination $chromeStatePath -Force
                    Write-Host $s.backupRestored -ForegroundColor Green

                    $variationsPath = "$($channelToRestore.UserData)\Variations"
                    $variationsSafePath = "$($channelToRestore.UserData)\Variations Safe"
                    $variationsSeedV2 = "$($channelToRestore.UserData)\VariationsSeedV2"
                    $variationsSafeSeedV2 = "$($channelToRestore.UserData)\VariationsSafeSeedV2"
                    $cachePaths = @($variationsPath, $variationsSafePath, $variationsSeedV2, $variationsSafeSeedV2)

                    foreach ($cachePath in $cachePaths) {
                        if (Test-Path $cachePath) {
                            Remove-Item -Path $cachePath -Force -Recurse -ErrorAction SilentlyContinue
                        }
                    }
                    Write-Host $s.cacheCleared -ForegroundColor Green

                    if (Test-Path $channelToRestore.ExePath) {
                        Write-Host "$($s.launching) $($selectedBackup.Channel)..." -ForegroundColor Green
                        Start-Process -FilePath $channelToRestore.ExePath
                    }

                    Write-Host ""
                    Write-Host $s.doneRestored -ForegroundColor Green
                    exit 0
                } else {
                    Write-Host "$($s.channelNotFound)" -ForegroundColor Red
                    exit 1
                }
            } else {
                Write-Host "$($s.invalidSelection)" -ForegroundColor Red
                exit 1
            }
        } else {
            Write-Host "$($s.invalidInput)" -ForegroundColor Red
            exit 1
        }
    }
    Write-Host ""
}

$chromeProcesses = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
if ($chromeProcesses) {
    Write-Host $s.chromeRunning -ForegroundColor Yellow
    try {
        Stop-Process -Name "chrome" -Force -ErrorAction Stop
        Start-Sleep -Seconds 2
        Write-Host $s.chromeClosed -ForegroundColor Green
    }
    catch {
        Write-Host $s.chromeCloseFailed -ForegroundColor Red
        Write-Host $s.closeManually -ForegroundColor Yellow
        Read-Host
    }

    $chromeProcesses = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
    if ($chromeProcesses) {
        Write-Host $s.chromeStillRunning -ForegroundColor Red
        Write-Host $s.checkTaskManager -ForegroundColor Yellow
        exit 1
    }
    Write-Host ""
}

$patchedCount = 0
$errors = 0
$installedChannels = @()

foreach ($channel in $channels) {
    $chromeUserData = $channel.UserData
    $chromeStatePath = "$chromeUserData\Local State"
    $variationsPath = "$chromeUserData\Variations"
    $variationsSafePath = "$chromeUserData\Variations Safe"
    $variationsSeedV2 = "$chromeUserData\VariationsSeedV2"
    $variationsSafeSeedV2 = "$chromeUserData\VariationsSafeSeedV2"

    if (-not (Test-Path $chromeStatePath)) {
        Write-Host "$($s.skipped) $($channel.Name)" -ForegroundColor DarkGray
        continue
    }

    Write-Host ""
    Write-Host "$($s.processing) $($channel.Name)" -ForegroundColor Cyan

    # Create backup folder in user profile
    $backupDir = Join-Path $env:USERPROFILE "ChromeGeminiBackup"
    if (-not (Test-Path $backupDir)) {
        New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
    }

    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupFileName = "Local_State_$($channel.Name)_$timestamp.bak"
    $backupPath = Join-Path $backupDir $backupFileName

    Copy-Item -Path $chromeStatePath -Destination $backupPath -Force
    Write-Host "  $($s.backupCreated) $backupDir\$backupFileName" -ForegroundColor Green

    $cachePaths = @($variationsPath, $variationsSafePath, $variationsSeedV2, $variationsSafeSeedV2)
    foreach ($cachePath in $cachePaths) {
        if (Test-Path $cachePath) {
            Remove-Item -Path $cachePath -Force -Recurse -ErrorAction SilentlyContinue
            Write-Host "  $($s.deletedCache) $(Split-Path $cachePath -Leaf)" -ForegroundColor Green
        }
    }

    $content = Get-Content -Path $chromeStatePath -Raw -Encoding UTF8

    $content = $content -replace '"variations_country":"[^"]*"', '"variations_country":"us"'
    $content = $content -replace '("variations_permanent_consistency_country":\[[^]]*)"[^"]*"\]', '$1"us"]'

    if ($content -match '"is_glic_eligible"\s*:\s*false') {
        $content = $content -replace '"is_glic_eligible"\s*:\s*false', '"is_glic_eligible":true'
        Write-Host "  $($s.glicEnabled)" -ForegroundColor Green
    } elseif ($content -notmatch '"is_glic_eligible"') {
        Write-Host "  $($s.glicNotFound)" -ForegroundColor Yellow
    }

    $content = $content -replace '"variations_compressed_seed":"[^"]*",?', ''
    $content = $content -replace '"variations_seed_signature":"[^"]*",?', ''
    $content = $content -replace '"variations_compressed_seed_v2":"[^"]*",?', ''
    $content = $content -replace '"variations_seed_signature_v2":"[^"]*",?', ''
    Write-Host "  $($s.clearedSeeds)" -ForegroundColor Green

    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($chromeStatePath, $content, $utf8NoBom)

    $verifyContent = Get-Content -Path $chromeStatePath -Raw
    $fileOk = $true

    if ($verifyContent -match '"is_glic_eligible":true') {
        Write-Host "  $($s.okGlic)" -ForegroundColor Green
    } else {
        Write-Host "  $($s.warnGlic)" -ForegroundColor Yellow
        $fileOk = $false
    }

    if ($verifyContent -match '"variations_country":"us"') {
        Write-Host "  $($s.okCountry)" -ForegroundColor Green
    } else {
        Write-Host "  $($s.warnCountry)" -ForegroundColor Yellow
        $fileOk = $false
    }

    if ($verifyContent -match '"variations_permanent_consistency_country":\[[^]]*"us"\]') {
        Write-Host "  $($s.okPermanent)" -ForegroundColor Green
    } else {
        Write-Host "  $($s.warnPermanent)" -ForegroundColor Yellow
        $fileOk = $false
    }

    if ($fileOk) {
        $patchedCount++
        $installedChannels += $channel
    } else {
        $errors++
        $installedChannels += $channel
    }
}

Write-Host ""
if ($patchedCount -eq 0 -and $errors -eq 0) {
    Write-Host $s.noConfig -ForegroundColor Red
    exit 1
}

Write-Host ($s.donePatched -f $patchedCount, $errors) -ForegroundColor Green
Write-Host ""

if ($installedChannels.Count -gt 0) {
    $availableChannels = $installedChannels | Where-Object { Test-Path $_.ExePath }

    if ($availableChannels.Count -eq 0) {
        Write-Host $s.noExe -ForegroundColor Yellow
        Write-Host ""
        foreach ($channel in $installedChannels) {
            Write-Host "   [$($channel.Name)]" -ForegroundColor White
            Write-Host "   & '$($channel.ExePath)' --enable-features=Glic --force-variations-country=US" -ForegroundColor Yellow
            Write-Host ""
        }
        exit 0
    }

    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  $($s.patchSuccess)" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "$($s.beforeLaunch)" -ForegroundColor Yellow
    Write-Host "  $($s.checkVpn1)" -ForegroundColor White
    Write-Host "  $($s.checkVpn2)" -ForegroundColor White
    Write-Host ""

    $confirmation = Read-Host $s.vpnConfirm

    if ($confirmation -eq "exit") {
        Write-Host ""
        Write-Host "$($s.exiting)" -ForegroundColor Yellow
        Write-Host ""
        foreach ($channel in $availableChannels) {
            Write-Host "   [$($channel.Name)]" -ForegroundColor White
            Write-Host "   & '$($channel.ExePath)' --enable-features=Glic --force-variations-country=US" -ForegroundColor DarkGray
            Write-Host ""
        }
        exit 0
    }

    Write-Host ""
    Write-Host "$($s.applyingPatch)" -ForegroundColor Cyan
    Write-Host ""

    foreach ($channel in $availableChannels) {
        Write-Host "$($s.processing) $($channel.Name)..." -ForegroundColor Cyan
        try {
            $process = Start-Process -FilePath $channel.ExePath -ArgumentList "--enable-features=Glic", "--force-variations-country=US" -PassThru
            Write-Host "  ✓ $($channel.Name) $($s.launched)" -ForegroundColor Green

            Write-Host "  $($s.waiting)" -ForegroundColor Yellow
            Start-Sleep -Seconds 3

            if (!$process.HasExited) {
                Stop-Process -Id $process.Id -Force -ErrorAction SilentlyContinue
                Start-Sleep -Seconds 1
                Get-Process -Name "chrome" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
                Write-Host "  ✓ $($channel.Name) $($s.closed)" -ForegroundColor Green
            }
        }
        catch {
            Write-Host "  $($s.failedProcess) $($channel.Name): $_" -ForegroundColor Red
        }
        Write-Host ""
    }

    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  ✓ $($s.patchSuccess)" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "$($s.allConfigured)" -ForegroundColor White
    Write-Host "$($s.useNormally)" -ForegroundColor White
    Write-Host ""

    $launchChoice = Read-Host $s.pressOne

    if ($launchChoice -eq "1") {
        Write-Host ""

        if ($availableChannels.Count -eq 1) {
            $channel = $availableChannels[0]
            Write-Host "$($s.starting) $($channel.Name)..." -ForegroundColor Cyan
            try {
                Start-Process -FilePath $channel.ExePath
                Write-Host "✓ $($channel.Name) $($s.startedSuccess)" -ForegroundColor Green
            }
            catch {
                Write-Host "$($s.failedLaunch) $_" -ForegroundColor Red
            }
        }
        else {
            Write-Host "$($s.selectChannel)" -ForegroundColor Cyan
            Write-Host ""

            for ($i = 0; $i -lt $availableChannels.Count; $i++) {
                Write-Host "  [$($i + 1)] $($availableChannels[$i].Name)" -ForegroundColor White
            }
            Write-Host ""

            $channelChoice = Read-Host $s.enterNumber

            if ($channelChoice -match '^\d+$') {
                $index = [int]$channelChoice - 1
                if ($index -ge 0 -and $index -lt $availableChannels.Count) {
                    $channel = $availableChannels[$index]
                    Write-Host ""
                    Write-Host "$($s.starting) $($channel.Name)..." -ForegroundColor Cyan
                    try {
                        Start-Process -FilePath $channel.ExePath
                        Write-Host "✓ $($channel.Name) $($s.startedSuccess)" -ForegroundColor Green
                    }
                    catch {
                        Write-Host "$($s.failedLaunch) $_" -ForegroundColor Red
                    }
                }
                else {
                    Write-Host "$($s.invalidSelection)" -ForegroundColor Red
                }
            }
            else {
                Write-Host "$($s.invalidInput)" -ForegroundColor Red
            }
        }
    }

    Write-Host ""
    Write-Host "$($s.enjoyGemini)" -ForegroundColor Cyan
}
