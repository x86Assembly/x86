; x86 irvine pg 138
; 4.10.7
; Copy a string in reverse order
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword


.data
source byte "A wonderful day to be programming", 0
target byte sizeof source dup("#")
.code
main proc
	mov ecx, sizeof source
	mov esi, 0
	l1: 
		mov ebx, sizeof source - 1
		sub ebx, esi             ; ebx starts at the last element
		mov al, source[ebx]
		mov target[esi], al
		inc esi
		loop l1
	main ENDP
	END main
