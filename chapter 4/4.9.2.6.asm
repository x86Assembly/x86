; x86 irvine pg 136
; 4.9.2.6
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
.data

.code
main proc
	mov ax, 0
	sub al, 1

	main ENDP
	END main

