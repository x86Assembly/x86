;5.8.2.4
; This program defines a procedure that
; switches pairs of a dword array.
; If lengthof array is odd, the last element will
; not be changed

include Irvine32.inc
.data
myarray dword 1000h, 2000h, 3000h, 4000h, 5000h
.code

main proc
	mov esi, offset myarray    ; dumpmem
	mov ebx, type myarray
	mov ecx, lengthof myarray
	call dumpmem
	call pairswitcharray	   ; switch pairs
	call dumpmem
	call waitmsg
	exit
main ENDP

pairswitcharray proc uses esi ecx
	mov esi, 0
	mov ecx, lengthof myarray / 2  ;number of pairs
	l1:
	mov eax, myarray[esi]
	xchg eax, myarray[esi + type myarray]
	mov myarray[esi], eax
	add esi, (type myarray * 2)  ;move to next pair 
	loop l1
	ret
pairswitcharray ENDP
END main
