function imatges = imatges(total)

% Obrim fitxer original i fitxer generat a la classificació.
fid = fopen(['test/' grup '.txt']);
fid_out = fopen(strcat(grup,'out.txt'));

% Inicialització del vector d'imatges, contindrà 1 o 0 en funció de si la
% imatge corresponent al índex del vector ha estat ben classificada o no,
% respectivament.
imatges = zeros(1,total);

% Lectura de la primera línia de cada fitxer.
linia = fgetl(fid);
linia_out = feglt(fid_out);

% Posició del caràcter d'interès. El caràcter d'interès determina si una
% imatge és rural o urbana.
c = length(linia);

% Primera comprovació.
if linia(c) == linia_out(c)
    imatges(1) = 1;
end

% Iteració comparativa.
for i = 2:total
    if linia(c) == linia_out(c)
        imatges(i) = 1;
    end
end