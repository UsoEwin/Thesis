function success=isopen(obj)

%ISOPEN  Check if the device is open.
%  S=ISOPEN(OBJ) checks whether the device is open or not.
%  S=1 if device is open, S=0 if device is not open.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

success = calllib('okFrontPanel', 'okFrontPanel_IsOpen', obj.ptr);
