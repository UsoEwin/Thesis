function reset(obj)

%RESET  Reset the device.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

calllib('okFrontPanel', 'okFrontPanel_ResetFPGA', obj.ptr);
