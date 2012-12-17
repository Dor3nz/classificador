%% CLASSIFICADOR DE IMATGES NATURE/CITY
%  Aleix Casanovas, Sergi Alonso, Marc Andr�s i Gen�s Matutes

%% ENTRENAMENT
%[mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat] = train;

%% APLICACI� DE DIFERENTS LLINDARS / MATRIUS DE CONVERSIO
[x_record,y_precisio] = classificacio_llindars(mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat);

%% PRECISSI� I RECORD / PLOT
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

figure(1);
plot(x_record_plot,y_precisio_plot,'-rs',...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','k',...
                'MarkerSize',3); title 'gr�fic precissi�/record'; xlabel 'record';ylabel 'precissi�';