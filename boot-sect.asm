; A simple boot sector program that just loops forever. To assemble, we use
; the `bin` flag to tell nasm that we want raw machine code, rather than a code
; package that has additional metadata for linking in other routines that we'd
; expect to use when programming in a more typical OS environment. Screw that.
; Apart from the factory BIOS routines, we're the only code running on the
; computer right now.

; To assemble:
; nasm boot sect.asm -f bin -o boot sect.bin
;

loop:
  jmp loop

; When assembled, this program must fit into 512 bytes, since that's the size
; the BIOS code will expect. This line tells nasm to pad our program with enough
; zero bytes (db 0) to bring us to the 510th byte.
times 510-($-$$) db 0

; Last two bytes are the magic number that tell the BIOS that this is a boot
; sector.
dw 0xaa55
