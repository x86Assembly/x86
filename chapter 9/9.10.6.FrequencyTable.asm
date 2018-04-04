; 9.10.6.FrequencyTable

include link.inc
include macros.inc




.data
disp1 byte "This program demonstrates a procedure which creates a frequency table when passed a string", 0ah,0dh, 0ah,0dh,0

string byte 50 dup(0)
ftable byte 256 dup(0)
.code
	main proc
		invoke displayString, addr disp1
	l1: invoke getString, addr string
		invoke get_frequencies, addr string, addr ftable
		invoke dumpMemory, addr ftable, lengthof ftable, 1	
		invoke initializeArray, addr ftable, lengthof ftable, 0
		jmp l1
		
	
	exit
	main endp


end main
	