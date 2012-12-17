%% CLASSIFICADOR DE IMATGES NATURE/CITY
%  Aleix Casanovas, Sergi Alonso, Marc Andr�s i Gen�s Matutes

function classificador(file, llindar_verd, llindar_linies)

%% GUARDA LES IMATGES

% El vector cont es fa servir per determinar si la imatge �s natura o
% o ciutat en funci� de si el valor de cada �ndex, aquest referint-se a la
% imatge, �s positiu o negatiu respectivament.
cont = zeros(1,10);

% Nombre d'imatges a classificar.
global num;


% Obre el fitxer enviat desde la interf�cie.
%fitxer = fopen([file '.txt'])

% Lectura de les imatges i posterior emmagatzematge d'aquestes a I.
for i = 0:(num-1)
    nom_imatge = strcat(file,'-',num2str(i));
    imatge = imread(nom_imatge,'jpg');
    I(:,:,:,(i+1)) = imatge;
end

%% C�LCUL DE VERD
% Guarda els nivells de verd de les imatges en un vector.

% El vector nivells_verd cont� el nivell de verd de les imatges
% consecutives.
nivells_verd = zeros(1,num);
probabilitat = zeros(1,num);

for i = 1:num
    
    % C�lcul del nivell de verd de la imatge.
    [green,prob] = verd(I(:,:,:,i));
    nivells_verd(i) = green;
    probabilitat(i) = prob;
    
    % Si es supera el llindar de verd sumem 1(rural), en cas contrari restem 1(ciutat).
    if(probabilitat(i) > llindar_verd)
        cont(i) = cont(i) + 1;
    else
        cont(i) = cont(i) - 1;
    end
end

%% DETECCI� DE CONTORNS
% TRANSFORMADA DE HOUGH

% Vectors on es guarda el nombre de l�nies horitzontal i vertical de 
% cada imatge.
numhoritzontal = zeros(1,10);
numvertical = zeros(1,10);

for i = 1:num
    % C�lcul de les l�nies horitzontals i verticals de la imatge.
    [numhor,numver] = detect(I(:,:,:,i));
    numhoritzontal(i) = numhor;
    numvertical(i) = numver;

    % Si es supera el llindar de l�nies restem 2(ciutat), en cas contrari 
    % sumem 2(rural).
    if((numhor+numver) > llindar_linies)
        cont(i) = cont(i) - 2;        
    elseif((numhor+numver) <= llindar_linies)
        cont(i) = cont(i) + 2;        
    end    
end


%% EVALUACI� DELS RESULTATS
% Treu el fitxer de sortida

fid = fopen(strcat(file,'out.txt'),'w');

for i = 1:num
    if(cont(i) < 0)
         fprintf(fid, strcat(file,'-',num2str(i-1),' 0'));
         fprintf(fid,'\n');
    elseif(cont(i) > 0)
        fprintf(fid, strcat(file,'-',num2str(i-1),' 1'));
        fprintf(fid,'\n');
    end
end
