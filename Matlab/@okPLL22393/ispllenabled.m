function y = isoutputenabled(obj, n)

%ISOUTPUTENABLED  Checks if an output is enabled.
%  Y=ISOUTPUTENABLED(OBJ,N) returns 1 if output N is enabled.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

y = calllib('okFrontPanel', 'okPLL22393_IsOutputEnabled', obj.ptr, n);
