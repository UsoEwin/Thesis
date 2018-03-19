function obj = setoutputsource(obj, n, src)

%SETOUTPUTSOURCE  Get an output source.
%  PLL=SETOUTPUTSOURCE(OBJ, N, SRC) sets the source for output N to SRC
%  where SRC is a string representing the source:
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

calllib('okFrontPanel', 'okPLL22393_SetOutputSource', obj.ptr, n, src);
