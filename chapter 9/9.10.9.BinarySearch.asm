; 9.10.9.BinarySearch
include link.inc
include macros.inc




.data
disp1 byte "This program demonstrates a binary search procedure", 0ah,0dh, 0ah,0dh,0
array byte 0ffh dup(?)
disp3 byte "Random character array: ",0ah,0dh,0ah, 0dh,0
disp2 byte 0ah,0dh,0ah,0dh, "Sorted array: ",0ah,0dh,0ah,0dh,0
searchval byte 0
prompt1 byte "Enter search character: ",0

.code
	main proc
		invoke displayString, addr disp1
		invoke displayString, addr disp3
		invoke randomCharArray, addr array, lengthof array
		invoke displayAscii, addr array, lengthof array
		invoke betterBubblesort, addr array, lengthof array
		invoke displayString, addr disp2
		invoke displayAscii, addr array, lengthof array
		
		call crlf
		call crlf
	l1: invoke displayString, addr prompt1
		call readchar
		mov searchval, al
		call crlf
		call writeChar
		invoke binarySearchAndDisplay, addr array, lengthof array, al
		
		jmp l1
	exit
	main endp


end main
	