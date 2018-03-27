function q = getpllq(obj, n)

%GETPLLQ  Returns the Q divider for the specified PLL.
%  Q = GETPLLQ(OBJ, N) returns the currently programmed
%  Q divider for PLL number N.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

q = calllib('okFrontPanel', 'okPLL22393_GetPLLQ', obj.ptr, n);
