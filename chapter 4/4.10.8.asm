; x86 irvine pg 138
; 4.10.8
; Shifting the Elements in an Array
; This shifts values one element foward
; and wraps the last element around to the first
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
myarray dword 10h,20h,30h,40h, 50h, 60h
.code
main proc
	mov ecx, lengthof myarray
	mov esi, 0
	mov eax, 0
	l1: 
		xchg eax, myarray[esi]
		add esi, type myarray
		loop l1
		mov myarray, eax
	main ENDP
	END main

