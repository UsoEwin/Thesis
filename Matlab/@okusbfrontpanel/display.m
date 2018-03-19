function display(obj)

%DISPLAY  Display an okfrontpanel object.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

if (0 == isopen(obj))
	disp('   NO DEVICE OPEN.')
else
	stg = sprintf('      Board model: %s', getboardmodel(obj));
	disp(stg)
	stg = sprintf('Firmware revision: %d.%d', ...
		getdevicemajorversion(obj), getdeviceminorversion(obj));
	disp(stg)
	stg = sprintf('    Serial number: %s', getserialnumber(obj));
	disp(stg)
	stg = sprintf('        Device ID: %s', getdeviceid(obj));
	disp(stg)
end
