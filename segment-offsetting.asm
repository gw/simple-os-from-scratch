; Simple boot sector program that demonstrates segment offsetting.

mov ah, 0x0e

; Does not print an X, as CPU treats this relative memory address as global.
; mov al, [the_secret]
; int 0x10

; This prints an X correctly, by manually setting the data segment offset in
; the ds register. We can't set it directly so we set it via bx. When the CPU
; calculates the absolute address, it does ds*16 + the_secret, hence our using
; 0x7c0 instead of 0x7c00, which is where BIOS usually loads the boot sector.
mov bx, 0x7c0
mov ds, bx
mov al, [the_secret]
int 0x10

; Offset of the the extra data segment instead. This doesn't print an X.
mov al, [es:the_secret]
int 0x10

; Manually set es the same way we set ds above. This prints correctly.
mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10

the_secret:
  db "X"

; Boot sector padding and magic number
times 510-($-$$) db 0
dw 0xaa55
