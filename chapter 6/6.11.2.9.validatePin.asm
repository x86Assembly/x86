; 6.11.2.9
; Validating a pin

; This program validates the range of each
; digit of a pin using two arrays, one for
; minimum, one for maximum

; Pseudocode

; display valid range for each digit
; get pin from user, store in buffer
; compare each digit to range


; Procedures defined

; 1. displayRange
; 2. getPin
; 3. validatePin	rec:edx=offsetPin, ret:eax=0 if valid or eax= index of invalid digit0
; 4. displayResult





include irvine32.inc

.data

pin byte 6 dup(0)

.code

main proc

	  call displayRange
l1: call getPin
	  call validatePin
	  call displayResult
	  jmp l1

exit
main endp








; 1

displayRange proc 

	.data
  
	disp1 byte "Range, MSB to LSB", 0ah,0dh
		  byte "digit 1		[5,9]", 0ah,0dh
		  byte "digit 2		[2,5]", 0ah,0dh
		  byte "digit 3     [4,8]", 0ah,0dh
		  byte "digit 4		[1,4]", 0ah,0dh
		  byte "digit 5		[3,6]", 0ah,0dh,0ah,0dh,0
	
	.code

	mov edx, offset disp1
	call writeString

ret
displayRange endp







; 2

getPin proc
	
	.data
	disp2  byte  "Enter 5 digit pin: ", 0
	disp6  byte  "none digit found", 0ah, 0dh, 0
	
	.code

l2:	mov edx, offset disp2
    call writeString
	
  mov edx, offset pin
	mov esi, 0
	mov ecx, 6
	call readString
	mov ebx, 30h ; convert ascii to binaray
	mov ecx, 5
	l1:
		sub [edx], ebx
		inc edx
		loop l1

	
	; valid input check
	mov edx, offset pin
	mov ecx, 5	
	mov eax, 0
	mov ebx, 9
	l3:
		cmp [edx], al
		jb invalid
		cmp [edx], bl
		ja invalid
		inc edx
		loop l3
		jmp ext

invalid:
	mov edx, offset disp6
	call writeString
	jmp l2
		
		
ext:
	
mov edx, offset pin	
ret
getPin endp






; 3

validatePin proc
	
	; rec: edx=offsetpin ret: if valid, eax=0
							 ; else eax= index of invalid digit
	.data
	
	upperlimit byte 9,5,8,4,6
	lowerlimit byte 5,2,4,1,3
	
	.code
	
	mov ecx, 5
	mov esi, 0

l1: 
	mov al, upperlimit[esi]
	cmp [edx], al
	ja invalid
	mov al, lowerlimit[esi]
	cmp [edx], al
	jb invalid
	inc edx
	inc esi
	loop l1
	mov eax, 0
	jmp ext

invalid:
	inc esi
	mov eax, esi
	
ext:
ret
validatePin endp





; 4

displayResult proc
	
	.data

	disp3 byte "valid", 0ah,0dh,0
	disp4 byte "Invalid range, digit # ", 0

	.code

	cmp eax, 0
	je valid
	
	mov edx, offset disp4
	call writeString
	call writeDec
	call crlf
	jmp ext
	
valid:
	mov edx, offset disp3
	call writeString

	

ext:
ret
displayResult endp 

end main

	
	
