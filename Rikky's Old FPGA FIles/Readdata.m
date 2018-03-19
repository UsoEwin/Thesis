%clc;clear all;close all;

%% Setup comm to OK

xptr=handles.fpga_xid.xptr;
if(exist('xptr','var'))
     [ok_is_open, voidPtr] =calllib('okFrontPanel', 'okUsbFrontPanel_IsOpen',xptr);
     [ok_is_enabled, voidPtr] =calllib('okFrontPanel', 'okUsbFrontPanel_IsFrontPanelEnabled',xptr);
     [ok_is_FP3sup, voidPtr] =calllib('okFrontPanel', 'okUsbFrontPanel_IsFrontPanel3Supported',xptr);
end

  if(~exist('xptr', 'var') || ~ok_is_open || ~ok_is_enabled || ~ok_is_FP3sup)
      disp('Initializing SPI...');
      [fpga_xid,success,xptr] = SPI_initialize(1,0,0);
      last = -1;
      
      % check if our initialize was successful
      if(~success)
          disp('Initializing SPI.. FAILED@@@');
          return
      end
  end


%% Reset the FPGA
reset_fpga = 1;
if (reset_fpga)
    [ok_ErrorCode, voidPtr] = calllib('okFrontPanel', 'okUsbFrontPanel_ActivateTriggerIn', xptr, hex2dec('51'), 0);
end

%% read out data
num_blocks = 64;
num_bytes = 1024; % 1024 = max
buf = zeros(num_bytes,num_blocks,'uint8');
for j = 1:num_blocks
    pv(j) = libpointer('uint8Ptr', buf(:,j));
end

%disp('Getting data from FPGA....');
for j = 1:num_blocks
    calllib('okFrontPanel', 'okUsbFrontPanel_ReadFromBlockPipeOut', xptr, hex2dec('A0'), num_bytes, num_bytes, pv(j));
end

%% parse data
values = zeros(num_blocks, round((num_bytes-1)/2));
%disp('Parsing data....');
total_string = [];
for j = 1:num_blocks
    
    if(num_blocks > 31 && mod(j,32) == 0)
        % if its going to take a while, give user feedback
        disp(['Block ' num2str(j)]);
    end
    
    for i=1:2:num_bytes-1
        x = pv(j).Value(i);
        x = cast(x,'uint8');
        y = pv(j).Value(i+1);
        y = cast(y,'uint8');

        x_string = dec2bin(x, 8);
        y_string = dec2bin(y, 8);
        %disp([y_string ' ' x_string]);
        %current_string = fliplr([y_string x_string(1:2)]); % take the first 11 bits that corresponds to the differencer out
        current_string = [y_string x_string];
        total_string = [total_string current_string];
        %disp(['-> ' current_string]);
        
        % Matlab's bin2num function
        % is much faster w/o the checking ;)
        %[m,n] = size(current_string);
        %v = current_string - '0'; 
        %twos = pow2(n-1:-1:0);
        %val = sum(v .* twos(ones(m,1),:),2);

        
        %disp(['-> ' num2str(val)]);
        
        % tc2dec (w/o bin2num function call)
        %N = 10;
        %y = sign(2^(N-1)-val)*(2^(N-1)-abs(2^(N-1)-val));
        %if ((y == 0) && (val ~= 0))
        %  value = -val;
        %else
        %    value = y;
        %end
        %disp(['-> ' num2str(value)]);
        %values(j,(i+1)/2) = value;

        %disp([num2str(i) ': ' current_string '  ->  ' ...
        %fliplr(current_string) '  ->  ' num2str(current_value)])
    end

    %figure; plot(values(j,:))
end

output=double(total_string-'0');
save('fpga_out.mat','output');
figure;
plot(output);


