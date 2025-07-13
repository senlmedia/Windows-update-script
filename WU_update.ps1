# --- Stap 0.1: Controleer of script als administrator draait ---
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $arguments = "-ExecutionPolicy Bypass -File `"$PSCommandPath`""
    Start-Process powershell -ArgumentList $arguments -Verb RunAs
    exit
}

# --- Stap 0.1b: Logging starten ---
$outputLogsPath = [System.IO.Path]::Combine([Environment]::GetFolderPath("Desktop"), "output logs")
if (-not (Test-Path $outputLogsPath)) {
    New-Item -Path $outputLogsPath -ItemType Directory | Out-Null
}
$logFile = Join-Path $outputLogsPath ("Output_WU_Install_Check_{0}.txt" -f (Get-Date -Format 'dd-MM-yyyy_HHmmss'))
Function Log {
    param ([string]$message)
    $timestamp = Get-Date -Format "dd-MM-yyyy_HHmms"
    "$timestamp - $message" | Tee-Object -FilePath $logFile -Append
}
Log "Script gestart door gebruiker: $env:USERNAME"
Log "Systeemnaam: $env:COMPUTERNAME"
Log "Besturingssysteem: $((Get-CimInstance Win32_OperatingSystem).Caption)"

# --- Stap 0.2: Controleer netwerkverbinding met Microsoft ---
$targetHost = "www.microsoft.com"
Log "Controleren of $targetHost bereikbaar is..."
try {
    $pingResult = Test-Connection -ComputerName $targetHost -Count 2 -Quiet -ErrorAction Stop
    if ($pingResult) {
        Log "$targetHost is bereikbaar."
    } else {
        Log "Waarschuwing: $targetHost is NIET bereikbaar. Mogelijk netwerkprobleem."
    }
} catch {
    Log "Fout bij het testen van netwerkverbinding: $_"
}

# --- Stap 1: Controleer ExecutionPolicy ---
$currentPolicy = Get-ExecutionPolicy -Scope CurrentUser
$requiredPolicy = "RemoteSigned"
if ($currentPolicy -ne $requiredPolicy) {
    Log "Huidige ExecutionPolicy is '$currentPolicy'."
    $changePolicy = Read-Host "ExecutionPolicy is '$currentPolicy'. Aanpassen naar '$requiredPolicy'? (ja/nee)"
    if ($changePolicy.ToLower() -eq "ja") {
        Set-ExecutionPolicy -ExecutionPolicy $requiredPolicy -Scope CurrentUser -Force
        Log "ExecutionPolicy aangepast naar '$requiredPolicy'."
    } else {
        Log "Gebruiker heeft geweigerd ExecutionPolicy aan te passen. Script wordt gestopt."
        exit
    }
} else {
    Log "ExecutionPolicy is correct ingesteld op '$requiredPolicy'."
}

# --- Stap 2: Controleer of NuGet beschikbaar is ---
if (-not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
    Log "NuGet niet gevonden. Installatie wordt gestart..."
    try {
        Install-PackageProvider -Name NuGet -Force
        Log "NuGet geïnstalleerd."
    } catch {
        Log "Fout bij installatie van NuGet: $_"
        exit
    }
} else {
    Log "NuGet is al aanwezig."
}

# --- Stap 3: Controleer of Windows Update Module al aanwezig is ---
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Log "Windows Update Module niet gevonden. Installatie wordt gestart..."
    try {
        Install-Module -Name PSWindowsUpdate -Force
        Log "Windows Update Module geïnstalleerd."
    } catch {
        Log "Fout bij installatie van Windows Update Module: $_"
        exit
    }
} else {
    Log "Windows Update Module is al aanwezig."
}

# --- Stap 4: Importeer de module met foutafhandeling ---
try {
    Import-Module PSWindowsUpdate -Force -ErrorAction Stop
    Log "Windows Update Module succesvol geïmporteerd."
} catch {
    Log "Fout bij importeren van Windows Update Module: $_"
    exit
}

# --- Stap 5: Zoek updates en categoriseer ---
Log "Zoeken naar beschikbare updates gestart..."
$updates = Get-WUList -MicrosoftUpdate
if (-not $updates) {
    Log "Geen updates gevonden."
    Write-Host "Geen updates gevonden."
    exit
}

# Categoriseer updates
$cumulativeUpdates = $updates | Where-Object { $_.Title -match 'Cumulatieve update|Cumulative Update' }
$securityUpdates   = $updates | Where-Object { $_.Title -match 'Beveiligingsupdate|Security Update|beveiligingsinformatie' }
$driverUpdates     = $updates | Where-Object { $_.Title -match 'Stuurprogramma|Driver' }
$featureUpdates    = $updates | Where-Object { $_.Title -match 'Feature update|Functie-update' }
$previewUpdates    = $updates | Where-Object { $_.Title -match 'Preview' }
$definitionUpdates = $updates | Where-Object { $_.Title -match 'Definitie-update|Definition Update' }
$ssuUpdates        = $updates | Where-Object { $_.Title -match 'Servicing Stack Update|SSU' }
$otherUpdates       = $updates | Where-Object {
    $_.Title -notmatch 'Cumulatieve update|Cumulative Update|Beveiligingsupdate|Security Update|Stuurprogramma|Driver|Feature update|Functie-update|Preview|Definitie-update|Definition Update|Servicing Stack Update|SSU|beveiligingsinformatie|'
}

# Logging bij categorisatie
Log "Aantal gevonden updates: $($updates.Count)"
Log "Aantal cumulatieve updates: $($cumulativeUpdates.Count)"
Log "Aantal beveiligingsupdates: $($securityUpdates.Count)"
Log "Aantal driver-updates: $($driverUpdates.Count)"
Log "Aantal feature-updates: $($featureUpdates.Count)"
Log "Aantal preview-updates: $($previewUpdates.Count)"
Log "Aantal definitie-updates: $($definitionUpdates.Count)"
Log "Aantal servicing stack-updates: $($ssuUpdates.Count)"
Log "Aantal overige updates: $($otherUpdates.Count)"

# Overzicht van alle gevonden updates
foreach ($u in $updates) {
    Log "Update gevonden: $($u.Title) (KB: $($u.KBArticleIDs -join ', '))"
}

# --- Stap 6: Keuzemenu ---
Write-Host "`n📦 Updateoverzicht:"
Write-Host "1. Cumulatieve updates: $($cumulativeUpdates.Count)"
Write-Host "2. Beveiligingsupdates: $($securityUpdates.Count)"
Write-Host "3. Driver-updates:      $($driverUpdates.Count)"
Write-Host "4. Feature-updates:     $($featureUpdates.Count)"
Write-Host "5. Preview-updates:     $($previewUpdates.Count)"
Write-Host "6. Definitie-updates:   $($definitionUpdates.Count)"
Write-Host "7. Servicing Stack:     $($ssuUpdates.Count)"
Write-Host "8. Overige updates:     $($otherUpdates.Count)"
Write-Host "9. Alles installeren"

$selectie = Read-Host "Welke categorieën wil je installeren? (bijv. 1,2,4 of 9 voor alles)"
$selectedUpdates = @()
$selectedCategories = @()

if ($selectie -eq '9') {
    $selectedUpdates += $updates
    $selectedCategories += 'Alles'
} else {
    if ($selectie -match '1') { $selectedUpdates += $cumulativeUpdates; $selectedCategories += 'Cumulatieve updates' }
    if ($selectie -match '2') { $selectedUpdates += $securityUpdates; $selectedCategories += 'Beveiligingsupdates' }
    if ($selectie -match '3') { $selectedUpdates += $driverUpdates; $selectedCategories += 'Driver-updates' }
    if ($selectie -match '4') { $selectedUpdates += $featureUpdates; $selectedCategories += 'Feature-updates' }
    if ($selectie -match '5') { $selectedUpdates += $previewUpdates; $selectedCategories += 'Preview-updates' }
    if ($selectie -match '6') { $selectedUpdates += $definitionUpdates; $selectedCategories += 'Definitie-updates' }
    if ($selectie -match '7') { $selectedUpdates += $ssuUpdates; $selectedCategories += 'Servicing Stack-updates' }
    if ($selectie -match '8') { $selectedUpdates += $otherUpdates; $selectedCategories += 'Overige updates' }
}

Log "Gebruiker heeft gekozen voor installatie van: $($selectedCategories -join ', ')"

# --- Stap 7: Installeer geselecteerde updates ---
if ($selectedUpdates.Count -eq 0) {
    Log "Geen updates geselecteerd voor installatie."
    Write-Host "Geen updates geselecteerd."
    exit
}

$updateCount = $selectedUpdates.Count
for ($i = 0; $i -lt $updateCount; $i++) {
    $update = $selectedUpdates[$i]
    $percentComplete = [math]::Round(($i / $updateCount) * 100)
    Write-Progress -Activity "Updates installeren..." -Status "Bezig met: $($update.Title)" -PercentComplete $percentComplete

    Log "Bezig met installeren van update: $($update.Title) (KB: $($update.KBArticleIDs -join ', '))"
    try {
        $result = $update | Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot
        if ($result) {
            Log "Installatie voltooid: $($update.Title)"
        } else {
            Log "Installatie overgeslagen of mislukt: $($update.Title)"
        }
    } catch {
        Log "Fout bij installatie van $($update.Title): $_"
    }
}
Write-Progress -Activity "Updates installeren..." -Completed

# --- Stap 8: Vraag om herstart ---
$rebootRequired = $selectedUpdates | Where-Object { $_.RebootRequired -eq $true }
if ($rebootRequired.Count -gt 0) {
    Log "Voor één of meer geïnstalleerde updates is een herstart vereist."
    $reboot = Read-Host "Er is een herstart vereist. Wil je nu opnieuw opstarten? (ja/nee)"
    if ($reboot.ToLower() -eq "ja") {
        Log "Gebruiker kiest voor herstart. Systeem wordt opnieuw opgestart."
        Restart-Computer
    } else {
        Log "Gebruiker heeft herstart overgeslagen."
    }
} else {
    Log "Geen herstart vereist voor geïnstalleerde updates."
}

Log "Script voltooid. Logbestand opgeslagen op: $logFile"
Start-Process notepad.exe $logFile
