---
name: uit-de-praktijk
description: Leg een bug die net gevonden en opgelost is vast als les — in boek/leerlog.md en, als het hoofdstuk al bestaat, als sectie "Uit de praktijk" in het boek. Gebruik deze skill direct nadat een fout in het spel is opgelost (crash, hang, verkeerd scherm, timingprobleem, geheugencorruptie), vooral als de oorzaak niet voor de hand lag of met de emulator-monitor (breakpoints, trace) gevonden werd.
---

# Een bug als les vastleggen

Fouten zijn het leerzaamste deel van het project. Leg ze vast terwijl ze
vers zijn, voordat de context verdwenen is.

## 1. Het leerlog

Voeg bovenaan `boek/leerlog.md` een item toe (maak het bestand aan als het
er niet is):

```markdown
## 2026-11-12 — Korte titel van wat er zichtbaar misging

- **Wat je zag:** het symptoom, zoals een speler het ziet.
- **Oorzaak:** wat er werkelijk gebeurde, in termen van de 6502 of de machine.
- **Hoe gevonden:** welke stappen, welke monitorcommando's (`b`, `bw`, `tr`,
  `m`), wat liet de screenshot zien. Ook wat níet hielp.
- **Oplossing:** de wijziging, met bestand en regel.
- **Les:** één of twee zinnen die ook buiten dit spel gelden.
- **Hoofdstuk:** NN, of "nog niet geschreven".
```

Gebruik de datum van vandaag.

## 2. In het boek

Bestaat het hoofdstuk al waar de foutieve code in voorkomt, voeg dan een
sectie `## Uit de praktijk: <titel>` toe vóór "Probeer het". Vertel het als
verhaal: eerst wat er leek te werken, dan wat er misging, hoe het gevonden
werd, en als laatste de les. Verwijs naar de regels in het hoofdstuk die de
fout voorkomen.

Pas ook de snapshot in `boek/stappen/` aan als de fout daarin zat.

## 3. Een opdracht

Bedenk een "Probeer het"-opdracht waarbij de lezer de fout zelf terugzet en
ziet wat er gebeurt. Zo leert de lezer het symptoom herkennen.

## Wat niet

- Geen schuld en geen excuses: beschrijf wat er gebeurde.
- Geen les die alleen "test beter" zegt. Wat moet je precies anders doen?
