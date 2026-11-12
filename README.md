# Acorn Electron starter voor Claude Code

Een startproject voor het schrijven van software voor de Acorn Electron met
[Claude Code](https://code.claude.com). Het hoort bij het artikel
"Claude Code voor retro-projecten op de Acorn Electron".

Claude Code weet in dit project op welke machine het werkt, hoe het code
draait in de emulator, en controleert na elke wijziging zelf het scherm.

## Wat je nodig hebt

- [Claude Code](https://code.claude.com)
- De Acorn Electron-emulator van
  [virididev/ElectronEmulator](https://github.com/virididev/ElectronEmulator).
  Zet hem waar je wilt; de skills vinden hem in de gebruikelijke mappen
  (zoals `/Applications` op een Mac, `~/.local/bin` op Linux of
  `%ProgramFiles%\acornelectron` op Windows) en in het `PATH`
- De ROM's van de Electron (`os.rom` en `basic.rom`). Die zijn van Acorn en
  zitten niet bij de emulator; zie de README van de emulator voor waar ze
  moeten staan
- Python 3, `make` en `jq`
- Voor assembly: [cc65](https://cc65.github.io) voor `ca65` en `ld65`
  (macOS `brew install cc65`, Debian/Ubuntu `sudo apt install cc65`)

Staat de emulator op een andere plek, zet dan het pad in
`.claude/settings.local.json`:

```json
{
  "env": {
    "ELECTRON_EMU": "/pad/naar/acornelectron"
  }
}
```

## Aan de slag

Kies eerst in welke taal je wilt werken. Beide beginnen met hetzelfde kleine
programma: de Electron in MODE 2 en een gekleurde groet.

```sh
make start-asm     # 6502-assembly met ca65 en ld65: src/main.s en src/electron.cfg
make start-basic   # BBC BASIC met inline assembler: src/spel.bas
```

Zet de keuze ook in `CLAUDE.md`, onder **Taal**. Doe je dat niet, dan vraagt
Claude ernaar voordat het code schrijft.

```sh
make check   # wordt de emulator gevonden, zijn de ROM's er?
make test    # draai het programma zonder venster; het scherm komt in build/screen.png
make run     # draai het programma in de emulator met venster
```

In assembly bouwt `make` ook een tape, `build/spel.uef`, die vanzelf laadt en
start. Die opent `make run` in de emulator.

Start daarna `claude` in deze map. Bij de eerste start vraagt Claude Code of je
de map vertrouwt; pas dan gelden de permissies uit `.claude/settings.json`.

## Wat erin zit

```text
├── CLAUDE.md                  # platform, toolchain en afspraken
├── .claude/
│   ├── settings.json          # permissies en de hook
│   ├── hooks/
│   │   └── test-na-wijziging.sh   # draait make test na elke wijziging in src/
│   ├── skills/
│   │   ├── electron-*/        # de emulator: draaien, testen, debuggen,
│   │   │                      #   profileren en een tape maken
│   │   ├── spel-geheugenkaart/    # de geheugenindeling van het spel
│   │   ├── boek-hoofdstuk/    # een hoofdstuk van het leerboek schrijven
│   │   ├── uit-de-praktijk/   # een opgeloste bug vastleggen als les
│   │   └── leg-uit/           # leermodus: uitleggen en oefenen
│   └── agents/
│       ├── 6502-reviewer.md   # controleert de 6502-code, in assembly of BASIC
│       └── boek-lezer.md      # leest het boek als een beginner
├── src/                       # je programma, na make start-asm of make start-basic
├── templates/
│   ├── asm/                   # main.s en electron.cfg voor ca65 en ld65
│   └── basic/                 # spel.bas
├── tests/
│   ├── asm.mon                # monitorscript voor make test in assembly
│   └── basic.mon              # monitorscript voor make test in BASIC
├── tools/
│   └── mk_uef.py              # maakt een tape van het programma
├── boek/                      # het leerboek, met de code na elk hoofdstuk
└── Makefile
```

Het artikel legt uit wat elk onderdeel doet en hoe je het zelf schrijft.

## Het programma

Het sjabloon is een klein begin: het zet de Electron in MODE 2 en schrijft een
gekleurde groet. Bouw het van hieruit uit tot je eigen spel, en laat Claude het
boek in `boek/` bijhouden terwijl je dat doet.
