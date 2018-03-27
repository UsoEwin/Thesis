function freq = getoutputfrequency(obj, n)

%GETOUTPUTFREQUENCY  Returns an output frequency.
%  FREQ=GETOUTPUTFREQUENCY(OBJ,N) returns the output frequency of the
%  N-th PLL output.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

freq = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', obj.ptr, n);
