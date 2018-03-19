function obj = setoutputsource(obj, n, src)

%SETOUTPUTSOURCE  Get an output source.
%  PLL=SETOUTPUTSOURCE(OBJ, N, SRC) sets the source for output N to SRC
%  where SRC is a string representing the source:
%     'ClkSrc_Ref'
%     'ClkSrc_Div1ByN'
%     'ClkSrc_Div1By2'
%     'ClkSrc_Div1By3'
%     'ClkSrc_Div2ByN'
%     'ClkSrc_Div2By2'
%     'ClkSrc_Div2By4'
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

calllib('okFrontPanel', 'okPLL22150_SetOutputSource', obj.ptr, n, src);
