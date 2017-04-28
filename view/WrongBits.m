function varargout = WrongBits(varargin)
% WRONGBITS MATLAB code for WrongBits.fig
%      WRONGBITS, by itself, creates a new WRONGBITS or raises the existing
%      singleton*.
%
%      H = WRONGBITS returns the handle to a new WRONGBITS or the handle to
%      the existing singleton*.
%
%      WRONGBITS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WRONGBITS.M with the given input arguments.
%
%      WRONGBITS('Property','Value',...) creates a new WRONGBITS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WrongBits_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WrongBits_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WrongBits

% Last Modified by GUIDE v2.5 29-Apr-2017 00:00:31

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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WrongBits (see VARARGIN)

% Choose default command line output for WrongBits
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WrongBits wait for user response (see UIRESUME)
% uiwait(handles.wrongBitsFigure);


% --- Outputs from this function are returned to the command line.
function varargout = WrongBits_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function periodicNumberOfBits_Callback(hObject, eventdata, handles)
% hObject    handle to periodicNumberOfBits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of periodicNumberOfBits as text
%        str2double(get(hObject,'String')) returns contents of periodicNumberOfBits as a double


% --- Executes during object creation, after setting all properties.
function periodicNumberOfBits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to periodicNumberOfBits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function periodicInterval_Callback(hObject, eventdata, handles)
% hObject    handle to periodicInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of periodicInterval as text
%        str2double(get(hObject,'String')) returns contents of periodicInterval as a double


% --- Executes during object creation, after setting all properties.
function periodicInterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to periodicInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in periodicOKButton.
function periodicOKButton_Callback(hObject, eventdata, handles)
% hObject    handle to periodicOKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function singleNumberOfBits_Callback(hObject, eventdata, handles)
% hObject    handle to singleNumberOfBits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of singleNumberOfBits as text
%        str2double(get(hObject,'String')) returns contents of singleNumberOfBits as a double


% --- Executes during object creation, after setting all properties.
function singleNumberOfBits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to singleNumberOfBits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function singleIndexes_Callback(hObject, eventdata, handles)
% hObject    handle to singleIndexes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of singleIndexes as text
%        str2double(get(hObject,'String')) returns contents of singleIndexes as a double


% --- Executes during object creation, after setting all properties.
function singleIndexes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to singleIndexes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in singleOKButton.
function singleOKButton_Callback(hObject, eventdata, handles)
global singleNumberOfBitsVar; global singleIndexesVar; global encodedSignalVar;
singleNumberOfBitsVar = str2num(get(handles.singleNumberOfBits, 'String'));
textBoxString = get(handles.singleIndexes, 'String');
singleIndexesVar = sscanf(textBoxString, '%d ', singleNumberOfBitsVar);
disp(singleIndexesVar);
customChannel = CustomChannel();
customChannel.send(encodedSignalVar);
customChannel.changeSingleBits(singleIndexesVar);
close(handles.wrongBitsFigure);
% hObject    handle to singleOKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function periodicStart_Callback(hObject, eventdata, handles)
% hObject    handle to periodicStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of periodicStart as text
%        str2double(get(hObject,'String')) returns contents of periodicStart as a double


% --- Executes during object creation, after setting all properties.
function periodicStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to periodicStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function singleInfo_CreateFcn(hObject, eventdata, handles)
global encodedSignalVar;
set(hObject, 'String', strcat('Signal length : ', num2str(encodedSignalVar.getSize()), '(for making last bits wrong)'));
% hObject    handle to singleInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
