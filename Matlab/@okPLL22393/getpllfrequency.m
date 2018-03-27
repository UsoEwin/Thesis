function freq = getpllfrequency(obj, n)

%GETPLLFREQUENCY  Returns a PLL's VCO frequency.
%  FREQ=GETPLLFREQUENCY(OBJ, N) returns the current VCO frequency
%  for PLL number N.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

freq = calllib('okFrontPanel', 'okPLL22393_GetPLLFrequency', obj.ptr, n);
