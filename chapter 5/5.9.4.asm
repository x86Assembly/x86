;5.9.4
; This program prompts the user for
; two integers and displays the result
; repeating this 3 times

include Irvine32.inc
.data

.data
prompt1 byte "Enter the first integer: ", 0
prompt2 byte "Enter the second integer: " ,  0
display1 byte "The two values added together is: ", 0
value1 sdword ?
value2 sdword ?
sum sdword ?
.code

main proc
	mov ecx, 3
	l1:
		call addInt
		call clrscr
		loop l1
	exit
main ENDP

addInt proc uses ecx
	call displayPurpose

	; get first number
	mov edx, offset prompt1
	call writestring
	call readInt
	mov value1, eax

	; get second number
	mov edx, offset prompt2
	call writestring
	call readInt
	mov value2, eax

	; add the numbers
	mov eax, value1
	add eax, value2
	mov sum, eax

	; display sum
	mov edx, offset display1
	call writeString
	mov eax, sum
	call writedec

	; pause screen
	mov ecx, 10
	l1: call crlf 
	loop l1
	call waitmsg
	ret
addInt ENDP

getString proc
	.code
	call readint
getString ENDp

displayPurpose proc
	.data
	info byte "This programs adds two integers", 0ah, 0dh,
			  "repeating 3 times", 0ah, 0dh, 0
	.code
	mov dh, 10
	mov dl, 0
	call goToXY
	mov edx, offset info
	call writeString
	call crlf
	ret
displayPurpose ENDP
	

END main
