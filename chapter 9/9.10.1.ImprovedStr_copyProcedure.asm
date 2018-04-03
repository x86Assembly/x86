; 9.10.2.Str_concatProcedure

include link.inc
include macros.inc




.data
disp1 byte "This program demonstrates a procedure which limits the bytes copied", 0ah,0dh
	  byte "when copying a string.", 0ah,0dh,0ah,0dh,0
disp2 byte "String copied: ",0
disp3 byte "Max bytes to copy: ",0
maxbytes dword 0
string1 byte 50 dup (0)
buffer byte 50 dup (0)
string2 byte 50 dup (0)
.code
	main proc
		invoke displayString, addr disp1
	l1: invoke getString, addr string1
		invoke displayString, addr disp3
		call readDec
		mov maxBytes, eax
		call crlf
		invoke str_copyN, addr string1, addr string2, maxbytes
		invoke displayString, addr disp2
		invoke displayString, addr string2
		call crlf
		call crlf
		invoke resetString, addr string2
		jmp l1
		
	exit
	main endp


end main
	