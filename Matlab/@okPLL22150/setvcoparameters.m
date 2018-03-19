function obj = setvcoparameters(obj, p, q)

%SETVCOPARAMETERS  Sets the P and Q VCO dividers.
%  OBJ=SETVCOPARAMETERS(OBJ,P,Q) sets the P and Q dividers
%  which specify the VCO output frequency.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

calllib('okFrontPanel', 'okPLL22150_SetVCOParameters', obj.ptr, p, q);
