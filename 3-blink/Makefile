HEX := blink.hex


.PHONY: flash clean

$(HEX): blink.asm
	avra $^ -l blink.asm.lst

flash: $(HEX) 
	avrdude -p m168 -c usbasp -v -U flash:w:blink.hex

clean:
	rm -f *.lst *.hex *.obj
