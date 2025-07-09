# 🛠️ Windows Update Script – Versie 2
Een geavanceerd PowerShell-script voor het beheren van Windows-updates met uitgebreide logging, categorisatie en gebruikersinteractie.

## 📋 Functionaliteiten
- Controleert of het script met administratorrechten draait
- Start logging met systeem- en gebruikersinformatie
- Controleert netwerkverbinding met Microsoft
- Controleert en stelt indien nodig de juiste `ExecutionPolicy` in
- Installeert automatisch NuGet en PSWindowsUpdate-module indien nodig
- Categoriseert updates in:
  - Cumulatieve updates
  - Beveiligingsupdates
  - Driver-updates
  - Feature-updates
  - Preview-updates
  - Definitie-updates
  - Servicing Stack-updates
- Interactief keuzemenu voor installatie per categorie of alles tegelijk
- Installeert geselecteerde updates met voortgangsindicator
- Vraagt gebruiker om herstart na installatie
- Logt alle acties en fouten in een tijdgestempeld logbestand

## 🧰 Vereisten
- Windows 10 of hoger
- PowerShell 5.1 of nieuwer
- Administratorrechten
- Internetverbinding

## 📦 Installatie
Open PowerShell als administrator.
Sla het script op als WU_update_v2.ps1.
Voer het script uit:

## ▶️ Gebruik
Tijdens de uitvoering:

Wordt gevraagd of je de ExecutionPolicy wilt aanpassen (indien nodig)
Wordt een overzicht van beschikbare updates getoond
Kun je kiezen welke categorieën je wilt installeren
Wordt een logbestand aangemaakt in:
C:\Users\[gebruikersnaam]\OneDrive - S&L Media\Zakelijk\S&L documenten\Scripts totaal\output logs

## 📝 Logging
Alle acties worden gelogd, inclusief systeeminformatie, netwerkstatus, updatecategorieën, installatievoortgang en fouten. Het logbestand wordt automatisch geopend na afloop.

## 🔄 Herstart
Na installatie van updates wordt gevraagd of je het systeem opnieuw wilt opstarten.

## ⚠️ Opmerkingen
Het script gebruikt Get-WUList en Install-WindowsUpdate van de PSWindowsUpdate-module.
Zorg dat je toestemming hebt om updates te installeren op het systeem.
Cumulatieve updates worden herkend op basis van titelpatronen.

## 📄 Licentie
Dit script is bedoeld voor intern gebruik binnen S&L Media. Gebruik op eigen risico.
