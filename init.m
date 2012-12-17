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

% Choose default command line output for init
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Llegeix fitxers .txt del directori de train
FitxersEntrenament = dir([pwd '/train/*.txt']);
LlistaEntrenament = FitxersEntrenament(1).name;

% Omple el vector vertical amb els noms dels fitxers
for i = 2:length(FitxersEntrenament)
    LlistaEntrenament = vertcat(LlistaEntrenament, FitxersEntrenament(i).name);
end
LlistaEntrenament = mat2cell(LlistaEntrenament);

% Llegeix fitxers .txt del directori de train
FitxersProva = dir([pwd '/test/*.txt']);
LlistaProva = FitxersProva(1).name;

% Omple el vector vertical amb els noms dels fitxers
for i = 2:length(FitxersProva)
    LlistaProva = vertcat(LlistaProva, FitxersProva(i).name);
end
LlistaProva = mat2cell(LlistaProva);
% Omple el desplegable dels Fitxers de Prova amb els seus noms
set(handles.popup_prova,'string',LlistaProva);


% --- Outputs from this function are returned to the command line.
function varargout = init_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on selection change in popup_prova.
function popup_prova_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popup_prova_CreateFcn(hObject, eventdata, handles)

handles.popup_prova = hObject;
guidata(hObject, handles);

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_entrena.
function push_entrena_Callback(hObject, eventdata, handles)

% Crida a la funció train i li passa el nom del fitxer a obrir
[mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat] = train;

% Càlcul de llindars idonis.
K_verd = (mitjana_verd_natura + mitjana_verd_ciutat)/2;
K_linies = (mitjana_linia_natura + mitjana_linia_ciutat)/2;

% Display dels llindars a la interfície.
set(handles.verd_percent, 'String', [num2str(K_verd*100) ' %']);
set(handles.n_linies, 'String', num2str(K_linies));

% Habilita el botó de classificació
set(handles.push_classifica,'Enable','on');





% --- Executes on button press in push_classifica.
function push_classifica_Callback(hObject, eventdata, handles)

%Llegeix el contingut del desplegable d'entrenament 
file = getCurrentPopupString(handles.popup_prova);

%Guarda l'arxiu seleccionat en una variable
o_file = fopen(['train/' file]);


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
