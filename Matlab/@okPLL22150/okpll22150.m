function obj = okpll22150()

%okpll22150  Constructs an okpll22150 object.
%  OBJ=OKPLL22150() constructs the okpll22150 object.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

if ~libisloaded('okFrontPanel')
	loadlibrary('okFrontPanel', 'okFrontPanelDLL.h');
end

obj.ptr = calllib('okFrontPanel', 'okPLL22150_Construct');
calllib('okFrontPanel', 'okPLL22150_SetCrystalLoad', obj.ptr, 12.0);
calllib('okFrontPanel', 'okPLL22150_SetReference', obj.ptr, 48.0, 1);

obj = class(obj, 'okpll22150');
