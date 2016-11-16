; Print a value as a hex string. Value must be 2 bytes.

[org 0x7c00]

mov bp, 0x8000
mov sp, bp

; mov dx, 0x1fb6 ; Use dx as arg register for print-hex
mov dx, 0xac

push 0

hex_to_ascii:
  cmp dx, 0 ; Terminate loop if we're at 0
  je print

  mov bx, dx   ; BX is the only register allowed for use as an index
  and bx, 0xf  ; Extract low-order nibble (lowest 4 bits)

  push dword [CHAR_TAB + bx] ; Push ASCII to stack
  ; mov al, 'X'
  ; call print_nibble

  shr dx, 4  ; Divide by 16
  jmp hex_to_ascii

print:
  ; Print '0x' prefix
  mov al, '0'
  call print_nibble
  mov al, 'x'
  call print_nibble
  pop ax
  call print_nibble
  pop ax
  call print_nibble
  pop ax
  call print_nibble
  ;
  ; .loop:
  ;   ; Terminate loop if top of stack is 0
  ;   pop ax
  ;   cmp ax, 0
  ;   je end
  ;
  ;   call print_nibble
  ;   jmp .loop

end:
  jmp $

; Helpers
; al - ASCII code to print
print_nibble:
  mov ah, 0x0e
  int 0x10
  ret


; DATA
CHAR_TAB: db '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', 0

; Boot sector: and magic number
times 510-($-$$) db 0
dw 0xaa55
