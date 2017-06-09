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


function singleIndexes_CreateFcn(hObject, eventdata, handles)
global channel;

singleErrorsString = channel.singleErrorsToString();
if  strcmp(singleErrorsString, '')
    set(hObject,'string','None');
else
    set(hObject,'string',channel.singleErrorsToString());
end

function periodicNumberOfBits_CreateFcn(hObject, eventdata, handles)
global channel;

set(hObject,'string',channel.periodicNumOfBits);

function periodicInterval_CreateFcn(hObject, eventdata, handles)
global channel;

set(hObject,'string',channel.periodicInterval);

function periodicStart_CreateFcn(hObject, eventdata, handles)
global channel;

set(hObject,'string',channel.periodicStart);


% --- Executes during object creation, after setting all properties.
function tbDesyncBreakpoint_CreateFcn(hObject, eventdata, handles)
global channel;

set(hObject,'string',channel.desyncBreakpoint);




% --- Executes during object creation, after setting all properties.
function rbDesyncTypeAppend_CreateFcn(hObject, eventdata, handles)
global channel;

if channel.desyncType == 1
    set(hObject,'value',1);
end
    

% --- Executes during object creation, after setting all properties.
function rbDesyncTypeDelete_CreateFcn(hObject, eventdata, handles)
global channel;

if channel.desyncType == -1
    set(hObject,'value',1);
end


% --- Executes during object creation, after setting all properties.
function rbDesyncNone_CreateFcn(hObject, eventdata, handles)
global channel;

if channel.desyncType == 0
    set(hObject,'value',1);
end


function tbDesyncBreakpoint_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function rbDesyncTypeRandom_CreateFcn(hObject, eventdata, handles)

global channel;

if channel.desyncType == 2
    set(hObject,'value',1);
end


% --- Executes on button press in btnOKglobal.
function btnOKglobal_Callback(hObject, eventdata, handles)
global channel;

% single errors
textBoxString = get(handles.singleIndexes, 'String');
channel.singleErrors = sscanf(textBoxString, '%d ');

% periodic errors
number = str2num(get(handles.periodicNumberOfBits, 'String'));
interval = str2num(get(handles.periodicInterval, 'String'));
start = str2num(get(handles.periodicStart, 'String'));

channel.periodicNumOfBits = number;
channel.periodicInterval = interval;
channel.periodicStart = start;

% desync errors
channel.desyncBreakpoint = str2num(get(handles.tbDesyncBreakpoint, 'String'));

if get(handles.rbDesyncTypeAppend,'value') == 1
    channel.desyncType = 1;
elseif get(handles.rbDesyncTypeDelete,'value') == 1
    channel.desyncType = -1;
elseif get(handles.rbDesyncTypeRandom,'value') == 1
    channel.desyncType = 2;
else
    channel.desyncType = 0;
end

close(handles.wrongBitsFigure);


