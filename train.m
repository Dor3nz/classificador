function train(file)

% Obre el fitxer que cont� les id de les imatges d'entrenament.
file = fopen(['train/' file]);

% Guarda les imatges de la col�lecci�.
i= 0;
while fegtl(file) ~= -1
    i = i + 1;
    fila = fgetl(file);
    nom_imatge = fila(1:4);

    imatge = imread(['train/' nom_imatge],'jpg');
    
    I(:,:,:,(i)) = imatge;
end

% L'estructura de dades cont� el contingut de verd aix� com el n�mero de 
% l�nies rectes de cada imatge.
dades = zeros(10,1,2);

for i = 1:10    
    [green,prob] = verd(I(:,:,:,i));
    dades(i,1,1) = prob;
    
    [numhor,numver] = detect(I(:,:,:,i));
    dades(i,1,2)= numhor + numver;        
end

% Inicialitzaci� de totals.
[total_verd_natura, total_verd_ciutat, total_linia_natura, total_linia_ciutat] = deal(0);

    
    

  %Les diferents mitjanes ser�n els llindars perfectes que delimiten les imatges de ciutat o es imatges de natura
  
  %Ara ja sabem el llindar perfecte, mitjan�ant les imatges
  %d'aprenantatge.. Per tant, utilitzarem aquests llindars per classificar
  %les demes imatges.