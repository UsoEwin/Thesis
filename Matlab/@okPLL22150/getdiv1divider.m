function y = getdiv1divider(obj)

%GETDIV1DIVIDER  Get the divider 1 divider value.
%  Y=GETDIV1DIVIDER(OBJ) returns the divider 1 divider in Y.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

y = calllib('okFrontPanel', 'okPLL22150_GetDiv1Divider', obj.ptr);
