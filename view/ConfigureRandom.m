function varargout = ConfigureRandom(varargin)
% CONFIGURERANDOM MATLAB code for ConfigureRandom.fig
%      CONFIGURERANDOM, by itself, creates a new CONFIGURERANDOM or raises the existing
%      singleton*.
%
%      H = CONFIGURERANDOM returns the handle to a new CONFIGURERANDOM or the handle to
%      the existing singleton*.
%
%      CONFIGURERANDOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIGURERANDOM.M with the given input arguments.
%
%      CONFIGURERANDOM('Property','Value',...) creates a new CONFIGURERANDOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ConfigureRandom_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ConfigureRandom_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ConfigureRandom

% Last Modified by GUIDE v2.5 04-Jun-2017 11:55:06

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT


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
% hObject    handle to tbBDprobability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String',random.duplProb);
