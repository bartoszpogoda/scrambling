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
[fn, fp] = uigetfile('*.txt', 'Select signal file');
originalSignalVar = Signal(fullfile(fp,fn));
set(handles.originalSignal, 'string', originalSignalVar.toString());

% --- Executes on button press in sendButton.
function sendButton_Callback(hObject, eventdata, handles)
global encodedSignalVar; global channel; global receivedSignalVar;
channel.send(encodedSignalVar);
receivedSignalVar = channel.receive();
set(handles.receivedSignal, 'String', receivedSignalVar.toString());


% --- Executes on button press in scrambleButton.
function scrambleButton_Callback(hObject, eventdata, handles)
global originalSignalVar; global scrambledSignalVar; global LFSRFileVar;
if LFSRFileVar == 0
    disp('bezpliku');
    scrambler = Scrambler();
else
    disp('zplikiem');
    scrambler = Scrambler(LFSRFileVar);
end
originalSignalVarCopy = originalSignalVar.copy();
scrambledSignalVar = scrambler.scramble(originalSignalVarCopy);
set(handles.scrambledSignal, 'String', scrambledSignalVar.toString());
scrambler.disp();


% --- Executes on button press in descrambleButton.
function descrambleButton_Callback(hObject, eventdata, handles)
global decodedSignalVar; global descrambledSignalVar; global originalSignalVar; global LFSRFileVar;
if LFSRFileVar == 0
    disp('bezpliku');
    descrambler = Descrambler();
else
    disp('zplikiem');
    descrambler = Descrambler(LFSRFileVar);
end
%descrambler = Descrambler();
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


% --- Executes on button press in loadLFSRButton.
function loadLFSRButton_Callback(hObject, eventdata, handles)
global LFSRFileVar;
[fn, fp] = uigetfile('*.txt', 'Select LFSR file');
LFSRFileVar = importdata(fullfile(fp,fn));
% hObject    handle to loadLFSRButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in clearAllButton.
function clearAllButton_Callback(hObject, eventdata, handles)
set(handles.originalSignal, 'String', '');
set(handles.scrambledSignal, 'String', '');
set(handles.encodedSignal, 'String', '');
set(handles.receivedSignal, 'String', '');
set(handles.decodedSignal, 'String', '');
set(handles.descrambledSignal, 'String', '');
global LFSRFileVar;
LFSRFileVar = 0;
% hObject    handle to clearAllButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
