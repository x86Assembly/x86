; 7.10.8.AddPackedIntegers


; This program using a procedure to add two packed decimal strings

; Pseudocode

; get 2 values from user
; add two strings
; display result, trim upper line

; Procedures defined

; 1. displayPurpose
; 2. get2Strings
; 3. addPacked
; 4. displayResult

include irvine32.inc


.data

byte4d1 byte 12h,34h,56h,78h
byte4d2 byte 11h,22h,33h,44h
byte8d1 byte 11h,22h,11h,22h,11h,44h,44h,22h
byte8d2 byte 55h,66h,33h,22h,55h,33h,44h,22h
byte16d1 byte 33h,44h,22h,44h,22h,44h,22h,44h,33h,44h,22h,44h,22h,44h,22h,44h
byte16d2 byte 45h,32h,12h,11h,21h,12h,12h,32h,12h,32h,12h,32h,12h,32h,54h,34h
sum byte 17 dup (0)


.code

	main proc
		
		mov esi, offset byte4d1
		mov edi, offset byte4d2
		mov ecx, 4
		mov edx, offset sum
		call addPacked

		mov esi, offset byte8d1
		mov edi, offset byte8d2
		mov ecx, 8
		mov edx, offset sum
		call addPacked

		mov esi, offset byte16d1
		mov edi, offset byte16d2
		mov ecx, 16
		mov edx, offset sum
		call addPacked
		call crlf
		call waitmsg
exit
main endp





addPacked proc

	mov sum, 0

	mov edx, ecx
	sub edx, 1
	add esi, edx
	add edi, edx
	add edx, 1
	push ecx
	mov eax, 0
	clc
	
l1: mov al, byte ptr [esi]
	adc al, byte ptr [edi]
	daa
	mov byte ptr sum[edx], al
	dec esi
	dec edi
	dec edx
	loop l1

	mov al, 0
	adc al, 0
	mov byte ptr sum[edx], al
	
	pop ecx
	add ecx, 1
	call writePacked


ret
addPacked endp

writePacked proc
	mov esi, 0
	call crlf
l2: mov al, byte ptr sum[esi]
	mov ebx, 1
	inc esi
	call writeHexb
	loop l2

ret
writePacked endp
	

end main