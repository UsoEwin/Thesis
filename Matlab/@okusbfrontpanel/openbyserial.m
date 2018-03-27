function obj=openbyserial(obj, str)

%OPENBYSERIAL  Open an Opal Kelly FrontPanel-enabled device.
%  Opens an attached device by serial number.
%
%  OBJ=OPENBYSERIAL(OBJ, '') opens the first device found.
%
%  OBJ=OPENBYSERIAL(OBJ, STRING) opens a device identified by serial
%  number STRING.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

if ~exist('str','var');
	str = '';
end

ret = calllib('okFrontPanel', 'okFrontPanel_OpenBySerial', obj.ptr, str);
