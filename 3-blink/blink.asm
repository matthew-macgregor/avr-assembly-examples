; blink.asm
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
.equ PINS_OUT		= 0x01
.equ Counter		= 65535

ldi r16,PINS_OUT		
out DDRB,r16		; set data direction to out

; r17 will be used to toggle the value in r16 (XOR)
ser r17			; set all r17
; r16 will be used to set our pins high or low
clr r16			; clear all r16

; main loop
loop:
	sbiw r24, 1		; count down to zero
				; sbiw = subtract immediate from word	
	nop			; doo-dee-doo
	nop
	nop
	brne loop		; loop until zero
	
	; toggle 
	eor r16, r17		; toggle
	out PORTB, r16		; all pins high/low (toggle)
	
	; counter is zero, reset
	ldi r25, HIGH(Counter)	; set our counter
	ldi r24, LOW(Counter)	; using 16 bits
	rjmp loop

