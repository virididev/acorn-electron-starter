---
name: spel-geheugenkaart
description: Geheugenindeling van dit Acorn Electron-spel — welke zero page-adressen, pagina's en RAM-gebieden het spel gebruikt en welke vrij zijn, in assembly (ca65, src/main.s) en in BBC BASIC (src/spel.bas). Gebruik deze skill bij het toevoegen van variabelen, buffers of tabellen, bij het kiezen waar code en data komen, bij het aanpassen van src/electron.cfg, of bij het debuggen van geheugencorruptie.
---

# Geheugenkaart van het spel (Acorn Electron, zonder discs)

Kijk in `CLAUDE.md` welke taal het project gebruikt.

## Assembly (ca65 en ld65)

| Gebied | Gebruik | Opmerking |
|--------|---------|-----------|
| &00–&6F | OS en BASIC | Niet gebruiken zolang het programma terug wil naar BASIC |
| &70–&8F | Segment `ZEROPAGE` | Vrij voor dit spel |
| &90–&FF | OS | Niet gebruiken |
| &0100–&01FF | 6502-stack | |
| &0200–&0DFF | OS-werkruimte, vectoren, buffers | Alleen via gedocumenteerde vectoren |
| &0E00–&2FFF | `CODE`, `RODATA`, `DATA`, `BSS` | Geladen en gestart op &0E00 |
| &3000–&7FFF | MODE 2-schermgeheugen | 20 KB |

`src/electron.cfg` laat `MAIN` eindigen op &3000; ld65 geeft een fout als het
programma groter wordt. Kies je een andere schermmodus, pas dan de grens aan:
&5800 in MODE 4–5, &6000 in MODE 6.

Neemt het spel de machine helemaal over en hoeft het niet terug naar BASIC,
dan mag het ook &00–&6F gebruiken. Zet dat dan in deze skill.

## BBC BASIC

| Gebied | Gebruik | Opmerking |
|--------|---------|-----------|
| &00–&6F | BASIC en OS | Niet gebruiken |
| &70–&8F | Spelvariabelen (zero page) | Vrij voor dit spel |
| &90–&FF | OS | Niet gebruiken |
| &0100–&01FF | 6502-stack | |
| &0200–&0DFF | OS-werkruimte, vectoren, buffers | Alleen via gedocumenteerde vectoren |
| &0E00–… | BASIC-programma (PAGE) | Groeit omhoog |
| na het programma | Variabelen en `DIM`-ruimte | Hier staat de machinecode (`DIM CODE%`) |
| &3000–&7FFF | MODE 2-schermgeheugen | 20 KB; HIMEM = &3000 |

Het programma, de variabelen en de machinecode moeten samen onder &3000
blijven. Wordt het krap, overweeg dan MODE 5 (HIMEM &5800, 4 kleuren) of
machinecode op een vast adres.

## Zero page-toewijzing

| Adres | Label | Betekenis |
|-------|-------|-----------|
| &70–&8F | — | Vrij |

Werk deze tabel bij zodra je een nieuw zero page-adres in gebruik neemt.
