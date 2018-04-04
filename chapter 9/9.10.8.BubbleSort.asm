; 9.10.6.FrequencyTable
include link.inc
include macros.inc




.data
disp1 byte "This program demonstrates a bubble sort procedure which includes an exchange flag", 0ah,0dh, 0ah,0dh,0
array byte 08ffh dup(?)
disp3 byte "Random character array: ",0ah,0dh,0ah, 0dh,0
disp2 byte 0ah,0dh,0ah,0dh, "Sorted array: ",0ah,0dh,0ah,0dh,0
.code
	main proc
		invoke displayString, addr disp1
		invoke displayString, addr disp3
		invoke randomCharArray, addr array, lengthof array
		invoke displayAscii, addr array, lengthof array
		invoke betterBubblesort, addr array, lengthof array
		invoke displayString, addr disp2
		invoke displayAscii, addr array, lengthof array
	
		
		
	call waitmsg
	exit
	main endp


end main
	