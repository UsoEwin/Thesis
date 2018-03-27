function v = getdevicemajorversion(obj)

%GETDEVICEMAJORVERSION  Returns the device major version number.
%  V=GETDEVICEMAJORVERSION(OBJ) returns the major version of the device.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

v = calllib('okFrontPanel', 'okFrontPanel_GetDeviceMajorVersion', obj.ptr);
