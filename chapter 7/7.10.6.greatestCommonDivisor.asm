; 7.10.6.greatestCommonDivisor

; This program calculates the GCD of two numbers

; Pseudocode

; get numbers from user
; calculate gcd
; display result

; procedures defined

; 1. displayPurpose
; 2. getab
; 3. gcd
; 4. displayResult

include irvine32.inc


.data
small1 dword 0
large1 dword 0
gcd1 dword 0

.code

main proc
	call displayPurpose
l1: call getab
	call gcd
	call displayResult
	jmp l1

exit
main endp






; 1





displayPurpose proc
	
	.data 
	
	disp1 byte "This program calculates the greatest common divisor", 0ah,0dh
	      byte "of two values", 0ah, 0dh, 0
	
	.code

	mov edx, offset disp1
	call writeString
	
ret
displayPurpose endp







; 2





getab proc
	
	.data
	
	disp2 byte "Enter smaller value: ", 0
	disp3 byte "Enter larger value: ", 0
	
	.code

	mov edx, offset disp2
	call writeString
	call readDec
	mov small1, eax

	mov edx, offset disp3
	call writeString
	call readDec
	mov large1, eax
	
ret
getab endp






; 3





gcd proc
	; eax and ebx contain a value

	mov edx, 0   ; clear remainder
	
	mov eax, large1
	mov ebx, small1


l1: idiv ebx
	mov eax, ebx
	mov ebx, edx
	mov edx, 0
	cmp ebx, 0
	ja l1
	
mov gcd1, eax

ret
gcd endp








;  4




displayResult proc
	
	.data

	disp4 byte "The gcd is: ", 0
	
	.code
	


	mov edx, offset disp4
	call writeString

	mov eax, gcd1
	call writeDec

	call crlf
	call crlf
	
	call crlf
	call crlf

ret
displayResult endp


end main
