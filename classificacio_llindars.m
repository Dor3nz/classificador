function classificacio_llindars(mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat)

K_verd = (mitjana_verd_natura + mitjana_verd_ciutat)/2;
K_linies = (mitjana_linia_natura + mitjana_linia_ciutat)/2;


disp('CLASSIFICACIÓ MITJANÇANT EL LLINDAR APRÈS');
grup = input('Quin grup imatges vols classificar? ','s');
disp('');

classificador(grup,K_verd,K_linies);

matrius(grup);
%precissio i record

disp('CLASSIFICACIÓ MITJANÇANT LLINDARS MANUALS');
disp('Desitja posar uns llindars diferents?');
sortir = 'n';
while(sortir~='s')
    
K2_verd = input('Llindar de tant per cent de verd: ');
K2_linies = input('Llindar del nombre de linies: ');

classificador(grup,K2_verd,K2_linies);
matrius(grup);
%precissio i record

sortir = input('Desitja sortir?(s --> si | n --> no) ','s');
end