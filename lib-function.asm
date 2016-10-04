; A simple boot sector program that includes a separate asm file and calls
; a function in it.

mov bp, 0x8000  ; Set base of stack past where BIOS loads our boot sector
mov sp, bp

mov bx, HELLO_MSG ; bx will be the arg parameter for the lib function
call print_string

mov bx, GOODBYE_MSG
call print_string

jmp $

%include "print-string.asm"

; Data
HELLO_MSG:
  db 'Hello, World!', 0  ; Null-terminated string

GOODBYE_MSG:
  db 'Goodbye!', 0

; Padding and magic number
times 510-($-$$) db 0
dw 0xaa55
