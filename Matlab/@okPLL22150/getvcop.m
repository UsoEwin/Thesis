function p = getvcop(obj)

%GETVCOP  Returns the current VCO P divider.
%  P = GETVCOP(OBJ) returns the currently programmed
%  P divider in the VCO.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

p = calllib('okFrontPanel', 'okPLL22150_GetVCOP', obj.ptr);
