;
; PWM_ASM.asm
;
; Created: 12.04.2022 23:03:26
; Author : ZM
;

.def temp = r16
.def count = r17
.cseg
.org	$000
    	rjmp init
.org	$006	
	rjmp TIM1_COMPA
;===========================SETUP=======================================
init:
    	ldi temp, low(RAMEND)
	out SPL, temp
	ldi temp, high(RAMEND)
	out SPH, temp

	ldi temp, 0x08
	out DDRB, temp
	clr temp
	out PORTB, temp
	clr count
	clr temp
	out TCCR1A, temp
	ldi temp, 0x09
	out TCCR1B, temp
	clr temp
	out TCNT1L, temp
	out ICR1L, temp
	ldi temp, 0x04
	out OCR1AH, temp
	ldi temp, 0xE2
	out OCR1AL, temp
	clr temp 
	out OCR1BH, temp
	out OCR1BL, temp
	out ASSR, temp
	ldi temp, 0x69
	out TCCR2, temp
	clr temp
	out TCNT2, temp
	out OCR2, temp
	ldi temp, 0x10
	out TIMSK, temp
	sei
;==========================MAIN_LOOP=====================================
MAIN_LOOP:
    	rjmp MAIN_LOOP
;==========================INTERRUPT_FUNCTION============================
TIM1_COMPA:
    	ldi ZH, HIGH (2*NUM)
	ldi ZL, LOW (2*NUM)
	add ZL, count
	lpm
	out OCR2, r0
	inc count
	cpi count, 128
	brne PC+2
	clr count
    	reti
;===========================DATA=========================================
NUM: 	 .DB 127, 134, 140, 146, 152, 158, 164, 170, 176, 182
     	 .DB 187, 193, 198, 203, 208, 213, 217, 222, 226, 230
	 .DB 233, 236, 240, 242, 245, 247, 249, 251, 252, 253
	 .DB 254, 254, 254, 254, 254, 253, 252, 251, 249, 247
	 .DB 245, 242, 240, 236, 233, 230, 226, 222, 217, 213
	 .DB 208, 203, 198, 193, 187, 182, 176, 170, 164, 158
	 .DB 152, 146, 140, 134, 127, 121, 115, 109, 103,  97
	 .DB  91,  85,  79,  73,  68,  62,  57,  52,  47,  42
	 .DB  38,  33,  29,  25,  22,  19,  15,  13,  10,   8
	 .DB   6,   4,   3,   2,   1,   1,   0,   1,   1,   2
	 .DB   3,   4,   6,   8,  10,  13,  15,  19,  22,  25
	 .DB  29,  33,  38,  42,  47,  52,  57,  62,  68,  73
	 .DB  79,  85,  91,  97, 103, 109, 115, 121

      



