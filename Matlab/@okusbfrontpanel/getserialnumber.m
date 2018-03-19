function sn = getserialnumber(obj)

%GETSERIALNUMBER  Returns the device serial number string.
%  SN=GETSERIALNUMBER(OBJ) returns the serial number of the device.
%  This string is set at the factory and stored in EEPROM.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

sn = calllib('okFrontPanel', 'okFrontPanel_GetSerialNumber', obj.ptr, '           ');
