function imatges = comprova_imatges(total, grup)

% Obrim fitxer original i fitxer generat a la classificació.
fid = fopen(['test/' grup '.txt']);
fid_out = fopen(strcat(grup,'out.txt'));

% Inicialització del vector d'imatges, contindrà 1 o 0 en funció de si la
% imatge corresponent al índex del vector ha estat ben classificada o no,
% respectivament.
imatges = zeros(1,total);

% Iteració comparativa. La variable c és la posició del caràcter d'interès. 
% El caràcter d'interès determina si una imatge és rural o urbana.
for i = 1:total
    linia = fgetl(fid);
    linia_out = fgetl(fid_out);
    c = length(linia);
    co = length(linia_out);
    
    if linia(c) == linia_out(co)
        imatges(i) = 1;
    end
end