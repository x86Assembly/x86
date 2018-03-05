;5.8.2.5
; This program displays a subroutine's
; return address

include Irvine32.inc
.data
myarray dword 1000h, 2000h, 3000h, 4000h, 5000h
.code

main proc
	call myroutine
	exit
main ENDP

myroutine proc
	.data
	display byte "myroutine's return address: "
	.code
	mov edx, offset display
	call writestring
	pop eax				; get address from stack
	push eax			; return a copy of address to stack
	call writehex		; print address
	ret
myroutine ENDP
END main
