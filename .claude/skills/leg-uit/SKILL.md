---
name: leg-uit
description: Leermodus — leg een stuk 6502-assembly, BBC BASIC of een begrip uit game development uit aan de gebruiker, die dit project gebruikt om te leren, en laat het zien in de emulator. Gebruik deze skill bij vragen als "wat doet deze routine", "waarom werkt dit", "leg uit", "hoe werkt X op de 6502", "ik snap niet waarom", of als de gebruiker vraagt om een oefening of om het zelf te mogen proberen.
---

# Uitleggen om te leren

De gebruiker leert 6502-assembly en game development met dit project. Het
doel is dat de gebruiker het zelf begrijpt, niet dat het probleem zo snel mogelijk
weg is.

## Uitleggen

1. **Begin bij het probleem**, niet bij de instructie: wat moet deze code
   voor het spel doen?
2. **Loop door de code** met de waarden erbij. Zeg per instructie wat er in
   A, X, Y en de flags staat, alleen waar het ertoe doet.
3. **Laat het zien in de emulator.** Gebruik de skill `electron-debug`: een
   breakpoint op de routine, een paar keer `s` en `r`, en toon de echte
   registers en het geheugen. Echte waarden zeggen meer dan een tabel.
4. **Verbind het met wat de gebruiker al kent**: een eerder hoofdstuk in `boek/`,
   een item in `boek/leerlog.md`, of een vergelijkbare constructie in een
   moderne taal.
5. **Sluit af met één vraag** die laat zien of het begrepen is: "Wat gebeurt
   er als X hier 0 is?"

## Oefeningen

Vraagt de gebruiker om een oefening, of om het zelf te proberen:

- Geef een opdracht die in vijf tot vijftien minuten te doen is en een
  zichtbaar resultaat heeft in de emulator.
- Geef niet meteen de oplossing. Geef hints in stappen als erom gevraagd
  wordt: eerst de richting, dan de instructie, dan pas code.
- Laat de gebruiker eerst voorspellen wat er gebeurt, en dan draaien.
- Kijk de uitwerking na door die te draaien (`make test`) en zeg wat goed
  is voordat je zegt wat beter kan.

## Wat niet

- Niet ongevraagd de code van de gebruiker herschrijven tijdens het leren.
- Geen uitleg uit het hoofd over cycli, adressen of OS-calls: kijk het na in
  de skills `6502`, `bbcbasic` en `electron-emulator`, of meet het.
