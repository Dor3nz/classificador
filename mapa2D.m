

numgrups = 0;

dades_tots_grups = zeros(10,6,2);

disp('Llegim els diferents grups');
disp('11');
numgrups = numgrups + 1;
disp('12');
numgrups = numgrups + 1;
disp('21');
numgrups = numgrups + 1;
disp('22');
numgrups = numgrups + 1;
disp('31');
numgrups = numgrups + 1;
disp('32');
numgrups = numgrups + 1;

grup = zeros(1,numgrups);

grup1 = input('primer grup ','s');
grup2 = input('segon grup ','s');
grup3 = input('tercer grup ','s');
grup4 = input('4 grup ','s');
grup5 = input('5 grup ','s');
grup6 = input('6 grup ','s');

fid1 = fopen(strcat(grup1,'.txt'));
fid2 = fopen(strcat(grup2,'.txt'));
fid3 = fopen(strcat(grup3,'.txt'));
fid4 = fopen(strcat(grup4,'.txt'));
fid5 = fopen(strcat(grup5,'.txt'));
fid6 = fopen(strcat(grup6,'.txt'));


valor_da = zeros(1,7);

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



i = 1;
for k = 5:5:s1(2)
    valors(1,i) = str2num(valor_da1(k));
    i=i+1;
end

i = 1;
for k = 5:5:s2(2)
    valors(2,i) = str2num(valor_da2(k));
    i=i+1;
end
    
i = 1;
for k = 5:5:s3(2)
    valors(3,i) = str2num(valor_da3(k));
    i=i+1;
end

i = 1;
for k = 5:5:s4(2)
    valors(4,i) = str2num(valor_da4(k));
    i=i+1;
end
i = 1;
for k = 5:5:s5(2)
    valors(5,i) = str2num(valor_da5(k));
    i=i+1;
end

i = 1;
for k = 5:5:s6(2)
    valors(6,i) = str2num(valor_da6(k));
    i=i+1;
end


for i = 0:9
    arxiu = strcat(grup1,'-',num2str(i));
    im = imread(arxiu,'jpg');
    I1(:,:,:,(i+1)) = im;

end

for i = 0:9
    arxiu = strcat(grup2,'-',num2str(i));
    im = imread(arxiu,'jpg');
    I2(:,:,:,(i+1)) = im;

end

for i = 0:9
    arxiu = strcat(grup3,'-',num2str(i));
    im = imread(arxiu,'jpg');
    I3(:,:,:,(i+1)) = im;

end

for i = 0:9
    arxiu = strcat(grup4,'-',num2str(i));
    im = imread(arxiu,'jpg');
    I4(:,:,:,(i+1)) = im;

end

for i = 0:9
    arxiu = strcat(grup5,'-',num2str(i));
    im = imread(arxiu,'jpg');
    I5(:,:,:,(i+1)) = im;

end

for i = 0:9
    arxiu = strcat(grup6,'-',num2str(i));
    im = imread(arxiu,'jpg');
    I6(:,:,:,(i+1)) = im;

end

for i = 1:10
    
    [green,prob] = verd(I1(:,:,:,i));
    dades_tots_grups(i,1,1) = prob;
    
    [numhor,numver] = detect(I1(:,:,:,i));
    dades_tots_grups(i,1,2)= numhor + numver;
        
end


for i = 1:10
    
    [green,prob] = verd(I2(:,:,:,i));
    dades_tots_grups(i,2,1) = prob;
    
    [numhor,numver] = detect(I2(:,:,:,i));
    dades_tots_grups(i,2,2)= numhor + numver;
        
end


for i = 1:10
    
    [green,prob] = verd(I3(:,:,:,i));
    dades_tots_grups(i,3,1) = prob;
    
    [numhor,numver] = detect(I3(:,:,:,i));
    dades_tots_grups(i,3,2)= numhor + numver;
        
end

for i = 1:10
    
    [green,prob] = verd(I4(:,:,:,i));
    dades_tots_grups(i,4,1) = prob;
    
    [numhor,numver] = detect(I4(:,:,:,i));
    dades_tots_grups(i,4,2)= numhor + numver;
        
end

for i = 1:10
    
    [green,prob] = verd(I5(:,:,:,i));
    dades_tots_grups(i,5,1) = prob;
    
    [numhor,numver] = detect(I5(:,:,:,i));
    dades_tots_grups(i,5,2)= numhor + numver;
        
end

for i = 1:10
    
    [green,prob] = verd(I6(:,:,:,i));
    dades_tots_grups(i,6,1) = prob;
    
    [numhor,numver] = detect(I6(:,:,:,i));
    dades_tots_grups(i,6,2)= numhor + numver;
        
end

total_verd_natura = zeros(1,6);
total_verd_ciutat = zeros(1,6);

for i = 1:10
    if ( valors(1,i) == 1)
        total_verd_natura(1) = sum(dades_tots_grups(i,1,1));
    elseif ( valors(1,i) == 0)
        total_verd_ciutat(1) = sum(dades_tots_grups(i,1,1));
    end
end

for i = 1:10
    if ( valors(2,i) == 1)
        total_verd_natura(2) = sum(dades_tots_grups(i,2,1));
    elseif ( valors(2,i) == 0)
        total_verd_ciutat(2) =  sum(dades_tots_grups(i,2,1));
    end
end

for i = 1:10
    if ( valors(3,i) == 1)
        total_verd_natura(3) = sum(dades_tots_grups(i,3,1));
    elseif ( valors(3,i) == 0)
        total_verd_ciutat(3) = sum(dades_tots_grups(i,3,1));
    end
end

for i = 1:10
    if ( valors(4,i) == 1)
        total_verd_natura(4) = sum(dades_tots_grups(i,4,1));
    elseif( valors(4,i) == 0)
        total_verd_ciutat(4) = sum(dades_tots_grups(i,4,1));
    end
end

for i = 1:10
    if ( valors(5,i) == 1)
        total_verd_natura(5) = sum(dades_tots_grups(i,5,1));
    elseif ( valors(5,i) == 0)
        total_verd_ciutat(5) = sum(dades_tots_grups(i,5,1));
    end
end

for i = 1:10
    if ( valors(6,i) == 1)
        total_verd_natura(6) = sum(dades_tots_grups(i,6,1));
    elseif ( valors(6,i) == 0)
        total_verd_ciutat(6) = sum(dades_tots_grups(i,6,1));
    end
end


    mitjana_verd_natura = sum(total_verd_natura(:))/10;
    mitjana_verd_ciutat = sum(total_verd_ciutat(:))/10;
        
        
        
        
        
        
        
        