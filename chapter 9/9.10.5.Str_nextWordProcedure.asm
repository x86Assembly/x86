; 9.10.4.Str_findProcedure

include link.inc
include macros.inc




.data
disp1 byte "This program demonstrates a procedure which searches for a delimiter character in a string,", 0ah,0dh
	  byte "when the character is found, it is replaced with a null terminator and eax equals the address of the next character.", 0ah, 0dh, 0ah,0dh,0
prompt1 byte "Enter string: ", 0
prompt2 byte "Enter delimiter character: ", 0
disp2 byte "address: ",0
disp3 byte "index: ",0
notf byte "Character not found.",0ah,0dh,0
found1 byte "Found",0ah,0dh,0
address dword 0
sLength dword 0
index dword 0
disp4 byte "New string: ",0
string1 byte 50 dup (0)
buffer byte 50 dup (0)
char byte 0
.code
	main proc
		invoke displayString, addr disp1				; get info from user
	l1: invoke promptString, addr prompt1, addr string1
		invoke promptString, addr prompt2, addr char
		invoke str_nextWord, addr string1, char  ; search
		mov address, eax ; save address of next character
		jz found
		
		; not found
		invoke displayString, addr notf
		call crlf
		jmp l1
		
		; display results
		; calculate index
		found:
		mov eax, address
		sub eax, offset string1
		sub eax, 1

		; display address and index
		invoke displayAddressAndIndex, address, eax
		
	
		; display new string
		invoke displayString, addr disp4
		invoke displayString, addr string1
		call crlf
		call crlf
		jmp l1
	
	exit
	main endp


end main
	