; x86 irvine pg 136
; 4.9.2.18
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword


.data
mybytes16 label word
mybytes byte 10h, 20h, 30h, 40h
mywordsarray label dword
mywords word 3 dup(?), 2000h
mystring  byte "abcde"
.code
main proc
	mov eax, mywordsarray
	mov ax, mybytes16

	main ENDP
	END main

