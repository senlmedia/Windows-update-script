🛠️ Windows Update Installatie & Controle Script
Dit PowerShell-script automatiseert het proces van het controleren en installeren van Windows-updates op een veilige en gecontroleerde manier. Het script bevat logging, foutafhandeling en gebruikersinteractie, en is bedoeld voor gebruik door systeembeheerders of gevorderde gebruikers.

📋 Functionaliteiten
Controleert of het script als administrator wordt uitgevoerd
Start logging en slaat logbestanden op
Controleert netwerkverbinding met Microsoft
Controleert en stelt de juiste ExecutionPolicy in
Installeert indien nodig NuGet en de PSWindowsUpdate-module
Zoekt en installeert beschikbare Windows-updates
(Optioneel) Zoekt en installeert cumulatieve updates (gedeactiveerd in script)
Vraagt de gebruiker of het systeem opnieuw moet worden opgestart
🧰 Vereisten
Windows 10 of hoger
PowerShell 5.1 of nieuwer
Administratorrechten
Internetverbinding
📦 Installatie
Zorg dat je PowerShell als administrator uitvoert.
Sla het script op als .ps1 bestand, bijvoorbeeld InstallUpdates.ps1.
Dubbelklik op het script of voer het uit via PowerShell.
▶️ Gebruik

Tijdens de uitvoering:

Wordt gevraagd of je de ExecutionPolicy wilt aanpassen (indien nodig).
Wordt een logbestand aangemaakt in de map:
C:\Users\[gebruikersnaam]\OneDrive - S&L Media\Zakelijk\S&L documenten\Scripts totaal\output logs
📝 Logging
Alle acties en foutmeldingen worden gelogd in een tekstbestand met tijdstempel. Dit bestand wordt automatisch geopend aan het einde van het script.

🔄 Herstart
Na installatie van updates wordt gevraagd of je het systeem opnieuw wilt opstarten.

⚠️ Opmerkingen
Het script bevat een uitgeschakelde sectie voor het installeren van cumulatieve updates. Deze kan worden geactiveerd door de commentaartekens (<# en #>) te verwijderen.
Zorg ervoor dat je toestemming hebt om updates te installeren op het systeem waarop je dit script uitvoert.
📄 Licentie
Dit script is bedoeld voor intern gebruik binnen S&L Media. Aanpassingen zijn toegestaan, maar gebruik op eigen risico.
