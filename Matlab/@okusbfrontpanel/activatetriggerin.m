function activatetriggerin(obj, epaddr, epbit)

%ACTIVATETRIGGERIN  Activate a trigger of a TriggerIn.
%  ACTIVATETRIGGERIN(OBJ,epADDR,BIT) activates a trigger
%  from a TriggerIn endpoint.  OBJ is the device class instance.
%  epADDR is a scalar containing the TriggerIn endpoint address
%  and BIT contains the corresponding bit (BIT = [0,7]).
%
%  The valid endpoint address ranges are:
%
%    0x00-0x1F : WireIn
%    0x20-0x3F : WireOut
%  * 0x40-0x5F : TriggerIn
%    0x60-0x7F : TriggerOut
%    0x80-0x9F : PipeIn
%    0xA0-0xBF : PipeOut
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

success = calllib('okFrontPanel', 'okFrontPanel_ActivateTriggerIn', obj.ptr, epaddr, epbit);

if (0 == success)
	error('ActivateTriggerIn failed.');
end
