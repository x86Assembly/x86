; x86 irvine pg 136
; 4.9.2.5
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
.data

.code
main proc
	mov ax, 0ffffh
	add al, 0ffh

	main ENDP
	END main

