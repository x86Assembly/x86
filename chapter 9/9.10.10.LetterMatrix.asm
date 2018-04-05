; 9.10.10.LetterMatrix
include link.inc
include macros.inc




.data
disp1 byte "This program displays a 4 by 4 matrix of letters with a predefined vowel probability", 0ah,0dh,0ah,0dh,0
prompt byte "Enter vowel probability (0-100): ", 0
letterarray byte 10h dup (0)
size1 = 4d
vowelProbability dword 0
.code
	main proc
		call randomize
		invoke displayString, addr disp1
	l1: invoke getVar, addr prompt, addr vowelProbability
		
		mov ecx, 3
	l2: invoke randomCharArrayVowelProbability, addr letterArray, lengthof letterArray, vowelProbability
		invoke displayAsciiMatrix, addr letterArray, size1
		call crlf
		loop l2
	
	call crlf
	call crlf
	
	jmp l1
	exit
	main endp


end main
	