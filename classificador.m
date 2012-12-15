%% CLASSIFICADOR DE IMATGES NATURE/CITY
%  Aleix Casanovas, Sergi Alonso, Marc Andrés i Genís Matutes

function classificador(file)

%% GUARDA LES IMATGES
num = 10;
file = fopen([file '.txt']);

for i = 0:(num-1)
    fila = fgetl(file);
    nom_imatge = fila(1:4);
    imatge = imread(nom_imatge,'jpg');
    I(:,:,:,(i+1)) = imatge;
end

%% CÀLCUL DE VERD
% Guarda els nivells de verd de les imatges en un vector.

% El vector nivells_verd conté el nivell de verd de les imatges
% consecutives.
nivells_verd = zeros(1,num);
probabilitat = zeros(1,num);

for i = 1:num
    
    [green,prob] = verd(I(:,:,:,i));
    nivells_verd(i) = green;
    probabilitat(i) = prob;
    
    if(probabilitat(i)>0.35)
    cont(i) = cont(i) + 1;
    disp(strcat(grup,'-',num2str(i-1),': Alt contingut de verd'));
    disp('');
else
    cont(i) = cont(i) - 1;
    disp(strcat(grup,'-',num2str(i-1),': Baix contingut de verd'));
    disp('');
    end
end

%% DETECCIÓ DE CONTORNS
% TRANSFORMADA DE HOUGH

numhoritzontal = zeros(1,10);
numvertical = zeros(1,10);

for i = 1:num
    [numhor,numver] = detect(I(:,:,:,i));
    numhoritzontal(i) = numhor;
    numvertical(i) = numver;
    disp(strcat(grup,'-',num2str(i-1),' Lines horitzontals: ',num2str(numhor)));
    disp(strcat(grup,'-',num2str(i-1),' Lines verticals: ',num2str(numver)));
    
    if((numhor+numver) > 5)
        cont(i) = cont(i) - 2;        
    elseif((numhor+numver) <= 5)
        cont(i) = cont(i) + 2;        
    end    
end


%% EVALUACIÓ DELS RESULTATS
% Extreure en una funció que ha de:
%        - Escriure fitxer de sortida
%        - Retornar el nom del fitxer de sortida perquè 
%            el pugui llegir l'evaluador

fid=fopen(strcat(grup,'out.txt'),'w');

for i = 1:num
    if(cont(i) < 0)
         disp(strcat(grup,'-',num2str(i-1),' 0'));
         fprintf(fid, strcat(grup,'-',num2str(i-1),' 0'));
         fprintf(fid,'\n');
    elseif(cont(i) > 0)
        disp(strcat(grup,'-',num2str(i-1),' 1'));
        fprintf(fid, strcat(grup,'-',num2str(i-1),' 1'));
        fprintf(fid,'\n');
    end
end
