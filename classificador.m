%% CLASSIFICADOR DE IMATGES NATURE/CITY
%  Aleix Casanovas, Sergi Alonso, Marc Andr�s i Gen�s Matutes

%% LLEGIM LES 10 IMATGES
clear
cont = zeros(1,10);
cd('C:\Users\Aleix\Desktop\EET\Q5\Gesti� i Distribuci� de Sistemes Audiovisuals\Classificador_complet') % nos situamos en el directorio de trabajo


grup = input('Quin grup imatges vols classificar? ','s');
global num;
num = input('Quantes imatges vols classificar? ');

for i = 0:(num-1)
    arxiu = strcat(grup,'-',num2str(i));
    
    im = imread(arxiu,'jpg');
    I(:,:,:,(i+1)) = im;

end
s = size(I);

%% C�LCUL DELS VALORS RGB DE LA IMATGE

for i = 1:num

RGB_r(:,:,i) = I(:,:,1,i);
RGB_g(:,:,i) = I(:,:,2,i);       
RGB_b(:,:,i) = I(:,:,3,i);

end




%% C�LCUL DE VERD

ver = zeros(1,num);
probabilitat = zeros(1,num);

for i = 1:num
    
    [green,prob] = verd(I(:,:,:,i));
    ver(i) = green;
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

%% DETECCI� DE CONTORNS
%TRANSFORMADA DE HOUGH

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


%% EVALUACI� DELS RESULTATS

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
