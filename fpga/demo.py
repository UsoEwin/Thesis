# This file need to be placed under root of python
# This is a demo file for XEM 6010
import os
import ok
import time
dev = ok.okCFrontPanel()
dev.OpenBySerial("")
error = dev.ConfigureFPGA("first.bit")
#loop toggle the LED
while True:
    dev.SetWireInValue(0x00, 0x02)
    dev.UpdateWireIns()
    time.sleep(1)
    dev.SetWireInValue(0x00, 0x00)
    dev.UpdateWireIns()
    time.sleep(1)