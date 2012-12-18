function [x_record_manual, y_precisio_manual] = classificacio_llindars_manuals(grup, num, llindar_verd,llindar_linies)

classificador(grup, num, llindar_verd,llindar_linies);

[x_record, y_precisio] = precisio_record(grup, num);

x_record_manual= x_record;
y_precisio_manual = y_precisio;