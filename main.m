%% CLASSIFICADOR DE IMATGES NATURE/CITY
%  Aleix Casanovas, Sergi Alonso, Marc Andr�s i Gen�s Matutes

%% ENTRENAMENT
[mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat] = train;

%% APLICACI� DE DIFERENTS LLINDARS / MATRIUS DE CONVERSIO
classificacio_llindars(mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat)

%% PRECISSI� I RECORD / PLOT