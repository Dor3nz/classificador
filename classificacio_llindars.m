function [x_record,y_precisio] = classificacio_llindars(grup, num, mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat)

% Càlcul de llindars idonis.
K_verd = (mitjana_verd_natura + mitjana_verd_ciutat)/2;
K_linies = (mitjana_linia_natura + mitjana_linia_ciutat)/2;

% Genera el fitxer de sortida per poder analitzar la precisió i el record.
classificador(grup, num, K_verd,K_linies);

% Genera matrius de confusió.
matrius(grup, num);

% Càlcul de record i precisió que es retornarà a la interfície.
[x_record,y_precisio] = precisio_record(grup, num);