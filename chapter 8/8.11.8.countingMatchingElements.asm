
; 8.11.8.countingMatchingElements

; This program counts the number of matching elements in a two
; arrays

include irvine32.inc

; procedures

; 1. displayPurpose
getArrayLength proto pal:ptr dword
getArray proto	pa:ptr dword,  la:dword ; rec: offset & length
countMatches proto ptra1:ptr dword, ptra2:ptr dword, al1:dword
; 4 displayResult

.data

a1 dword  0ffh dup (0)
a2 dword  0ffh dup (0)
alength1 dword 0

.code

main proc
	
	call displayPurpose
l1: invoke getArrayLength, addr alength1
	invoke getArray, addr a1, alength1
	invoke getArray, addr a2, alength1
	invoke countMatches, addr a1, addr a2, alength1
	call displayResult
	jmp l1
exit
main endp


displayPurpose proc
	
	.data
	
	msg2 byte "This program counts matching elements of two arrays.",0ah,0dh,0
	.code

	mov edx, offset msg2
	call writeString
	
ret
displayPurpose endp



























getArraylength proc uses edx eax esi  pal1:ptr dword
	
	.data
	
	msg4 byte 0ah, 0dh, "Array length: ",0
	
	.code
		
	mov edx, offset msg4
	call writeString

	mov esi, pal1
	call readDec
	mov [esi], eax

ret
getArraylength endp







getArray proc uses edx eax ecx esi, pa:ptr dword,   la1:dword
	.data
	msg byte " integer array: ", 0

	.code
	
	call crlf
	mov edi, pa
	mov eax, la1
	call writeDec

	mov edx, offset msg
	call writeString
	call crlf
	call crlf

	mov ecx, la1
	mov esi, 0
	mov eax, 0
l1: call readDec
	mov [edi], eax
	add edi, 4
	loop l1

ret
getArray endp






; 3




countMatches proc uses esi edi pa11:ptr dword, pa22:ptr dword, length11:dword

	mov esi, pa11
	mov edi, pa22
	mov ecx, length11
	mov eax, 0
	

l1:	mov edx, [esi]
	cmp edx, [edi]
	je match
ba: add esi, 4
	add edi, 4
	loop l1
	jmp ext

match:
	add eax, 1
	jmp ba

ext:
ret
countMatches endp















; 4





displayResult proc
	; rec: eax = match count
	.data

	disp1 byte "Matches: ", 0
	
	.code

	mov edx, offset disp1
	call writeString
	call writeDec

ret
displayResult endp


end main