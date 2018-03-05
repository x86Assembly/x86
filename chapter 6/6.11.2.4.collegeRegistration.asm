; 6.11.2.4
; college registration

; This program recieves the grade average
; and credits enrolled from the user, calculates 
; whether the student can enroll, and displays
; a message of the result

; pseudocode

; display purpose
; get grade average - range check 400
; get credits - range check 1-30
; calculate evaluation
; display message

; procedures defined

; 1. displayPurpose
; 2. getab
; 3. calculateEvaluation	rec: eax=grade average ebx=credits enrolled ret: cf=0 if student can register
; 4. displayMessage         rec: cf, if cf=0 display "can register", if cf=1 display "cant register"

include Irvine32.inc

.code
main proc
	  call displayPurpose
l1: call getab
	  call calculateEvaluation
	  call displayMessage
	  jmp l1
exit
main endp

; 1.
displayPurpose proc
	.data
	disp byte 0ah, 0dh, "This program calculates whether a student can register or not.", 0ah, 0dh, 0
	.code
	mov edx, offset disp
	call writeString
ret
displayPurpose endp

; 2.
getab proc
	.data
	disp1 byte "Enter grade average (0-400): ", 0
	disp2 byte "Enter credits (1-30): ", 0
	.code
	  mov edx, offset disp2
l1: call writeString
	  call readDec
	  cmp eax, 30
	  jnbe l1
	  cmp eax, 1
	  jnae l1
	  mov ebx, eax ; store credits in ebx

	mov edx, offset disp1
l2: call writeString
	  call readDec
	  cmp eax, 400
	  jnbe l2
	  cmp eax, 1
	  jnae l2
ret
getab endp

; 3
calculateEvaluation proc
	; rec: eax=credits ebx=gradeAverage ret: if can register cf=0, else cf=1
	cmp eax, 350
	jg canRegister
	
	cmp eax, 250
	jng next
	cmp ebx, 16
	jle canRegister

next: 
	cmp eax, 12
	jle canRegister
	
	clc
	jmp ext

canRegister:
	stc

ext:
ret
calculateEvaluation endp

; 4
displayMessage proc
	.data
	yes byte "The student may register", 0ah, 0dh, 0
	no byte "The student can't register", 0ah, 0dh, 0
	.code
  
	jc can
	mov edx, offset no
	jmp write
can:
	mov edx, offset yes
	
write:
	call writeString
	
ret
displayMessage endp

end main
