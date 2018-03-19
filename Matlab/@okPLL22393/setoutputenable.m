function obj = setoutputenable(obj, n, en)

%SETOUTPUTENABLE  Enables or disables a PLL output.
%  PLL=SETOUTPUTENABLE(OBJ,N,EN) disables output N if EN=0.  Enables
%  output N otherwise.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

calllib('okFrontPanel', 'okPLL22393_SetOutputEnable', obj.ptr, n, en);
