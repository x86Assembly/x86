; 8.11.4.FindThreesProcedures

; This program displays whether an array contains
; three consecutive values of 3



include irvine32.inc

; procedures

; 1. displayPurpose
getArrayLength proto pal:ptr dword
getArray proto	pa:ptr dword,  la:dword ; rec: offset & length
findThrees proto pa2: ptr dword, la2:dword ; ret: if 3of3 eax=1, else eax= 0
; 5. displayResult		; rec eax

.data



a1 dword 0ffh dup (0)
alength dword 0ffh

.code

main proc

	call displayPurpose
l1: invoke getArrayLength, addr alength
	invoke getArray, addr a1, alength
	invoke findThrees, addr a1, alength
	call displayResult
	jmp l1

exit
main endp







; 1



displayPurpose proc
	
	.data
	
	msg2 byte "This program display whether an array contain three consecutive", 0ah,0dh
	     byte "values of 3", 0ah,0dh,0

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

	mov ecx, la1
	mov esi, 0
	mov eax, 0
l1: call readDec
	mov [edi], eax
	add edi, 4
	loop l1

ret
getArray endp



















; 4



findThrees proc uses ebx ecx edx esi edi  pa3: ptr dword, la3:dword

	mov esi, pa3
	mov edi, 0
	mov ecx, la3
	mov eax, 0  ; eax is 3/3 flag, set to zero
	mov ebx, 0  ; this counts consecutive threes
	
l1:	cmp byte ptr [esi], 3
	je three1
	add esi, 4	 ; move to next
	mov ebx, 0   ; if not a 3, reset 3 count
	loop l1
	jmp ext

three1:
	add ebx, 1		; three found, add 1 to count
	cmp ebx, 3      ; if three 3's found, jump out
	je threesFound
	add esi, 4
	loop l1
	jmp ext

threesFound:
	mov eax, 1
	jmp ext

ext:
ret
findThrees endp

















; 5



displayResult proc
	
	.data
	yes1 byte "Three consecutive 3's found", 0ah, 0dh,0
	no1 byte "Three consecutive 3's not found", 0ah, 0dh,0

	.code

	cmp eax, 1
	je yes2
	mov edx, offset no1
	call writeString
	jmp ext


yes2:
	mov edx, offset yes1
	call writeString

ext:
ret
displayResult endp




end main
	
	



