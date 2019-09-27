#include <avr/io.h>
#include "avrx.h"

.global main


DSEG
v: BYTE 8
m: BYTE 1


CSEG
	rjmp main
	; Leave space to int vectors
	; .org int_vectors_size
main:
	; load in x pointer to v
	ldi XH, HIGH(v)
	ldi XL, LOW(v)
	; load values
	ldi r18, 129
	st X+, r18
	ldi r18, 129
	st X+, r18
	ldi r18, 129
	st X+, r18
	ldi r18, 129
	st X+, r18
	ldi r18, 129
	st X+, r18
	ldi r18, 129
	st X+, r18
	ldi r18, 129
	st X+, r18
	ldi r18, 129
	st X+, r18

	; load in x pointer to v
	ldi XH, HIGH(v)
	ldi XL, LOW(v)
	;load in y pointer to m
	ldi YH, HIGH(m)
	ldi YL, LOW(m)

	call average
	st Y, r19
keepBlinking:
	call blink
	rjmp average
