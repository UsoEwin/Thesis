function obj = setdiv2(obj, divsrc, n)

%SETDIV2  Sets the divider 2 parameters.
%  PLL=SETDIV2(OBJ, DIVSRC, N) Sets the divider 2 clock source
%  to DIVSRC and the divider to N.  DIVSRC is one of the following
%  strings:
%     'DivSrc_Ref'
%     'DivSrc_VCO'
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

calllib('okFrontPanel', 'okPLL22150_SetDiv2', obj.ptr, divsrc, n);
