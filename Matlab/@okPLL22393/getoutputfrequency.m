function freq = getoutputfrequency(obj, n)

%GETOUTPUTFREQUENCY  Returns an output frequency.
%  FREQ=GETOUTPUTFREQUENCY(OBJ,N) returns the output frequency of the
%  output number N.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

freq = calllib('okFrontPanel', 'okPLL22393_GetOutputFrequency', obj.ptr, n);
