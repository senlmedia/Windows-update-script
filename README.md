 README.md — Windows Update Automatiseringsscript
🧾 Overzicht
Dit PowerShell-script automatiseert het proces van het controleren, categoriseren en installeren van Windows-updates via de PSWindowsUpdate-module. Het script is bedoeld voor systeembeheerders of gevorderde gebruikers die updates efficiënt willen beheren.

⚙️ Functionaliteit
Het script voert de volgende stappen uit:

Controle op administratorrechten
Start logging naar een bestand op het bureaublad
Controleert netwerkverbinding met www.microsoft.com
Controleert en stelt ExecutionPolicy in op RemoteSigned
Installeert NuGet indien nodig
Installeert de PSWindowsUpdate-module indien nodig
Zoekt beschikbare updates en categoriseert deze:
Cumulatieve updates
Beveiligingsupdates
Driver-updates
Feature-updates
Preview-updates
Definitie-updates
Servicing Stack-updates
Overige updates
Toont een keuzemenu voor installatie van specifieke categorieën
Installeert geselecteerde updates
Vraagt om herstart indien nodig
🖥️ Vereisten
Windows 10 of hoger
PowerShell 5.1 of hoger
Administratorrechten
Internetverbinding
Toestemming om modules te installeren (zoals NuGet en PSWindowsUpdate)
▶️ Gebruik
Start PowerShell als Administrator
Voer het script uit:

Volg de instructies in de console
Je krijgt een overzicht van updates en kunt kiezen welke je wilt installeren.
📝 Logging
Alle acties worden gelogd in een tekstbestand op het bureaublad in de map output logs.
Aan het einde van het script wordt het logbestand automatisch geopend in Notepad.
⚠️ Opmerkingen
Het script vraagt toestemming om de ExecutionPolicy aan te passen indien nodig.
Herstart wordt alleen uitgevoerd als updates dit vereisen én de gebruiker toestemming geeft.
