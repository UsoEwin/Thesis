function y = getoutputdivider(obj, n)

%GETOUTPUTDIVIDER  Get the output divider value.
%  Y=GETOUTPUTDIVIDER(OBJ, N) returns the output divider value for
%  output number N.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

y = calllib('okFrontPanel', 'okPLL22393_GetOutputDivider', obj.ptr, n);
