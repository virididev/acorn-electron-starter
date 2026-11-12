# Mijn spel – Acorn Electron

Voorbeeldproject bij het artikel "Claude Code voor retro-projecten op de Acorn Electron".

## Doel

Dit project is een leermiddel: ik leer er 6502-assembly en game development
op de Electron mee. Leg uit wat je doet en waarom (skill `leg-uit`), en houd
het boek in `boek/` bij als het spel verandert.

## Taal

Taal: **nog niet gekozen**

Er zijn twee manieren om dit spel te schrijven. Is de taal hierboven nog niet
gekozen, vraag dan eerst welke de gebruiker wil, voordat je code schrijft.
Kies nooit zelf.

| Keuze | Bron | Starten met |
| --- | --- | --- |
| 6502-assembly met ca65 en ld65 | `src/main.s`, `src/electron.cfg` | `make start-asm` |
| BBC BASIC II met inline assembler | `src/spel.bas` | `make start-basic` |

Na de keuze: draai het `make`-commando en vervang "nog niet gekozen" hierboven
door de gekozen taal.

## Platform

- Machine: Acorn Electron, 32 KB RAM, OS 1.00, BASIC II, geen discs
- Het programma begint op &0E00 (PAGE)
- Geen MODE 7; schermmodus MODE 2, schermgeheugen vanaf &3000
- Zero page &70–&8F is vrij voor eigen gebruik
- Gebruik OS-calls via de vectoren (OSWRCH &FFEE, OSBYTE &FFF4, OSWORD &FFF1)

## Toolchain

- Emulator: https://github.com/virididev/ElectronEmulator, ergens op dit systeem
  geïnstalleerd. `.claude/skills/electron-emulator/scripts/emu.py` vindt hem
  (eventueel via `ELECTRON_EMU` in `.claude/settings.local.json`)
- `make check`: wordt de emulator gevonden, zijn de ROM's er?
- `make test`: draait het programma headless en zet een screenshot in
  `build/screen.png`; gebeurt automatisch na elke wijziging in `src/` via een hook
- `make run`: het programma in de emulator met venster (voor de gebruiker)
- `make test SRC=<map>`: test een andere map, bijvoorbeeld een stap uit het boek
- Voor debuggen, testscripts, profileren en een tape (.uef): de skills
  `electron-*` in `.claude/skills/`

### Assembly (ca65 en ld65)

- `src/main.s` bevat het programma en mag andere bestanden in `src/` insluiten
  met `.include`; `src/electron.cfg` zegt de linker waar alles in het geheugen komt
- `make` bouwt `build/spel.bin`, de labels in `build/spel.lbl`, de listing in
  `build/spel.lst` en een tape `build/spel.uef` die vanzelf laadt en start
- Zero page-variabelen in het segment `ZEROPAGE` (&70–&8F), code in `CODE`
- Een programma dat van tape komt, keert niet terug naar BASIC
- `tests/asm.mon` laadt `build/spel.bin` op &0E00 en start het met `CALL &E00`

### BBC BASIC

- `src/spel.bas` bevat het programma; BASIC assembleert de inline assembler bij RUN
  (twee passes: `FOR PASS%=0 TO 2 STEP 2` met `[OPT PASS%`)
- Schrijf alles in hoofdletters: de emulator typt kleine letters als hoofdletters
- Regelnummers in stappen van 10
- `tests/basic.mon` start het ingetypte programma met `RUN`

## Conventies

- Zie de skill `spel-geheugenkaart` voor de volledige geheugenindeling
- Controleer na een wijziging altijd `build/screen.png`

## Het boek

- `boek/`: een hoofdstuk per stap van het spel, met de code na elk hoofdstuk
  in `boek/stappen/hoofdstuk-NN/` en screenshots in `boek/afbeeldingen/`
- Nieuw of gewijzigd hoofdstuk: skill `boek-hoofdstuk`, daarna subagent `boek-lezer`
- Bug opgelost: skill `uit-de-praktijk` (leerlog en "Uit de praktijk"-sectie)
