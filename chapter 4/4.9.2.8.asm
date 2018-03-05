; x86 irvine pg 136
; 4.9.2.8

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
a1 dd 0fh, 0fh, 03h
.code
main proc
	mov esi, offset a1
	mov ecx, lengthof a1
	mov eax, 0
	l1:
		add eax, [esi]
		add esi, type a1
		loop l1

	main ENDP
	END main



