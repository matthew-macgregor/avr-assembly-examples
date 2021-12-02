HEX := sram.hex

.PHONY: flash clean

$(HEX): sram.asm
	avra $^ -l sram.asm.lst

flash: $(HEX) 
	avrdude -p m168 -c usbasp -v -U flash:w:$(HEX)

clean:
	rm -f *.lst *.hex *.obj
