; x86 irvine pg 136
; 4.9.2.16
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword


.data
mybytes byte 10h, 20h, 30h, 40h
mywords word 3 dup(?), 2000h
mystring  byte "abcde"
.code
main proc
	mov eax, dword ptr mybytes

	main ENDP
	END main

