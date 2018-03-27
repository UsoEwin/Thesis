function updatetriggerouts(obj)

%UPDATETRIGGEROUTS  Update all TriggerOut endpoints on the device.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

calllib('okFrontPanel', 'okFrontPanel_UpdateTriggerOuts', obj.ptr);
