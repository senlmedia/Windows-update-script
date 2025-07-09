# 📦 Release Notes – WU_update_v2

**Versie:** 2
**Datum:** 9 juli 2025
**Auteur:** S&L Media IT
**Bestandsnaam:** `WU_update_v2 - kopie.txt`

## ✨ Nieuwe functionaliteiten

- **Updatecategorisatie**: Updates worden nu automatisch gecategoriseerd in:
  - Cumulatieve updates
  - Beveiligingsupdates
  - Driver-updates
  - Feature-updates
  - Preview-updates
  - Definitie-updates
  - Servicing Stack-updates

- **Interactief keuzemenu**: Gebruikers kunnen nu zelf kiezen welke categorieën updates ze willen installeren, of alles in één keer.

- **Gedetailleerde logging**:
  - Logt systeeminformatie, gebruiker, en besturingssysteem bij start.
  - Logt netwerkstatus, installatievoortgang en eventuele fouten.
  - Logbestand wordt automatisch geopend na voltooiing.

- **Verbeterde foutafhandeling**:
  - Bij ontbrekende modules of netwerkproblemen wordt het script veilig afgebroken met logging.
  - Installatie van NuGet en PSWindowsUpdate gebeurt automatisch indien nodig.

## 🔧 Verbeteringen

- **ExecutionPolicy-check**: Script controleert en biedt aan om de policy aan te passen naar `RemoteSigned`.
- **Administratorcontrole**: Script start zichzelf opnieuw op met verhoogde rechten indien nodig.
- **Modulaire structuur**: Elke stap is duidelijk gescheiden en gelogd voor betere traceerbaarheid.


## 🧪 Testresultaten

- Script succesvol getest op Windows 10 en Windows 11.
- Werkt met zowel Engelse als Nederlandse updatebeschrijvingen.
- Logbestanden worden correct aangemaakt en opgeslagen.

## ⚠️ Bekende beperkingen

- Cumulatieve updates worden niet automatisch herkend als ze afwijkende titels hebben.
- Herstart wordt handmatig gevraagd; automatische herstart is optioneel.

## 📁 Locatie logbestanden

C:\Users\[gebruikersnaam]\OneDrive - S&L Media\Zakelijk\S&L documenten\Scripts totaal\output logs
