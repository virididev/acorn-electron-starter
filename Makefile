# Acorn Electron starter
#
# Kies eerst een taal:
#   make start-asm     6502-assembly met ca65 en ld65 (src/main.s)
#   make start-basic   BBC BASIC met inline assembler (src/spel.bas)
#
# Daarna:
#   make check   wordt de emulator gevonden, zijn de ROM's er?
#   make test    draai het programma zonder venster; het scherm komt in build/screen.png
#   make run     draai het programma in de emulator met venster
#
# SRC kiest een andere map met broncode, bijvoorbeeld een stap uit het boek:
#   make test SRC=boek/stappen/hoofdstuk-03
#
# De emulator mag overal staan: emu.py (uit de skill electron-emulator) vindt
# hem via $ELECTRON_EMU, 'emu.py setup', het PATH of de gebruikelijke plekken.

EMU      := .claude/skills/electron-emulator/scripts/emu.py
EMULATOR ?= $(shell $(EMU) path 2>/dev/null | head -1)
SRC      ?= src
BUILD    := build

# De taal volgt uit wat er in SRC staat
ifneq ($(wildcard $(SRC)/main.s),)
TAAL := asm
else ifneq ($(wildcard $(SRC)/spel.bas),)
TAAL := basic
endif

.PHONY: all build run test check clean start-asm start-basic geen-taal

ifeq ($(TAAL),asm)

# Assembleren en linken; het label-bestand is voor breakpoints op namen (@label)
build:
	@mkdir -p $(BUILD)
	ca65 -t none -g -I $(SRC) $(SRC)/main.s -o $(BUILD)/spel.o -l $(BUILD)/spel.lst
	ld65 -C $(SRC)/electron.cfg -S 0x0E00 -o $(BUILD)/spel.bin -Ln $(BUILD)/spel.lbl $(BUILD)/spel.o
	@python3 tools/mk_uef.py $(BUILD)/spel.bin $(BUILD)/spel.uef 0x0E00

run: build
	"$(EMULATOR)" $(BUILD)/spel.uef

test: build
	@$(EMU) run --png $(BUILD)/screen.png --monitor tests/asm.mon
	@echo "Screenshot: $(BUILD)/screen.png"

else ifeq ($(TAAL),basic)

# Een BASIC-programma hoeft niet gebouwd te worden: de emulator typt het in
build:
	@echo "BBC BASIC: niets te bouwen"

run:
	"$(EMULATOR)" --type "$$(awk '{printf "%s\\n", $$0}' $(SRC)/spel.bas)RUN\n"

test:
	@mkdir -p $(BUILD)
	@$(EMU) run --png $(BUILD)/screen.png --monitor tests/basic.mon $(SRC)/spel.bas
	@echo "Screenshot: $(BUILD)/screen.png"

else

build run test: geen-taal

endif

all: build

geen-taal:
	@echo "Er staat nog geen programma in $(SRC)/. Kies eerst een taal:" >&2
	@echo "  make start-asm     6502-assembly met ca65 en ld65" >&2
	@echo "  make start-basic   BBC BASIC met inline assembler" >&2
	@exit 1

start-asm start-basic:
	@if [ -e src/main.s ] || [ -e src/spel.bas ]; then \
		echo "Er staat al een programma in src/." >&2; exit 1; fi
	cp templates/$(subst start-,,$@)/* src/
	@echo "Klaar: src/ bevat nu het sjabloon voor $(subst start-,,$@)."

check:
	@$(EMU) check

clean:
	rm -rf $(BUILD)
