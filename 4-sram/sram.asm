; sram.asm
; notes from: http://www.rjhcoding.com/avr-asm-sram.php
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

.list	; enable list generation

; Constants
.equ DDRB 		= 0x04
.equ PORTB		= 0x05
.equ RAMSTART		= 0x100 ; ATmega168! from iom168p.h
.equ COUNTER		= 65535

.macro reset_counter
	ldi	r25, HIGH(COUNTER)
	ldi	r24, LOW(COUNTER)
.endmacro

; ######################################################### ;
;   Data Segment
; ######################################################### ;

	.dseg		
	.org RAMSTART
var:	.byte	2	; allocate 2 bytes

; ######################################################### ;
;   Code Segment
; ######################################################### ;

	.cseg		; code segment

ser r16			; set all
out DDRB,r16		; set data direction to out


; main loop
start:
	ldi	r16, 0xAA	; load byte
	ldi	r17, 0x55	; load byte
	sts	var, r16	; store direct to data space
	sts	var+1, r17	; second 8 bits
	
	reset_counter

	; Note: lds and sts are more expensive (+1 clock cycle) and
	; use more program memory when used on r0:r15
	; We're not going to use r16,r17 for demo purposes (since 
	; we used those to set the data.
	lds	r18, var		; load to r1:r0
	lds	r19, var+1

	out	PORTB, r18		; 0xAA first

loop_0xAA:
	; Display the bytes at var[0]. Since we set this to 0xAA, 
	; our pins will display 0b10101010 (use LEDs).
	sbiw	r24, 1		; only works with certain registers
	brne	loop_0xAA

	; Reset our counter	
	reset_counter
	out	PORTB, r19

loop_0x55:
	; Display the bytes at var[1], set to 0x55, which will 
	; output 0b01010101.
	sbiw	r24, 1
	brne 	loop_0x55

	; Reset our counter
	reset_counter
	out	PORTB, r18

	rjmp loop_0xAA 

