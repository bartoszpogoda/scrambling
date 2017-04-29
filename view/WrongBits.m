function varargout = WrongBits(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WrongBits_OpeningFcn, ...
                   'gui_OutputFcn',  @WrongBits_OutputFcn, ...
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


% --- Executes just before WrongBits is made visible.
function WrongBits_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = WrongBits_OutputFcn(hObject, eventdata, handles) 

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

set(hObject,'string',channel.singleErrorsToString());

function periodicNumberOfBits_CreateFcn(hObject, eventdata, handles)
function periodicInterval_CreateFcn(hObject, eventdata, handles)
function periodicStart_CreateFcn(hObject, eventdata, handles)
