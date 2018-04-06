INCLUDE Irvine32.inc			; Last updated: 4.6.2018
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
writesquares proto color1:byte, color2:byte, char2:ptr dword, size2:byte, numsquares:dword
writesquare proto  ptrarr:ptr dword, size1:byte
setcolor proto color1:byte, color2:byte
nextrow proto size2:byte
drawrow proto ptrarr:ptr dword, row1:byte, col1:byte
drawcheckers proto ptrarr:ptr dword, color6:byte
loadfile proto, ptrbuff:ptr dword, ptrlength:ptr dword, ptrfilename:ptr dword
randomarray proTO ptrbuff5:Ptr dword, leng:dword
goto00 proto
bubblesortbyte proto ptrarray:ptr dword, leng:dword
binarySearch proto ptrarray:ptr dword, leng:dword, searchval:byte
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
str_nextWord proto ptrString:ptr byte, charDelimiter:byte
displayAddressAndIndex proto address:dword, index:dword
get_frequencies proto ptrString:ptr byte, ptrTable:ptr dword
sievePrimes proto ptrarray:ptr dword, leng:dword
displayUnmarkedElements proto ptrarray:ptr byte, leng:dword
initializeArray proto ptrarray:ptr dword, leng:dword, char:byte
dumpMemory proto ptrarray:ptr dword, leng:dword, type1:byte
betterBubbleSort proto ptrarray:ptr dword, leng:dword
randomCharArray proto ptrarray:ptr dword, leng:dword
binarySearchAndDisplay proto ptrarray:ptr dword, leng:dword, searchChar4:byte
randomCharArrayVowelProbability proto ptrArray:ptr byte, leng:dword, prob:dword
randomCharVowel proto
displayAsciiMatrix proto, ptrArray:ptr dword, size1:dword
displayAsciiSpaced proto, ptrArray:ptr dword, leng:dword
displaySetsOfVowelProbability proto, ptrArray:ptr dword, leng:dword, size1:dword, prob:dword
getVowelRatio proto ptrarray:ptr dword, leng:dword
str_concatL proto ptrtarget:ptr dword, ptrsource:ptr dword, maxLeng:dword
countVowels proto ptrarray:ptr dword, leng:dword
scanLetterArray proto CharArray1:ptr dword, sizeLine1:dword, ptrSetList1:ptr dword, prob351:dword
getSetsWithinVowelProbability proto ptrCharArray:ptr dword, sizeLine:dword, ptrSetList:ptr dword, prob35:dword
getColumnsArray proto  ptrCharArray:ptr dword, ptrColArray:ptr dword, size1:dword
getDiagonalsArray proto ptrCharArray34:ptr dword, diagonalsArray:ptr dword, sizeLine:dword
scanLetterArrayDiagonals proto diagonalsArray32:ptr dword, sizeLine41:dword, ptrSetList42:ptr dword, prob35:dword
randomAsciiArrayMax9 proto ptrArray:ptr dword, leng:dword
Better_calc_row_sum proto   ptrArray73:ptr dword, width73:dword, type73:dword, rowIndex73:dword
convertAsciiToInteger proto ptrArray:ptr dword, leng:dword
displayIntegerTable proto ptrArray:ptr dword, rowlengbytes:dword, type1:dword, leng:dword
calc_row_sum proto