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
FitxersProva = dir([pwd '/test/*.txt']);
LlistaProva = FitxersProva(1).name;

% Omple el vector vertical amb els noms dels fitxers
for i = 2:length(FitxersProva)
    LlistaProva = vertcat(LlistaProva, FitxersProva(i).name);
end
LlistaProva = mat2cell(LlistaProva);
% Omple el desplegable dels Fitxers de Prova amb els seus noms
set(handles.popup_prova,'string',LlistaProva);

% Emplena el desplegable de N imatges a llegir en funci� del nombre de
% l�nies que hi ha a l'arxiu seleccionat.
fid = fopen(['test/' getCurrentPopupString(handles.popup_prova)]);

nLinies = 0;
while (fgets(fid) ~= -1),
  nLinies = nLinies+1;
end
fclose(fid);

% Creaci� i assignaci� del String del desplegable.
n_imatges = 1;
for i = 2:nLinies
    n_imatges = vertcat(n_imatges, i);
end
n_imatges = mat2cell(n_imatges);
set(handles.n_imatges_popup, 'String', n_imatges);


% --- Outputs from this function are returned to the command line.
function varargout = init_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on selection change in popup_prova.
function popup_prova_Callback(hObject, eventdata, handles)

% Llegeix i compta les l�nies del fitxer seleccionat.
fid = fopen(['test/' getCurrentPopupString(handles.popup_prova)]);

nLinies = 0;
while (fgets(fid) ~= -1),
  nLinies = nLinies+1;
end
fclose(fid);

% Creaci� i assignaci� del String del desplegable.
n_imatges = 1;
for i = 2:nLinies
    n_imatges = vertcat(n_imatges, i);
end
n_imatges = mat2cell(n_imatges);
set(handles.n_imatges_popup, 'String', n_imatges);

% --- Executes during object creation, after setting all properties.
function popup_prova_CreateFcn(hObject, eventdata, handles)

handles.popup_prova = hObject;
guidata(hObject, handles);

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_entrena.
function push_entrena_Callback(hObject, eventdata, handles)
%Variables globals.
global mitjana_verd_natura;
global mitjana_verd_ciutat;
global mitjana_linia_natura;
global mitjana_linia_ciutat;

% Canvia status a entrenant.
set(handles.text_estat, 'String', 'Entrenant...');
drawnow

% Crida a la funci� train i li passa el nom del fitxer a obrir
[mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat] = train;

% C�lcul de llindars idonis.
K_verd = (mitjana_verd_natura + mitjana_verd_ciutat)/2;
K_linies = (mitjana_linia_natura + mitjana_linia_ciutat)/2;

% Display dels llindars a la interf�cie.
set(handles.verd_percent, 'String', [num2str(K_verd*100) ' %']);
set(handles.n_linies, 'String', num2str(K_linies));

% Habilita el bot� de classificaci�
set(handles.push_classifica,'Enable','on');

% Canvia status a disponible.
set(handles.text_estat, 'String', 'Disponible');
drawnow



% --- Executes on button press in push_classifica.
function push_classifica_Callback(hObject, eventdata, handles)
%Variables globals.
global mitjana_verd_natura;
global mitjana_verd_ciutat;
global mitjana_linia_natura;
global mitjana_linia_ciutat;
global grup;
global num;

% Canvia status a classificant.
set(handles.text_estat, 'String', 'Classificant...');
drawnow

% Llegeix el contingut del desplegable d'entrenament 
file = getCurrentPopupString(handles.popup_prova);

% Lectura del record i la precisi�.
grup = file(1:2);
num = str2num(getCurrentPopupString(handles.n_imatges_popup));
[x_record,y_precisio] = classificacio_llindars(grup, num, mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat);

% Escriu el record i la precisi� a la interf�cie.
set(handles.precisio, 'String', y_precisio);
set(handles.record, 'String', x_record);

% Dibuixa la gr�fica de precisi� i record.
x_record = [0 x_record];
y_precisio = [1 y_precisio];

size_record = size(x_record);
size_precisio = size(y_precisio);

x_record_plot = zeros(1,size_record(2));
y_precisio_plot = zeros(1,size_precisio(2));

for q = 1:size_record(2)
    [x_record_plot(q),posicio] = min(x_record);
    x_record(posicio) = 2;
    y_precisio_plot(q) = y_precisio(posicio);    
end

size_r_plot = size(x_record_plot);

x_record_plot = [x_record_plot x_record_plot(size_r_plot(2))];
y_precisio_plot = [y_precisio 0];

plot(handles.axes_prec_rec, x_record_plot,y_precisio_plot,'-rs',...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','k',...
                'MarkerSize',3);
title 'Classificaci�'; 
xlabel 'record';ylabel 'precissi�';

% Dibuixa la matriu de confusi�.
[positius_certs, negatius_falsos, positius_falsos, negatius_certs] = matrius(grup, num);

complexData = { ...
    'Positius predicci�' positius_certs negatius_falsos; ...
    'Negatius predicci�' positius_falsos negatius_certs;};
set(handles.conf_matrix, 'Data', complexData, 'ColumnName', {'','Positius reals','Negatius reals'});

% Mostra el nombre d'imatges ben/mal classificades.
global imatges;
imatges = comprova_imatges(num, grup);
imatges_correctes = sum(imatges);

percentatge = [num2str(imatges_correctes) '/' num2str(num)];
set(handles.percent_imatges, 'String', percentatge);

% Posa el color vermell, verd o groc si el total de imatges ben
% classificades supera el 50%, no supera el 50% o �s exactament 50%
% respectivament.
if imatges_correctes/num < 0.5
    set(handles.percent_imatges, 'ForegroundColor', 'r');
elseif imatges_correctes/num == 0.5
    set(handles.percent_imatges, 'ForegroundColor', 'y');
else
    set(handles.percent_imatges, 'ForegroundColor', 'g');
end

% Posa disponible la visualitzaci� dels resultats erronis.
set(handles.mal_classificades_button, 'Enable', 'on');

% Disponible la utilitat de llindars manuals.
set(handles.manual_verd, 'Enable', 'on');
set(handles.manual_linies, 'Enable', 'on');
set(handles.push_classifica_manual, 'Enable', 'on');

% Canvia status a disponible.
set(handles.text_estat, 'String', 'Disponible');
drawnow

% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in n_imatges_popup.
function n_imatges_popup_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function n_imatges_popup_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mal_classificades_button.
function mal_classificades_button_Callback(hObject, eventdata, handles)
global grup;
global num;
global imatges;

% Obrim el fitxer del grup.
file = fopen(['test/' grup '.txt']);
incorrectes = num - sum(imatges);

% Mostra les imatges mal classificades en una figura.
figure;
j = 1;
for i = 1:num
    linia = fgetl(file);
    if imatges(i) == 0
        img = imread(['test/' linia(1:4) '.jpg']);
        subplot(1,incorrectes,j), subimage(img);
        j = j + 1;
    end
end


% --- Executes on selection change in popup_iteracions.
function popup_iteracions_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function popup_iteracions_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_valida.
function push_valida_Callback(hObject, eventdata, handles)
global iteracions;
% Canvia status a validant.
set(handles.text_estat, 'String', 'Validant...');
drawnow

% Inicialitzaci� de la validaci�.
iteracions = str2num(getCurrentPopupString(handles.popup_iteracions));

% Execuci� de la validaci� creuada.
[x_record_val,y_precisio_val]= validacio_creuada(iteracions);

% Dibuix del gr�fic.
plot(handles.axes_prec_rec, x_record_val,y_precisio_val,'-rs',...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','k',...
                'MarkerSize',3); 
title 'Validaci� Creuada'; 
xlabel 'record';ylabel 'precissi�';

% Canvia status a disponible.
set(handles.text_estat, 'String', 'Validant...');
drawnow

% --- Executes on button press in itera_endarrere.
function itera_endarrere_Callback(hObject, eventdata, handles)


% --- Executes on button press in itera_endavant.
function itera_endavant_Callback(hObject, eventdata, handles)



% --- Executes on button press in push_classifica_manual.
function push_classifica_manual_Callback(hObject, eventdata, handles)
global grup;
global num;

% Canvia status a classificant.
set(handles.text_estat, 'String', 'Classificant...');
drawnow

% Lectura dels llindars entrats per l'usuari.
llindar_verd = str2num(get(handles.manual_verd, 'String'));
llindar_linies = str2num(get(handles.manual_linies, 'String'));

% C�lcul de precisi� i record.
[x_record, y_precisio] = classificacio_llindars_manuals(grup, num, llindar_verd, llindar_linies);

% Dibuix de la gr�fica.
cla(handles.axes_prec_rec);
x_record = [0 x_record];
y_precisio = [1 y_precisio];

size_record = size(x_record);
size_precisio = size(y_precisio);

x_record_plot = zeros(1,size_record(2));
y_precisio_plot = zeros(1,size_precisio(2));

for q = 1:size_record(2)
    [x_record_plot(q),posicio] = min(x_record);
    x_record(posicio) = 2;
    y_precisio_plot(q) = y_precisio(posicio);    
end

size_r_plot = size(x_record_plot);

x_record_plot = [x_record_plot x_record_plot(size_r_plot(2))];
y_precisio_plot = [y_precisio 0];

plot(handles.axes_prec_rec, x_record_plot,y_precisio_plot,'-rs',...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','k',...
                'MarkerSize',3); 
title 'Classificaci� Manual'; 
xlabel 'record';ylabel 'precissi�';

% C�lcul matrius.
[positius_certs, negatius_falsos, positius_falsos, negatius_certs] = matrius(grup, num);

complexData = { ...
    'Positius predicci�' positius_certs negatius_falsos; ...
    'Negatius predicci�' positius_falsos negatius_certs;};
set(handles.conf_matrix, 'Data', complexData, 'ColumnName', {'','Positius reals','Negatius reals'});

% Mostra el nombre d'imatges ben/mal classificades.
global imatges;
imatges = comprova_imatges(num, grup);
imatges_correctes = sum(imatges);

percentatge = [num2str(imatges_correctes) '/' num2str(num)];
set(handles.percent_imatges, 'String', percentatge);

% Posa el color vermell, verd o groc si el total de imatges ben
% classificades supera el 50%, no supera el 50% o �s exactament 50%
% respectivament.
if imatges_correctes/num < 0.5
    set(handles.percent_imatges, 'ForegroundColor', 'r');
elseif imatges_correctes/num == 0.5
    set(handles.percent_imatges, 'ForegroundColor', 'y');
else
    set(handles.percent_imatges, 'ForegroundColor', 'g');
end

% Canvia status a disponible.
set(handles.text_estat, 'String', 'Disponible');
drawnow

function manual_verd_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function manual_verd_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function manual_linies_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function manual_linies_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
