function varargout = ConfigureRandom(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ConfigureRandom_OpeningFcn, ...
                   'gui_OutputFcn',  @ConfigureRandom_OutputFcn, ...
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


% --- Executes just before ConfigureRandom is made visible.
function ConfigureRandom_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
movegui(hObject,'center');

% --- Outputs from this function are returned to the command line.
function varargout = ConfigureRandom_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in btnOK.
function btnOK_Callback(hObject, eventdata, handles)
global random;

probabilityValue = get(handles.sliderBDprobability, 'Value');
random.duplProb = probabilityValue;
close(handles.figConfigureRandom);

% --- Executes on slider movement.
function sliderBDprobability_Callback(hObject, eventdata, handles)

probabilityValue = get(hObject, 'Value');
set(handles.tbBDprobability, 'String', num2str(probabilityValue,3));

% --- Executes during object creation, after setting all properties.
function sliderBDprobability_CreateFcn(hObject, eventdata, handles)
global random;
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject,'Value',random.duplProb);


function tbBDprobability_Callback(hObject, eventdata, handles)
probabilityValue = str2double(get(hObject,'String'));
if probabilityValue < 0 || probabilityValue > 1
    errordlg('Probability must be within <0, 1> range','Range error');
    set(hObject, 'String', get(handles.sliderBDprobability, 'Value'));
else
    set(handles.sliderBDprobability, 'Value', str2double(get(hObject,'String')));
end

% --- Executes during object creation, after setting all properties.
function tbBDprobability_CreateFcn(hObject, eventdata, handles)
global random;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String',random.duplProb);
