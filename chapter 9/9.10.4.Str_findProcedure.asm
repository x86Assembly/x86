; 9.10.3.Str_removeProcedure

include link.inc
include macros.inc




.data
disp1 byte "This program demonstrates a procedure which search for a string within a string", 0ah,0dh
	  byte "and returns the address the string was found", 0ah, 0dh, 0ah,0dh,0
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
	main proc
		invoke displayString, addr disp1				; get info from user
	l1: invoke promptString, addr prompt1, addr string1
		invoke promptString, addr prompt2, addr searchString
		invoke str_findAndDisplay, addr searchString, addr string1    ; search
		jmp l1
	
	exit
	main endp


end main
	