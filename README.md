{
    "chunks": [
        {
            "type": "txt",
            "chunk_number": 1,
            "lines": [
                {
                    "line_number": 1,
                    "text": "# --- Stap 0.1: Controleer of script als administrator draait ---"
                },
                {
                    "line_number": 2,
                    "text": "if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] \"Administrator\")) {"
                },
                {
                    "line_number": 3,
                    "text": "$arguments = \"-ExecutionPolicy Bypass -File `\"$PSCommandPath`\"\""
                },
                {
                    "line_number": 4,
                    "text": "Start-Process powershell -ArgumentList $arguments -Verb RunAs"
                },
                {
                    "line_number": 5,
                    "text": "exit"
                },
                {
                    "line_number": 6,
                    "text": "}"
                },
                {
                    "line_number": 7,
                    "text": ""
                },
                {
                    "line_number": 8,
                    "text": "# --- Stap 0.1b: Logging starten ---"
                },
                {
                    "line_number": 9,
                    "text": "$outputLogsPath = [System.IO.Path]::Combine([Environment]::GetFolderPath(\"Desktop\"), \"output logs\")"
                },
                {
                    "line_number": 10,
                    "text": "if (-not (Test-Path $outputLogsPath)) {"
                },
                {
                    "line_number": 11,
                    "text": "New-Item -Path $outputLogsPath -ItemType Directory | Out-Null"
                },
                {
                    "line_number": 12,
                    "text": "}"
                },
                {
                    "line_number": 13,
                    "text": "$logFile = Join-Path $outputLogsPath (\"Output_WU_Install_Check_{0}.txt\" -f (Get-Date -Format 'dd-MM-yyyy_HHmmss'))"
                },
                {
                    "line_number": 14,
                    "text": "Function Log {"
                },
                {
                    "line_number": 15,
                    "text": "param ([string]$message)"
                },
                {
                    "line_number": 16,
                    "text": "$timestamp = Get-Date -Format \"dd-MM-yyyy_HHmms\""
                },
                {
                    "line_number": 17,
                    "text": "\"$timestamp - $message\" | Tee-Object -FilePath $logFile -Append"
                },
                {
                    "line_number": 18,
                    "text": "}"
                },
                {
                    "line_number": 19,
                    "text": "Log \"Script gestart door gebruiker: $env:USERNAME\""
                },
                {
                    "line_number": 20,
                    "text": "Log \"Systeemnaam: $env:COMPUTERNAME\""
                },
                {
                    "line_number": 21,
                    "text": "Log \"Besturingssysteem: $((Get-CimInstance Win32_OperatingSystem).Caption)\""
                },
                {
                    "line_number": 22,
                    "text": ""
                },
                {
                    "line_number": 23,
                    "text": "# --- Stap 0.2: Controleer netwerkverbinding met Microsoft ---"
                },
                {
                    "line_number": 24,
                    "text": "$targetHost = \"www.microsoft.com\""
                },
                {
                    "line_number": 25,
                    "text": "Log \"Controleren of $targetHost bereikbaar is...\""
                },
                {
                    "line_number": 26,
                    "text": "try {"
                },
                {
                    "line_number": 27,
                    "text": "$pingResult = Test-Connection -ComputerName $targetHost -Count 2 -Quiet -ErrorAction Stop"
                },
                {
                    "line_number": 28,
                    "text": "if ($pingResult) {"
                },
                {
                    "line_number": 29,
                    "text": "Log \"$targetHost is bereikbaar.\""
                },
                {
                    "line_number": 30,
                    "text": "} else {"
                },
                {
                    "line_number": 31,
                    "text": "Log \"Waarschuwing: $targetHost is NIET bereikbaar. Mogelijk netwerkprobleem.\""
                },
                {
                    "line_number": 32,
                    "text": "}"
                },
                {
                    "line_number": 33,
                    "text": "} catch {"
                },
                {
                    "line_number": 34,
                    "text": "Log \"Fout bij het testen van netwerkverbinding: $_\""
                },
                {
                    "line_number": 35,
                    "text": "}"
                },
                {
                    "line_number": 36,
                    "text": ""
                },
                {
                    "line_number": 37,
                    "text": "# --- Stap 1: Controleer ExecutionPolicy ---"
                },
                {
                    "line_number": 38,
                    "text": "$currentPolicy = Get-ExecutionPolicy -Scope CurrentUser"
                },
                {
                    "line_number": 39,
                    "text": "$requiredPolicy = \"RemoteSigned\""
                },
                {
                    "line_number": 40,
                    "text": "if ($currentPolicy -ne $requiredPolicy) {"
                },
                {
                    "line_number": 41,
                    "text": "Log \"Huidige ExecutionPolicy is '$currentPolicy'.\""
                },
                {
                    "line_number": 42,
                    "text": "$changePolicy = Read-Host \"ExecutionPolicy is '$currentPolicy'. Aanpassen naar '$requiredPolicy'? (ja/nee)\""
                },
                {
                    "line_number": 43,
                    "text": "if ($changePolicy.ToLower() -eq \"ja\") {"
                },
                {
                    "line_number": 44,
                    "text": "Set-ExecutionPolicy -ExecutionPolicy $requiredPolicy -Scope CurrentUser -Force"
                },
                {
                    "line_number": 45,
                    "text": "Log \"ExecutionPolicy aangepast naar '$requiredPolicy'.\""
                },
                {
                    "line_number": 46,
                    "text": "} else {"
                },
                {
                    "line_number": 47,
                    "text": "Log \"Gebruiker heeft geweigerd ExecutionPolicy aan te passen. Script wordt gestopt.\""
                },
                {
                    "line_number": 48,
                    "text": "exit"
                },
                {
                    "line_number": 49,
                    "text": "}"
                },
                {
                    "line_number": 50,
                    "text": "} else {"
                },
                {
                    "line_number": 51,
                    "text": "Log \"ExecutionPolicy is correct ingesteld op '$requiredPolicy'.\""
                },
                {
                    "line_number": 52,
                    "text": "}"
                },
                {
                    "line_number": 53,
                    "text": ""
                },
                {
                    "line_number": 54,
                    "text": "# --- Stap 2: Controleer of NuGet beschikbaar is ---"
                },
                {
                    "line_number": 55,
                    "text": "if (-not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {"
                },
                {
                    "line_number": 56,
                    "text": "Log \"NuGet niet gevonden. Installatie wordt gestart...\""
                },
                {
                    "line_number": 57,
                    "text": "try {"
                },
                {
                    "line_number": 58,
                    "text": "Install-PackageProvider -Name NuGet -Force"
                },
                {
                    "line_number": 59,
                    "text": "Log \"NuGet ge\u00efnstalleerd.\""
                },
                {
                    "line_number": 60,
                    "text": "} catch {"
                },
                {
                    "line_number": 61,
                    "text": "Log \"Fout bij installatie van NuGet: $_\""
                },
                {
                    "line_number": 62,
                    "text": "exit"
                },
                {
                    "line_number": 63,
                    "text": "}"
                },
                {
                    "line_number": 64,
                    "text": "} else {"
                },
                {
                    "line_number": 65,
                    "text": "Log \"NuGet is al aanwezig.\""
                },
                {
                    "line_number": 66,
                    "text": "}"
                },
                {
                    "line_number": 67,
                    "text": ""
                },
                {
                    "line_number": 68,
                    "text": "# --- Stap 3: Controleer of Windows Update Module al aanwezig is ---"
                },
                {
                    "line_number": 69,
                    "text": "if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {"
                },
                {
                    "line_number": 70,
                    "text": "Log \"Windows Update Module niet gevonden. Installatie wordt gestart...\""
                },
                {
                    "line_number": 71,
                    "text": "try {"
                },
                {
                    "line_number": 72,
                    "text": "Install-Module -Name PSWindowsUpdate -Force"
                },
                {
                    "line_number": 73,
                    "text": "Log \"Windows Update Module ge\u00efnstalleerd.\""
                },
                {
                    "line_number": 74,
                    "text": "} catch {"
                },
                {
                    "line_number": 75,
                    "text": "Log \"Fout bij installatie van Windows Update Module: $_\""
                },
                {
                    "line_number": 76,
                    "text": "exit"
                },
                {
                    "line_number": 77,
                    "text": "}"
                },
                {
                    "line_number": 78,
                    "text": "} else {"
                },
                {
                    "line_number": 79,
                    "text": "Log \"Windows Update Module is al aanwezig.\""
                },
                {
                    "line_number": 80,
                    "text": "}"
                },
                {
                    "line_number": 81,
                    "text": ""
                },
                {
                    "line_number": 82,
                    "text": "# --- Stap 4: Importeer de module met foutafhandeling ---"
                },
                {
                    "line_number": 83,
                    "text": "try {"
                },
                {
                    "line_number": 84,
                    "text": "Import-Module PSWindowsUpdate -Force -ErrorAction Stop"
                },
                {
                    "line_number": 85,
                    "text": "Log \"Windows Update Module succesvol ge\u00efmporteerd.\""
                },
                {
                    "line_number": 86,
                    "text": "} catch {"
                },
                {
                    "line_number": 87,
                    "text": "Log \"Fout bij importeren van Windows Update Module: $_\""
                },
                {
                    "line_number": 88,
                    "text": "exit"
                },
                {
                    "line_number": 89,
                    "text": "}"
                },
                {
                    "line_number": 90,
                    "text": ""
                },
                {
                    "line_number": 91,
                    "text": "# --- Stap 5: Zoek updates en categoriseer ---"
                },
                {
                    "line_number": 92,
                    "text": "Log \"Zoeken naar beschikbare updates gestart...\""
                },
                {
                    "line_number": 93,
                    "text": "$updates = Get-WUList -MicrosoftUpdate"
                },
                {
                    "line_number": 94,
                    "text": "if (-not $updates) {"
                },
                {
                    "line_number": 95,
                    "text": "Log \"Geen updates gevonden.\""
                },
                {
                    "line_number": 96,
                    "text": "Write-Host \"Geen updates gevonden.\""
                },
                {
                    "line_number": 97,
                    "text": "exit"
                },
                {
                    "line_number": 98,
                    "text": "}"
                },
                {
                    "line_number": 99,
                    "text": ""
                },
                {
                    "line_number": 100,
                    "text": "# Categoriseer updates"
                },
                {
                    "line_number": 101,
                    "text": "$cumulativeUpdates = $updates | Where-Object { $_.Title -match 'Cumulatieve update|Cumulative Update' }"
                },
                {
                    "line_number": 102,
                    "text": "$securityUpdates   = $updates | Where-Object { $_.Title -match 'Beveiligingsupdate|Security Update|beveiligingsinformatie' }"
                },
                {
                    "line_number": 103,
                    "text": "$driverUpdates     = $updates | Where-Object { $_.Title -match 'Stuurprogramma|Driver' }"
                },
                {
                    "line_number": 104,
                    "text": "$featureUpdates    = $updates | Where-Object { $_.Title -match 'Feature update|Functie-update' }"
                },
                {
                    "line_number": 105,
                    "text": "$previewUpdates    = $updates | Where-Object { $_.Title -match 'Preview' }"
                },
                {
                    "line_number": 106,
                    "text": "$definitionUpdates = $updates | Where-Object { $_.Title -match 'Definitie-update|Definition Update' }"
                },
                {
                    "line_number": 107,
                    "text": "$ssuUpdates        = $updates | Where-Object { $_.Title -match 'Servicing Stack Update|SSU' }"
                },
                {
                    "line_number": 108,
                    "text": "$otherUpdates       = $updates | Where-Object {"
                },
                {
                    "line_number": 109,
                    "text": "$_.Title -notmatch 'Cumulatieve update|Cumulative Update|Beveiligingsupdate|Security Update|Stuurprogramma|Driver|Feature update|Functie-update|Preview|Definitie-update|Definition Update|Servicing Stack Update|SSU|beveiligingsinformatie|'"
                },
                {
                    "line_number": 110,
                    "text": "}"
                },
                {
                    "line_number": 111,
                    "text": ""
                },
                {
                    "line_number": 112,
                    "text": "# Logging bij categorisatie"
                },
                {
                    "line_number": 113,
                    "text": "Log \"Aantal gevonden updates: $($updates.Count)\""
                },
                {
                    "line_number": 114,
                    "text": "Log \"Aantal cumulatieve updates: $($cumulativeUpdates.Count)\""
                },
                {
                    "line_number": 115,
                    "text": "Log \"Aantal beveiligingsupdates: $($securityUpdates.Count)\""
                },
                {
                    "line_number": 116,
                    "text": "Log \"Aantal driver-updates: $($driverUpdates.Count)\""
                },
                {
                    "line_number": 117,
                    "text": "Log \"Aantal feature-updates: $($featureUpdates.Count)\""
                },
                {
                    "line_number": 118,
                    "text": "Log \"Aantal preview-updates: $($previewUpdates.Count)\""
                },
                {
                    "line_number": 119,
                    "text": "Log \"Aantal definitie-updates: $($definitionUpdates.Count)\""
                },
                {
                    "line_number": 120,
                    "text": "Log \"Aantal servicing stack-updates: $($ssuUpdates.Count)\""
                },
                {
                    "line_number": 121,
                    "text": "Log \"Aantal overige updates: $($otherUpdates.Count)\""
                },
                {
                    "line_number": 122,
                    "text": ""
                },
                {
                    "line_number": 123,
                    "text": "# Overzicht van alle gevonden updates"
                },
                {
                    "line_number": 124,
                    "text": "foreach ($u in $updates) {"
                },
                {
                    "line_number": 125,
                    "text": "Log \"Update gevonden: $($u.Title) (KB: $($u.KBArticleIDs -join ', '))\""
                },
                {
                    "line_number": 126,
                    "text": "}"
                },
                {
                    "line_number": 127,
                    "text": ""
                },
                {
                    "line_number": 128,
                    "text": "# --- Stap 6: Keuzemenu ---"
                },
                {
                    "line_number": 129,
                    "text": "Write-Host \"`n\ud83d\udce6 Updateoverzicht:\""
                },
                {
                    "line_number": 130,
                    "text": "Write-Host \"1. Cumulatieve updates: $($cumulativeUpdates.Count)\""
                },
                {
                    "line_number": 131,
                    "text": "Write-Host \"2. Beveiligingsupdates: $($securityUpdates.Count)\""
                },
                {
                    "line_number": 132,
                    "text": "Write-Host \"3. Driver-updates:      $($driverUpdates.Count)\""
                },
                {
                    "line_number": 133,
                    "text": "Write-Host \"4. Feature-updates:     $($featureUpdates.Count)\""
                },
                {
                    "line_number": 134,
                    "text": "Write-Host \"5. Preview-updates:     $($previewUpdates.Count)\""
                },
                {
                    "line_number": 135,
                    "text": "Write-Host \"6. Definitie-updates:   $($definitionUpdates.Count)\""
                },
                {
                    "line_number": 136,
                    "text": "Write-Host \"7. Servicing Stack:     $($ssuUpdates.Count)\""
                },
                {
                    "line_number": 137,
                    "text": "Write-Host \"8. Overige updates:     $($otherUpdates.Count)\""
                },
                {
                    "line_number": 138,
                    "text": "Write-Host \"9. Alles installeren\""
                },
                {
                    "line_number": 139,
                    "text": ""
                },
                {
                    "line_number": 140,
                    "text": "$selectie = Read-Host \"Welke categorie\u00ebn wil je installeren? (bijv. 1,2,4 of 9 voor alles)\""
                },
                {
                    "line_number": 141,
                    "text": "$selectedUpdates = @()"
                },
                {
                    "line_number": 142,
                    "text": "$selectedCategories = @()"
                },
                {
                    "line_number": 143,
                    "text": ""
                },
                {
                    "line_number": 144,
                    "text": "if ($selectie -eq '9') {"
                },
                {
                    "line_number": 145,
                    "text": "$selectedUpdates += $updates"
                },
                {
                    "line_number": 146,
                    "text": "$selectedCategories += 'Alles'"
                },
                {
                    "line_number": 147,
                    "text": "} else {"
                },
                {
                    "line_number": 148,
                    "text": "if ($selectie -match '1') { $selectedUpdates += $cumulativeUpdates; $selectedCategories += 'Cumulatieve updates' }"
                },
                {
                    "line_number": 149,
                    "text": "if ($selectie -match '2') { $selectedUpdates += $securityUpdates; $selectedCategories += 'Beveiligingsupdates' }"
                },
                {
                    "line_number": 150,
                    "text": "if ($selectie -match '3') { $selectedUpdates += $driverUpdates; $selectedCategories += 'Driver-updates' }"
                },
                {
                    "line_number": 151,
                    "text": "if ($selectie -match '4') { $selectedUpdates += $featureUpdates; $selectedCategories += 'Feature-updates' }"
                },
                {
                    "line_number": 152,
                    "text": "if ($selectie -match '5') { $selectedUpdates += $previewUpdates; $selectedCategories += 'Preview-updates' }"
                },
                {
                    "line_number": 153,
                    "text": "if ($selectie -match '6') { $selectedUpdates += $definitionUpdates; $selectedCategories += 'Definitie-updates' }"
                },
                {
                    "line_number": 154,
                    "text": "if ($selectie -match '7') { $selectedUpdates += $ssuUpdates; $selectedCategories += 'Servicing Stack-updates' }"
                },
                {
                    "line_number": 155,
                    "text": "if ($selectie -match '8') { $selectedUpdates += $otherUpdates; $selectedCategories += 'Overige updates' }"
                },
                {
                    "line_number": 156,
                    "text": "}"
                },
                {
                    "line_number": 157,
                    "text": ""
                },
                {
                    "line_number": 158,
                    "text": "Log \"Gebruiker heeft gekozen voor installatie van: $($selectedCategories -join ', ')\""
                },
                {
                    "line_number": 159,
                    "text": ""
                },
                {
                    "line_number": 160,
                    "text": "# --- Stap 7: Installeer geselecteerde updates ---"
                },
                {
                    "line_number": 161,
                    "text": "if ($selectedUpdates.Count -eq 0) {"
                },
                {
                    "line_number": 162,
                    "text": "Log \"Geen updates geselecteerd voor installatie.\""
                },
                {
                    "line_number": 163,
                    "text": "Write-Host \"Geen updates geselecteerd.\""
                },
                {
                    "line_number": 164,
                    "text": "exit"
                },
                {
                    "line_number": 165,
                    "text": "}"
                },
                {
                    "line_number": 166,
                    "text": ""
                },
                {
                    "line_number": 167,
                    "text": "$updateCount = $selectedUpdates.Count"
                },
                {
                    "line_number": 168,
                    "text": "for ($i = 0; $i -lt $updateCount; $i++) {"
                },
                {
                    "line_number": 169,
                    "text": "$update = $selectedUpdates[$i]"
                },
                {
                    "line_number": 170,
                    "text": "$percentComplete = [math]::Round(($i / $updateCount) * 100)"
                },
                {
                    "line_number": 171,
                    "text": "Write-Progress -Activity \"Updates installeren...\" -Status \"Bezig met: $($update.Title)\" -PercentComplete $percentComplete"
                },
                {
                    "line_number": 172,
                    "text": ""
                },
                {
                    "line_number": 173,
                    "text": "Log \"Bezig met installeren van update: $($update.Title) (KB: $($update.KBArticleIDs -join ', '))\""
                },
                {
                    "line_number": 174,
                    "text": "try {"
                },
                {
                    "line_number": 175,
                    "text": "$result = $update | Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot"
                },
                {
                    "line_number": 176,
                    "text": "if ($result) {"
                },
                {
                    "line_number": 177,
                    "text": "Log \"Installatie voltooid: $($update.Title)\""
                },
                {
                    "line_number": 178,
                    "text": "} else {"
                },
                {
                    "line_number": 179,
                    "text": "Log \"Installatie overgeslagen of mislukt: $($update.Title)\""
                },
                {
                    "line_number": 180,
                    "text": "}"
                },
                {
                    "line_number": 181,
                    "text": "} catch {"
                },
                {
                    "line_number": 182,
                    "text": "Log \"Fout bij installatie van $($update.Title): $_\""
                },
                {
                    "line_number": 183,
                    "text": "}"
                },
                {
                    "line_number": 184,
                    "text": "}"
                },
                {
                    "line_number": 185,
                    "text": "Write-Progress -Activity \"Updates installeren...\" -Completed"
                },
                {
                    "line_number": 186,
                    "text": ""
                },
                {
                    "line_number": 187,
                    "text": "# --- Stap 8: Vraag om herstart ---"
                },
                {
                    "line_number": 188,
                    "text": "$rebootRequired = $selectedUpdates | Where-Object { $_.RebootRequired -eq $true }"
                },
                {
                    "line_number": 189,
                    "text": "if ($rebootRequired.Count -gt 0) {"
                },
                {
                    "line_number": 190,
                    "text": "Log \"Voor \u00e9\u00e9n of meer ge\u00efnstalleerde updates is een herstart vereist.\""
                },
                {
                    "line_number": 191,
                    "text": "$reboot = Read-Host \"Er is een herstart vereist. Wil je nu opnieuw opstarten? (ja/nee)\""
                },
                {
                    "line_number": 192,
                    "text": "if ($reboot.ToLower() -eq \"ja\") {"
                },
                {
                    "line_number": 193,
                    "text": "Log \"Gebruiker kiest voor herstart. Systeem wordt opnieuw opgestart.\""
                },
                {
                    "line_number": 194,
                    "text": "Restart-Computer"
                },
                {
                    "line_number": 195,
                    "text": "} else {"
                },
                {
                    "line_number": 196,
                    "text": "Log \"Gebruiker heeft herstart overgeslagen.\""
                },
                {
                    "line_number": 197,
                    "text": "}"
                },
                {
                    "line_number": 198,
                    "text": "} else {"
                },
                {
                    "line_number": 199,
                    "text": "Log \"Geen herstart vereist voor ge\u00efnstalleerde updates.\""
                },
                {
                    "line_number": 200,
                    "text": "}"
                },
                {
                    "line_number": 201,
                    "text": ""
                },
                {
                    "line_number": 202,
                    "text": "Log \"Script voltooid. Logbestand opgeslagen op: $logFile\""
                },
                {
                    "line_number": 203,
                    "text": "Start-Process notepad.exe $logFile"
                }
            ],
            "token_count": 1035
        }
    ]
}
