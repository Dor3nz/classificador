function [mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat] = train

ngrups = 6;

% L'estrucutra dades_tots_grups conté els valors de verd i número de
% línines de les imatges d'entrenament de tots els grups.
global dades_tots_grups;
global valors;
dades_tots_grups = zeros(10,6,2);

fid1 = fopen('train/11.txt');
fid2 = fopen('train/12.txt');
fid3 = fopen('train/21.txt');
fid4 = fopen('train/22.txt');
fid5 = fopen('train/31.txt');
fid6 = fopen('train/32.txt');

valor_da1 = fscanf(fid1,'%s');
valor_da2 = fscanf(fid2,'%s');
valor_da3 = fscanf(fid3,'%s');
valor_da4 = fscanf(fid4,'%s');
valor_da5 = fscanf(fid5,'%s');
valor_da6 = fscanf(fid6,'%s');

s1 = size(valor_da1);
s2 = size(valor_da2);
s3 = size(valor_da3);
s4 = size(valor_da4);
s5 = size(valor_da5);
s6 = size(valor_da6);

function assigna_valors(s, valor_da)
    i = 1;
    for k = 5:5:s
        valors(2,i) = str2num(valor_da(k));
        i = i + 1;
    end
end

assigna_valors(s1, valor_da1);
assigna_valors(s2, valor_da2);
assigna_valors(s3, valor_da3);
assigna_valors(s4, valor_da4);
assigna_valors(s5, valor_da5);
assigna_valors(s6, valor_da6);

function I = lectura_imatge(grup)
    for i = 0:9
        arxiu = strcat(grup, '-', num2str(i));
        im = imread(['train/' arxiu], 'jpg');
        I(:,:,:,(i+1)) = im;
    end
end

I1 = lectura_imatge('11');
I2 = lectura_imatge('12');
I3 = lectura_imatge('21');
I4 = lectura_imatge('22');
I5 = lectura_imatge('31');
I6 = lectura_imatge('32');

function llindars(I, ngrup)
    for i = 1:10
        [green,prob] = verd(I(:,:,:,i));
        dades_tots_grups(i,ngrup,1) = prob;

        [numhor,numver] = detect(I(:,:,:,i));
        dades_tots_grups(i,ngrup,2)= numhor + numver;
    end      
end

llindars(I1, 1);
llindars(I2, 2);
llindars(I3, 3);
llindars(I4, 4);
llindars(I5, 5);
llindars(I6, 6);


% calculs finals

total_verd_natura = zeros(1,6);
total_verd_ciutat = zeros(1,6);

total_linia_natura = zeros(1,6);
total_linia_ciutat = zeros(1,6);
   

for j = 1:6
    cont=0;
    for i = 1:10
        if ( valors(1,i) == 1)
        cont=cont+1;
        end
    end
   
	for i = 1:10
    		if ( valors(j,i) == 1)
        		total_verd_natura(j) =total_verd_natura(j)+ dades_tots_grups(i,j,1)/cont;
			total_linia_natura(j) =total_linia_natura(j)+ dades_tots_grups(i,j,2)/cont;
    		elseif ( valors(j,i) == 0)
        		total_verd_ciutat(j) =total_verd_ciutat(j)+ dades_tots_grups(i,j,1)/(10-cont);
			total_linia_ciutat(j) =total_linia_ciutat(j)+dades_tots_grups(i,j,2)/(10-cont);
    		end
	end 
end       


    mitjana_verd_natura = sum(total_verd_natura(:))/6;
    mitjana_verd_ciutat = sum(total_verd_ciutat(:))/6;

    mitjana_linia_natura = sum(total_linia_natura(:))/6;
    mitjana_linia_ciutat = sum(total_linia_ciutat(:))/6;
end
    
    

  %Les diferents mitjanes serán els llindars perfectes que delimiten les imatges de ciutat o es imatges de natura
  
  %Ara ja sabem el llindar perfecte, mitjançant les imatges
  %d'aprenantatge.. Per tant, utilitzarem aquests llindars per classificar
  %les demes imatges.