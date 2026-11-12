; main.s - Acorn Electron, 6502-assembly voor ca65
; Zet de Electron in MODE 2 en schrijft een gekleurde groet.

OSWRCH = $FFEE              ; schrijf het teken in A naar het scherm

.zeropage
; &70-&8F: vrij voor dit programma (zie de skill spel-geheugenkaart)

.code
start:  lda #22             ; VDU 22,2: MODE 2
        jsr OSWRCH
        lda #2
        jsr OSWRCH

        ldx #0
@loop:  lda message,x
        beq @done           ; een 0 sluit de tekst af
        jsr OSWRCH
        inx
        bne @loop

@done:  jmp @done           ; blijf hier: een programma van tape keert niet terug naar BASIC

.rodata
message:
        .byte 17, 1, "HELLO "   ; VDU 17,1: rode tekst
        .byte 17, 3, "ACORN!"   ; VDU 17,3: gele tekst
        .byte 0
