function id = getdeviceid(obj)

%GETDEVICEID  Returns the device ID string.
%  ID=GETDEVICEID(OBJ) returns the device ID string of the device.
%  This string is configurable by the user using SETDEVICEID.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

id = calllib('okFrontPanel', 'okFrontPanel_GetDeviceID', obj.ptr, '                                 ');
