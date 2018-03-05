
; 6.11.2.3

; Test Score Evaluation

;

include irvine32.inc

; CalcGrade;rec:al=int[0-100];ret:al=char



; This program defines and runs a 

; calcGrade procedure.

; We first define the procedure





.code

calcGrade proc uses ebx ecx edx

;rec al=[0,100] ret al=charGrade if invalid cf=1 els cf=0



	.code
	cmp al, 100d
	ja inv

	cmp al, 90d
	jae A

	cmp al, 80d
	jae B

	cmp al, 70d
	jae Cg

	cmp al, 60
	jae D

	mov al, 'F'
	jmp ext



A: mov al, 'A'
	jmp ext

B: mov al, 'B'
	jmp ext

Cg: mov al, 'C'
	jmp ext

D: mov al, 'D'
	jmp ext

inv: 
    stc
	jmp invext

ext:
clc
invext:
ret
calcGrade endp



; Pseudocode
; display purpose
; get grade from user
; if user enters negative number, display that many random grades
; convert integer to character
;	return char in eax
; display char grade


; procedures defined
; 1. calcGrade
; 2. displayRandomGrades rec eax=number of grades to display
; 3. displayPurpose
; 4. displayGrade
; 5. getRandom100
; 6. getGrade



.data
score byte 0
.code
	main proc
		call displayPurpose
	l1: call getGrade
		cmp eax, 101
		jg l1
		je tes
		mov score, al
		cmp eax, 0
		jl rand
		call calcGrade
		call displayGrade
		jmp l1
	rand:
		neg eax
		mov ecx, eax
		call displayRandomGrades
		jmp l1
	tes:
			 call crlf
			 mov ecx, 101
		l2:  mov eax, 101
			 sub eax, ecx
			 mov score, al
			 call calcGrade
			 call displayGrade
			 loop l2
		jmp l1
			

	exit

	main endp 



; 2

displayRandomGrades proc uses ebx ecx edx
; rec ecx=number of randoms to display
	l4:
		call getRandom100
		mov score, al
		call calcGrade
		call displayGrade
		loop l4

ret

displayRandomGrades endp

; 3
displayPurpose proc
pushad ; rec:nothing;ret:nothing
	.data
	disp byte 10,13, "This progrom calculates a students "
				byte "grade.", 10,13
				byte "Valid inputs are (-,101].",10,13
				byte "A negative input will display random grades.",10,13
				byte "Enter 101 to test the the calcGrade procedure.",10,13,0

	.code
	mov edx, offset disp
	call writeString
	call crlf

popad
ret
displayPurpose endp

; 4
displayGrade proc
pushad ;rec:al=charGrade;ret:nothing
	call writeChar
	mov al, ' '
	call writeChar
	mov al, score
	call writeDec
	call crlf

popad
ret
displayGrade endp

; 5
getRandom100 proc
;rec nothing; ret eax=random [0,100]
	mov eax, 100
	call randomRange

ret
getRandom100 endp

; 6

getGrade proc uses ebx ecx edx esi
; rec nothing; ret al=[-2,100]
	.data
	prompt1 byte "Enter -n to 101: ", 0
	inv1 byte "invalid input",0

	.code
l3: mov edx, offset prompt1
	call writeString
	call readInt
	cmp eax, 101
	jg inv
	jmp ext
inv:
	mov edx, offset inv1
	call writeString
	call crlf

ext:
ret
getGrade endp



end main

	
	
