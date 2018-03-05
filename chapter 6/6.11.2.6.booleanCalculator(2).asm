; 6.11.2.6
; boolean Calculator (2)

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

; Procedures defined (rec = recieves,   ret = returns)		EXPLAINATION

; 1. displayMenu	 rec:nothing		ret:nothing			Displays menu
; 2. getSelection	 rec:nothing		ret:al=selection	Gets selection from user
; 3. tableSelection  rec:al=selection	ret:nothing			Finds procedure from table and calls it
; 4. getx			 rec:nothing		ret: eax = x		Gets x from user
; 5. gety			 rec:nothing	    ret: ebx = y		Gets y from user
; 6. xAndy			 rec:nothing		ret:nothing			Executes and displays <AND eax, ebx>	result
; 7. xOry			 rec:nothing		ret:nothing			Executes and displays <OR  eax, ebx>  result
; 8. notx		     rec:nothing		ret:nothing			Executes and displays <NOT eax>	result
; 9. xXORy			 rec:nothing		ret:nothing			Executes and displays <xor eax, ebx> result
; 10. exitProgram    rec:nothing	    ret:nothing			Displays goodbye and exits program
; 11. displayBreak	 rec:nothing		ret:nothing			Displays a line, separating data

; 12. and_op	     rec:nothing		ret:nothing			prompts, and executes AND of two hexadecimals
; 13. or_op			 rec:nothing		ret:nothing			prompts, and executes OR of two hexadecimals
; 14. not_op		 rec:nothing		ret:nothing			prompts, and executes NOT of a hexadecimal
; 15. xor_op		 rec:nothing		ret:nothing			prompts, and executes xor_op of two hexadecimals
; 16. getxhex		 rec:nothing		ret:eax=x hex		gets x from user in hex
; 17. getyhex		 rec:nothing		ret:ebx=x hex		gets y from user in hex

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
		 byte "2. x OR y", 0ah, 0dh
		 byte "3. NOT x", 0ah, 0dh
		 byte "4. XOR y",0ah, 0dh
		 byte "5. xh AND yh", 0ah, 0dh
		 byte "6. xh OR yh", 0ah, 0dh
		 byte "7. NOT xh", 0ah, 0dh
		 byte "8. xh XOR yh", 0ah, 0dh
		 byte "9. Exit Program", 0ah, 0dh,0

	.code
	
	mov edx, offset disp1
	call WriteString
ret
displayMenu endp






; 2

getSelection proc uses edx

	.data ; rec:nothing  ret:eax=selection
	disp2 byte 0ah, 0dh,"Enter selection (1-9): ", 0
	error byte "Invalid input.", 0ah, 0dh, 0
	
	.code
l1: mov edx, offset disp2 ; display prompt
	call writeString
	call readDec

	cmp eax, 0	; range check
	jna dispError
	cmp eax, 9
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
			   dword and_op
			   byte 6
			   dword or_op
			   byte 7
			   dword not_op
			   byte 8
			   dword xor_op
			   byte 9
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






; 12

and_op proc uses edx

	.data
	disp10 byte "xh AND yh", 0ah, 0dh, 0

	.code
	mov edx, offset disp10
	call writeString
	call getxhex
	call getyhex
	and eax, ebx
	call writeHex
	call crlf
ret
and_op endp


	




; 13

or_op proc uses edx
	.data
	disp13 byte "xh or yh", 0ah, 0dh, 0
	
	.code
	mov edx, offset disp13
	call writeString
	call getxhex
	call getyhex
	or eax, ebx
	call writeHex
	call crlf
ret
or_op endp








; 14

not_op	proc uses edx

	.data
	disp14 byte "NOT xh", 0ah, 0dh,0
	
	.code
	mov edx, offset disp14
	call writeString
	call getxhex
	not eax
	call writeHex
	call crlf

ret
not_op endp







; 15

xor_op proc uses edx

	.data
	disp15 byte "xh XOR yh",0ah, 0dh,0
	
	.code 
	mov edx, offset disp15
	call writeString
	call getxhex
	call getyhex
	xor eax, ebx
	call writeHex
	call crlf
ret
xor_op endp
	
	





; 16

getxhex proc uses edx
	.data ;rec:nothing ret: eax = hex x value
	disp11 byte "Enter x in hex: ", 0

	.code
	mov edx, offset disp11
	call writeString
	call readHex
ret
getxhex endp









; 17

getyhex proc uses edx eax
	.data ;rec:nothing		ret: ebx = hex y value
	disp12 byte "Enter y in hex: ", 0
	
	.code
	mov edx, offset disp12
	call writeString
	call readHex

mov ebx, eax
ret
getyhex endp
	



end main
	
	
	
			  

