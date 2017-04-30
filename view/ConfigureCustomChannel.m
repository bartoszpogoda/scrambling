function varargout = ConfigureCustomChannel(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ConfigureCustomChannel_OpeningFcn, ...
                   'gui_OutputFcn',  @ConfigureCustomChannel_OutputFcn, ...
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


% --- Executes just before ConfigureCustomChannel is made visible.
function ConfigureCustomChannel_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);
movegui(hObject,'center');


% --- Outputs from this function are returned to the command line.
function varargout = ConfigureCustomChannel_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in singleOKButton.
function singleOKButton_Callback(hObject, eventdata, handles)
global channel;

textBoxString = get(handles.singleIndexes, 'String');
singleIndexesVar = sscanf(textBoxString, '%d ');
channel.setSingleErrors(singleIndexesVar);
close(handles.wrongBitsFigure);


% --- Executes during object creation, after setting all properties.
function singleInfo_CreateFcn(hObject, eventdata, handles)
global encodedSignalVar;

set(hObject, 'String', strcat('Signal length : ', num2str(encodedSignalVar.getSize()), '(for making last bits wrong)'));


function singleIndexes_CreateFcn(hObject, eventdata, handles)
global channel;

singleErrorsString = channel.singleErrorsToString();
if  strcmp(singleErrorsString, '')
    set(hObject,'string','None');
else
    set(hObject,'string',channel.singleErrorsToString());
end

function periodicOKButton_Callback(hObject, eventdata, handles)
global channel;

number = str2num(get(handles.periodicNumberOfBits, 'String'));
interval = str2num(get(handles.periodicInterval, 'String'));
start = str2num(get(handles.periodicStart, 'String'));

channel.setPeriodicNumOfBits(number);
channel.setPeriodicInterval(interval);
channel.setPeriodicStart(start);

close(handles.wrongBitsFigure);

function periodicNumberOfBits_CreateFcn(hObject, eventdata, handles)
global channel;

set(hObject,'string',channel.getPeriodicNumOfBits());

function periodicInterval_CreateFcn(hObject, eventdata, handles)
global channel;

set(hObject,'string',channel.getPeriodicInterval());

function periodicStart_CreateFcn(hObject, eventdata, handles)
global channel;

set(hObject,'string',channel.getPeriodicStart());
