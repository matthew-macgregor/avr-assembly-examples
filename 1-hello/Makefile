HEX := hello.hex


.PHONY: flash clean

$(HEX): hello.asm
	avra hello.asm -l hello.asm.lst

flash: $(HEX) 
	avrdude -p m168 -c usbasp -v -U flash:w:hello.hex

clean:
	rm -f *.lst *.hex *.obj
