function s=isfrontpanelenabled(obj)

%ISFRONTPANELENABLED  Check if FrontPanel is enabled on XEM device.
%  S=ISFRONTPANELENABLED(OBJ) checks whether FrontPanel is enabled
%  on the device.
%  S=1 if FrontPanel is enabled, S=0 if FrontPanel access is not available.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

s = calllib('okFrontPanel', 'okFrontPanel_IsFrontPanelEnabled', obj.ptr);
