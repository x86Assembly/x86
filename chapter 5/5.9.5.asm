;5.9.5
; This program generates random numbers
; within an input range

include Irvine32.inc
.data
min sdword ?
max sdword ?
.code

main proc
	call displayPurpose
	call getRange
	mov ecx, 10
	mov ebx, min
	mov eax, max
	l1:
		call betterRandomRange
		loop l1


	mov ecx, 10
	l2:
		call crlf
		loop l2
	call waitmsg
	exit
main ENDP

getrange proc
	.data
	prompt1 byte "Enter minimum: ", 0
	prompt2 byte "Enter maximum: ", 0
	.code
	
	; get minimum
	mov edx, offset prompt1
	call writestring
	call readInt
	mov min, eax
	call crlf

	; get maximum
	mov edx, offset prompt2
	call writestring
	call readInt
	mov max, eax
	call crlf

	ret
getRange ENDP



; recieves min in ebx, max in eax
; returns random integer to eax
betterRandomRange proc uses ebx eax
	sub eax, ebx
	call randomrange
	add eax, min
	call writedec
	call crlf
	ret
betterRandomRange ENDP
	

displayPurpose proc
	.data
	info byte "This program generates 10 random", 0ah, 0dh,
			  "numbers within a given range.", 0ah, 0dh, 0
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
