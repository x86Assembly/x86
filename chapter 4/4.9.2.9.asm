; x86 irvine pg 136
; 4.9.2.9

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

; ax = (val2 + bx) -val4
.data
val2 dw 0fh
val4 dw 02h
.code
main proc
	mov bx, 1
	add bx, val2
	sub bx, val4
	mov ax, bx

	main ENDP
	END main

