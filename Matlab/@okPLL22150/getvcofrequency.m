function freq = getvcofrequency(obj)

%GETVCOFREQUENCY  Returns the VCO frequency.
%  FREQ=GETVCOFREQUENCY(OBJ) returns the currently programmed VCO frequency.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

freq = calllib('okFrontPanel', 'okPLL22150_GetVCOFrequency', obj.ptr);
