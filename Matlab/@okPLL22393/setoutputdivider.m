function obj = setoutputdivider(obj, n, div)

%SETOUTPUTDIVIDER  Sets an outputs divider value.
%  PLL=SETOUTPUTDIVIDER(OBJ, N, DIV) Sets output number N divider to DIV.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

calllib('okFrontPanel', 'okPLL22393_SetOutputDivider', obj.ptr, n, div);
