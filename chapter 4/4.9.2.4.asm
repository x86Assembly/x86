; x86 irvine pg 136
; 4.9.2.4
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
.data

.code
main proc
	mov al, -125
	add al, -125

	main ENDP
	END main
