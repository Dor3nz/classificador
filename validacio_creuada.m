function [x_record_plot, y_precisio_plot] = validacio_creuada(iteracions)

imatges_train = 50; % inicialitzem els percentatges a 50%
imatges_prova = 50;

%%

cont = 1;

% Guardem tots els grups disponibles dins del directori en un vector.
llista_grups = {};
fitxers_grups = dir('validacio_creuada/*.txt');
for i = 1:length(fitxers_grups)
    llista_grups{i} = fitxers_grups(i).name;
end

% Emplena el vector I.
for i = 1:length(llista_grups)
    
    % Obertura de fitxer.
    fitxer = llista_grups(i);
    fid = fopen(['validacio_creuada/' char(fitxer)]);
    valor_da = fscanf(fid,'%s');
    fid = fopen(['validacio_creuada/' char(fitxer)]);
    
    % Lectura i emmagatzematge de les imatges.
    for i = 0:9
        linia = fgetl(fid);
        nom_imatge = [linia(1:2) '-' num2str(i)];
        imatge = imread(['validacio_creuada/' nom_imatge],'jpg');
        I(:,:,:,(i+1)) = imatge;
    end
    
    I_tot(:,:,:,:,cont) = I;

    s1 = size(valor_da);
    i=1;
    for k = 9:9:s1(2)
        valors(cont,i) = str2num(valor_da(k));
        i=i+1;
    end
    
    cont = cont + 1;
end

%% ITERACIO

cont_iteracio = 1;

% iteracions = input('Escrigui les iteracions que vol fer: '); % Preguntem les iteracions que vol fer

for i = 1:iteracions
%% CALCUL DE VECTORS DE IMATGES I VALORS
    
s_valors = size(valors);

I_tot_s = size(I_tot);

valors_vec = valors(1,:);

for i = 2:s_valors(1) % Ens posem els diferents valors de les diferents imatges dels diferents grups en un mateix vector
valors_vec = [valors_vec valors(i,:)]; 
end

I_vec = reshape(I_tot,I_tot_s(1),I_tot_s(2),I_tot_s(3),I_tot_s(4)*I_tot_s(5)); % Ens posem totes les imatges dels diferents grups seguides
s_I_vec = size(I_vec);


aleatori = randperm(s_I_vec(4)); % creem un vector aleatori del mateix size que la imatge

valors_vec_aleat = valors_vec; % Ens guardem les dades
I_vec_aleat = I_vec;

for i = 1:s_I_vec(4)
    
    valors_vec(i) = valors_vec_aleat(aleatori(i)); % Canviem la posicio de una imatge i un vector en els diferents vectors
    I_vec(:,:,:,i) = I_vec_aleat(:,:,:,aleatori(i));
    I_vec2(:,:,:,i) = I_vec(:,:,:,i);
    
end


cont_vec_posicio_entrenament = 1;

% Dividim el percentatge que seran les imatges d'entrenament i les que
% seran de prova

for i = 1:s_I_vec(4)*(imatges_train/100)
   
I_vec2_entrenament(:,:,:,i) = I_vec2(:,:,:,i);

cont_vec_posicio_entrenament = cont_vec_posicio_entrenament + 1;

end

cont_vec_posicio_prova = 1;

for j = cont_vec_posicio_entrenament:s_I_vec(4)
    
I_vec2_prova(:,:,:,cont_vec_posicio_prova) = I_vec2(:,:,:,j);

cont_vec_posicio_prova = cont_vec_posicio_prova + 1;

end

valors_vec_prova = valors_vec(cont_vec_posicio_entrenament:s_I_vec(4));



%%ENTRENAMENT AMB IMATGES JA LLEGIDES

% Calculem el verd i les linies de les imatges d'entrenament

s_vec2_entrenament = size(I_vec2_entrenament);
s_vec2_prova = size(I_vec2_prova);


for i = 1:s_vec2_entrenament(4)
    
    [green,prob] = verd(I_vec2_entrenament(:,:,:,i));
    
    if(valors_vec(i) == 1)
        prob_vec_natura(i) = prob;
    elseif(valors_vec(i) == 0)
        prob_vec_ciutat(i) = prob;
    end
    
    [numhor,numver] = detect(I_vec2_entrenament(:,:,:,i));
    
    if(valors_vec(i) == 1)
        linies_vec_natura(i) = numhor+numver;
    elseif(valors_vec(i) == 0)
        linies_vec_ciutat(i) = numhor+numver;
    end
end

%Calcul dels llindars idonis calculats pel classificador
    
    s_vec_natura_verd = size(prob_vec_natura);
    s_vec_ciutat_verd = size(prob_vec_ciutat);
    s_vec_natura_linies = size(linies_vec_natura);
    s_vec_ciutat_linies = size(linies_vec_ciutat);


    mitjana_verd_natura = sum(prob_vec_natura(:))/ s_vec_natura_verd(2);
    mitjana_verd_ciutat = sum(prob_vec_ciutat(:))/ s_vec_ciutat_verd(2);

    mitjana_linia_natura = sum(linies_vec_natura(:))/s_vec_natura_linies(2);
    mitjana_linia_ciutat = sum(linies_vec_ciutat(:))/s_vec_ciutat_linies(2);
    
    llindar_verd = (mitjana_verd_natura + mitjana_verd_ciutat)/2;
    llindar_linies = (mitjana_linia_natura + mitjana_linia_ciutat)/2;
    
    %% CLASSIFICACIO IMATGES DE PROVA
    
    %Calculem si son ciutat o natura segons els llindars calculats
    %anteriorment
    
    cont_prova = zeros(1,s_vec2_prova(4));
    
for i = 1:s_vec2_prova(4)
    
    [green_prova,prob_prova(i)] = verd(I_vec2_prova(:,:,:,i));

    
    if(prob_prova(i) > llindar_verd)
        cont_prova(i) = cont_prova(i) + 1;
    else
        cont_prova(i) = cont_prova(i) - 1;
    end
  
    [numhor_prova,numver_prova] = detect(I_vec2_prova(:,:,:,i));
    
    
    if((numhor_prova+numver_prova) > llindar_linies)
        cont_prova(i) = cont_prova(i) - 2;
    elseif((numhor_prova+numver_prova) <= llindar_linies)
        cont_prova(i) = cont_prova(i) + 2;    
    end 
end

% Ens creem un arxiu dadesout.txt

s_llista_grups = size(llista_grups);
file = 'dades';
fid = fopen(strcat(file,'out.txt'),'w');


for h = 1:s_vec2_prova(4)
    if(cont_prova(h) < 0)
        fprintf(fid,strcat('0'));
        fprintf(fid,'\n');
    elseif(cont_prova(h) > 0)
        fprintf(fid, strcat('1'));
        fprintf(fid,'\n');
    end
end

%% PRECISIO I RECORD

% Calculem la precisio i record de cada iteracio

fid_final = fopen(strcat(file,'out','.txt'));
out = fscanf(fid_final,'%s');

s_in = size(valors_vec_prova);
s_out = size(out);


for k = 1:s_out(2)    
    valors_out(k) = str2num(out(k));
end

for u = 1:s_in(2)
    valors_in(u) = valors_vec_prova(u);
end

positius_certs = 0;
negatius_falsos = 0;
positius_falsos = 0;
negatius_certs = 0;


for q = 1:s_out(2)
    if((valors_in(q) == 1) && (valors_out(q) == 1))
        positius_certs = positius_certs + 1;
    
    elseif((valors_in(q) == 0) && (valors_out(q) == 1))
        positius_falsos = positius_falsos + 1;
        
    elseif((valors_in(q) == 1) && (valors_out(q) == 0))
        negatius_falsos = negatius_falsos + 1;
        
    elseif((valors_in(q) == 0) && (valors_out(q) == 0))
        negatius_certs = negatius_certs + 1;
    end
end


x_record_num = positius_certs / ( positius_certs + negatius_falsos );
y_precisio_num = positius_certs / ( positius_certs + positius_falsos );

x_record(cont_iteracio) = x_record_num;
y_precisio(cont_iteracio) = y_precisio_num;
    
    cont_iteracio = cont_iteracio + 1;
end

%% PLOT PRECISIO I RECORD

%Plotegem la precisio i record de totes les iteracions

x_record = [0 x_record];
y_precisio = [1 y_precisio];

size_record = size(x_record);
size_precisio = size(y_precisio);

x_record_plot = zeros(1,size_record(2));
y_precisio_plot = zeros(1,size_precisio(2));

x_record2 = x_record;
y_precisio2 = y_precisio;

for q = 1:size_record(2)
    [x_record_plot(q),posicio] = min(x_record);
    x_record(posicio) = 2;
    y_precisio_plot(q) = y_precisio(posicio);
    
end

size_r_plot = size(x_record_plot);

x_record_plot = [x_record_plot x_record_plot(size_r_plot(2))];
y_precisio_plot = [y_precisio 0];