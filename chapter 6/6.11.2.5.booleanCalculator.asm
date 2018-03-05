; 6.11.2.5
; boolean Calculator

; This program displays a menu for the user
; to select a procedure to execute. Procedures
; are stored using table-driven selection.

; user choices
; 1. x And y
; 2. x Or y
; 3. Not x
; 4. x xor y
; 5. exit program

; Pseudocode
; display menu
; get user selection
; search for selection
; get x, or get x and y
; calculate data
; display result
; repeat program

; Procedures defined   rec = recieves	 	 ret = returns			EXPLAINATION

; 1. displayMenu	 rec:nothing		ret:nothing			Displays menu
; 2. getSelection	 rec:nothing		ret:al=selection		Gets selection from user
; 3. tableSelection    rec:al=selection		ret:nothing			Finds procedure from table and calls it
; 4. getx		rec:nothing		ret: eax = x			Gets x from user
; 5. gety		rec:nothing	    	ret: ebx = y			Gets y from user
; 6. xAndy		rec:nothing		ret:nothing			Executes and displays <AND eax, ebx>	result
; 7. xOry		rec:nothing		ret:nothing			Executes and displays <OR  eax, ebx>  result
; 8. notx		rec:nothing		ret:nothing			Executes and displays <NOT eax>	result
; 9. xXORy		rec:nothing		ret:nothing			Executes and displays <xor eax, ebx> result
; 10. exitProgram    	rec:nothing	    	ret:nothing			Displays goodbye and exits program
; 11. displayBreak	rec:nothing		ret:nothing			Displays a line, separating data

include Irvine32.inc



.code

main proc
		l1: call displayMenu
	 call getSelection
		call displayBreak
		call tableSelection
		call displayBreak
		jmp l1
exit
main endp









; 1.

displayMenu proc uses edx

	.data ; rec:nothing ret:nothing

	disp1 byte 0ah,0dh,"Menu",0ah,0dh
		 byte "1. x AND y", 0ah, 0dh
		 byte "2. x Or y", 0ah, 0dh
		 byte "3. Not x", 0ah, 0dh
		 byte "4. x Xor y",0ah, 0dh
		 byte "5. Exit Program", 0ah, 0dh,0

	.code
	
	mov edx, offset disp1
	call WriteString
ret
displayMenu endp






; 2

getSelection proc uses edx

	.data ; rec:nothing  ret:eax=selection
	disp2 byte 0ah, 0dh,"Enter selection (1-5): ", 0
	error byte "Invalid input.", 0ah, 0dh, 0
	
	.code
l1: mov edx, offset disp2 ; display prompt
	call writeString
	call readDec

	cmp eax, 0	; range check
	jna dispError
	cmp eax, 5
	jnbe dispError
	jmp ext

dispError:		; display Error, get another selection
	mov edx, offset error
	call writeString
	jmp l1

ext:
call crlf
ret
getSelection endp








; 3

tableSelection proc
	.data ; rec eax=selection   ret nothing
	caseTable  byte 1
			   dword xAndy
	caseLength = ($-caseTable)
			   byte 2
			   dword xOrY
			   byte 3
			   dword notX
			   byte 4
			   dword xXORy
			   byte 5
			   dword exitProgram
	numberOfCases = ($-caseTable) / caseLength

	.code
	mov ebx, offset caseTable
	mov ecx, numberOfCases
	
compare:
	cmp al, [ebx]
	jne next
	call near ptr [ebx + 1]
	jmp ext

next:
	add ebx, caseLength
	loop compare

ext:
ret
tableSelection endp





; 4

getx proc uses edx
	.data	; rec:nothing	ret: eax = x value
	disp3 byte "Enter x: ", 0
	error1 byte "Invalid input.", 0ah,0dh, 0
	.code
l1: mov edx, offset disp3
	call writeString
	call readInt
	jo l1
	jmp ext


ext:
ret
getx endp







; 5

gety proc uses edx eax
	.data ; rec:nothing ret: ebx= decimal value
	disp4 byte "Enter y: ", 0
	error2 byte "Invalid input.", 0ah, 0dh, 0
	
	.code
l1: mov edx, offset disp4
	call writeString
	call readInt
	jo l1
	jmp ext

ext:
mov ebx, eax
ret
gety endp






; 6

xAndy proc uses edx
	.data ; rec: nothing ret: nothing
	disp5 byte "x And y", 0ah, 0dh, 0
	
	.code
	mov edx, offset disp5
	call writeString
	call getx
	call gety
	and eax, ebx
	call writeBin
	call crlf

ret
xAndy endp






; 7

xOry proc uses edx
	.data ;rec: nothing    ret: nothing
	disp6 byte "x OR y", 0ah, 0dh, 0
		
	.code
	mov edx, offset disp6
	call writeString
	call getx
	call gety
	or eax, ebx
	call writeBin
	call crlf

ret
xOry endp







; 8

notx proc uses edx
	.data ; rec: nothing  ret: nothing
	disp7 byte "NOT x (one's compliment)", 0ah, 0dh, 0
	
	.code
	
	mov edx, offset disp7
	call writeString
	call getx
	not eax
	call writeBin
	call crlf

ret
notx endp






; 9

xXORy proc uses edx
	.data ; rec: nothing	ret: nothing
	disp8 byte "x XOR y", 0ah, 0dh, 0

	.code
	
	mov edx, offset disp8
	call writeString
	call getx
	call gety
	xor eax, ebx
	call writeBin
	call crlf

ret
xXORy endp





; 10

exitProgram proc uses edx eax
	.data ; rec:nothing		ret:nothing
	disp9 byte 0ah, 0dh, "Happy days!", 0ah, 0dh,0

	.code
	
	mov edx, offset disp9
	call WriteString
	mov eax, 1000
	call delay
	exit
ret
exitProgram endp





; 11

displayBreak proc uses edx eax ecx
	mov ecx, 40
	mov al, "-"
	l1:
		call writeChar
		loop l1
	call crlf
ret
displayBreak endp



end main
	
	
