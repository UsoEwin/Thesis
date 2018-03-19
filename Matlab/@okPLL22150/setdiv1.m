function obj = setdiv1(obj, divsrc, n)

%SETDIV1  Sets the divider 1 parameters.
%  PLL=SETDIV1(OBJ, DIVSRC, N) Sets the divider 1 clock source
%  to DIVSRC and the divider to N.  DIVSRC is one of the following
%  strings:
%     'DivSrc_Ref'
%     'DivSrc_VCO'
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

calllib('okFrontPanel', 'okPLL22150_SetDiv1', obj.ptr, divsrc, n);
