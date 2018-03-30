
; 8.11.9.CountingNearlyMatchingElements

; This program counts the number of nearly matching elements in a two
; arrays

include irvine32.inc

; procedures

; 1. displayPurpose
getArrayLength proto pal:ptr dword
getMaxDiff proto dif1:ptr dword
getArray proto	pa:ptr dword,  la:dword ; rec: offset & length
countNearMatches proto ptra1:ptr dword, ptra2:ptr dword, al1:dword, diff11:dword
; 6 displayResult

.data

a1 dword  0ffh dup (0)
a2 dword  0ffh dup (0)
alength1 dword 0
diff dword 0

.code

main proc
	
	call displayPurpose
l1: invoke getArrayLength, addr alength1

    invoke getMaxDiff, addr diff
	invoke getArray, addr a1, alength1
	invoke getArray, addr a2, alength1
	invoke countNearMatches, addr a1, addr a2, alength1, diff
	call displayResult
	jmp l1
exit
main endp






; 1





displayPurpose proc
	
	.data
	
	msg2 byte "This program counts the nearly matching elements of two arrays.",0ah,0dh,0
	.code

	mov edx, offset msg2
	call writeString
	
ret
displayPurpose endp














; 2 







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













; 3





getMaxDiff proc ptrDiff:ptr dword
	
	.data
	
	disp3 byte "Max difference: ",0
	
	.code
	mov esi, ptrDiff

	mov edx, offset disp3
	call writeString

	call readDec
	mov [esi], eax
	
ret
getMaxDiff endp









; 4







getArray proc uses edx eax ecx esi, pa:ptr dword,   la1:dword
	.data
	msg byte " integer array: ", 0
	string byte 21 dup (0)

	.code
	mov esi, 0 ; for string

	mov edi, pa
	mov eax, la1
	call writeDec

	mov edx, offset msg
	call writeString

	mov ecx, la1
	mov esi, 0
	mov eax, 0

comment !
	; This commented out code is simpler, but will not display
	; the array on the same line, readDec automatically prints
    ; a cr line feed after each value, which would be less appealing to the user.
	; The code after this code is all there in order to display 
	; the array on the same line

l1: call readDec
	mov [edi], eax
	add edi, 4
	loop l1
	
		!  ; end of comment block

l1: call readchar
	cmp al, 0dh
	je nx
	mov string[esi], al
	call writechar
	inc esi
	jmp l1
nx:
	mov al, ','
	cmp ecx, 1
	je ov
	call writechar
ov: mov edx, offset string
	push ecx
	mov ecx, lengthof string
	pop ecx
	call parsedecimal32
	mov [edi], eax
	add edi, 4

	; reset string
	push ecx
	mov esi, 0
	mov ecx, lengthof string
l2: mov string[esi], 0
	inc esi
	loop l2

	mov esi, 0
	pop ecx
	loop l1
	
call crlf
ret
getArray endp


















; 5









countNearMatches proc uses esi edi pa11:ptr dword, pa22:ptr dword, length11:dword, dif1:dword

	mov esi, pa11
	mov edi, pa22
	mov ecx, length11
	mov eax, 0
	mov ebx, dif1
	

l1:	mov edx, [esi]
	sub edx, [edi]
	cmp edx, 0
	jl negate
b1: cmp edx, ebx
	jle nearMatch
ba: add esi, 4
	add edi, 4
	loop l1
	jmp ext

nearMatch:
	add eax, 1
	jmp ba
negate:
	neg edx
	jmp b1

ext:
ret
countNearMatches endp












; 6





displayResult proc
	; rec: eax = match count
	.data

	disp1 byte "Matches: ", 0
	
	.code

	call crlf
	mov edx, offset disp1
	call writeString
	call writeDec

call crlf
ret
displayResult endp


end main