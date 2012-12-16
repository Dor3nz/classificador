%% CLASSIFICADOR DE IMATGES NATURE/CITY
%  Aleix Casanovas, Sergi Alonso, Marc Andrés i Genís Matutes

%% ENTRENAMENT
[mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat] = train;

%% APLICACIÓ DE DIFERENTS LLINDARS / MATRIUS DE CONVERSIO
classificacio_llindars(mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat)

%% PRECISSIÓ I RECORD / PLOT