; x86 irvine pg 136
; 4.10.4
; copying a word arraay to a doubleWord array
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword


.data
wordarray word 1000h,2000h,3000h, 4000h
doublearray dword ?
.code
main proc
	mov ecx, lengthof wordarray
	mov esi, 0
	l1: 
		movzx eax, wordarray[esi]
		mov doublearray[esi*2], eax
		add esi, type wordarray
		loop l1
	main ENDP
	END main

