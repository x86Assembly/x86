; x86 irvine pg 136
; 4.10.2
; Exchanging pairs of array values (even number of elements)
; this program exchanges each byte with the
; following byte, i to i+1, i+2 to i+3, and so on
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword


.data
myarray byte 10h, 20h, 30h, 40h, 50h, 60h, 70h, 80h
.code
main proc
	mov ecx, sizeof myarray/2
	mov esi, 0
	l1:
		mov al, myarray[esi]
		xchg al, myarray[esi+1]
		mov myarray[esi], al
		add esi, 2
		loop l1
	main ENDP
	END main
