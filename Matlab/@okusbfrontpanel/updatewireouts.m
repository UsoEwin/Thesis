function updatewireouts(obj)

%UPDATEWIREOUTS  Update all WireOut endpoints on XEM device.
%  UPDATEWIREOUTS(OBJ) updates all WireOut endpoints on the
%  device.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

calllib('okFrontPanel', 'okFrontPanel_UpdateWireOuts', obj.ptr);
