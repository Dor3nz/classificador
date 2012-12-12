function y = evaluador(fitxer_resultats, fitxer_dades)

% Evaluador
% GDSA
% Aleix Casanovas, Sergi Alonso, Marc Andrés i Genís Matutes

% FUNCIONAMENT I REQUERIMENTS:
%
%   - Tenir ambdós documents (resultats i dades) al mateix directori que el
%   evaluador.m
%
%   - Crida, suposant que els mencionats fitxers són resultats.txt i dades.txt: 
%
%        $ evaluador('resultats.txt', 'dades.txt')
%

%Lectura dels fitxers d'entrada
resultats = fopen(fitxer_resultats);
dades = fopen(fitxer_dades);

% ---------------------- %
% VALIDACIÓ DE RESULTATS %
% ---------------------- %
%
%Iteració comparativa
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
% PRECISIÓ I RECORD %
% ----------------- %
%
%Assignació del nombre d'imatges rellevants
M = 5;

%Reinicialització dels resultats
resultats = fopen(fitxer_resultats);

%Vectors de Record/Precisió
x_record = zeros(1,10);
y_precisio = zeros(1,10);

%Iteració
Nk = 0;
for k = 1:10
    resultat = fgetl(resultats);
    if (str2num(resultat(length(resultat))) == 1)
        Nk = Nk + 1;
    end
    x_record(k) = Nk / M;
    y_precisio(k) = Nk / k;
end

%Dibuix del gràfic
figure;

plot(x_record, y_precisio);
title('Corba de Precisió-Record')
xlabel('Record')
ylabel('Precisió')
end

