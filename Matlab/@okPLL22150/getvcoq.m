function q = getvcoq(obj)

%GETVCOQ  Returns the current VCO Q divider.
%  Q = GETVCOQ(OBJ) returns the currently programmed
%  Q divider in the VCO.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

q = calllib('okFrontPanel', 'okPLL22150_GetVCOQ', obj.ptr);
