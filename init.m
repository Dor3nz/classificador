function varargout = init(varargin)


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @init_OpeningFcn, ...
                   'gui_OutputFcn',  @init_OutputFcn, ...
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


% --- Executes just before init is made visible.
function init_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to init (see VARARGIN)

% Choose default command line output for init
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes init wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Omple el desplegable dels Fitxers de Prova
FitxersProva = dir([pwd '/test/*.txt']);
LlistaProva = FitxersProva(1).name;

for i = 2:length(FitxersProva)
    LlistaProva = vertcat(LlistaProva, FitxersProva(i).name);
end
set(handles.popup_prova,'string',LlistaProva);


% --- Outputs from this function are returned to the command line.
function varargout = init_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popup_entrenament.
function popup_entrenament_Callback(hObject, eventdata, handles)
% hObject    handle to popup_entrenament (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_entrenament contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_entrenament


% --- Executes during object creation, after setting all properties.
function popup_entrenament_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_entrenament (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_prova.
function popup_prova_Callback(hObject, eventdata, handles)
% hObject    handle to popup_prova (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_prova contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_prova


% --- Executes during object creation, after setting all properties.
function popup_prova_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_prova (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.popup_test=hObject;  %pass handles the popup menu object
guidata(hObject, handles);


% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_entrena.
function push_entrena_Callback(hObject, eventdata, handles)
% hObject    handle to push_entrena (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in push_classifica.
function push_classifica_Callback(hObject, eventdata, handles)
% hObject    handle to push_classifica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
