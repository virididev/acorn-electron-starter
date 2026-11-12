---
name: boek-hoofdstuk
description: Schrijf of herschrijf een hoofdstuk van het leerboek in boek/ — het boek dat het spel stap voor stap opbouwt, zodat de lezer (de gebruiker zelf) 6502-assembly en gamedevelopment op de Acorn Electron leert. Gebruik deze skill bij "schrijf hoofdstuk", "voeg aan het boek toe", "werk het boek bij na deze wijziging", bij het maken van een snapshot in boek/stappen/, of als een nieuwe functie van het spel klaar is en in het boek moet.
---

# Een hoofdstuk van het boek schrijven

Het boek in `boek/` bouwt het spel op vanaf een lege map. Elk hoofdstuk voegt
één ding toe en eindigt met een programma dat draait. De lezer typt de code
zelf in; het boek is een leermiddel, geen documentatie.

Schrijf in de taal van `boek/README.md`. Volg de stijl in
`references/stijl.md` en de opbouw in `references/sjabloon.md`.

## Werkwijze

1. **Eerst de code, dan de tekst.** Laat de wijziging werken in `src/` en
   controleer haar in de emulator (`make test`, kijk naar `build/screen.png`).
   Schrijf nooit over code die je niet hebt zien draaien.
2. **Knip de wijziging in stappen.** Elke stap is klein genoeg om in te typen
   en eindigt, waar het kan, met iets dat de lezer kan zien. Probeer elke
   tussenstap ook echt in de emulator.
3. **Schrijf het hoofdstuk** volgens het sjabloon. Leg elk nieuw begrip uit
   op de plek waar het voor het eerst nodig is, met een verwijzing naar een
   eerder hoofdstuk als het daar al stond.
4. **Maak de snapshot.** Kopieer `src/` zoals die na dit hoofdstuk is naar
   `boek/stappen/hoofdstuk-NN/` (twee cijfers). Elke snapshot draait op zichzelf:
   `make test SRC=boek/stappen/hoofdstuk-NN`.
5. **Bewaar het scherm.** Kopieer `build/screen.png` naar
   `boek/afbeeldingen/hoofdstuk-NN.png` en neem het op onder "Wat je nu hebt".
6. **Controleer de keten.** Vorige snapshot + alle code uit dit hoofdstuk moet
   precies de nieuwe snapshot opleveren. Vergelijk met `diff -r`; elk verschil
   is een stuk code dat de lezer mist of te veel krijgt.
7. **Werk `boek/README.md` bij**: de inhoudsopgave en, als er een nieuwe
   instructie in voorkomt, de appendix met 6502-instructies.
8. Laat daarna de agent `boek-lezer` het hoofdstuk lezen.

## Drie soorten codeblokken

Zet boven elk blok de bestandsnaam cursief, zoals *`src/main.s`* of
*`src/spel.bas`*. Gebruik `asm` of `basic` als taal van het codeblok, naar de
taal in `CLAUDE.md`.

- **Een heel bestand of een hele routine**: de lezer typt het zo in.
- **Nieuwe regels voor een bestaand bestand**: zeg waar ze komen als dat
  ertoe doet.
- **Een wijziging binnen een routine**: als `diff`-blok, met `+` voor nieuwe
  regels en `-` voor regels die weg moeten. Zeg dat de tekens niet meetypen.

In een BASIC-listing met regelnummers is een wijziging meestal gewoon de
nieuwe versie van de regel: zeg dan "vervang regel 120 door".

## Wat niet

- Geen code in het boek die niet in een snapshot staat, en andersom.
- Niet vooruitlopen: een begrip dat pas in hoofdstuk 9 nodig is, staat niet
  in hoofdstuk 4.
- Geen uitleg of code voor de BBC Micro: het boek gaat over de Electron, die
  onder meer MODE 7 en de 6522 VIA mist.
