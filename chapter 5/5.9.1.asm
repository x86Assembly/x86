;5.9.1
; This program displays a string in
; muliple colors

include Irvine32.inc
.data
mystring byte "just keep coding", 0ah, 0dh,
			   "just keep coding", 0ah, 0dh,
			   "just keep coding, coding, coding", 0
blueonwhite dword blue + (white * 16)
redonblack dword red + (black * 16)
blueonred dword blue + (red * 16)
yellowonblack dword yellow + (black * 16)

.code
main proc
	
	call printstring
	exit
main ENDP

printstring proc

	mov esi, offset blueonwhite
	mov edx, offset mystring
	mov ecx, 4
	l1:
		mov eax, [esi]
		call settextcolor
		call clrscr
		call writestring
		add esi, type dword  ; move to next color
		mov eax, 500
		call delay
		loop l1
		ret
printstring ENDP

END main
