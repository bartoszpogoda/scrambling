function varargout = ConfigureBSC(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ConfigureBSC_OpeningFcn, ...
                   'gui_OutputFcn',  @ConfigureBSC_OutputFcn, ...
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


% --- Executes just before ConfigureBSC is made visible.
function ConfigureBSC_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);
movegui(hObject,'center');


% --- Outputs from this function are returned to the command line.
function varargout = ConfigureBSC_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in btnOKBSC.
function btnOKBSC_Callback(hObject, eventdata, handles)
global channel;

probabilityValue = get(handles.sliderProbabilityBSC, 'Value');
channel.probability = probabilityValue;
close(handles.figConfigureBSC);

% --- Executes on slider movement.
function sliderProbabilityBSC_Callback(hObject, eventdata, handles)

BSCpercentage = get(hObject, 'Value');
set(handles.tbBSCProbability, 'String', num2str(BSCpercentage,3));


% --- Executes during object creation, after setting all properties.
function sliderProbabilityBSC_CreateFcn(hObject, eventdata, handles)
global channel;

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject,'Value',channel.probability);



function tbBSCProbability_Callback(hObject, eventdata, handles)

currentTBValue = str2double(get(hObject,'String'));
if currentTBValue < 0 || currentTBValue > 0.5
    errordlg('Crossover probability must be within <0, 0.5> range','Range error');
    set(hObject, 'String', get(handles.sliderProbabilityBSC, 'Value'));
else
    set(handles.sliderProbabilityBSC, 'Value', str2double(get(hObject,'String')));
end



% --- Executes during object creation, after setting all properties.
function tbBSCProbability_CreateFcn(hObject, eventdata, handles)
global channel;

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String',channel.probability);
