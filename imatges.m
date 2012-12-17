function imatges = imatges(total)

% Obrim fitxer original i fitxer generat a la classificaci�.
fid = fopen(['test/' grup '.txt']);
fid_out = fopen(strcat(grup,'out.txt'));

% Inicialitzaci� del vector d'imatges, contindr� 1 o 0 en funci� de si la
% imatge corresponent al �ndex del vector ha estat ben classificada o no,
% respectivament.
imatges = zeros(1,total);

% Lectura de la primera l�nia de cada fitxer.
linia = fgetl(fid);
linia_out = feglt(fid_out);

% Posici� del car�cter d'inter�s. El car�cter d'inter�s determina si una
% imatge �s rural o urbana.
c = length(linia);

% Primera comprovaci�.
if linia(c) == linia_out(c)
    imatges(1) = 1;
end

% Iteraci� comparativa.
for i = 2:total
    if linia(c) == linia_out(c)
        imatges(i) = 1;
    end
end