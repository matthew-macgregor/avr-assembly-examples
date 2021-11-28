; hello.asm
; from: https://www.instructables.com/Command-Line-Assembly-Language-Programming-for-Ard/

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
.equ DDRB 		= 0x04
.equ PORTB		= 0x05
.equ PINS_HI		= 0x57

ldi r16,PINS_HI		; set pins
out DDRB,r16		; set data direction to out
out PORTB,r16		; set pin to high on portb

; main loop
start:
	rjmp start
