# 🛠️ Windows Update Installatie & Controle Script

Dit PowerShell-script automatiseert het proces van het controleren en installeren van Windows-updates op een veilige en gecontroleerde manier.
Het script bevat logging, foutafhandeling en gebruikersinteractie, en is bedoeld voor gebruik door systeembeheerders of gevorderde gebruikers.

## 📋 Functionaliteiten

- Controleert of het script als administrator wordt uitgevoerd
- Start logging en slaat logbestanden op
- Controleert netwerkverbinding met Microsoft
- Controleert en stelt de juiste `ExecutionPolicy` in
- Installeert indien nodig NuGet en de `PSWindowsUpdate`-module
- Zoekt en installeert beschikbare Windows-updates
- (Optioneel) Zoekt en installeert cumulatieve updates (gedeactiveerd in script)
- Vraagt de gebruiker of het systeem opnieuw moet worden opgestart

## 🧰 Vereisten

- Windows 10 of hoger
- PowerShell 5.1 of nieuwer
- Administratorrechten
- Internetverbinding

## 📝 Logging

Alle acties en foutmeldingen worden gelogd in een tekstbestand met tijdstempel. Dit logbestand wordt opgeslagen in de volgende map:

C:\Users\[gebruikersnaam]\OneDrive - S&L Media\Zakelijk\S&L documenten\Scripts totaal\output logs

Het logbestand wordt automatisch geopend aan het einde van het script.

## 🔄 Herstart

Na installatie van updates wordt gevraagd of je het systeem opnieuw wilt opstarten.
Indien je 'ja' kiest, wordt het systeem automatisch opnieuw opgestart.

## ⚠️ Opmerkingen

- Het script bevat een uitgeschakelde sectie voor het installeren van cumulatieve updates.
  Deze kan worden geactiveerd door de commentaartekens (`<#` en `#>`) te verwijderen.
- Zorg ervoor dat je toestemming hebt om updates te installeren op het systeem waarop je dit script uitvoert.

## 📄 Licentie

Dit script is bedoeld voor intern gebruik binnen S&L Media.
Aanpassingen zijn toegestaan, maar gebruik is op eigen risico.
