function obj = setpllparameters(obj, n, p, q)

%SETPLLPARAMETERS  Sets the P and Q values for the specified PLL.
%  OBJ=SETPLLPARAMETERS(OBJ,N,P,Q) sets the P and Q values for PLL
%  number N.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

calllib('okFrontPanel', 'okPLL22393_SetPLLParameters', obj.ptr, n, p, q, 1);
