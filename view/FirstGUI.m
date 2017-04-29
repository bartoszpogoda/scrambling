function varargout = FirstGUI(varargin)
addpath(genpath('view'));
addpath(genpath('model'));

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FirstGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FirstGUI_OutputFcn, ...
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


% --- Executes just before FirstGUI is made visible.
function FirstGUI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);
movegui(hObject,'center');
    

% --- Outputs from this function are returned to the command line.
function varargout = FirstGUI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in signalButton.
function signalButton_Callback(hObject, eventdata, handles)
global file; global originalSignalVar;

fileName = get(handles.fileInput, 'String');
if isempty(fileName)
    fprintf('Brak pliku');
else
    originalSignalVar = Signal('files/signal64.txt');
    set(handles.originalSignal, 'string', originalSignalVar.toString());
end

% --- Executes on button press in sendButton.
function sendButton_Callback(hObject, eventdata, handles)
global encodedSignalVar; global channel; global receivedSignalVar;

channel.send(encodedSignalVar);
receivedSignalVar = channel.receive();
set(handles.receivedSignal, 'String', receivedSignalVar.toString());


% --- Executes on button press in scrambleButton.
function scrambleButton_Callback(hObject, eventdata, handles)
global originalSignalVar; global scrambledSignalVar;

scrambler = Scrambler();
originalSignalVarCopy = originalSignalVar.copy();
scrambledSignalVar = scrambler.scramble(originalSignalVarCopy);
set(handles.scrambledSignal, 'String', scrambledSignalVar.toString());


% --- Executes on button press in descrambleButton.
function descrambleButton_Callback(hObject, eventdata, handles)
global decodedSignalVar; global descrambledSignalVar; global originalSignalVar;

descrambler = Descrambler();
descrambledSignalVar = descrambler.descramble(decodedSignalVar);
set(handles.descrambledSignal, 'String', descrambledSignalVar.toString());
set(handles.berValue, 'String', Helper.calculateBER(originalSignalVar,descrambledSignalVar));


% --- Executes on button press in encodeButton.
function encodeButton_Callback(hObject, eventdata, handles)
global encodedSignalVar; global scrambledSignalVar;

encoder = EthernetCoder();
scrambledSignalVarCopy = scrambledSignalVar;
encodedSignalVar = encoder.encode(scrambledSignalVarCopy);
set(handles.encodedSignal, 'String', encodedSignalVar.toString());


% --- Executes on button press in decodeButton.
function decodeButton_Callback(hObject, eventdata, handles)
global decodedSignalVar; global receivedSignalVar;

decoder = EthernetDecoder();
decodedSignalVar = decoder.decode(receivedSignalVar);
set(handles.decodedSignal, 'String', decodedSignalVar.toString());



% --- Executes on button press in wrongBitsButton.
function wrongBitsButton_Callback(hObject, eventdata, handles)
WrongBits();


% --- Executes on button press in btnConfigureChannel.
function btnConfigureChannel_Callback(hObject, eventdata, handles)

if get(handles.rbIdealChannel, 'Value') == 1
    % ideal channel selected
elseif get(handles.rbCustomChannel, 'Value') == 1
    ConfigureCustomChannel();
elseif get(handles.rbBSChannel, 'Value') == 1
    ConfigureBSC();
end

% --- Executes on button press in rbIdealChannel.
function rbIdealChannel_Callback(hObject, eventdata, handles)
global channel;

set(handles.btnConfigureChannel,'enable','off');
channel = IdealChannel();


% --- Executes on button press in rbCustomChannel.
function rbCustomChannel_Callback(hObject, eventdata, handles)
global channel;

set(handles.btnConfigureChannel,'enable','on');
channel = CustomChannel();


% --- Executes on button press in rbBSChannel.
function rbBSChannel_Callback(hObject, eventdata, handles)
global channel;

set(handles.btnConfigureChannel,'enable','on');
channel = BSChannel();



function fileInput_CreateFcn(hObject, eventdata, handles)
