;5.9.7

; This program displays a single character at 100 random
; screen locations at an interval of .1 second

; 1 function defined
; 1. gotoRandomXY - moves cursor to random screen location

include Irvine32.inc
.code
	; places cursor at random point
	main proc
		mov ecx, 100
		l1:
			call goToRandomXY
			mov al, 'S'
			call writeChar
			mov eax, 100
			call delay
			loop l1
		call waitmsg
		exit
	main ENDP
	
	; 1
	goToRandomXY proc uses ecx ; relocates cursor to random position
		.data
		maxx byte 10
		maxy byte 10
		.code
		call randomize
		call getMaxXY
		movzx eax, al
		sub eax, 11
		call randomRange
		mov maxy, al
		call getMaxXY
		movzx eax, dl
		call randomRange
		mov maxx, al
		mov dh, maxy
		mov dl, maxx
		call Gotoxy
		mov eax, 0
		;mov al, maxx
		;call writeDec
		;mov al, maxy
		;call writeDec
		ret
	goToRandomXY ENDP

	END mai
