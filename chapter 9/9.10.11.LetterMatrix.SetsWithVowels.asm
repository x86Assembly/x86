; 9.10.10.LetterMatrix/SetsWithVowels
include link.inc
include macros.inc




.data
disp1 byte "This program displays a matrix of letters with a predefined vowel probability.", 0ah,0dh
	  byte "The rows, columns, and diagonals which are of the set of the exact probability defined are displayed.",0ah,0dh,0ah,0dh,0
prompt byte "Enter vowel probability (0-100): ", 0
prompt2 byte "Enter matrix width: ",0
letterarray byte 0f000h dup (0)
widthMatrix dword 0
sizeMatrix dword 0
vowelProbability dword 0
correctSets byte 0f000h dup (0)
.code
	main proc
		call randomize
		
		invoke displayString, addr disp1
	l1: invoke getVar, addr prompt2, addr widthMatrix		; get width form user
		invoke getVar, addr prompt, addr vowelProbability	; get probability from user
		
		

		mov eax, widthMatrix		; calculate size of array  (width^2)
		mul eax
		mov sizeMatrix, eax

		
		;generate character array
		invoke randomCharArrayVowelProbability, addr letterArray, sizeMatrix, vowelProbability
		invoke displayAsciiMatrix, addr letterArray, widthMatrix  ; display matrix
		call crlf

		; generate array containing sets of charcters which are the exact probability defined by the user
		invoke getSetsWithinVowelProbability, addr letterArray, widthMatrix, addr correctSets, vowelProbability
		
		; display sets which have the probability
		call crlf
		invoke displayString, addr correctSets
		call crlf
		call crlf
	
		; reset array of sets
		invoke initializeArray, addr correctSets, lengthof correctSets, 0
		jmp l1
		exit
		main endp


end main
	