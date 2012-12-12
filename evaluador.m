function y = evaluador(fitxer_resultats, fitxer_dades)

% Evaluador
% GDSA
% Aleix Casanovas, Sergi Alonso, Marc Andr�s i Gen�s Matutes

% FUNCIONAMENT I REQUERIMENTS:
%
%   - Tenir ambd�s documents (resultats i dades) al mateix directori que el
%   evaluador.m
%
%   - Crida, suposant que els mencionats fitxers s�n resultats.txt i dades.txt: 
%
%        $ evaluador('resultats.txt', 'dades.txt')
%

%Lectura dels fitxers d'entrada
resultats = fopen(fitxer_resultats);
dades = fopen(fitxer_dades);

% ---------------------- %
% VALIDACI� DE RESULTATS %
% ---------------------- %
%
%Iteraci� comparativa
encerts = 0;
for k = 1:10
    obtingut = fgetl(resultats);
    real = fgetl(dades);
    if (str2num(obtingut(length(obtingut) )) == str2num(real(length(real))))
        encerts = encerts + 1;
    end
end

percent = (encerts / 10) * 100;

% ----------------- %
% PRECISI� I RECORD %
% ----------------- %
%
%Assignaci� del nombre d'imatges rellevants
M = 5;

%Reinicialitzaci� dels resultats
resultats = fopen(fitxer_resultats);

%Vectors de Record/Precisi�
x_record = zeros(1,10);
y_precisio = zeros(1,10);

%Iteraci�
Nk = 0;
for k = 1:10
    resultat = fgetl(resultats);
    if (str2num(resultat(length(resultat))) == 1)
        Nk = Nk + 1;
    end
    x_record(k) = Nk / M;
    y_precisio(k) = Nk / k;
end

%Dibuix del gr�fic
figure;

plot(x_record, y_precisio);
title('Corba de Precisi�-Record')
xlabel('Record')
ylabel('Precisi�')
end

