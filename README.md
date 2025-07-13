# 📄 README.md — Windows Update Automatiseringsscript

## 🧾 Overzicht

Dit PowerShell-script automatiseert het proces van het controleren, categoriseren en installeren van Windows-updates via de **PSWindowsUpdate**-module. Het script is bedoeld voor systeembeheerders of gevorderde gebruikers die updates efficiënt willen beheren.

## ⚙️ Functionaliteit

Het script voert de volgende stappen uit:

1. **Controle op administratorrechten**  
2. **Start logging naar een bestand op het bureaublad**  
3. **Controleert netwerkverbinding met www.microsoft.com**  
4. **Controleert en stelt ExecutionPolicy in op `RemoteSigned`**  
5. **Installeert NuGet indien nodig**  
6. **Installeert de PSWindowsUpdate-module indien nodig**  
7. **Zoekt beschikbare updates en categoriseert deze:**
   - Cumulatieve updates
   - Beveiligingsupdates
   - Driver-updates
   - Feature-updates
   - Preview-updates
   - Definitie-updates
   - Servicing Stack-updates
   - Overige updates
8. **Toont een keuzemenu voor installatie van specifieke categorieën**  
9. **Installeert geselecteerde updates**  
10. **Vraagt om herstart indien nodig**

3. **Volg de instructies in de console**
   - Je krijgt een overzicht van updates en kunt kiezen welke je wilt installeren.

---

### 📝 Logging

- Alle acties worden gelogd in een tekstbestand op het bureaublad in de map `output logs`.
- Aan het einde van het script wordt het logbestand automatisch geopend in Notepad.

---

### ⚠️ Opmerkingen

- Het script vraagt toestemming om de ExecutionPolicy aan te passen indien nodig.
- Herstart wordt alleen uitgevoerd als updates dit vereisen én de gebruiker toestemming geeft.
