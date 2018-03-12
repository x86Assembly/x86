; 7.10.1
; DisplayAsciiDecimal

; This program accepts a digit string from
; the user, along with a decimal offset value
; for which the decimal point is to be placed.
; A procedure is then used to display the value
; with the decimal point


; Pseudocode

; get digit string from user
; get decimal offset from user
; create string with decimal point at offset
;		if offset greater than length of string
;				display error
; repeat program

; procedures defined	rec/ret		

; 1. displayPurpose		rec:n;ret:n	
; 2. getdecimal			rec:n;ret: edx=offset value, ecx=length, ebx=decimaloffset
; 3. writeScaled		rec: edx=offset value, ecx=length, ebx=decimaloffset


include irvine32.inc

.data

digitString	byte 0ffh dup (0)
digitStringLength dword 0
offsetDecimal dword 0


.code

	main proc
		call displayPurpose
l1:		call getdecimal
		call writeScaled
		jmp l1
exit
main endp






; 1










displayPurpose proc
	
	.data
	msg byte 0ah, 0dh, "This program accepts a digit string and decimal offset from the user, ", 0ah,0dh
		byte "then displays the value with the decimal", 0ah, 0dh, 0
	
	.code

	mov edx, offset msg
	call writeString
	call crlf
	call crlf

ret
displayPurpose endp






; 2





getDecimal proc

	.data

	disp1 byte "Enter digit string: ",  0
	disp2 byte "Enter decimal offset: ",  0
	error1 byte "Decimal offset can't be longer than string", 0ah, 0dh,0
	error2 byte "Invalid character found, Don't include decimal point in string", 0ah, 0dh, 0

	.code
	
beg:mov edx, offset disp1
	call writeString
	
	mov edx, offset digitString		; get digit
	mov ecx, lengthof digitString
	call readString
	mov digitStringLength, eax

	
	mov esi, offset digitstring    ; check string for invalid charcters
	mov ecx, digitStringLength
l1:	mov al, byte ptr [esi]
	cmp al, 30h
	jb err2
	cmp al, 39h
	ja err2
	inc esi
	loop l1

	mov edx, offset disp2		; get decimal offset
	call writeString
	
	call readDec
	mov offsetDecimal, eax
	
	cmp digitStringLength, eax
	jb err1
	jmp ext

err2:
	mov edx, offset error2
	call writeString
	jmp beg

err1:
	mov edx, offset error1
	call writeString
	jmp beg

ext:

mov ebx, offsetDecimal
mov ecx, digitStringLength
mov edx, offset digitString

ret
getDecimal endp




; 3






writeScaled proc
	; rec
	; ebx = offsetdecimal value
	; ecx = length of string
	; edx = offset string
	
	mov eax, 0

	mov edi, ecx
	sub edi, ebx

l2: cmp ecx, ebx
	je addDecimal
ba: mov al, [edx]
    call writeChar
	inc edx
	loop l2
	cmp ebx, 0
	je addDecimalLast
	jmp ext

addDecimal:
	mov al, '.'
	call writeChar
	jmp ba
addDecimalLast:
	mov al, '.'
	call writeChar

ext:

call crlf
ret
writeScaled endp


end main
	
		

	
	
