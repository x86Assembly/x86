include link.inc
include macros.inc




.data
disp1 byte "This program demonstrates a procedure which concatenates two strings.", 0ah,0dh,0ah, 0dh,0
disp2 byte "Strings concatenated: ",0
string1 byte 50 dup (0)
buffer byte 50 dup (0)
string2 byte 50 dup (0)
.code
	main proc
		invoke displayString, addr disp1
		invoke getString, addr string1
		invoke getString, addr string2
		invoke str_concat, addr string1, addr string2
		call crlf
		invoke displayString, addr disp2
		invoke displayString, addr string1
		call crlf
		call crlf
		call waitmsg
		
	exit
	main endp


end main
	