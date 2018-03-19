%MERVIN'S SPI CODE
function [fpga_xid, success, xptr] = SPI_initialize(download, debug_nochip, brd_num)
%[fpga_xid] = SPI_initialize(download, filename)
%[fpga_xid] = SPI_initialize(download) %uses default value for bit file
% if download is 1 then it attempts to download the bit file to the fpga,
% if 0 it skips downloading

%bit_file = 'ecog_adc_synth_xlx_cw.bit';
bit_file = 'ECOG_TOP.bit';
%bit_file = 'wired_tester_top.bit';
if (debug_nochip)
    %bit_file = 'ecog_adc_synth_xlx_cw.bit'; %SPI_right_but_not_work
    bit_file = 'ECOG_TOP.bit';
    %bit_file = 'wired_tester_top.bit';
end

fpga_xid = struct ('xptr', [],'ok_is_open',0,'ok_is_enabled',0,...
    'ok_is_FP3sup',0,'bit_file',0,'serial',0,'model',0, 'time', -1, 'brd_num',0);
fpga_xid.time = datestr(now, 0); %time created

if (ismac)
     addpath('/Applications/FrontPanel.app');
     addpath('/Applications/FrontPanel.app/API');
     if ~libisloaded('okFrontPanel')
     	loadlibrary('okFrontPanel', 'okFrontPanelDLL.h');
     end
    
    % MAC is not currently supported by the Opal Kelly Matlab API
    %return;
    
end

% windows
if (ispc)
    addpath('C:\Program Files\Opal Kelly\FrontPanel\API\Matlab');
    addpath('C:\Program Files\Opal Kelly\FrontPanel\API');
    if ~libisloaded('okFrontPanel')
        loadlibrary('okFrontPanel', 'okFrontPanelDLL.h');
    end
end


% Try to construct an okUsbFrontPanel and open it.

xptr = calllib('okFrontPanel', 'okUsbFrontPanel_Construct');
num = calllib('okFrontPanel', 'okUsbFrontPanel_GetDeviceCount', xptr);
% Overwrite board number to first board if set too high
if (num <=brd_num)
    brd_num=0;
end
    
[m,voidPtr] = calllib('okFrontPanel',...
    'okUsbFrontPanel_GetDeviceListModel', xptr, brd_num);
[voidPtr,sn] = calllib('okFrontPanel',...
    'okUsbFrontPanel_GetDeviceListSerial', xptr, brd_num, '           ', 10);
[ok_ErrorCode, voidPtr, opened_sn] =calllib('okFrontPanel',...
    'okUsbFrontPanel_OpenBySerial',xptr, strcat(sn)); %convert char array to string 

    
if download
    % change 'spitb.bit' to 'spitb_test.bit' if you want to test the code
    % without connecting the opalkelly board to another chip
    [ok_HDL_load, voidPtr, HDLfile] = calllib('okFrontPanel',...
        'okUsbFrontPanel_ConfigureFPGA',xptr, bit_file);
end
[ok_is_open, voidPtr] =calllib('okFrontPanel', 'okUsbFrontPanel_IsOpen',xptr);
[ok_is_enabled, voidPtr] =calllib('okFrontPanel', 'okUsbFrontPanel_IsFrontPanelEnabled',xptr);
[ok_is_FP3sup, voidPtr] =calllib('okFrontPanel', 'okUsbFrontPanel_IsFrontPanel3Supported',xptr);
display([ ok_is_open, ok_is_enabled, ok_is_FP3sup]);
success = ok_is_open && ok_is_enabled && ok_is_FP3sup;

%Set return fpga data structure
fpga_xid.xptr = xptr;
fpga_xid.ok_is_open = ok_is_open;
fpga_xid.ok_is_enabled = ok_is_enabled;
fpga_xid.ok_is_FP3sup = ok_is_FP3sup;
fpga_xid.bit_file = bit_file; %bit file
fpga_xid.serial = sn; %serial
fpga_xid.model = m; %model 
fpga_xid.time = datestr(now, 0); %time created
fpga_xid.brd_num = brd_num; %Board number used
return;