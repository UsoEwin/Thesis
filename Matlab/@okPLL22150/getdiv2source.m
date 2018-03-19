function y = getdiv2source(obj)

%GETDIV2SOURCE  Get the divider 2 source.
%  Y=GETDIV2SOURCE(OBJ) returns the divider 2 source in Y.
%  The result is a string representing the source:
%     'DivSrc_Ref'
%     'DivSrc_VCO'
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

y = calllib('okFrontPanel', 'okPLL22150_GetDiv2Source', obj.ptr);
