# Stijl van het boek

De lezer kan programmeren, maar kent de 6502 en de Electron nog niet.

## Zinnen en woorden

- Korte zinnen. Eén gedachte per zin.
- Gewone woorden. Een vakterm alleen als de lezer hem nodig heeft om verder
  te lezen of te zoeken, en dan met uitleg erbij de eerste keer: "Deze manier
  om negatieve getallen te schrijven heet two's complement."
- Spreek de lezer aan met "je". "We" alleen niet.
- Zeg waarom, niet alleen wat. "OSBYTE &81 kijkt niet in de buffer, maar
  direct naar het toetsenbord" is beter dan "gebruik OSBYTE &81".
- Geen superlatieven, geen "simpelweg", "gewoon even" of "eenvoudig": wat
  eenvoudig is, voelt de lezer zelf.

## Getallen

- Hexadecimaal zoals in de broncode: `&FFEE` in BBC BASIC, `$FFEE` in ca65.
- Reken een getal één keer voor als het niet vanzelf spreekt:
  256 - 99 = 157, dat is `&9D`.
- Tijden in frames én in seconden: 50 frames is een seconde.

## Tabellen

Gebruik een tabel voor alles wat de lezer later wil opzoeken: toetsen,
kleuren, geheugengebieden, OS-calls. Niet voor uitleg.

## Vaste onderdelen

- **Uit de praktijk**: wat er misging toen het spel werd gemaakt, hoe het
  gevonden werd en wat de les is. Zie de skill `uit-de-praktijk`.
- **Probeer het**: drie tot vijf opdrachten. Van "verander dit getal en
  voorspel wat er gebeurt" tot "bouw dit zelf". Geef geen antwoorden; vraag
  wél om eerst te voorspellen en dan pas te draaien.
- **Wat je nu hebt**: twee of drie zinnen en de screenshot.
