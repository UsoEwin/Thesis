function p = getpllp(obj, n)

%GETPLLP  Returns the P multiplier for the specified PLL.
%  P = GETPLLP(OBJ, N) returns the currently programmed
%  P multiplier for PLL number N.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

p = calllib('okFrontPanel', 'okPLL22393_GetPLLP', obj.ptr, n);
