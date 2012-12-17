function [x_record,y_precisio] = classificacio_llindars(mitjana_verd_natura,mitjana_verd_ciutat,mitjana_linia_natura,mitjana_linia_ciutat)

global num;

K_verd = (mitjana_verd_natura + mitjana_verd_ciutat)/2;
K_linies = (mitjana_linia_natura + mitjana_linia_ciutat)/2;


disp(strcat('Llindars idonis calculats pel classificador:'));
disp(strcat('Verd: ',num2str(K_verd)));
disp(strcat('Linies: ',num2str(K_linies)));
        

disp('CLASSIFICACIÓ MITJANÇANT EL LLINDAR APRÈS');
grup = input('Quin grup imatges vols classificar? ','s');
disp('');

num = input('Quantes imatges vols fer? ');

classificador(grup,K_verd,K_linies);

matrius(grup);
[x_record(1),y_precisio(1)] = precisio_record(grup);
disp(strcat('Record: ',num2str(x_record(1))));
disp(strcat('Precisio: ',num2str(y_precisio(1))));

disp('CLASSIFICACIÓ MITJANÇANT LLINDARS MANUALS');
disp('Desitja posar uns llindars diferents?');
sortir = 'n';

cont_K = 2;
while(sortir~='s')
    
K2_verd = input('Llindar de tant per cent de verd: ');
K2_linies = input('Llindar del nombre de linies: ');

classificador(grup,K2_verd,K2_linies);
matrius(grup);
[x_record(cont_K),y_precisio(cont_K)] = precisio_record(grup);

disp(strcat('Record: ',num2str(x_record(cont_K))));
disp(strcat('Precisio: ',num2str(y_precisio(cont_K))));


cont_K = cont_K + 1;
sortir = input('Desitja sortir?(s --> si | n --> no) ','s');
end