INCLUDE link.inc				; Last updated: 4.5.2018
include macros.inc

; All source code starting with chapter 9 must include link.inc
; and x86lib.asm in project

; link.inc   contains a prototype for each procedure
; x86lib.asm   contains defined procedures and includes irvine32.inc


; INSTRUCTIONS



; 1. save link.inc to your project folder & import x86lib.asm to your project

;    	click "View" in visual studios
;		click "Solution Explorer"
;		right-click "Project" in solution explorer
;		click "Add"
;		click "Existing item"
;       click "x86lib.asm"

;		x86lib.asm should be displayed in solution explorer
;       add include link.inc directive in asm file







; Most procedures accept pointers
; Procedures defined

; 1. displayString
; 2. getArray
; 3. displayResult
; 4. get3Values
; 5. primeArray
; 6. multiplyArrayByte
; 7. getString
; 8. displayFileContents
; 9. dumpascii
; 10. displayascii
; 11. 
; 12. drawrow
; 13. writesquares
; 14. writesquare
; 15. drawcheckers
; 16. loadFile
; 17. asciiMatrix   currently not functional
; 18. randomArray
; 19. randomchar
; 20. goto00
; 21. bubbleSort
; 22. binarySearch		 
; 23. rollingtext
; 24. displayAsciiLine
; 25. rollingTextBackwards
; 26. xorbuffer
; 27. compareArraysd
; 28. findCharInW
; 29. showIndexOfCharInW
; 30. displayLargerString
; 31. str_lcase
; 32. display2DElementDword
; 33. str_copyN
; 34. str_concat
; 35. resetString
; 36. getVar
; 37. str_remove
; 38. promptString
; 39. str_find
; 40. str_findAndDisplay
; 41. str_nextWord
; 42. displayAddressAndIndex
; 43. get_frequencies
; 44. sievePrimes
; 45. displayUnmarkedElements
; 46. intializeArray
; 47. dumpMemory
; 48. betterBubbleSort
; 49. randomCharArray
; 50. binarySearchAndDisplay
; 51. randomCharArrayVowelProbability
; 52. randomCharVowel
; 53. randomCapitalConsonant
; 54. displayAsciiMatrix

.code



; 1

displayString proc uses edx ptrmsg:ptr dword
	
	mov edx, ptrmsg
	call writeString
	;call crlf
ret
displayString endp





; 2
getArray proc uses edx eax ecx esi, pa:ptr dword,   la1:dword
	.data
	msg byte " integer array: ", 0
	string byte 21 dup (0)

	.code
	mov esi, 0 ; for string

	mov edi, pa
	mov eax, la1
	call writeDec

	mov edx, offset msg
	call writeString

	mov ecx, la1
	mov esi, 0
	mov eax, 0

comment !
	; This commented out code is simpler, but will not display
	; the array on the same line, readDec automatically prints
    ; a cr line feed after each value, which would be less appealing to the user.
	; The code after this code is all there in order to display 
	; the array on the same line

l1: call readDec
	mov [edi], eax
	add edi, 4
	loop l1
	
		!  ; end of comment block

l1: call readchar
	cmp al, 0dh
	je nx
	mov string[esi], al
	call writechar
	inc esi
	jmp l1
nx:
	mov al, ','
	cmp ecx, 1
	je ov
	call writechar
ov: mov edx, offset string
	push ecx
	mov ecx, lengthof string
	pop ecx
	call parsedecimal32
	mov [edi], eax
	add edi, 4

	; reset string
	push ecx
	mov esi, 0
	mov ecx, lengthof string
l2: mov string[esi], 0
	inc esi
	loop l2

	mov esi, 0
	pop ecx
	loop l1
	
call crlf
ret
getArray endp







; 3

displayResult proc private uses edx val1:dword
	
	.data
	msg1 byte "Result: ",0
	
	.code
	
	mov edx, offset msg1
	call writeString

	mov eax, val1
	call writeDec
	call crlf

ret
displayResult endp















; 4


 get3Values proc private v111:ptr dword, v222:ptr dword, v333:ptr dword

	.data

	msg11 byte "Val 1: ", 0
	msg21 byte "Val 2: ", 0
	msg31 byte "Val 3: ", 0

	.code
	
	call crlf
	
	mov edx, offset msg11
	call writeString
		
	call readInt
	mov esi, v111
	mov [esi], eax

	mov edx, offset msg21
	call writeString
	
	call readInt
	mov esi, v222
	mov [esi], eax


	mov edx, offset msg31
	call writeString
	
	call readInt
	mov esi, v333
	mov [esi], eax
		
ret
get3Values endp





; 5


primeArray proc uses ecx edi eax ptrarray:ptr dword, lengtha:dword, val:byte

	mov edi, ptrarray
	mov ecx, lengtha
	mov al, val
	cld
	rep stosb
ret
primeArray endp






; 6



multiplyArrayByte proc uses eax esi edi ptrarray:ptr byte, lengtha:dword, mult:byte
	
	mov esi, ptrarray
	mov edi, esi
	mov ecx, lengtha
	cld
	mov eax, 0

l1: lodsb
	mul mult
	stosb
	loop l1

ret
multiplyArrayByte endp
	







; 7



getstring proc uses  eax ecx  ptrstr1:ptr dword

	.data
	msg112 byte "enter string: ", 0

	.code
	mov edx, offset msg112
	call writestring
	mov edx, ptrstr1
	invoke str_length, ptrstr1
	;mov ecx, eax
	mov ecx, 0ffh
	mov edx, ptrstr1
	call readstring

mov edx, ptrstr1
ret
getstring endp













; 8

displayFileContents proc 
	pushad

.data
lengthfirst = 0ffffh

filename byte 129d dup ('#')

data byte lengthfirst dup ('#')
datalength dword lengthfirst

.code
	l1: invoke primeArray, addr data, 0ffffh, '#'
		invoke primeArray, addr filename, 129d, '#'
		mov datalength, 0ffffh
		invoke getString, addr filename
		mov edx, offset filename
		call openinputFile
		mov edi, eax
		mov edx, offset data
		mov ecx, datalength
		cmp al, 0ffh
		je l1
		call readfromfile
		mov datalength, eax
		mov eax, edi
		call closefile
		
		invoke displayascii, addr data, datalength
		
		mov edx, offset data
		;call writestring
		call crlf

popad
ret
displayFileContents endp







; 9

dumpascii proc   uses ecx ebx esi eax ptraddress1:ptr dword, le1:dword, t1:dword

		mov ecx, le1
		mov esi, ptraddress1
		mov ebx, t1

l1:     mov al, [esi]
		call writechar
		add esi, t1
		loop l1

ret
dumpascii endp




geteax proc uses edx
	.data

	msg75 byte "Enter eaxl: "

	.code
	mov edx, offset msg75
	call writeString
	call readint
ret
geteax endp









; 10

displayascii proc uses esi eax edx ecx	ptrdata2:ptr DWORD, length2:dword

	call crlf
	mov ecx, length2
	mov esi, ptrdata2
	
l1: mov al, byte ptr [esi]
	call writechar
	inc esi
	loop l1

ret
displayascii endp






;  11


comment !

; currently not functional
displayasciiMatrix proc uses esi ecx eax ptrbuff:ptr byte, length4:dword

	


writesquares proto color1:byte, color2:byte, char2:ptr dword, size2:byte, numsquares:dword
writesquare proto  ptrarr:ptr dword, size1:byte
setcolor proto color1:byte, color2:byte
nextrow proto size2:byte
drawrow proto ptrarr:ptr dword, row1:byte, col1:byte
drawcheckers proto ptrarr:ptr dword, color6:byte



.data
character byte 0dbh
size3 byte 10
numsquares dword 8
color1 byte 0
color2 byte 3

.code

	
	mov ecx, 0
	mov bl, 3
l1:
	mov dx, 0
	call gotoxy

	push eax
	mov eax, 1000
	;call delay
	pop eax
	invoke drawcheckers,ptrbuff, bl
	inc bl
	push eax
	mov eax, 100
	call delay
	pop eax
	;loop l1
	
	call crlf
	call crlf
	call crlf
	call crlf
	call crlf
	call waitmsg

ret  
displayasciimatrix endp



!


; 12


drawrow proc uses ecx eax ebx edx esi ptrarray4:ptr dword, row2:byte, col2:byte

	
	mov dh, row2
	mov dl, col2
	mov ecx, 4
l1: call gotoxy
	invoke writesquare, ptrarray4, 10
	add dl, 20
	sub dh, 10
	loop l1

ret
drawrow endp 







; 13

writesquares proc color3:byte, color4:byte, ptrarr12:ptr dword, size2:byte, numsquares1:dword
	
	mov edx, 0


	mov ecx, numsquares1
l2: push ecx
	mov ecx, numsquares1
l1: push ecx
	call gotoxy
	invoke writesquare,ptrarr12, size2
	add dh, 3d
	pop ecx
	loop l1
	pop ecx
	call crlf
	add dl, 10d

	loop l2

ret
writesquares endp







; 14

writesquare proc uses ecx esi ptrarray3:ptr DWORD, size1:byte

	mov esi, ptrarray3
	mov ecx, 0
	mov cl, size1
l2: push ecx
	movzx ecx, size1
l1:	mov al, byte ptr[esi]
	call writeChar
	inc esi
	loop l1
	add dh, 1
	call gotoxy
	pop ecx
	loop l2

ret
writesquare endp







;  15

drawcheckers proc uses ebx ptrarr21:ptr dword, color4:byte
	
	mov al, color4
	shl al, 4
	;or al, 0fh
	;call settextcolor
	
	mov dl, 0
	mov bl, 0
	mov ecx, 7
l1: invoke drawrow, ptrarr21, bl, dl
	add bl, 5
	xor dl, 10d
	loop l1
	

COMMENT !
	invoke drawrow, 0, 0
	invoke drawrow, 5, 10
	invoke drawrow, 10, 0
	invoke drawrow, 15, 10
	invoke drawrow, 20, 0
	invoke drawrow, 25, 10
	invoke drawrow, 30, 0
	invoke drawrow, 35, 10
	invoke drawrow, 40, 0

	!
	

ret
drawcheckers endp





; 16

loadfile proc uses edx ECX esi eax ebx edi ptrbuff22:ptr dword, ptrlength22:PTR DWORD, PTRFILENAME:ptr dword

	mov esi, ptrfilename
	mov edi, ptrlength22
	mov edx,esi
	call openinputfile
	mov ebx, eax
	mov edx, ptrbuff22
	mov ecx, [edi]
	call readfromfile
	mov [edi], eax
	mov eax, ebx
	call closefile
	
ret
loadfile endp



















; 17

; currently not functional
asciimatrix proc uses esi eax  ptrbufff:ptr dword, leng:DWORD

	mov esi, ptrbufff
	mov ecx, leng
	shr ecx, 2
	mov ebx, 8
	
 l1: invoke writesquare, esi, bl
	  add esi, ebx
	  loop l1

ret
asciimatrix endp 












; 18

randomarray proc  uses ecx esi ptrbuff5:Ptr dword, leng:dword
		
		call randomize
		mov ecx, leng
		mov esi, ptrbuff5
l1:		jmp getRandom
l2:		mov [esi], al
		inc esi
		loop l1
		jmp ext

getRandom:
 		mov eax, 0fh
		;call randomRange
		call randomchar
		jmp l2


ext:
ret
randomarray endp







; 19

randomchar proc
	
	mov eax, 7ah
	sub eax, 20h
	call randomrange
	add eax, 20h
ret
randomchar endp





; 20

goto00 proc

	mov dx, 0
	call gotoxy
ret 
goto00 endp





; 21


bubblesortByte proc uses eax ecx esi pa43:ptr dword, len3:dword

		mov ecx, len3
		dec ecx

l1: push ecx
	mov esi, pa43

l2: mov al, byte ptr [esi]
	cmp byte ptr[esi+1], al
	jg l3
	xchg al,byte ptr [esi+1]
	mov byte ptr[esi], al

l3: add esi, 1
	loop l2

	pop ecx
	loop l1
l4:

ret

bubblesortByte endp







; 22

binarysearch proc  uses ebx edx esi edi   ptra81:ptr dword, leng42:dword, searchval:byte

local first:dword, last:dword, mid:dword
		
		; 

	mov first, 0
	mov eax, leng42
	dec eax
	mov last, eax
	movzx edi, searchval
	mov ebx, ptra81 

l1: mov eax, first
	cmp eax,last
	jg l5
	
	mov eax, last
	add eax, first
	shr eax, 1
	mov mid,eax
	
	mov esi, mid
	;shl esi, 2
	movzx edx, byte ptr[ebx+esi]

	cmp edx, edi
	jge l2
	
	mov eax, mid
	inc eax
	mov first, eax
	jmp l4

	l2: cmp edx, edi
		jle l3

		mov eax, mid
		dec eax
		mov last, eax
		jmp l4
	
	l3: mov eax, mid
		jmp l9
		
	l4: jmp l1

	l5: mov eax, -1
	l9: ret
binarysearch endp

		



	




;23

rollingtext proc ptra13:ptr dword, lengtt:dword, width3:dword
pushad
	
		mov esi, ptra13
		mov ebx, 0
		mov ecx, lengtt
	    sub ecx, width3
	l1: invoke displayasciiLine,ptra13 , width3
		mov eax, 100
		call delay
		call goto00
		
		INC ptra13
		LOOP l1
		
		
	
		call waitmsg

popad
ret
rollingtext endp





; 24

displayasciiLine proc uses esi eax edx	ptrdata2:ptr DWORD, length2:dword

	call crlf
	mov ecx, length2
	mov esi, ptrdata2
	
l1: mov al, byte ptr [esi]
	cmp al, 20h
	jl no
	cmp al, 7ah
	ja no
b: call writechar
	inc esi
	loop l1
	jmp ext
no:
	mov al, 20h
	jmp b

ext:
ret
displayasciiLine endp





; 25

rollingtextbackwards proc ptra13:ptr dword, lengtt:dword, width3:dword
pushad
	
		mov esi, ptra13
		mov ebx, 0
		mov ecx, lengtt
	    sub ecx, width3

		add ptra13, ecx
	l1: invoke displayasciiLine,ptra13 , width3
		mov eax, 100
		call delay
		call goto00
		
		dec ptra13
		LOOP l1
		
		
	
		call waitmsg

popad
ret
rollingtextbackwards endp





; 26

xorbuffer proc ptra6:ptr dword, leng54:dword, key4:byte
pushad
	mov esi, ptra6
	mov ecx, leng54
	mov al, key4
l1: xor [esi], al
	inc esi
	loop l1
popad
ret
xorbuffer endp




; 27


compareArraysd proc uses ebx ecx esi edi  ptr19:ptr dword, ptr18:ptr dword, leng78:dword
;ret flags
	
	mov esi, ptr19
	mov edi, ptr18
	mov ecx, leng78
	cld

	repe cmpsd



comment !

l1: mov eax, [esi]
	mov ebx, [edi]
	cmp eax, ebx
	jne done
	add esi, 4
	add edi, 4
	loop l1

done:
		!


ret
compareArraysd endp





; 28


findCharInW proc  uses ebx esi ptra41:ptr word, leng09:dword, char01:byte
; ret eax = index of char
; if not found, eax = -1 and cf=1
	mov ecx, leng09
	mov edi, ptra41
	movzx ax, char01
	cld
	repne scasw
	jecxz notfound

	sub edi, 2   ; point to previous
	

	mov eax, edi		; move address of char found to eax
	comment !
		if you want to return the memory address of the char and not the index,
		uncomment the follow jump
			!
	;jmp extf:
			
	sub eax, ptra41     ; subtract table address from char address to get byte offset from beginning of array
	shr eax, 1			; divide by type to get array index (word = 2)
	clc
	jmp ext		
notfound:
	stc
	mov eax, -1
	jmp ext

extf:
clc
ext:
ret
findCharInW endp
	





; 29


showIndexOfCharInW proc		ptarray:ptr word, leng08:dword, char04:byte


	mov al, char04
	call writechar
	invoke findCharInW, ptarray, leng08, char04
	jc notfound
	mwrite " found at index: "
	call writeDec
	jmp ext

notfound: 
	mwrite "Not found"
ext:
ret
showIndexOfCharInW endp






; 30

displayLargerString proc st12:ptr dword, st22:ptr dword
	pushad
	invoke str_compare, st12, st22
	jg firstgreater
	je even1
	mov edx, st22
	call writeString
	jmp ext

firstgreater:
	mov edx, st12
	call writeString
	jmp ext

even1:
	mwrite "Both Strings the same"
	
ext:
popad
ret
displayLargerString endp






; 31

str_lcase proc		ptrstri2:ptr byte
pushad 
	invoke str_length, ptrstri2
	mov ecx, eax
	mov esi, ptrstri2
l1: cmp byte ptr [esi], 41h
	jl ext
	cmp byte ptr [esi], 5ah
	jg ext
	or al, 00100000b
	inc esi
	loop l1
ext:
popad
ret
str_lcase endp






; 32

display2DElementDword proc	ptrarr323:ptr dword, rowsize8:dword, row53:dword, col51:dword
pushad

		mov esi, ptrarr323
		mov eax, rowsize8
		mov ecx, row53
		mul ecx
		mov ebx, col51
		shl ebx, 2
		add esi, ebx
		mov eax, [eax + esi]
		call writeHex
popad
ret
display2DElementDword endp






; 33

str_copyN proc ptrsource:ptr dword, ptrtarget:ptr dword, lengt09:dword
pushad

	mov ecx, lengt09
	jecxz ext
	mov esi, ptrsource
	mov edi, ptrtarget
	
	invoke str_length, ptrsource
	cmp eax, ecx
	jl strLessThanLimit

l1:
	rep movsb
	jmp ext

strLessThanLimit:
	mov ecx, eax
	jmp l1
ext:
ret
str_copyN endp










; 34

str_concat proc ptrtarg3:ptr dword, ptrso3:ptr dword
	local targetLength:dword, sourceLength:dword
pushad
		
	invoke str_length, ptrtarg3	; get length of target and source
	mov targetLength, eax
	invoke str_length, ptrso3
	mov sourceLength, eax
					
	mov edi, ptrtarg3
	add edi, targetLength		; edi points to end of target
	mov esi, ptrso3				; esi points to beginning of source
	
	mov ecx, sourceLength
	cld
	rep movsb		; mov [edi], [esi]         until ecx=0
	mov byte ptr [esi], 0    ; add null terminator

popad
ret
str_concat endp




; 35


resetString proc	ptrstrinn:ptr byte
pushad
		invoke str_length, ptrstrinn
		mov ecx, eax
		mov eax, 0
		mov edi, ptrstrinn
		cld
		rep stosb
ret
popad
resetString endp 


; 36


getVar proc		ptrPrompt32:ptr byte, ptrValue31:ptr dword
pushad
		mov esi, ptrValue31
		invoke displayString, ptrPrompt32
		call readInt
		mov [esi], eax
popad
ret
getVar endp




; 37

str_remove proc    ptrStartRemove1:ptr byte, numBytes:dword
pushad
			mov esi, ptrstartRemove1  
			mov edi, ptrstartRemove1
			add esi, numBytes			; esi points to beginning of second half of string	
			invoke str_length, esi      ; get length of second half of string to keep
			mov ecx, eax
			cld
			rep movsb
			mov byte ptr [edi], 0  ; add null terminator
popad
ret
str_remove endp




; 38


promptString proc		ptrPrompt64:ptr byte, ptroutputString:ptr byte
pushad
			invoke displayString, ptrPrompt64
			mov ecx, 0ffffh
			mov edx, ptroutputString
			call readString
popad
ret
promptString endp



; 39

str_find proc uses esi edi ebx ecx  ptrSearchString:ptr byte, ptrSourceString:ptr byte
	
			local sourceLength:dword, searchLength:dword,
				  maxComparisons:dword
			
		

			invoke str_length, ptrsourceString  ; get source length
			mov sourceLength, eax

			invoke str_length, ptrSearchString  ; get search length
			mov searchLength, eax

			cmp sourceLength, eax				; if source length is less than search length,
			jl notfound							; jump out, can't be found
		
			mov eax, sourceLength				; get the max amount of comparisons	
			sub eax, searchLength				; which is the difference + one
			add eax, 1
			mov maxComparisons, eax				

			mov esi, ptrsourceString			; set pointer to source outside of loop, it will change
			mov ecx, maxComparisons
l1:			push ecx
			mov edi, ptrsearchString			; set pointer to search inside loop, it will reset to first character each iteration
			mov ecx, searchLength				; we will compare each char for the length of the search string
			cld									; clear the direction flag, so we incriment
			repe cmpsb							; compare every byte for the length of the search string until a character is not the same
			je stringFound						; if exited repeat instruction with zero flag set, then we found the string
			pop ecx								; restore loop count, as ecx was used by cmpsd
			loop l1
			
notfound:										; no match found
			mov eax, 0							
			cmp eax, 1							; clear the zero flag
			jmp ext
stringFound:									; if found
			sub esi, searchLength			    ; esi currently points to address of the end of the found search string within the source string, we subtract to the length of the search string to find the beginning of the search string
			mov eax, esi	; move address to eax
			mov ebx, 0
			cmp ebx, 0  ; set zero flag
ext:
ret
str_find endp





; 40




str_findAndDisplay proc ptrsearchString1:ptr byte,   ptrsourceString1:ptr byte
pushad
		

.data
prompt1 byte "Enter outer string: ", 0
prompt2 byte "Enter search string: ", 0
disp2 byte "address: ",0
disp3 byte "index: ",0
notf byte "String not found.",0ah,0dh,0
found byte "Found",0ah,0dh,0
address dword 0
index dword 0
string1 byte 50 dup (0)
buffer byte 50 dup (0)
searchString byte 50 dup (0)
.code

		invoke str_find, ptrsearchString1, ptrsourceString1    ; search
		jnz notfound

		call crlf
		invoke displayString, addr found
		invoke displayString, addr disp2		; display resulting address
		
		call writeHex
		call crlf

		sub eax, ptrsourceString1		; display index 
		invoke displayString, addr disp3
		call writeDec
		
	
		call crlf
		call crlf
		jmp ext
notfound:
		call crlf
		invoke displayString, addr notf
		call crlf

		;invoke resetString, addr string2		; reset string to (0)'s
	
ext:
popad
ret
str_findAndDisplay endp




; 41



str_nextWord proc uses ebx ecx esi  ptrStr:ptr byte, char29:byte
	local sLength:dword
	
	invoke str_length, ptrStr ; get length
	mov sLength, eax

	mov ecx, eax
	mov al, char29

	mov esi, ptrStr

l1: cmp byte ptr[esi], al
	je found2
	inc esi
	loop l1
	jmp notFound
found2:
	mov byte ptr [esi], 0  ; add null
	mov eax, esi	; put address in eax	
	inc eax		; point to next character
	mov ebx, 0
	cmp ebx, 0  ; set zero flag
	jmp ext
notFound:
	mov eax, 1
	cmp eax, 0  ; clear the zero flag
ext:
ret
str_nextWord endp
	
	

; 42


displayAddressAndIndex proc   address12:dword, index12:dword
pushad
			.data
			disp21 byte "address: ",0
			disp31 byte "index: ",0
			found1 byte "Found",0ah,0dh,0
			
		.code
		call crlf
		invoke displayString, addr found1
		invoke displayString, addr disp21
		mov eax, address12
		call writeHex
		call crlf
		invoke displayString, addr disp31
		mov eax, index12
		call writeDec
		call crlf
		

popad
ret
displayAddressAndIndex endp




; 43

get_frequencies proc ptrString34:ptr byte, ptrTable34:ptr dword

		local sLength:dword
pushad
		invoke str_length, ptrString34
		cmp eax, 0
		je ext		;		if string empty, exit
		mov sLength, eax
		


		mov esi, ptrString34
		mov edi, ptrTable34
		cld
		mov ecx, sLength
l2:		push ecx
		mov ecx, 0ffh
	    mov al, byte ptr [esi]
	l1: cmp al, cl
		je add1
	b1: loop l1
		inc esi
		pop ecx
		loop l2
		jmp ext
add1:
		mov ebx, edi
		add ebx, ecx
		add byte ptr [ebx], 1
		jmp b1
ext:
popad
ret
get_frequencies endp







; 44

sievePrimes proc	ptrarrayp:ptr dword, leng72:dword
pushad
		mov esi, ptrarrayp
		mov ecx, leng72
		mov ebx, 2                 ; start with the sieve number as 2

		mov byte ptr [esi], 1      ; 0 is not prime
		mov byte ptr [esi +1], 1   ; 1 is not prime


l1:		push ecx			  ; save the count of the outer loop
		mov esi, ptrarrayp    ; point to beginning of array every interation
		mov eax, leng72		  ; get the length
		mov edx, 0			  ; clear edx to prepare for 32-division, which includes edx as the upper half of the dividend, we want it zero
		div ebx				  ; divide the length by the current sieve number, we use this as the count for the inner loop, otherwise it will interate past the end of the array
		mov edx, 1            ; move 1 into edx, we use edx to mark elements, because it is the last register we have which we have easy access to the lower byte
		mov ecx, eax		  ; use the length divided by the current sieve number as the inner loop count, where we will mark elements
		add esi, ebx		  ; ebx equals the current sieve number, so we add it to the pointer to point to that number first
		add esi, ebx		  ; we don't mark the first number equal to the sieve number, because a number divisible by itself may still be prime, so more up one more multiple
        call loopArray		  ; we interate the inner loop in a seperate procedure, we can now use F10 rather than F11 to step over the entire loop, this makes debugging faster
		add ebx, 1            ; move to the next sieve number by adding 1 to the current sieve number
		pop ecx				  ; restore the outer loop 
		loop l1				  ; end of outer loop
ext:
popad
ret
sievePrimes endp


loopArray proc
; rec, esi, edl, ebx, ecx
cmp ecx, 0			; sometimes we are passed ecx as 0, if so, jump out
je ext
l1:		mov byte ptr [esi], dl
		add esi, ebx
		loop l1
ext:
ret
loopArray endp

; 45


displayUnmarkedElements proc  ptrMarkedArray:ptr byte, leng73:dword
pushad
			mov ecx, leng73
			mov esi, ptrMarkedArray
	l1:		cmp byte ptr [esi], 0
			je display
			inc esi
			loop l1
			jmp ext
	display:
			mov eax, leng73
			sub eax, ecx
			call writeDec
			mov al, 2ch
			call writeChar
			mov al, 20h
			call writeChar
			inc esi
			loop l1
ext:
popad
ret
displayUnmarkedElements endp
		
		




; 46
InitializeArray proc ptrarray:ptr dword, lengtha:dword, val:byte
pushad
	mov edi, ptrarray
	mov ecx, lengtha
	mov al, val
	cld
	rep stosb
popad
ret
InitializeArray endp



; 47

dumpMemory proc ptrarray13:ptr dword, length42:dword, type32:byte
pushad
		mov esi, ptrarray13
		mov ecx, length42
		movzx ebx, type32
		call dumpmem
		call crlf
popad
ret
dumpMemory endp





; 48

betterBubbleSort proc  ptrarray43:ptr dword, length39:dword
		local exchangeFlag:dword
pushad

		mov ecx, length39
		dec ecx

	l1: push ecx
		mov esi, ptrarray43
		mov exchangeFlag, 0

	l2: mov al, byte ptr[esi]
		cmp [esi + 1], al
		jg l3
		mov exchangeFlag, 1
		xchg al, byte ptr [esi + 1]
		mov byte ptr [esi], al

	l3: inc esi
		loop l2
		
		pop ecx
		cmp exchangeFlag, 0
		je ext
		loop l1
ext:
ret
betterBubbleSort endp



;   49

randomCharArray proc    ptrarra43:ptr dword, leng324:dword
pushad
			call randomize
			mov esi, ptrarra43
			mov ecx, leng324

l1:			call randomchar
			mov byte ptr [esi], al
			inc esi
			loop l1
popad
ret
randomCharArray endp





; 50 


binarySearchAndDisplay proc   ptrarray832:ptr dword, leng421:dword, searchChar4:byte
pushad
		.data
		disp4 byte " found at index: ",0
        disp5 byte " Not found",0
		.code

		invoke binarySearch, ptrarray832, leng421, searchChar4
		cmp eax, -1
		je notfound
		
		invoke displayString, addr disp4
		call writeDec
		call crlf
		jmp ext
notfound:
		invoke displayString, addr disp5

ext:
	call crlf
	call crlf
popad
ret
binarySearchAndDisplay endp





; 51

randomCharArrayVowelProbability proc ptrarrayr1:ptr byte, leng4q:dword, prob:dword
pushad
		;call randomize
		mov esi, ptrarrayr1
		mov ecx, leng4q
		mov ebx, prob
		

l1:    mov eax, 100
	   call randomRange
	   cmp eax, prob
	   jl vowel
	   call randomCapitalConsonant
	   jmp eaxReady
vowel:
	   invoke randomCharVowel
eaxReady:
	   mov byte ptr [esi], al
	   inc esi
	   loop l1
popad
ret
randomCharArrayVowelProbability endp
	   
	



; 52



randomCharVowel proc
; ret: al = vowel
		;call randomize
		mov eax, 5d
		call randomrange
		cmp eax, 1
		je a1
		cmp eax, 2
		je e1
		cmp eax, 3
		je i1
		cmp eax, 4
		je o1
		cmp eax, 5
		je u1

a1:	mov al, 41h
	jmp ext
e1: mov al, 45h
	jmp ext
i1: mov al, 49h
	jmp ext
o1: mov al, 4fh
	jmp ext
u1: mov al, 55h
	jmp ext

ext:
ret
randomCharVowel endp





; 53


randomCapitalConsonant proc

	;call randomize
l1: mov eax, 26d
	call randomRange
	add eax, 41h
	
	; redo if vowel
	cmp al, 41h
	je l1
	cmp al, 45h
	je l1
	cmp al, 49h
	je l1
	cmp al, 4fh
	je l1
	cmp al, 55h
	je l1
	cmp al, 59h
	je l1
ret
randomCapitalConsonant endp



; 54


displayAsciiMatrix proc ptrArray82:ptr dword, size41:dword
pushad
			mov esi, ptrArray82
			mov ecx, size41
			mov ebx, size41

		l1: invoke displayAsciiSpaced, esi, ebx
			add esi, size41
			loop l1
popad
ret
displayAsciiMatrix endp


displayasciiSpaced proc uses esi eax edx ecx	ptrdata21:ptr DWORD, length21:dword

	call crlf
	mov ecx, length21
	mov esi, ptrdata21
	
l1: mov al, byte ptr [esi]
	call writechar
	mov al, 20h
	call writeChar
	inc esi
	loop l1

ret
displayasciiSpaced endp



end
