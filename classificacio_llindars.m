function [x_record,y_precisio] = classificacio_llindars(grup, num, mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat)

% C�lcul de llindars idonis.
K_verd = (mitjana_verd_natura + mitjana_verd_ciutat)/2;
K_linies = (mitjana_linia_natura + mitjana_linia_ciutat)/2;

% Genera el fitxer de sortida per poder analitzar la precisi� i el record.
classificador(grup, num, K_verd,K_linies);

% Genera matrius de confusi�.
matrius(grup, num);

% C�lcul de record i precisi� que es retornar� a la interf�cie.
[x_record,y_precisio] = precisio_record(grup, num);