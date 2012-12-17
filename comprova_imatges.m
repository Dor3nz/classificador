function imatges = comprova_imatges(total, grup)

% Obrim fitxer original i fitxer generat a la classificaci�.
fid = fopen(['test/' grup '.txt']);
fid_out = fopen(strcat(grup,'out.txt'));

% Inicialitzaci� del vector d'imatges, contindr� 1 o 0 en funci� de si la
% imatge corresponent al �ndex del vector ha estat ben classificada o no,
% respectivament.
imatges = zeros(1,total);

% Iteraci� comparativa. La variable c �s la posici� del car�cter d'inter�s. 
% El car�cter d'inter�s determina si una imatge �s rural o urbana.
for i = 1:total
    linia = fgetl(fid);
    linia_out = fgetl(fid_out);
    c = length(linia);
    co = length(linia_out);
    
    if linia(c) == linia_out(co)
        imatges(i) = 1;
    end
end