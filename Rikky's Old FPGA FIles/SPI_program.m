function  spi_readback = SPI_program(xptr, spi_setting, clkdiv, readback)

if(readback == 0) %program and loopback check
    addr = dec2bin(0,8);
    % 224 bits = 28 bytes
    % 512 bits = 64 bytes
    nbits = 512;
    nbytes = nbits/8;
    
    for i = 1:(nbytes-1) %CHANGE TO: i = 1:63
        addr = [addr,dec2bin(i,8)];
    end
    spi_address = double(addr)-48; %CHANGE TO: ???
    spi_address

    data = zeros(1,nbits*2);%CHANGE TO: calculate new bits (512*2)
    for i = 0:63 %CHANGE TO: change to i=0:63
        %Set address bit for SPI1
        data(i*16+1:i*16+8) = spi_address(i*8+1:i*8+8);
        %spi_address
        %Set spi settings for SPI1
        data(i*16+9:i*16+16) = fliplr(spi_setting(i*8+1:i*8+8));%fliplr
    end

    % Set SPI clock
    ma = hex2dec('FFFF');  
    val = 2^13+clkdiv;
    [ok_ErrorCode, voidPtr] =calllib('okFrontPanel', 'okUsbFrontPanel_SetWireInValue',xptr,00,val,ma);
    [voidPtr] =calllib('okFrontPanel', 'okUsbFrontPanel_UpdateWireIns',xptr);

    % Download SPI address and data to memory on FPGA by using ep00wire[10:0];
    for i = 0: length(data)-1
        val = data(i+1)+i*2;
        [ok_ErrorCode, voidPtr] =calllib('okFrontPanel', 'okUsbFrontPanel_SetWireInValue',xptr,00,val,ma);
        [voidPtr] =calllib('okFrontPanel', 'okUsbFrontPanel_UpdateWireIns',xptr);
    end

    % Start SPI
    val = val+2^15;
    [ok_ErrorCode, voidPtr] =calllib('okFrontPanel', 'okUsbFrontPanel_SetWireInValue',xptr,00,val,ma);
    [voidPtr] =calllib('okFrontPanel', 'okUsbFrontPanel_UpdateWireIns',xptr);
    
    spi_readback = zeros(1,512);
    
end

end
