
; 3.10 programming exercises pg 94

; 1. Integer Expression Calculation



; This program simulates the equation A = (A + B) - (C + D)

; using registers



.386

.model flat,stdcall

.stack 4096

ExitProcess proto,dwExitCode:dword



.code

main proc

	mov eax, 1

	mov ebx, 2

	mov ecx, 3

	mov edx, 4

	add eax, ebx

	add ecx, edx

	sub ecx, eax

	mov eax, ecx



	invoke Exitprocess,0

main endp

end main
