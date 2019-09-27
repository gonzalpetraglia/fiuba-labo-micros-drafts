#define I r25
#define SUM_LOW r24
#define SUM_HIGH r23
#define CURRENT_VALUE r22
#define ZERO r21
#define ALL_ONES r20

.global average

average:
	; load vector size
	ldi I, 8
	; init sum var
	ldi SUM_LOW, 0
	ldi SUM_HIGH, 0
	; init constants var
	ldi ZERO, 0
	ldi ALL_ONES, 255
loop:
	ld CURRENT_VALUE, X+
	add SUM_LOW, CURRENT_VALUE
	adc SUM_HIGH, ZERO
	cp CURRENT_VALUE, ZERO
	brlt negative
	rjmp summed
negative:
	adc SUM_HIGH, ALL_ONES
summed:
	dec I
	brne loop

endLoop:

	; divide by 8
	asr SUM_HIGH
	ror SUM_LOW
	asr SUM_HIGH
	ror SUM_LOW
	asr SUM_HIGH
	ror SUM_LOW

	st Y, SUM_LOW
	ret