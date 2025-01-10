# V6523 - Replacement for a 6523 or 6525 without IRQ Controller (CBM2 keyboard TPI)  

**Copyright (c) 2024 Vossi - v.1 / v.2 (C64 IEEE option)**

**www.mos6509.com**

## License
This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
International License. See [https://creativecommons.org/licenses/by-sa/4.0/](https://creativecommons.org/licenses/by-sa/4.0/).

:thumbsup: v.2 now with C64 IEEE488 Interface support (use special IEEE hdl-code)!

:pushpin: At JLC you have to select: Remove Order Number = "Specify a location"

**[Schematic](https://github.com/vossi1/v6523/blob/master/v6523_v2.png)**

**[Parts](https://github.com/vossi1/v6523/blob/master/parts.txt)**

**CPLD-Firmware:** The .JED file can be uploaded with a JTAG-SMT2 Xilinx programmer (China) and [xc3sprog](https://xc3sprog.sourceforge.net/)

:exclamation: **BEWARE: I got good CPLD's from China but there are some XC9572XL FAKES out there**

![V6523 720-photo](https://github.com/vossi1/v6523/blob/master/v6523_v1_photo2.jpg)
cbm 720 (the very first V6523 on the photo misses the pin1 side notch)

:white_check_mark: **Tested successful in cbm620, 720 and P500 with:** Diagnostic-ROM and my fingers :wink:

:x: **Does not work in 1551, C64-Magic Voice, CDTV (A570)**

You have to solder a wire to pin 10 of the 74LS08 (PHI2): (sadly I forgot the "specify a location" option :wink: )

![V6523 ieee-photo](https://github.com/vossi1/v6523/blob/master/v6523_ieee_photo.jpg)

I added this logic for the IEEE support to the v.2 version:

![V6523 ieee-logic](https://github.com/vossi1/v6523/blob/master/v6523_ieee-logic.jpg)

REASON: Commodore didn't combined CS with PHI2 like in the CBM2 machines.
According to the datasheet for the 6525, they should have done that.
I don't know why it still works with the 6525 in the IEEE interface?
