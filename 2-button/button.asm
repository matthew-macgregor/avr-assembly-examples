; button.asm
; https://www.instructables.com/Command-Line-Assembly-Language-Programming-for-Ard-1/
; constants
; ------------------------------------------------------

; Normally, we'd use the include file for these constants:
; .include "./m168def.inc"
; But since this is a learning exercise, we're going to hand 
; code the constants:

; SPECIFY DEVICE ***************************************************
.nolist
.device ATmega168

#pragma AVRPART ADMIN PART_NAME ATmega168
.equ	SIGNATURE_000	= 0x1e
.equ	SIGNATURE_001	= 0x94
.equ	SIGNATURE_002	= 0x06
#pragma AVRPART CORE CORE_VERSION V2E
.list

; Constants
.equ DDRB 	= 0x04
.equ DDRD	= 0x0a
.equ PIND	= 0x09
.equ PORTB	= 0x05
.equ PORTD	= 0x0b

; Defines
.def temp = r16 

rjmp init

init:
	ser temp		; sets all bits to 1
	out DDRB,temp		; everything is output
	ldi temp,0xfd
	out DDRD,temp		; PD1 is input, rest output	
	clr temp		; zero'd
	out PORTB,temp		; PortB pins all low
	ldi temp, 0x02
	out PORTD,temp		; PD1
	;; PD0 has a pull-up resistor (5V)?


main:
	;; PIND has the state of PORTD, PD1 will be 0 when button
	;; is pressed or 1 normally
	in temp,PIND
	;; Copying PORTD to PORTB, lighting the LED
	out PORTB,temp
	;; Main loop
	rjmp main
	


