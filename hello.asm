; A simple boot sector program that prints 'hello' using a BIOS routine.

mov ah, 0x0e  ; Scrolling TTY BIOS routine

mov al, 'H'
int 0x10

mov al, 'e'
int 0x10

mov al, 'l'
int 0x10
int 0x10

mov al, 'o'
int 0x10

jmp $ ; Jump to current address (endless loop)

; Padding and magic boot sector 2-byte number
times 510-($-$$) db 0

dw 0xaa55
