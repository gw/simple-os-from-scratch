;
; A simple boot sector program that demonstrates stack usage.
;

mov ah, 0x0e

; Set base of stack past where BIOS loads our boot sector. Since stack grows
; downward This gives us 0x8000 - (0x7c00 + 512 bytes of boot sector)
;                               - 0x7e00
;                                        = 0x200
;                                        = 512 bytes of stack space.
mov bp, 0x8000
mov sp, bp

; Since boot sectors operate in real mode, we're pushing 16-bit values onto the
; stack. For these 1-byte characters, the higher-order byte will be zeros.
push 'A'
push 'B'
push 'C'

; We can only pop 16 bits too, so we move the lowest-order bits into another
; register.
pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

mov al, [0x7ffe]  ; 0x8000 - 0x2 (subtract 2 bytes from bp)
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
