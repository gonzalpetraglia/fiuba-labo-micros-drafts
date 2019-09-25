#define I r25
#define SUM r24
#define CURRENT_VALUE r23

.global average

average:
	; load vector size
	ldi I, 8
	; init sum var
	ldi SUM, 0

loop:
	ld CURRENT_VALUE, X+
	add SUM, CURRENT_VALUE
	dec I
	brne loop

endLoop:

	; divide by 8
	asr SUM
	asr SUM
	asr SUM

	st Y, SUM
	ret