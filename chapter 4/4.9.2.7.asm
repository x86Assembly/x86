; x86 irvine pg 136
; 4.9.2.7

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

; eax = -val2 + 7-val3+val1
.data
val1 dd 12345678h
val2 dd 87654321h
val3 dd 0000000fh
.code
main proc
	neg val2
	mov eax, val2
	add eax, 7
	sub eax, val3
	add eax, val1

	main ENDP
	END main

