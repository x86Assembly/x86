; 9.10.3.Str_removeProcedure

include link.inc
include macros.inc




.data
disp1 byte "This program demonstrates a procedure which removes an interval of chars", 0ah,0dh
	  byte "from a string.", 0ah, 0dh, 0ah,0dh,0
disp2 byte "Index of first char to remove: ",0
disp3 byte "Number of chars to remove: ",0
disp4 byte "New string: ", 0
charindex dword 0
charcount dword 0
string1 byte 50 dup (0)
buffer byte 50 dup (0)
string2 byte 50 dup (0)
.code
	main proc
		invoke displayString, addr disp1
	l1: invoke getString, addr string1				; get input from user
		invoke getVar, addr disp2, addr charindex
		invoke getVar, addr disp3, addr charcount

		mov esi, offset string1		; remove selected characters from string
		add esi, charindex
		invoke str_remove, esi, charcount

		invoke displayString, addr disp4		; display result
		invoke displayString, addr string1
		call crlf
		call crlf

		invoke resetString, addr string2		; reset string to (0)'s
		jmp l1
		
	exit
	main endp


end main
	