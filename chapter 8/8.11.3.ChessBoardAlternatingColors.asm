; 8.11.2.ChessBoardAlternatingColors
include irvine32.inc

; This program displays a 8x8 chessboard


; procedures

; displayPupose
; getinfo

writesquares proto color1:byte, color2:byte, char2:byte, size2:byte, numsquares:dword
writesquare proto  char1:byte, size1:byte
setcolor proto color1:byte, color2:byte
nextrow proto size2:byte
drawrow proto row1:byte, col1:byte
drawcheckers proto color6:byte



.data
character byte 0dbh
size3 byte 10
numsquares dword 8
color1 byte 0
color2 byte 3

.code

main proc
	
	mov ecx, 0
	mov bl, 3
l1:
	mov dx, 0
	call gotoxy

	push eax
	mov eax, 1000
	call delay
	pop eax
	invoke drawcheckers, bl
	inc bl
	push eax
	mov eax, 100
	call delay
	pop eax
	loop l1
	
	call crlf
	call crlf
	call crlf
	call crlf
	call crlf
	call waitmsg
exit
main endp


drawrow proc uses ecx eax ebx edx row2:byte, col2:byte

	mov dh, row2
	mov dl, col2
	mov ecx, 4
l1: call gotoxy
	invoke writesquare, 0dbh, 10
	add dl, 20
	sub dh, 10
	call gotoxy
	invoke writesquare, ' ', 10
	loop l1

ret
drawrow endp 



writesquares proc color3:byte, color4:byte, char2:byte, size2:byte, numsquares1:dword
	
	mov edx, 0


	mov ecx, numsquares1
l2: push ecx
	mov ecx, numsquares1
l1: push ecx
	call gotoxy
	invoke writesquare, char2, size2
	invoke writesquare, ' ', size2
	add dh, 3d
	pop ecx
	loop l1
	pop ecx
	call crlf
	add dl, 10d

	loop l2

ret
writesquares endp

writesquare proc uses ecx char1:byte, size1:byte

	mov al, char1
	mov ecx, 5
l2: push ecx
	movzx ecx, size1
l1:	call writeChar
	loop l1
	add dh, 1
	call gotoxy
	pop ecx
	loop l2

ret
writesquare endp


drawcheckers proc uses ebx color4:byte
	
	mov al, color4
	shl al, 4
	;or al, 0fh
	call settextcolor
	
	mov dl, 0
	mov bl, 0
	mov ecx, 7
l1: invoke drawrow, bl, dl
	add bl, 5
	xor dl, 10d
	loop l1
	

COMMENT !
	invoke drawrow, 0, 0
	invoke drawrow, 5, 10
	invoke drawrow, 10, 0
	invoke drawrow, 15, 10
	invoke drawrow, 20, 0
	invoke drawrow, 25, 10
	invoke drawrow, 30, 0
	invoke drawrow, 35, 10
	invoke drawrow, 40, 0

	!
	

ret
drawcheckers endp















end main







