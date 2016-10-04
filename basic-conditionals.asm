; Translate provided boot sector pseudo-code into assembly to get a feel for
; how conditionals work.

; Pseudocode
; mov bx , 30
; if (bx <= 4) {
; mov al , ’A ’
; } else if (bx < 40) {
; mov al , ’B ’
; } else {
; mov al , ’C ’
; }
; mov ah , 0 x0e ; int =10/ ah =0 x0e -> BIOS tele - type output
; int 0 x10 ; print the character in al
; jmp $
; Padding and magic number.
; times 510 -( $ - $$ ) db 0
; dw 0 xaa55

mov bx, 4

cmp bx, 4
je first

cmp bx, 40
jl second

jmp else

first:
  mov al, 'A'
  jmp then
second:
  mov al, 'B'
  jmp then
else:
  mov al, 'C'
  jmp then

then:
  mov ah, 0x0e
  int 0x10

jmp $

times 510 - ($-$$) db 0
dw 0xaa55
