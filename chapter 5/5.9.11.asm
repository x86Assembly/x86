; x86 irvine
; 5.9.11
; puts a 1 in an array at every factor of K

; 1. displayPurpose
; 2. getNumber, returns k in eax
; 3. calculateArray, recieves k in eax
; 4. displayArray 
; 5. resetArray

include irvine32.inc

.data

myArray byte 50 dup(0)
bufferArray byte 1000 dup(0) ; to prevent code from being overwritten
.code
main proc
	call displayPurpose
	call displayArray
	l1:
	call getNumber
	call calculateArray
	call displayArray
	call resetArray

	mov ecx, 2
	l2:
		call crlf
		loop l2
	jmp l1
main ENDP

; 1
displayPurpose proc uses edx
	.data
	display byte "This program puts a 1 in an array at every ",
			 "multiple of K", 0ah, 0dh, 0
	.code
	mov edx, offset display
	call writeString
	ret
displayPurpose ENDP

; 2
getNumber proc uses edx ; returns k in eax
	.data
	prompt1 byte "Enter K: ", 0
	.code
	mov edx, offset prompt1
	call writeString
	call readDec
	ret
getNumber ENDP

; 3
calculateArray proc uses edx esi ecx ; recieves k in eax
	.data
	mult byte 0
	.code
	multi = 3
	mov esi, offset myArray
	mov ecx, lengthof myArray
	mov edx, 1
	l1:
		add esi, eax
		mov [esi], edx
		loop l1
	ret
calculateArray ENDP

; 4
displayArray proc uses esi ecx ebx
	mov esi, offset myArray
	mov ecx, lengthof myArray
	mov ebx, 1
	call dumpMem
	ret
displayArray ENDP

; 5
resetArray proc uses esi ecx edx
	mov esi, offset myArray
	mov ecx, lengthof myArray
	mov edx, 0
	l1:
		mov [esi], edx
		inc esi
		loop l1
	ret
resetArray ENDP

END main

	
	
