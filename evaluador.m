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
clear x_record;
clear y_precisio;
clear M;
grp = input('Quin grup vols evaluar?');
grup = num2str(grp);
global num;


fid = fopen(strcat(grup,'out.txt'));
fid2 = fopen(strcat(grup,'.txt'));
valor_res = fscanf(fid,'%s');
valor_da = fscanf(fid2,'%s');

% ---------------------- %
% VALIDACIÓ DE RESULTATS %
% ---------------------- %
%
%Iteració comparativa

positius_certs=0;
positius_falsos=0;
negatius_falsos=0;
encerts = zeros(1,num);
M = 0;
a= 0;
total = 1;
s = size(valor_res);
for k = 5:5:s(2)
    if (valor_res(k) == valor_da(k)==1)
        positius_certs =positius_certs+1;
    elseif((valor_res(k) == valor_da(k)) && (valor_res(k) == 1))
        a = a + 1;
    end
    total = total + 1;
end

percent = (encerts / 10) * 100;
precissio = length(encerts)/total
record = a/5

% ----------------- %
% PRECISIÓ I RECORD %
% ----------------- %
%
%Assignació del nombre d'imatges rellevants

%Reinicialització dels resultats   %PRECISSIO --> ELEMENTS BONS DE LES
%CERQUES TOTALS
% record --> quans certs de tots els certs

%Vectors de Record/Precisió

encert = 0;
total = 0;

M = 0;
AP = 0;
for i=1:num
    if(encerts(i) == 1)
        M = M + 1;
        y_precisio(M) = M/i;
        AP = AP + y_precisio(M);
    else
        if(M == 0)
            P(1) = 0;
        else
            y_precisio(M) = M/i;
        end
    end
end
disp(strcat('AP ',num2str(AP/M)));


y_precisio = [y_precisio 0];
N = length(find(encerts == 1));
x_record = 0:(1/N):1;

figure(1);
plot(x_record,y_precisio); title 'gràfic precissió/record'; xlabel 'record';ylabel 'precissió';




