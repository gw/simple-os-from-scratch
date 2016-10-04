;
; A simple boot sector program that demonstrates addressing.
;

mov ah, 0x0e

; First attempt
; Fails b/c `the_secret` refers to an offset, not a character value. Need to
; dereference (store the CONTENTS at the address, not the address).
mov al, the_secret
int 0x10

; Second attempt - Dereference the address
; Fails b/c CPU treats offset as if it were from the start of main RAM. But BIOS
; uses the first sections of RAM for the IVT and other BIOS data--our boot sector
; code is loaded somewhere after that, usually at 0x7c00.
mov al, [the_secret]
int 0x10

; Third attempt - Get offset relative to start of our boot sector code in RAM,
; rather than from start of RAM. This works.
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Fourth attempt - Hardcode the global offset (got from hexdump)
mov al, [0x7c1e]
int 0x10


jmp $ ; Jump to current address (endless loop)

the_secret:
  db "X"

; Padding and magic boot sector 2-byte number
times 510-($-$$) db 0

dw 0xaa55
