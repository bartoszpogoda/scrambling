function varargout = FirstGUI(varargin)
addpath(genpath('view'));
addpath(genpath('model'));
%originalSignalVar; scrambledSignalVar; encodedSignalVar;
%receivedSignalVar; descrambledSignalVar; decodedSignalVar;
% FIRSTGUI MATLAB code for FirstGUI.fig
%      FIRSTGUI, by itself, creates a new FIRSTGUI or raises the existing
%      singleton*.
%
%      H = FIRSTGUI returns the handle to a new FIRSTGUI or the handle to
%      the existing singleton*.
%
%      FIRSTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRSTGUI.M with the given input arguments.
%
%      FIRSTGUI('Property','Value',...) creates a new FIRSTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FirstGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FirstGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FirstGUI

% Last Modified by GUIDE v2.5 28-Apr-2017 00:05:53

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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FirstGUI (see VARARGIN)

% Choose default command line output for FirstGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
    
% UIWAIT makes FirstGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FirstGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in signalButton.
function signalButton_Callback(hObject, eventdata, handles)
global file; global originalSignalVar;
fileName = get(handles.fileInput, 'String');
if isempty(fileName)
    fprintf('Brak pliku');
else
    originalSignalVar = Signal('files/signal64.txt');
    set(handles.originalSignal, 'String', originalSignalVar.toString());
end
% hObject    handle to signalButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function fileInput_Callback(hObject, eventdata, handles)
% hObject    handle to fileInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileInput as text
%        str2double(get(hObject,'String')) returns contents of fileInput as a double


% --- Executes during object creation, after setting all properties.
function fileInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over signalButton.
function signalButton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to signalButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sendButton.
function sendButton_Callback(hObject, eventdata, handles)
global encodedSignalVar; global channel; global receivedSignalVar;
channel = IdealChannel();
channel.send(encodedSignalVar);
receivedSignalVar = channel.receive();
set(handles.receivedSignal, 'String', receivedSignalVar.toString());
% hObject    handle to sendButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in scrambleButton.
function scrambleButton_Callback(hObject, eventdata, handles)
global originalSignalVar; global scrambledSignalVar;
scrambler = Scrambler();
originalSignalVarCopy = originalSignalVar.copy();
scrambledSignalVar = scrambler.scramble(originalSignalVarCopy);
set(handles.scrambledSignal, 'String', scrambledSignalVar.toString());
% hObject    handle to scrambleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in descrambleButton.
function descrambleButton_Callback(hObject, eventdata, handles)
global decodedSignalVar; global descrambledSignalVar; global originalSignalVar;
descrambler = Descrambler();
descrambledSignalVar = descrambler.descramble(decodedSignalVar);
set(handles.descrambledSignal, 'String', descrambledSignalVar.toString());
set(handles.berValue, 'String', Helper.calculateBER(originalSignalVar,descrambledSignalVar));
% hObject    handle to descrambleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in encodeButton.
function encodeButton_Callback(hObject, eventdata, handles)
global encodedSignalVar; global scrambledSignalVar;
encoder = EthernetCoder();
scrambledSignalVarCopy = scrambledSignalVar;
encodedSignalVar = encoder.encode(scrambledSignalVarCopy);
set(handles.encodedSignal, 'String', encodedSignalVar.toString());
% hObject    handle to encodeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in decodeButton.
function decodeButton_Callback(hObject, eventdata, handles)
global decodedSignalVar; global receivedSignalVar;
decoder = EthernetDecoder();
decodedSignalVar = decoder.decode(receivedSignalVar);
set(handles.decodedSignal, 'String', decodedSignalVar.toString());
% hObject    handle to decodeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
global BSCpercentage;
BSCpercentage = get(hObject, 'Value');
set(handles.sliderValue, 'String', BSCpercentage);
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
global BSCpercentage;
% if set(handles.sliderValue, 'String', BSCpercentage);
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function sliderValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', '0');


% --- Executes during object creation, after setting all properties.
function berValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to berValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
