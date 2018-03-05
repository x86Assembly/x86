; x86 irvine pg 136
; 4.9.2.15
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
	mov al, byte ptr [mywords + 1]

	main ENDP
	END main
