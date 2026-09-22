#!/bin/bash
# Enable Gemini in Chrome - Multi-Channel / Multilingual
# Patches all Chrome channels, clears variations cache, auto-detects language
# Author: Oleksandr Drozd <dev.drozd@gmail.com>

# Detect system language
LANG_CODE="${LANG:0:2}"

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    echo "Unsupported OS"
    exit 1
fi

# Language strings
declare -A strings_en=(
    [title]="Gemini in Chrome Enabler"
    [chromeRunning]="Chrome is running. Closing all Chrome processes..."
    [chromeClosed]="✓ Chrome closed successfully."
    [chromeCloseFailed]="✗ Failed to close Chrome automatically."
    [closeManually]="Please close Chrome manually and press Enter to continue..."
    [chromeStillRunning]="Chrome is still running. Aborting."
    [foundBackups]="Found existing backups in ChromeGeminiBackup folder."
    [options]="Options:"
    [runPatch]="[1] Run patch (default)"
    [restoreBackup]="[2] Restore from backup"
    [choose]="Choose option (1 or 2)"
    [availableBackups]="Available backups:"
    [selectBackup]="Select backup to restore (number)"
    [restoring]="Restoring backup for Chrome"
    [closingChrome]="Closing Chrome..."
    [backupRestored]="✓ Backup restored"
    [cacheCleared]="✓ Cache cleared"
    [launching]="✓ Launching Chrome"
    [doneRestored]="Done! Backup restored and Chrome launched."
    [channelNotFound]="Channel not found. Exiting."
    [invalidSelection]="Invalid selection. Exiting."
    [invalidInput]="Invalid input. Exiting."
    [skipped]="Skipped (not found):"
    [processing]="Processing:"
    [backupCreated]="Backup created:"
    [deletedCache]="Deleted cache:"
    [glicEnabled]="is_glic_eligible enabled"
    [glicNotFound]="is_glic_eligible key not found (update Chrome)"
    [clearedSeeds]="Cleared variations seeds"
    [okGlic]="OK: is_glic_eligible = true"
    [warnGlic]="WARN: is_glic_eligible not changed"
    [okCountry]="OK: variations_country = us"
    [warnCountry]="WARN: variations_country not changed"
    [okPermanent]="OK: permanent_consistency_country = us"
    [warnPermanent]="WARN: permanent_consistency_country not changed"
    [noConfig]="No Chrome config found."
    [donePatched]="Done! Patched: %d, errors: %d"
    [noExe]="No Chrome executable found."
    [patchSuccess]="PATCH APPLIED SUCCESSFULLY!"
    [beforeLaunch]="BEFORE LAUNCHING:"
    [checkVpn1]="✓ Make sure your VPN is connected to a US server"
    [checkVpn2]="✓ Verify your VPN connection is active"
    [vpnConfirm]="VPN enabled? Press Enter to continue (or type 'exit' to quit)"
    [exiting]="Exiting."
    [applyingPatch]="Applying patch to Chrome channels..."
    [launched]="launched"
    [waiting]="Waiting 3 seconds for feature registration..."
    [closed]="closed"
    [failedProcess]="✗ Failed to process"
    [allConfigured]="All Chrome channels have been configured."
    [useNormally]="You can now use Chrome normally with Gemini enabled."
    [pressOne]="Press [1] to launch Chrome now, or any other key to exit"
    [selectChannel]="Select Chrome channel to launch:"
    [enterNumber]="Enter number"
    [starting]="Launching"
    [startedSuccess]="started successfully"
    [failedLaunch]="✗ Failed to launch:"
    [enjoyGemini]="Done! Enjoy Gemini in Chrome."
)

declare -A strings_ru=(
    [title]="Активатор Gemini для Chrome"
    [chromeRunning]="Chrome запущен. Закрытие всех процессов Chrome..."
    [chromeClosed]="✓ Chrome успешно закрыт."
    [chromeCloseFailed]="✗ Не удалось закрыть Chrome автоматически."
    [closeManually]="Закройте Chrome вручную и нажмите Enter для продолжения..."
    [chromeStillRunning]="Chrome всё ещё запущен. Прерывание работы."
    [foundBackups]="Найдены существующие резервные копии в папке ChromeGeminiBackup."
    [options]="Варианты:"
    [runPatch]="[1] Запустить патч (по умолчанию)"
    [restoreBackup]="[2] Восстановить из резервной копии"
    [choose]="Выберите вариант (1 или 2)"
    [availableBackups]="Доступные резервные копии:"
    [selectBackup]="Выберите резервную копию для восстановления (номер)"
    [restoring]="Восстановление резервной копии для Chrome"
    [closingChrome]="Закрытие Chrome..."
    [backupRestored]="✓ Резервная копия восстановлена"
    [cacheCleared]="✓ Кэш очищен"
    [launching]="✓ Запуск Chrome"
    [doneRestored]="Готово! Резервная копия восстановлена и Chrome запущен."
    [channelNotFound]="Канал не найден. Выход."
    [invalidSelection]="Неверный выбор. Выход."
    [invalidInput]="Неверный ввод. Выход."
    [skipped]="Пропущен (не найден):"
    [processing]="Обработка:"
    [backupCreated]="Резервная копия создана:"
    [deletedCache]="Удалён кэш:"
    [glicEnabled]="is_glic_eligible включён"
    [glicNotFound]="Ключ is_glic_eligible не найден (обновите Chrome)"
    [clearedSeeds]="Очищены variations seeds"
    [okGlic]="OK: is_glic_eligible = true"
    [warnGlic]="ВНИМАНИЕ: is_glic_eligible не изменён"
    [okCountry]="OK: variations_country = us"
    [warnCountry]="ВНИМАНИЕ: variations_country не изменён"
    [okPermanent]="OK: permanent_consistency_country = us"
    [warnPermanent]="ВНИМАНИЕ: permanent_consistency_country не изменён"
    [noConfig]="Конфигурация Chrome не найдена."
    [donePatched]="Готово! Пропатчено: %d, ошибок: %d"
    [noExe]="Исполняемый файл Chrome не найден."
    [patchSuccess]="ПАТЧ УСПЕШНО ПРИМЕНЁН!"
    [beforeLaunch]="ПЕРЕД ЗАПУСКОМ:"
    [checkVpn1]="✓ Убедитесь что VPN подключен к серверу США"
    [checkVpn2]="✓ Проверьте что VPN-соединение активно"
    [vpnConfirm]="VPN включен? Нажмите Enter для продолжения (или введите 'exit' для выхода)"
    [exiting]="Выход."
    [applyingPatch]="Применение патча к каналам Chrome..."
    [launched]="запущен"
    [waiting]="Ожидание 3 секунды для регистрации функций..."
    [closed]="закрыт"
    [failedProcess]="✗ Не удалось обработать"
    [allConfigured]="Все каналы Chrome настроены."
    [useNormally]="Теперь вы можете использовать Chrome с включенным Gemini."
    [pressOne]="Нажмите [1] для запуска Chrome, или любую другую клавишу для выхода"
    [selectChannel]="Выберите канал Chrome для запуска:"
    [enterNumber]="Введите номер"
    [starting]="Запуск"
    [startedSuccess]="успешно запущен"
    [failedLaunch]="✗ Не удалось запустить:"
    [enjoyGemini]="Готово! Наслаждайтесь Gemini в Chrome."
)

# Select language
case "$LANG_CODE" in
    ru) declare -n s=strings_ru ;;
    *) declare -n s=strings_en ;;
esac

echo ""
echo "${s[title]}"
echo ""

# Define Chrome paths based on OS
if [ "$OS" = "macos" ]; then
    CHROME_PATHS=(
        "$HOME/Library/Application Support/Google/Chrome"
        "$HOME/Library/Application Support/Google/Chrome Beta"
        "$HOME/Library/Application Support/Google/Chrome Dev"
        "$HOME/Library/Application Support/Google/Chrome Canary"
    )
    CHROME_EXES=(
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
        "/Applications/Google Chrome Beta.app/Contents/MacOS/Google Chrome Beta"
        "/Applications/Google Chrome Dev.app/Contents/MacOS/Google Chrome Dev"
        "/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary"
    )
    CHROME_NAMES=("Stable" "Beta" "Dev" "Canary")
else
    # Linux
    CHROME_PATHS=(
        "$HOME/.config/google-chrome"
        "$HOME/.config/google-chrome-beta"
        "$HOME/.config/google-chrome-unstable"
    )
    CHROME_EXES=(
        "/usr/bin/google-chrome"
        "/usr/bin/google-chrome-beta"
        "/usr/bin/google-chrome-unstable"
    )
    CHROME_NAMES=("Stable" "Beta" "Unstable")
fi

# Backup directory
BACKUP_DIR="$HOME/ChromeGeminiBackup"

# Check for existing backups
if [ -d "$BACKUP_DIR" ] && [ "$(ls -A "$BACKUP_DIR"/*.bak 2>/dev/null)" ]; then
    echo "${s[foundBackups]}"
    echo ""
    echo "${s[options]}"
    echo "  ${s[runPatch]}"
    echo "  ${s[restoreBackup]}"
    echo ""
    read -p "${s[choose]}: " backup_choice

    if [ "$backup_choice" = "2" ]; then
        echo ""
        echo "${s[availableBackups]}"
        echo ""

        backups=("$BACKUP_DIR"/*.bak)
        for i in "${!backups[@]}"; do
            backup="${backups[$i]}"
            filename=$(basename "$backup")
            echo "  [$((i+1))] $filename"
        done

        echo ""
        read -p "${s[selectBackup]}: " restore_choice

        if [[ "$restore_choice" =~ ^[0-9]+$ ]] && [ "$restore_choice" -ge 1 ] && [ "$restore_choice" -le "${#backups[@]}" ]; then
            selected_backup="${backups[$((restore_choice-1))]}"
            filename=$(basename "$selected_backup")

            # Extract channel name from filename
            if [[ "$filename" =~ Local_State_([^_]+)_ ]]; then
                channel_name="${BASH_REMATCH[1]}"

                # Find matching channel
                for i in "${!CHROME_NAMES[@]}"; do
                    if [ "${CHROME_NAMES[$i]}" = "$channel_name" ]; then
                        chrome_path="${CHROME_PATHS[$i]}"
                        chrome_exe="${CHROME_EXES[$i]}"

                        echo ""
                        echo "${s[restoring]} $channel_name..."

                        # Close Chrome
                        pkill -f "Chrome" 2>/dev/null
                        sleep 2

                        # Restore backup
                        cp "$selected_backup" "$chrome_path/Local State"
                        echo "${s[backupRestored]}"

                        # Clear cache
                        rm -rf "$chrome_path/Variations" 2>/dev/null
                        rm -rf "$chrome_path/Variations Safe" 2>/dev/null
                        rm -f "$chrome_path/VariationsSeedV2" 2>/dev/null
                        rm -f "$chrome_path/VariationsSafeSeedV2" 2>/dev/null
                        echo "${s[cacheCleared]}"

                        # Launch Chrome
                        if [ -f "$chrome_exe" ]; then
                            "$chrome_exe" &>/dev/null &
                            echo "${s[launching]} $channel_name..."
                        fi

                        echo ""
                        echo "${s[doneRestored]}"
                        exit 0
                    fi
                done
            fi

            echo "${s[channelNotFound]}"
            exit 1
        else
            echo "${s[invalidInput]}"
            exit 1
        fi
    fi
    echo ""
fi

# Close Chrome if running
if pgrep -f "Chrome" > /dev/null; then
    echo "${s[chromeRunning]}"
    pkill -f "Chrome" 2>/dev/null
    sleep 2

    if pgrep -f "Chrome" > /dev/null; then
        echo "${s[chromeCloseFailed]}"
        read -p "${s[closeManually]}"

        if pgrep -f "Chrome" > /dev/null; then
            echo "${s[chromeStillRunning]}"
            exit 1
        fi
    else
        echo "${s[chromeClosed]}"
    fi
    echo ""
fi

# Process channels
patched_count=0
errors=0
available_channels=()

for i in "${!CHROME_PATHS[@]}"; do
    chrome_path="${CHROME_PATHS[$i]}"
    chrome_exe="${CHROME_EXES[$i]}"
    channel_name="${CHROME_NAMES[$i]}"
    local_state="$chrome_path/Local State"

    if [ ! -f "$local_state" ]; then
        echo "${s[skipped]} $channel_name"
        continue
    fi

    echo ""
    echo "${s[processing]} $channel_name"

    # Create backup
    mkdir -p "$BACKUP_DIR"
    timestamp=$(date +"%Y%m%d_%H%M%S")
    backup_file="$BACKUP_DIR/Local_State_${channel_name}_${timestamp}.bak"
    cp "$local_state" "$backup_file"
    echo "  ${s[backupCreated]} $backup_file"

    # Clear cache
    rm -rf "$chrome_path/Variations" 2>/dev/null
    rm -rf "$chrome_path/Variations Safe" 2>/dev/null
    rm -f "$chrome_path/VariationsSeedV2" 2>/dev/null
    rm -f "$chrome_path/VariationsSafeSeedV2" 2>/dev/null
    echo "  ${s[deletedCache]} Variations"

    # Patch Local State
    if command -v python3 &>/dev/null; then
        python3 << 'EOF' "$local_state"
import json
import sys

file_path = sys.argv[1]

with open(file_path, 'r', encoding='utf-8') as f:
    data = json.load(f)

# Update settings
if 'variations_seed_version' in data:
    data['variations_country'] = 'us'
    if 'variations_permanent_consistency_country' in data:
        data['variations_permanent_consistency_country'] = ['us']
    if 'is_glic_eligible' in data:
        data['is_glic_eligible'] = True

    # Clear seeds
    data.pop('variations_compressed_seed', None)
    data.pop('variations_seed_signature', None)
    data.pop('variations_compressed_seed_v2', None)
    data.pop('variations_seed_signature_v2', None)

with open(file_path, 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
EOF

        echo "  ${s[glicEnabled]}"
        echo "  ${s[clearedSeeds]}"

        # Verify
        if grep -q '"is_glic_eligible": true' "$local_state" 2>/dev/null; then
            echo "  ${s[okGlic]}"
        else
            echo "  ${s[warnGlic]}"
        fi

        if grep -q '"variations_country": "us"' "$local_state" 2>/dev/null; then
            echo "  ${s[okCountry]}"
        else
            echo "  ${s[warnCountry]}"
        fi

        patched_count=$((patched_count + 1))

        if [ -f "$chrome_exe" ]; then
            available_channels+=("$i")
        fi
    else
        echo "  Python3 not found. Skipping patch."
        errors=$((errors + 1))
    fi
done

echo ""
if [ $patched_count -eq 0 ] && [ $errors -eq 0 ]; then
    echo "${s[noConfig]}"
    exit 1
fi

printf "${s[donePatched]}\n" "$patched_count" "$errors"
echo ""

if [ ${#available_channels[@]} -eq 0 ]; then
    echo "${s[noExe]}"
    exit 0
fi

echo "========================================"
echo "  ${s[patchSuccess]}"
echo "========================================"
echo ""
echo "${s[beforeLaunch]}"
echo "  ${s[checkVpn1]}"
echo "  ${s[checkVpn2]}"
echo ""

read -p "${s[vpnConfirm]}: " confirmation

if [ "$confirmation" = "exit" ]; then
    echo ""
    echo "${s[exiting]}"
    exit 0
fi

echo ""
echo "${s[applyingPatch]}"
echo ""

for idx in "${available_channels[@]}"; do
    chrome_exe="${CHROME_EXES[$idx]}"
    channel_name="${CHROME_NAMES[$idx]}"

    echo "${s[processing]} $channel_name..."

    if [ -f "$chrome_exe" ]; then
        "$chrome_exe" --enable-features=Glic --force-variations-country=US &>/dev/null &
        chrome_pid=$!
        echo "  ✓ $channel_name ${s[launched]}"

        echo "  ${s[waiting]}"
        sleep 3

        if kill -0 $chrome_pid 2>/dev/null; then
            kill $chrome_pid 2>/dev/null
            sleep 1
            pkill -P $chrome_pid 2>/dev/null
            echo "  ✓ $channel_name ${s[closed]}"
        fi
    fi
    echo ""
done

echo "========================================"
echo "  ✓ ${s[patchSuccess]}"
echo "========================================"
echo ""
echo "${s[allConfigured]}"
echo "${s[useNormally]}"
echo ""

read -p "${s[pressOne]}: " launch_choice

if [ "$launch_choice" = "1" ]; then
    echo ""

    if [ ${#available_channels[@]} -eq 1 ]; then
        idx="${available_channels[0]}"
        chrome_exe="${CHROME_EXES[$idx]}"
        channel_name="${CHROME_NAMES[$idx]}"

        echo "${s[starting]} $channel_name..."
        "$chrome_exe" &>/dev/null &
        echo "✓ $channel_name ${s[startedSuccess]}"
    else
        echo "${s[selectChannel]}"
        echo ""

        for i in "${!available_channels[@]}"; do
            idx="${available_channels[$i]}"
            channel_name="${CHROME_NAMES[$idx]}"
            echo "  [$((i+1))] $channel_name"
        done
        echo ""

        read -p "${s[enterNumber]}: " channel_choice

        if [[ "$channel_choice" =~ ^[0-9]+$ ]] && [ "$channel_choice" -ge 1 ] && [ "$channel_choice" -le "${#available_channels[@]}" ]; then
            idx="${available_channels[$((channel_choice-1))]}"
            chrome_exe="${CHROME_EXES[$idx]}"
            channel_name="${CHROME_NAMES[$idx]}"

            echo ""
            echo "${s[starting]} $channel_name..."
            "$chrome_exe" &>/dev/null &
            echo "✓ $channel_name ${s[startedSuccess]}"
        else
            echo "${s[invalidInput]}"
        fi
    fi
fi

echo ""
echo "${s[enjoyGemini]}"
