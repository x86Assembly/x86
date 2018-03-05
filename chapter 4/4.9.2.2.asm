; x86 irvine pg 136
; 4.9.2.2
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
.data

.code
main proc
	mov al, "b"
	mov bl, "c"
	mov cl, "d"
	mov dl, "a"
	xchg al, bl
	xchg al, dl
	xchg cl, dl
	

	main ENDP
	END main
