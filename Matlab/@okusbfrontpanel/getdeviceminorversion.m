function v = getdeviceminorversion(obj)

%GETDEVICEMINORVERSION  Returns the device minor version number.
%  V=GETDEVICEMINORVERSION(OBJ) returns the minor version of the device.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

v = calllib('okFrontPanel', 'okFrontPanel_GetDeviceMinorVersion', obj.ptr);
