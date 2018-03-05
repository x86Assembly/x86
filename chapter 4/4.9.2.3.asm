; x86 irvine pg 136
; 4.9.2.3
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
.data

.code
main proc
	mov al, 0
	mov al, 1
	mov al, 01110101b
	add al, 1
	sub al, 1

	main ENDP
	END main

