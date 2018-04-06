 ; 9.10.12.SumArrayRow
include link.inc
include macros.inc




.data
disp1 byte "This program demonstrates a procedure which sums a row of a two dimensional array or matrix",0ah,0dh,0ah,0dh,0
promptWidth byte 0ah,0dh,0ah,0dh, "Enter matrix width: ",0
promptRow byte  "Enter row to sum: ",0
disp2 byte 0ah,0dh, "Sum: ",0
rowIndex dword 0
sum dword 0

dispb byte 0ah,0dh,0ah,0dh, "Byte array: ",0ah,0dh,0ah,0dh,0
dispw byte 0ah,0dh,0ah,0dh, "Word array: ",0ah,0dh,0ah,0dh,0
dispd byte 0ah,0dh,0ah,0dh, "Dword array: ", 0ah,0dh,0ah,0dh,0

bArray byte 1,2,3,4
bRowLength = ($ - bArray)
		byte 5,5,5,5
		byte 1,2,1,2

wArray word 1,1,1,1
wARowLength = ($ - wArray) 
		word 2,2,2,2
		word 3,3,3,3

dArray dword 3,3,3,3
dARowLength = ($ - dArray)
	    dword 4,4,4,4
		dword 1,1,1,1

bRL dword bRowLength
wRL dword wARowLength
dRL dword dARowLength
.code
	main proc
		invoke displayString, addr disp1
		
		
		; sum of byte row
		
		invoke displayString, addr dispb
		invoke displayIntegerTable, addr bArray, bRL, type bArray, 3
		invoke getVar, addr promptRow, addr rowindex

		push rowindex
		push type bArray
		push bRL
		push offset bArray
		call calc_row_sum

		invoke displayString, addr disp2
		call writeDec


		; sum of word row
		
		invoke displayString, addr dispw
		invoke displayIntegerTable, addr wArray, wRl, type wArray, 3
		invoke getVar, addr promptRow, addr rowindex

		push rowindex
		push type wArray
		push wRl
		push offset wArray
		call calc_row_sum

		invoke displayString, addr disp2
		call writeDec



		; sum of dword row
		
		invoke displayString, addr dispd
		invoke displayIntegerTable, addr dArray, dRl, type dArray, 3
		invoke getVar, addr promptRow, addr rowindex
		
		push rowindex
		push type dArray
		push dRl
		push offset dArray
		call calc_row_sum
		
		;invoke Better_calc_row_sum, addr dArray, dRl, type dArray, rowindex    Here is the same procedure using advanced PROC, for future use

		invoke displayString, addr disp2
		call writeDec
		

		call crlf
		call crlf
		call waitmsg

		
		exit
		main endp


end main
	