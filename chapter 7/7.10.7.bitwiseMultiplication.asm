; 7.10.7.bitwiseMultiplication

; This program multiplies two values using 
; only shift instructions


; Pseudocode

; get two values from user
; multiply values
; display result

; Procedures defined

; 1. displayPurpose
; 2. getab			; ret: eax=val1 ebx=val2
; 3. bitwiseMultply ; rec: eax=val1 ebx=val2
; 4. displayResult


include Irvine32.inc

.code
	
	main proc
	
		call displayPurpose
	l1: call getab
		call bitwiseMultiply
		call displayResult
		jmp l1

	exit
	main endp





; 1







displayPurpose proc
	
	.data

	disp1 byte "This program multiplies two unsigned integers using only shift instructions", 0ah, 0dh, 0ah, 0dh, 0

	.code

	mov edx, offset disp1
	call writeString

ret
displayPurpose endp






; 2





getab proc
	
	.data

	disp2 byte  "Enter value 1: ", 0
	disp3 byte  "Enter value 2: ", 0

	.code

	mov edx, offset disp2	
	call writeString
	call readdec
	mov ebx, eax
	
	mov edx, offset disp3
	call writeString
	call readdec
	

ret
getab endp








; 3








bitwiseMultiply proc

	mov ecx, 32
	mov edx, 0	
	mov edi, 0    ; copy ebx
	mov esi, 0		; esi keeps index of binary


	; if either values are value
	cmp eax, 0
	je zero
	cmp ebx, 0
	je zero






	
l1: shr ebx, 1
	jc addOne
l2: inc esi
	shr ebx, 1
	jc shift
	loop l2
	jmp ext

addOne:
	add edi, eax
	jmp l2
shift: 
	push ecx
	mov ecx, esi
	shl eax, cl
	pop ecx
	loop l2
	
	
ext:

add eax, edi
jmp extn

zero:
	mov eax, 0
extn:


ret
bitwiseMultiply endp







; 4





displayResult proc

	.data

	disp4 byte "Product: ", 0
	
	.code
	
	mov edx, offset disp4
	call writeString
	call writeDec
	call crlf


ret
displayResult endp


end main
	
