; 6.11.2.10
; parity check

; This program tests and returns
; the parity of an array,
; eax = 1 if array contains an even
; number of bits, eax = 0 if the 
; array contains an odd number of 
; bits

; pseudocode

; get array from user
; calculate parity
; display result

; procedures defined		ret = returns	rec = recieves							EXPLAINATION

; 1. displayPurpose		rec:nothing		ret:nothing						displays purpose
; 2. getArray			rec:nothing		ret: esi = offset array, ecx = lengthof array		gets array from user
; 3. calculateParity		rec: esi = offset array, ecx= lengthof array					calculates parity of array
; 4. displayResult		ec: eax = 1 if even, eax = 0 if odd						displays even/odd

include Irvine32.inc

.code

main proc
	
	call displayPurpose
l1: call getArray
	call calculateParity
	call displayResult
	jmp l1
exit
main endp





; 1

displayPurpose proc
		
	.data
	
	disp byte 0ah, 0dh, "This program displays the parity of an array.",0ah,0dh
		 byte "Valid inputs are unsigned integers, characters, and strings.", 0ah, 0dh
		 byte "Separate elements with a space,",0ah,0dh
		 byte "Then press enter.",0ah,0dh, 0

	.code
	
	mov edx, offset disp
	call writeString

ret
displayPurpose endp







; 2

getArray proc
	; rec:nothing	ret: esi = offset array  ecx = length of array
	.data
	disp2 byte 0ah, 0dh,"Enter array: ", 0
	string byte 0ffh dup (0)
	stringLength dword (0)
	array byte 0ffh dup (0)
	arrayLength dword (0)
	.code
	
	mov edx, offset disp2
	call writeString
	
	mov edx, offset string
	mov ecx, lengthof string
	call readString

	mov ecx, eax
	mov edx, offset string
	mov esi, offset array
	mov ebx, 0

l1: mov al, [edx]
	cmp al, ' '
	je space
	call isDigit
	jne cha
	sub al, 30h ; convert integer string to binary
cha:mov [esi], al
	inc edx
	inc esi
	inc ebx
	loop l1
	jmp ext
	

space:
	inc edx
	loop l1

ext:
mov arrayLength, ebx
mov ecx, arrayLength
mov esi, offset array
ret
getArray endp





; 3

calculateParity proc
	; rec: ecx = length array, esi = offset array
	; ret: nothing
	cmp ecx, 1
	je one
	sub ecx, 1
one:mov al, [esi]
l1:	inc esi
	xor al, [esi]
	loop l1

	jp evenn
	
	mov eax, 0
	jmp ext

evenn:
	mov eax, 1

ext:
ret
calculateParity endp







; 4

displayResult proc
	; rec: eax = 1 if even,		eax = 0 if odd
	.data

	disp3 byte "Parity set (even)", 0
	disp4 byte "Parity clear (odd)",0
	disp5 byte "recieved invalid value",0

	.code
	
	cmp eax, 0
	je odd1

	cmp eax, 1
	je even1

	mov edx, offset disp5
	jmp ext

odd1:
	mov edx, offset disp4
	jmp ext

even1:
	mov edx, offset disp3
	
ext:
	call writeString

call crlf
ret
displayResult endp


end main
	
	
