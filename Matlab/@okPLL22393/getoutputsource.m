function y = getoutputsource(obj, n)

%GETOUTPUTSOURCE  Get an output source.
%  Y=GETOUTPUTSOURCE(OBJ, N) returns the source for output N.
%  The result is a string representing the source:
%     'ClkSrc_Ref'
%     'ClkSrc_PLL0_0'
%     'ClkSrc_PLL0_180'
%     'ClkSrc_PLL1_0'
%     'ClkSrc_PLL1_180'
%     'ClkSrc_PLL2_0'
%     'ClkSrc_PLL2_180'
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

y = calllib('okFrontPanel', 'okPLL22393_GetOutputSource', obj.ptr, n);
