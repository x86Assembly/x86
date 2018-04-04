; 9.10.7.SieveOfEratosthenese
include link.inc
include macros.inc




.data
disp1 byte "This program demonstrates a procedure which uses the Sieve of Erotosthenes method to display primes up to 65,000", 0ah,0dh, 0ah,0dh,0

primes byte 65000d dup(?)
.code
	main proc
		invoke displayString, addr disp1
		invoke InitializeArray, addr primes, lengthof primes, 0
		invoke sievePrimes, addr primes, lengthof primes
		invoke displayUnmarkedElements, addr primes, lengthof primes
		
	call waitmsg
	exit
	main endp


end main
	
