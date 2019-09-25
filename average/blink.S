#include "avrx.h"

#define SECONDS r19
#define SECONDS_LEFT r20

.global blink

blink:
  ; receive seconds in SECONDS
  sbi _SFR_IO_ADDR(DDRB), 7

blinkLoop:

  sbi _SFR_IO_ADDR(PORTB), 7

  mov SECONDS_LEFT, SECONDS
delayOn:
  call delay_1
  dec SECONDS_LEFT
  brne delayOn

  cbi _SFR_IO_ADDR(PORTB), 7

  mov SECONDS_LEFT, SECONDS
delayOff:

  call delay_1
  dec SECONDS_LEFT
  brne delayOff

  ret