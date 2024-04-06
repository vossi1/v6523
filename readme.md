# V6523 - Replacement for a 6523 or 6525 without IRQ Controller (CBM2 keyboard TPI)  

**Copyright (c) 2024 Vossi - v.1 / v.2 (C64 IEEE option)**

**www.mos6509.com**

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

**[Schematic](https://github.com/vossi1/v6523/blob/master/v6523_v2.png)**

**[Parts](https://github.com/vossi1/v6523/blob/master/parts.txt)**

![V6523 720-photo](https://github.com/vossi1/v6523/blob/master/v6523_v1_photo2.jpg)
cbm 720

**Gerber v.2 have only minimal changes, but they are currently untested. I will remove this when I have the first pcb here and it's tested!**

Note: The very first V6523 on the photo misses the pin1 side notch.

**Tested successful in cbm620, 720 and P500 with:** Diagnostic-ROM and fingers ;)
**Does not work in C64-Magic Voice, C64-IEEE488, CDTV (A570)**
**NOT tested in:** 1551

:x: **BEWARE: I got good CPLD's from China but There are some XC9572XL FAKES out there**

**UPDATE: Special hdl-code for the C64 IEEE488 interface + v.2 with PHI2 solder point:**

You have to solder a wire from pin 39 of the CPLD (v.1) to pin 10 of the 74LS08 (PHI2).
With the v.2 board you now have a solderpoint for Pin39 / PHI2!

REASON: Commodore didn't combined CS with PHI2 like in the CBM2 machines.
According to the datasheet for the 6525, they should have done that.
I don't know why it still works with the 6525 in the IEEE interface?

![V6523 ieee-photo](https://github.com/vossi1/v6523/blob/master/v6523_ieee_photo.jpg)

