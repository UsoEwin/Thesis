import os
import ok
import time

dev = ok.okCFrontPanel()
dev.OpenBySerial("")
error = dev.ConfigureFPGA("first.bit")

while True:
    dev.SetWireInValue(0x00, 0x02);
    dev.UpdateWireIns()
    time.sleep(0.5)
    dev.SetWireInValue(0x00, 0x00);
    dev.UpdateWireIns()
    time.sleep(0.5)