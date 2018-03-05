; x86 irvine pg 136
; 4.10.3
; Summing the gaps between array values
; This program sums the gaps(common difference)
; between each array value
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword


.data
myarray dword 0,2, 5, 9, 10
.code
main proc
	mov ecx, lengthof myarray - 1
	mov esi, 0
	mov eax, 0
	l1:
		mov ebx, myarray[esi]
		mov edx, myarray[esi + type myarray]
		sub edx, ebx
		add eax, edx
		add esi, type myarray
		loop l1
	
	main ENDP
	END main

