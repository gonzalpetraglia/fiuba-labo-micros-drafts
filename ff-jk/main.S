#include <avr/io.h>
#include "avrx.h"

.global main

.equ CLK, 0
.equ J, 1
.equ K, 2
.equ Q, 3

DSEG
v: BYTE 8
m: BYTE 1


CSEG
	rjmp main
	; Leave space to int vectors
	; .org int_vectors_size
main:
    cbi _SFR_IO_ADDR(DDRB), CLK; mask and mark as read/write
    cbi _SFR_IO_ADDR(DDRB), J; mask and mark as read/write
    cbi _SFR_IO_ADDR(DDRB), K; mask and mark as read/write
    sbi _SFR_IO_ADDR(DDRB), Q; mask and mark as read/write

high:
    sbic _SFR_IO_ADDR(PINB), CLK; read clk input; if low go to low
    rjmp high; if high, go back to high flank
    ; 
low: 
    sbis _SFR_IO_ADDR(PINB), CLK; read clk input; if high execute jk
    rjmp low; if low return



ff_jk:
    sbic _SFR_IO_ADDR(PINB), J
    rjmp j
    rjmp notj
j:  
    sbic _SFR_IO_ADDR(PINB), K
    rjmp setq ; if j and not k, q=1
    rjmp invertq ; if j and k, q=!q

notj:
    sbic _SFR_IO_ADDR(PINB), K; if k
    rjmp high; if not j and not k, return q(no changes)
    rjmp clearq; if not j and k return 0
    
invertq:
    sbic _SFR_IO_ADDR(PORTB), Q
    rjmp setq 
    rjmp clearq

setq: 
    sbi _SFR_IO_ADDR(PORTB), Q ; set q
    rjmp high ; we come from an ascendent flank    

clearq:
    cbi _SFR_IO_ADDR(PORTB), Q ; clear q
    rjmp high ; we come from an ascendent flank