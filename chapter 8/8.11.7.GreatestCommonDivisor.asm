;8.11.7.GreatestCommonDivisor

; This program finds the gcd


include irvine32.inc

; procedures

; 1. displayPurpose
get2values proto ptrval1:ptr dword, ptrval2:ptr dword
gcd proto val11:dword, val22:dword   ; ret eax = gcd
; 4. displayresult     rec eax = gcd


.data


val1 dword 0
val2 dword 0

.code

main proc
	call displayPurpose
l1: invoke get2values, addr val1, addr val2
	invoke gcd, val1, val2
	call displayresult
	jmp l1

exit
main endp










; 1



displayPurpose proc

	.data
	
	msg4 byte "This program displays the greatest common divisor", 0ah,0dh,0

	.code

	mov edx, offset msg4
	call writeString

ret
displayPurpose endp






; 2











get2values proc uses esi edi eax  ptrval11:ptr dword, ptrval22:ptr dword
	
	mov esi, ptrval11
	mov edi, ptrval22
	
	.data

	msg6 byte "Val 1: ", 0
	msg7 byte "Val 2: ", 0
	
	.code
	
	call crlf
	
	mov edx, offset msg6
	call writeString
	call readDec
	mov [esi], eax

	mov edx, offset msg7
	call writeString
	call readDec
	mov [edi], eax


ret
get2values endp








; 3


gcd proc	v1:dword,  v2:dword
; ret eax = gcd
	mov eax, v1
	mov ebx, v2
	mov edx, 0

l1: idiv ebx
	mov eax, ebx
	mov ebx, edx
	mov edx, 0
	cmp ebx, 0
	ja l1

ret
gcd endp







; 4 




displayResult proc

	.data
	
	msg8 byte "GCD: ", 0
	
	.code
	
	mov edx, offset msg8
	call writeString
	call writeDec
	call crlf

ret
displayResult endp








end main