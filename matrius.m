function [positius_certs, negatius_falsos, positius_falsos, negatius_certs] = matrius(grup, num)

positius_certs = 0;
negatius_falsos = 0;
positius_falsos = 0;
negatius_certs = 0;

fid = fopen(['test/' grup '.txt']);
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
