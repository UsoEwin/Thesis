function obj = okusbfrontpanel(ptr)

%okusbfrontpanel  Constructs an okusbfrontpanel object.
%  OBJ=OKUSBFRONTPANEL(PTR) constructs an empty okusbfrontpanel Matlab
%  object.  This is required for the inheritance model of Matlab, but 
%  since we're merely wrapping DLL functions, it doesn't do anything.
%  PTR must be a valid pointer to an okUsbFrontPanel C++ object.
%
%  NOTE: This is called from another method and should not be called
%    by the user.
%
%  Copyright (c) 2005 Opal Kelly Incorporated
%  $Rev$ $Date$

obj.ptr=ptr;
obj = class(obj, 'okusbfrontpanel');
