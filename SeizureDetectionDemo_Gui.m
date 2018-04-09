function varargout = SeizureDetectionDemo_Gui(varargin)
% SEIZUREDETECTIONDEMO_GUI MATLAB code for SeizureDetectionDemo_Gui.fig
%      SEIZUREDETECTIONDEMO_GUI, by itself, creates a new SEIZUREDETECTIONDEMO_GUI or raises the existing
%      singleton*.
%
%      H = SEIZUREDETECTIONDEMO_GUI returns the handle to a new SEIZUREDETECTIONDEMO_GUI or the handle to
%      the existing singleton*.
%
%      SEIZUREDETECTIONDEMO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEIZUREDETECTIONDEMO_GUI.M with the given input arguments.
%
%      SEIZUREDETECTIONDEMO_GUI('Property','Value',...) creates a new SEIZUREDETECTIONDEMO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SeizureDetectionDemo_Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SeizureDetectionDemo_Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SeizureDetectionDemo_Gui

% Last Modified by GUIDE v2.5 20-Mar-2018 22:50:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SeizureDetectionDemo_Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @SeizureDetectionDemo_Gui_OutputFcn, ...
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


% --- Executes just before SeizureDetectionDemo_Gui is made visible.
function SeizureDetectionDemo_Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SeizureDetectionDemo_Gui (see VARARGIN)

% Perform all the calculations
load('testdata_demo.mat');

handles.weightedSum = weightedSum;

h = fdesign.bandpass('N,F3dB1,F3dB2', 6, 1, 70, 250);
Hd = design(h, 'butter');
handles.dataFiltered = filter(Hd, data);
windowLength = 250;

handles.lineLength = movsum(abs(diff(handles.dataFiltered)), [windowLength-1 0])/windowLength;
handles.lineLength = handles.lineLength/max(handles.lineLength);

h1  = fdesign.bandpass('N,F3dB1,F3dB2', 6, 4, 8, 250);
Hd1 = design(h1, 'butter');
dataFiltered1 = filter(Hd1, data);
handles.thetaBandPower = movmean(dataFiltered1.^2, [windowLength-1 0]); 
handles.thetaBandPower = handles.thetaBandPower/max(handles.thetaBandPower);

h2  = fdesign.bandpass('N,F3dB1,F3dB2', 6, 8, 16, 250);
Hd2 = design(h2, 'butter');
dataFiltered2 = filter(Hd2, data);
handles.betaBandPower = movmean(dataFiltered2.^2, [windowLength-1 0]); 
handles.betaBandPower = handles.betaBandPower/max(handles.betaBandPower);

val = handles.dataFiltered.^2 - circshift(handles.dataFiltered, 1).*circshift(handles.dataFiltered, -1);
val([1 end]) = 0;
handles.nonlinearEnergy = movmean(val, [windowLength-1 0]);
handles.nonlinearEnergy = handles.nonlinearEnergy/max(handles.nonlinearEnergy);

handles.current_data = handles.lineLength;
handles.bitStop = false; 

handles.dataFilteredSeizure = NaN(size(data));
handles.dataFilteredSeizure(isSeizure) = handles.dataFiltered(isSeizure);
handles.dataFiltered(isSeizure) = NaN;

% Replace with previous neighbor to account for sliding window
for i = 1:50:16135
    handles.lineLength(i:i+49) = handles.lineLength(i);
    handles.thetaBandPower(i:i+49) = handles.thetaBandPower(i);
    handles.betaBandPower(i:i+49) = handles.betaBandPower(i);
    handles.nonlinearEnergy(i:i+49) = handles.nonlinearEnergy(i);
end

% Initialize all of the plots 
hold(handles.axes1, 'on')
hold(handles.axes2, 'on')
hold(handles.axes3, 'on')
hold(handles.axes4, 'on')

title(handles.axes1,'Filtered iEEG Data');
handles.filteredPlot = plot(handles.axes1, 0, 0, 'k');
handles.filteredPlotSeizure = plot(handles.axes1, 0, 0, 'r');
ylim(handles.axes1,[-400 600])
xlim(handles.axes1,[0 16135])

title(handles.axes2,'iEEG Data Feature Calculation')
handles.featurePlot = plot(handles.axes2, 0, 0, 'k');
handles.thresholdPlot = plot(handles.axes2, 0, 0, 'b');
xlim(handles.axes2,[0 16135])
ylim(handles.axes2, [-0.1 1.1])
     
title(handles.axes3,'iEEG Data Feature Comparison to Threshold');
handles.bitsPlot = stairs(handles.axes3, 0, 0, 'k');
xlim(handles.axes3,[0 16135])
ylim(handles.axes3,[-0.1 1.1])

title(handles.axes4,'Weighted Sum Calculation');
handles.weightsPlot = plot(handles.axes4, 0, 0, 'k');
handles.thresholdPlot2 = plot(handles.axes4, 0, 0, 'b');
xlim(handles.axes4,[0 16135])
ylim(handles.axes4,[-0.1 100])

% Choose default command line output for SeizureDetectionDemo_Guihald
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SeizureDetectionDemo_Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SeizureDetectionDemo_Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Size of the demo data
x = 1:1:16135;
i = 1; 
updatestep = 10;
% Initialize interface with FPGA
py.importlib.import_module('ok');
py.importlib.import_module('os');
py.importlib.import_module('time');

dev = py.ok.okCFrontPanel();
dev.OpenBySerial("");

while (1)
    % Make sure handles is updated to most recent version
    handles = guidata(hObject);
    set(handles.filteredPlot, 'XData', x(1:i), 'YData', handles.dataFiltered(1:i));
    set(handles.filteredPlotSeizure, 'XData', x(1:i), 'YData', handles.dataFilteredSeizure(1:i));
    
    threshold = get(handles.slider2, 'Value');
    set(handles.thresholdPlot, 'XData', [0 length(x)], 'YData', [threshold threshold]);
    
    h = get(handles.uibuttongroup1,'SelectedObject');
    switch get(h,'Tag')
        case 'radiobutton1'
            set(handles.featurePlot, 'XData', x(1:i), 'YData', handles.lineLength(1:i));
            bits = handles.lineLength(1:i) > threshold;
        case 'radiobutton2'
            set(handles.featurePlot, 'XData', x(1:i), 'YData', handles.thetaBandPower(1:i));
            bits = handles.thetaBandPower(1:i) > threshold;
        case 'radiobutton3'
            set(handles.featurePlot, 'XData', x(1:i), 'YData', handles.betaBandPower(1:i));
            bits = handles.betaBandPower(1:i) > threshold;
        case 'radiobutton4'
            set(handles.featurePlot, 'XData', x(1:i), 'YData', handles.nonlinearEnergy(1:i));
            bits = handles.nonlinearEnergy(1:i) > threshold;
        otherwise
            set(handles.featurePlot, 'XData', x(1:i), 'YData', handles.current_data(1:i));
            bits = handles.current_data(1:i) > threshold;
    end
    
    set(handles.bitsPlot, 'XData', x(1:i), 'YData', double(bits));
    
    threshold2 = 100*get(handles.slider3, 'Value');
    set(handles.thresholdPlot2, 'XData', [0 length(x)], 'YData', [threshold2 threshold2]);
    set(handles.weightsPlot, 'XData', x(1:i), 'YData', handles.weightedSum(1:i));
    
    % Code for led control when seizure detected
    if(handles.weightedSum(i) > threshold2) 
    	a = int32(0);
        b = int32(255);
        dev.SetWireInValue(a, b);
        dev.UpdateWireIns();
        py.time.sleep(0.05);
        a = int32(0);
        b = int32(0);
        dev.SetWireInValue(a, b);
        dev.UpdateWireIns();
    end
    
    % Create the updated plot
    drawnow
    
    if(i >= length(x) - updatestep)
        i = 1;
    end
    i = i + updatestep;
    
    if handles.bitStop
        break
    end

end

% Update handles structure
guidata(hObject, handles);

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.bitStop = true;

% Update handles structure
guidata(hObject, handles);


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
