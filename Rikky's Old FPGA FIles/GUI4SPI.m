function varargout = GUI4SPI(varargin)
% GUI4SPI MATLAB code for GUI4SPI.fig
%      GUI4SPI, by itself, creates a new GUI4SPI or raises the existing
%      singleton*.
%
%      H = GUI4SPI returns the handle to a new GUI4SPI or the handle to
%      the existing singleton*.
%
%      GUI4SPI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI4SPI.M with the given input arguments.
%
%      GUI4SPI('Property','Value',...) creates a new GUI4SPI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI4SPI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI4SPI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%       Created by: Mervin John
%       Berkeley Wireless Research Center (BWRC)
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI4SPI

% Last Modified by GUIDE v2.5 09-Sep-2012 16:23:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI4SPI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI4SPI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI4SPI is made visible.
function GUI4SPI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI4SPI (see VARARGIN)

% Choose default command line output for GUI4SPI
handles.output = hObject;

% MJ: Add global data
handles.gui_version = '1.2: 512bits';
handles.gui_date = '08/20/12';
handles.spi_length = 512;
handles.clkdiv = 160;
handles.clkfreq = '0.76kHz';
handles.num_spi =2;%TODO: change after editing SPI_program
handles.spi_stream = zeros (handles.spi_length, handles.num_spi);
handles.debugProgram = false;
%Create struct to store interface w/ Opal Kelly board
handles.fpga_xid = struct ('xptr', [],'ok_is_open',0,'ok_is_enabled',0,...
    'ok_is_FP3sup',0,'bit_file',0,'serial',0,'model',0, 'time', -1, 'brd_num',0);
% \MJ

% Update handles structure
guidata(hObject, handles);

% MJ: Initial GUI Data
text_about = sprintf ('%s %s \n%s %s', 'ActiveRFID SPI Matlab Interface ver. ',...
    handles.gui_version, 'Author: Rikky Muller ', handles.gui_date);
set(handles.text_about, 'String',text_about); 
set(handles.popupmenu_clkdiv, 'Value',3);
popupmenu_clkdiv_Callback(hObject, eventdata, handles);

%Add Cal Logo
I = imread('logo_cal.png');
image(I, 'Parent', handles.axes_logo);
axis (handles.axes_logo, 'off');
% \MJ

% UIWAIT makes GUI4SPI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI4SPI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_initialize.
function pushbutton_initialize_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_initialize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set_status(handles, 'Attempting to initialize FPGA....');

% Intialize FPGA (Multiple board option)
str = get(handles.popupmenu_brd, 'String');
val = get(handles.popupmenu_brd,'Value');
brd_num = str2num(str{val});
%handles.fpga_xid = SPI_initialize(1, get(handles.checkbox_nochip, 'Value'), brd_num);
[handles.fpga_xid,success,xptr] = SPI_initialize(1, 0, brd_num);
save data.mat xptr 
% update handles data 
guidata(hObject, handles);
% Set status
set_fpga_status (handles);
 

% --- Executes on button press in pushbutton_program.
function pushbutton_program_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_program (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set_status(handles, 'Attempting FPGA Program...');

spi_setting (1:handles.spi_length) = handles.spi_stream (:,1);

if (isempty(handles.fpga_xid.xptr))
    set_error(handles, 'FPGA XPTR not initialized: Try Initialize');
else
    readback = false;
    data_out = SPI_program(handles.fpga_xid.xptr, spi_setting, handles.clkdiv, readback);
    set_status(handles, 'FPGA Programmed');
end


% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_file= get(handles.edit_datafile, 'String');
set_status (handles, ['Loading settings from: '  data_file]);
fid = fopen (data_file);
if (fid < 0)
    set_error(handles, ['Settings could not be loaded from: '  data_file]);     
else
    str = get(handles.popupmenu_type, 'String');
    val = get(handles.popupmenu_type,'Value');
    switch str{val}
        case 'TXT'
            %Read data from file into structures
            nheaders = 1;
            data_format = '%s %u %u %u %s';
            data_delimiter = '\t';
            data = textscan (fid, data_format,... 
            'headerlines', nheaders, 'delimiter', data_delimiter);
            fclose (fid);

            spi_name = data{1}; spi_num = data{2}; spi_start = data{3};
            spi_end = data{4}; spi_default = data{5};
        case 'XLS'
            fclose (fid);
            [num,txt,data] = xlsread(data_file, 'Sheet1');
            spi_name = data(2:end,1); spi_num = cell2mat(data(2:end,2)); 
            spi_start = cell2mat(data(2:end,3));
            spi_end = cell2mat(data(2:end,4)); spi_default = data(2:end,5);
        case 'MAT'
            load(data_file, '-mat', 'dat');
            set_uitable_settings (hObject, handles, dat);
            set_status (handles, ['Settings loaded from: '  data_file]);
            return;
    end
    
    %Validate data
    n = length(spi_start);
    spi_size = abs(spi_end - spi_start)+1;
    spi_valid = zeros(n, 1);
    %For each row of SPI settings, check if length of digits is same as number
    %of bits
    for r=1:n
        spi_valid(r) = (spi_size(r) == length(spi_default{r})) ;
    end

    %Check if settings are binary
    bin2dec(spi_default); 

    for j=1:n
        dat(j,:) = {spi_name{j}, spi_num(j), spi_start(j), spi_end(j), spi_default{j}};
    end
    
    set_uitable_settings (hObject, handles, dat);
    set_status (handles, ['Settings loaded from: '  data_file]);
end


function edit_datafile_Callback(hObject, eventdata, handles)
% hObject    handle to edit_datafile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_datafile as text
%        str2double(get(hObject,'String')) returns contents of edit_datafile as a double

% --- Executes during object creation, after setting all properties.
function edit_datafile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_datafile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLABtable
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function set_status(handles, text)
status = [datestr(now, 14) ' Status: ' text];
set (handles.text_status, 'String', status);
set (handles.text_status, 'BackgroundColor', [0 1 0]);

function set_error(handles, text)
status = [datestr(now, 14) ' Error: ' text];
set (handles.text_status, 'String', status);
set (handles.text_status, 'BackgroundColor', [1 0 0]);

function set_fpga_status(handles)
set(handles.text_fpga_time, 'String', handles.fpga_xid.time);
set(handles.text_model, 'String', handles.fpga_xid.model);
set(handles.text_serial, 'String', handles.fpga_xid.serial);
set (handles.text_isopen, 'BackgroundColor', [0 handles.fpga_xid.ok_is_open 0]);
set (handles.text_isenabled, 'BackgroundColor', [0 handles.fpga_xid.ok_is_enabled 0]);
set (handles.text_isFP3sup, 'BackgroundColor', [0 handles.fpga_xid.ok_is_FP3sup 0]);

if (handles.fpga_xid.xptr == 0)
    set_error (handles, 'FPGA initialization attempt failed');
elseif  (all([handles.fpga_xid.ok_is_open,handles.fpga_xid.ok_is_enabled,...
        handles.fpga_xid.ok_is_FP3sup] ))
    set_status (handles, ['FPGA Initialized on board ' num2str(handles.fpga_xid.brd_num) ]);
    set(handles.pushbutton_program, 'Enable', 'on');
    %set(handles.pushbutton_readback, 'Enable', 'on');
    set(handles.popupmenu_brd, 'Value',handles.fpga_xid.brd_num+1);
else
    set_error (handles, 'FPGA Not Initialized');
end

%Load settings from dat into SPI Settings Table (uitable)
function set_uitable_settings (hObject, handles, dat)
% hObject    handle to edit_datafile (see GCBO)
% handles    structure with handles and user data (see GUIDATA)
% dat    structure with settings data
columnname =   {'Description', 'SPI', 'Start', 'Finish', 'Settings'};
columnformat = {'char', {'1','2'}, 'numeric', 'numeric', 'char'};
columnwidth = {150 40 40 40 200};
columneditable =  [false false false false true];
set(handles.uitable_settings, 'ColumnName', columnname);
set(handles.uitable_settings, 'ColumnFormat', columnformat);
set(handles.uitable_settings, 'ColumnEditable', columneditable);
set(handles.uitable_settings, 'Data', dat);
set(handles.uitable_settings, 'ColumnWidth', columnwidth);
set(handles.uitable_settings, 'RowName', 'numbered');
update_stream (hObject, handles);


function update_stream (hObject, handles)
set(handles.text_stream1, 'String', '');
dat = get(handles.uitable_settings, 'Data');
spi_name = dat(:,1); spi_num = cell2mat(dat(:, 2)); spi_start = cell2mat(dat(:,3));
spi_end = cell2mat(dat(:,4)); spi_setting = dat(:,5);

% Validate data
n = length(spi_start);
spi_size = abs(double(spi_end) - double(spi_start))+1;
spi_valid = zeros(n, 1);
% For each row of SPI settings, check if length of digits is same as number
% of bits
for r=1:n
    spi_valid(r) = (spi_size(r) == length(spi_setting{r})) ;
end

% TODO: validate bits

% Check if settings are binary
bin2dec(spi_setting); %TODO: more graceful exit

% If valid settings, then create SPI stream from default settings

for j=1:n
    setting = spi_setting{j};
    if (spi_end(j) >= spi_start(j))
        for k=1:spi_size(j)
            handles.spi_stream((spi_start(j)+k), spi_num(j)) = str2double(setting(k));   
        end
    else
         for k=1:spi_size(j)
             settinglr = fliplr(setting);
             handles.spi_stream(spi_end(j)+(k), spi_num(j)) = str2double(settinglr(k));   
         end    
    end
end



% Display string in box
set(handles.text_stream1, 'String', num2str(handles.spi_stream(:,1).', '%d%d%d%d%d%d%d%d '));

% Uncomment below for 2 SPI system
%set(handles.text_stream2, 'String', num2str(handles.spi_stream(:,2).', '%d%d%d%d%d%d%d%d '));

guidata(hObject, handles);

% --- Executes when entered data in editable cell(s) in uitable_settings.
function uitable_settings_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_settings (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
update_stream (hObject, handles);


% --- Executes on button press in radiobutton_D5.
function update_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_D5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_D5
update_stream (hObject, handles)

% --- Executes on selection change in popupmenu_clkdiv.
function popupmenu_clkdiv_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_clkdiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_clkdiv contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_clkdiv

% Determine the selected data set.
str = get(handles.popupmenu_clkdiv, 'String');
val = get(handles.popupmenu_clkdiv,'Value');
% Set current data to the selected data set.
switch str{val}
    case '10'
        handles.clkdiv = 10;
        handles.clkfreq = '48.8kHz';
    case '11'
        handles.clkdiv = 11;
        handles.clkfreq = '24.4kHz';
    case '12'
        handles.clkdiv = 12;
        handles.clkfreq = '12.2kHz';
    case '13'
        handles.clkdiv = 13;
        handles.clkfreq = '6.1kHz';
    case '14'
        handles.clkdiv = 14;
        handles.clkfreq = '3.05kHz';
    case '15'
        handles.clkdiv = 15;
        handles.clkfreq = '1.52kHz';
    case '16'
        handles.clkdiv = 160;
        handles.clkfreq = '0.76kHz';
    case '160'
        handles.clkdiv = 160;
        handles.clkfreq = '0.76kHz';
end
% Save the handles structure.
guidata(hObject,handles)
set(handles.text_clkdiv, 'String', handles.clkfreq);

% --- Executes during object creation, after setting all properties.
function popupmenu_clkdiv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_clkdiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_wkupregclk.
function popupmenu_wkupregclk_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_wkupregclk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_wkupregclk contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_wkupregclk

update_stream(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_wkupregclk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_wkupregclk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu_resultoutp.
function popupmenu_resultoutp_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_resultoutp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_resultoutp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_resultoutp
update_stream(hObject, handles);


% --- Executes on button press in popupmenu_type.
function popupmenu_type_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of popupmenu_type


% --------------------------------------------------------------------
function Menu_file_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Menu_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile({ '*.txt;*.xls;*.mat;','Setting Files (*.txt,*.xls,*.mat,)';...
   '*.txt',  'Tab-delimited txt file (*.txt)'; ...
   '*.xls','Excel (*.xls)'; ...
   '*.mat','MAT-files (*.mat)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file', '.\Settings');

if isequal(filename,0)
   disp('User selected Cancel');
else
   disp(['User selected', fullfile(pathname, filename)]);
   [pathstr, name, ext] = fileparts(filename);
   switch (lower(ext))
       case '.txt'
           set (handles.popupmenu_type, 'Value', 1);
       case '.xls'
           set (handles.popupmenu_type, 'Value', 2);
       case '.mat'
           set (handles.popupmenu_type, 'Value', 3);
   end
   set(handles.edit_datafile, 'String', fullfile(pathname, filename));
end


% --------------------------------------------------------------------
function Menu_save_mat_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_save_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
today = datestr(now, 30);
dat = get(handles.uitable_settings, 'Data');
comments = get(handles.edit_comment, 'String');
uisave({'comments', 'dat'},[today '_spi_settings']);
set_status(handles, ['Settings saved to :' today '_spi_settings.mat']);


% --------------------------------------------------------------------
function Menu_load_mat_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_load_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.mat', 'Select a MAT data file');
if isequal(filename,0)
   disp('User selected Cancel');
else
   disp(['User selected', fullfile(pathname, filename)]);
   load(fullfile(pathname, filename), '-mat', 'dat');
   comments = '';
   load(fullfile(pathname, filename), '-mat', 'comments');
   set_uitable_settings (hObject, handles, dat); 
   set (handles.edit_comment, 'String', comments);           
   set (handles.edit_datafile, 'String', fullfile(pathname, filename));
   set (handles.popupmenu_type, 'Value', 3);
   set_status(handles, ['Settings loaded from: ' filename]);
end



function edit_comment_Callback(hObject, eventdata, handles)
% hObject    handle to edit_comment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_comment as text
%        str2double(get(hObject,'String')) returns contents of edit_comment as a double


% --- Executes during object creation, after setting all properties.
function edit_comment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_comment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_brd.
function popupmenu_brd_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_brd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_brd contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_brd


% --- Executes during object creation, after setting all properties.
function popupmenu_brd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_brd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Readdata
