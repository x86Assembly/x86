; x86 irvine pg 136
; 4.10.1
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword


.data
bigEndian byte 12h, 34h, 56h, 78h
littleEndian byte ?
.code
main proc
	mov ecx, sizeof bigEndian
	mov esi, 0
	l1:
		mov al, bigEndian[esi]
		mov littleEndian[ecx -1], al
		inc esi
		loop l1
	main ENDP
	END main
