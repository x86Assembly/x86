; x86 irvine pg 136
; 4.10.5
; fibonacci numbers
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword


.data
first dword 0
second dword 1
fib dword ?
.code
main proc
	mov ecx, 5               ; first and second already initialized, 5 + 2 = 7
	l1: 
		 mov eax, first      ; clear eax, and add tbe two values
		 add eax, second
		 mov ebx, second      ; the second value is stored in the first
		 mov first, ebx
		 mov second, eax      ; the sum is stored in the second value
		 mov fib, eax         ; stores the current fibonacci number
		loop l1
	main ENDP
	END main

