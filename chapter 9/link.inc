INCLUDE Irvine32.inc			; Last updated: 4.3.2018
; This file declares prototypes for procedures defined in x86lib.asm
; add x86lib.asm to project solution explorer
; add INCLUDE link.inc to main asm files


getArray proto ptrarray:ptr dword,   leng:dword
displaystring proto msg1:ptr dword
displayResult proto result:dword
primeArray proto ptrarray:ptr dword, leng:dword, val:byte
multiplyArrayByte proto ptrarray:ptr byte, leng:dword, mult:byte
readToBuffer proto ptrfilename:ptr byte, lengtha:dword
read1 proto
getstring proto ptrstring:ptr dword
dumpascii proto ptraddress1:ptr dword, le1:dword, t1:dword
displayFileContents proto
getEax proto
displayascii proto   ptrdata1:ptr DWORD,length1:dword
displayasciiMatrix proto ptrdata2:ptr byte, length2:dword
loadfile proto, ptrbuff:ptr dword, ptrlength:ptr dword, ptrfilename:ptr dword
asciiMatrix proto ptrdata2:ptr dword, length2:dword
randomarray proTO ptrbuff5:Ptr dword, leng:dword
goto00 proto
bubblesortbyte proto ptrarray:ptr dword, leng:dword
binarySearch proto ptrarray:ptr dword, leng:dword, searchval:dword
rollingtext proto ptrarray:ptr dword, leng:dword, width1:dword
displayasciiLine proto	ptrdata2:ptr DWORD, length2:dword
rollingtextbackwards proto ptrarray:ptr dword, leng:dword, width1:dword
xorbuffer proto ptrarray:ptr dword, leng:dword, key:byte
compareArraysd proto ptrarray1:ptr dword, ptrarray2:ptr dword, leng:dword ;ret flags
findCharInW proto ptrarray1:ptr word, leng:dword, char:byte ; ret eax = index of character found, if not found then eax = -1
showIndexOfCharInW proto ptrarray:ptr word, leng:dword, char:byte   ; displays the index of the char if found
displayLargerString proto ptrString1:ptr dword, ptrString2:ptr dword
str_lcase proto ptrString:ptr byte
display2DElementDword proto ptrtable:ptr dword, rowsize:dword, rowindex:dword, colindex:dword
str_copyN proto ptrsource:ptr dword, ptrtarget:ptr dword, limit:dword
str_concat proto ptrtarget:ptr dword, ptrsource:ptr dword
resetString proto ptrString:ptr byte
str_remove proto ptrStartRemove:ptr byte, bytesToRemove:dword
getVar proto ptrPrompt:ptr byte, ptrvalue:ptr dword
str_find proto ptrSourceString:ptr byte, ptrTargetString:ptr byte
promptString proto ptrPrompt:ptr byte, ptrString:ptr byte
str_findAndDisplay proto ptrSourceString:ptr byte, ptrTargetString:ptr byte