; A simple string printer function to be used in other assembly code.
; Expects a null-terminated string to exist in bx upon entrance.
; Prints byte-by-byte, just cuz.

; Make [] derefs relative to this address--otherwise the assembler treats
; addresses in [] as relative to the beginning of RAM. 0x7c00 is usually
; where BIOSes load boot sectors. I think this is only used with the raw bin
; output format.
[org 0x7c00]


print_string:
  pusha  ; Copy all registers to stack

  mov ah, 0x0e  ; Scrolling TTY BIOS routine

  compare:
    ; Load byte at bx
    mov al, [bx] ; Assembles into 0x7c00 + (whatever offset is in bx)

    ; Exit on null-byte
    cmp al, 0
    je return

    ; Print
    int 0x10

    ; Increment pointer and loop
    inc bx
    jmp compare

  return:
    popa
    ret
