function matrius(grup)

global num;

positius_certs = 0;
negatius_falsos = 0;
positius_falsos = 0;
negatius_certs = 0;

fid = fopen(strcat(grup,'.txt'));
fid_out = fopen(strcat(grup,'out.txt'));

in = fscanf(fid,'%s');
out = fscanf(fid_out,'%s');

s_in = size(in);
s_out = size(out);

i = 1;
for k = 5:5:s_in(2)
    valors_in(i) = str2num(in(k));
    i=i+1;
end

j = 1;
for k = 5:5:s_out(2)
    valors_out(j) = str2num(out(k));
    j=j+1;
end

for q = 1:num
    if((valors_in(q) == 1) && (valors_out(q) == 1))
        positius_certs = positius_certs + 1;
    
    elseif((valors_in(q) == 0) && (valors_out(q) == 1))
        positius_falsos = positius_falsos + 1;
        
    elseif((valors_in(q) == 1) && (valors_out(q) == 0))
        negatius_falsos = negatius_falsos + 1;
        
    elseif((valors_in(q) == 0) && (valors_out(q) == 0))
        negatius_certs = negatius_certs + 1;
    end
end

f = figure('Position', [100 100 752 350]);
t = uitable('Parent', f, 'Position', [25 25 700 200]);

complexData = { ...
    'Positius predicci�' positius_certs negatius_falsos; ...
    'Negatius predicci�' positius_falsos negatius_certs;};
set(t, 'Data', complexData, 'ColumnName', {'','Positius reals','Negatius reals'});
        
