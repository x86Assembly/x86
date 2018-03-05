; x86 kip irvine
;5.8.2.2
; change a subroutines return address
; moving 3 bytes causes an access error,
; so this progrom moves address 5 bytes back
include Irvine32.inc
.data
array dword 4 dup(0)
.code
main proc
	call add5
	exit
main ENDP

add5 proc
	pop eax
	sub eax, 5
	push eax
	ret
add5 ENDP
END main
