function updatewireins(obj)

%UPDATEWIREINS  Update all WireIn endpoints on the device.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', obj.ptr);
