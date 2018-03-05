;5.9.6
; This programs generates 10 sets of random strings
; of which the length of the strings is defined
; by the user, then repeats the program 3 times
; 65-80 are capital letters in ascii

; 6 procedures are defined
; 1. main
; 2. displayRandom
; 3. getRandomString
; 4. getLength
; 5. betterRandomRandom
; 6. displayPurpose


include Irvine32.inc
.data
randomString byte 1000 dup(?)
stringLength dword ?
.code

; 1
main proc
	mov ecx, 3
	l1:
		call displayRandom
		call clrscr
		loop l1
	exit
main ENDP

; 2
displayRandom proc uses ecx
	call displayPurpose
	call getlength
	mov ecx, 10
	mov edx, offset randomString ; for writeString
	mov esi, offset randomString ; for pointer used in randomString
	l1:
		
		call getRandomString
		call writeString
		add edx, eax
		call crlf
		loop l1

	mov ecx, 10
	l2:
		call crlf
		loop l2
	call waitmsg
	ret
displayRandom ENDP

; 3
; recieves length of string in eax,
; recieves offset of array to store string in esi,
; returns a random string at given offset
getRandomString proc uses ecx eax edx
	mov ecx, eax
	mov edx, 0
	mov eax, 80
	mov ebx, 65
	l1:
		mov eax, 80
		mov ebx, 65
		call betterRandomRange
		mov [esi], eax
		add esi, 1
		loop l1
	;mov [esi], edx
	ret
getRandomString ENDP

		
		
	
; 4
getLength proc
	.data
	prompt1 byte "Enter the length of the strings: ", 0
	.code
	
	; get value
	mov edx, offset prompt1
	call writestring
	call readInt
	mov stringLength, eax
	call crlf

	ret
getLength ENDP


; 6
; recieves min in ebx, max in eax
; returns random integer to eax
betterRandomRange proc uses ebx
	sub eax, ebx
	call randomrange
	add eax, ebx
	;call writedec
	ret
betterRandomRange ENDP
	

; 7
displayPurpose proc
	.data
	info byte "This programs generates 10 sets of random strings of", 0ah, 0dh,
			  "which the length of the strings is defined by the user.", 0ah, 0dh, 
			  "The program then repeats 3 times.", 0ah, 0dh, 0
	.code
	mov dh, 1
	mov dl, 0
	call goToXY
	mov edx, offset info
	call writeString
	call crlf
	ret
displayPurpose ENDP
	

END main
