
#include <avr/io.h>

.global main
.text

main:		
		sbi _SFR_IO_ADDR(DDRB), 7


mainLoop:
		sbi _SFR_IO_ADDR(PORTB), 7

		call delay_1
		call delay_1
		call delay_1
		call delay_1
		call delay_1

		cbi _SFR_IO_ADDR(PORTB), 7

		call delay_1
		call delay_1
		call delay_1
		call delay_1
		call delay_1

		rjmp mainLoop
