%need pyversion
py.importlib.import_module('ok');
py.importlib.import_module('os');
py.importlib.import_module('time');

dev = py.ok.okCFrontPanel();
dev.OpenBySerial("");
error = dev.ConfigureFPGA("first.bit");

while 1
	a = int32(0);
	b = int32(1);
	dev.SetWireInValue(a, b);
	dev.UpdateWireIns();
	py.time.sleep(0.5);
	b = int32(0);
	dev.SetWireInValue(a, b);
	dev.UpdateWireIns();
	py.time.sleep(0.5);
end

