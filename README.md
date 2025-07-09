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
