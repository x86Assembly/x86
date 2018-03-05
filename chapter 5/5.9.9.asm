;5.9.9

; This program defines and calls a recursive 
; procedure. Instructed to use no conditional 
; branching other than loop.

;  	4 procedures defined
; 1. recursiveP, recieves desired number of calls in ecx, calls itself that many times, keeps and returns count in eax
; 2. displaycount, recieves count in eax, displays the value
; 3. getdesiredrecursions, prompts user, returns desired recursions in eax
; 4. displayPurpose

include Irvine32.inc
.code
	main proc
			call displayPurpose
			l1:
			mov eax, 0
			call getdesiredrecursions
			call recursiveP
			jmp l1
		
		exit
	main ENDP


; 1
recursiveP proc    ; recieves number of recursions in ecx, keeps count in eax
	 inc eax 
	 call displaycount
	 loop l1
	 jmp l2 ; this is looped over until ecx=0, then jumps over recursive call, returning to main
	 l1:
	 call recursiveP
	 l2:
	 ret
recursiveP ENDP

; 2
displaycount proc uses edx
	.data
	msg byte 0ah, 0dh, "This is recursion ", 0
	.code
	mov edx, offset msg
	call writeString
	call writeDec
	ret
displaycount ENDP

; 3
getdesiredrecursions proc uses edx eax 
	.data
	rcount byte 0ah, 0dh, "Enter number of recursions: ", 0
	.code
	mov edx, offset rcount
	call writeString
	call readDec
	mov ecx, eax
	ret
getdesiredrecursions ENDP

; 4
displayPurpose proc uses edx
	.data
	purpose byte 0ah, 0dh, "This program calls a recursive function the number of times defined by the user.", 0ah, 0dh, 0
	.code
	mov edx, offset purpose
	call writeString
	ret
displayPurpose ENDP

END main
