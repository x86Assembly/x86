; x86 irvine
; 5.9.10
; fibonacci numbers

include irvine32.inc

.data
first dword 0
second dword 1
fib dword ?
prompt1 byte "This program displays fibonacci numbers.", 0ah, 0dh, 0
prompt byte "Enter fibonacci number to calculate: ", 0
.code
main proc
	mov edx, offset prompt1
	call crlf
	call writeString
	call crlf
	l3:
	mov edx, offset prompt
	call writeString 
	call readDec
	mov ecx, eax
	mov eax, 0
	l1: 
		 call writespace
		 call writeDec
		 mov eax, first      ; clear eax, and add tbe two values
		 add eax, second
		 mov ebx, second      ; the second value is stored in the first
		 mov first, ebx
		 mov second, eax      ; the sum is stored in the second value
		 mov fib, eax         ; stores the current fibonacci number
		
		loop l1
	
	mov ecx, 5
	l2:
		call crlf
		loop l2

	mov first, 0 ; reset variables
	mov second, 1
	jmp l3
	main ENDP

writespace proc uses eax
	mov al, 32d
	call writechar
	ret
writespace ENDP
	END main
