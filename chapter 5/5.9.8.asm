;5.9.8

; THis program displays a char in all 255 possible
; combinations of foreground and background color

include Irvine32.inc
.code
	main proc
			mov ecx, 255
			mov eax, 0
			l1:
				call clrscr
				call writeletter
				call delay10
				inc eax 
				call settextcolor
				loop l1		
		exit
	main ENDP

writeletter proc uses eax
	mov al, 65d
	call writechar
	ret
writeletter ENDP

delay10 proc uses eax
	mov eax, 100
	call delay
	ret
delay10 ENDP

	END main
