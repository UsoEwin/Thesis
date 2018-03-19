function y = getdiv2divider(obj)

%GETDIV2DIVIDER  Get the divider 2 divider value.
%  Y=GETDIV2DIVIDER(OBJ) returns the divider 2 divider in Y.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

y = calllib('okFrontPanel', 'okPLL22150_GetDiv2Divider', obj.ptr);
