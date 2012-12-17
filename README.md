Classificador
=============

This is a learning project developed in Universitat Politècnica de Catalunya, 
under the module Gestió i Distribució de Senyals Audiovisuals (GDSA) from Grau en Sistemes Audiovisuals degree.

The program aim is to classify images between rural or urban as well as giving some details about
the classifier itself, such as Precision and Recall graphics or Confusion Matrices.


This project is currently WIP.

Manual d'instruccions
=====================

Continguts
----------
- Estructura del directori
- Inicialització del programa
- Interfície gràfica
- Funcionament

Estructura del directori
------------------------
Per a que el programa funcioni de manera correcte és important mantenir
l'estructura del mateix així com els continguts corresponents a cada un dels
seus directoris.

- classificador
    - /test
    - /train
    - classificacio_llindars.m
    - classificador.m
    - comprova_imatges.m
    - detect.m
    - getCurrentPopupString.m
    - init.fig
    - init.m
    - matrius.m
    - precisio_record.m
    - train.m
    - verd.m

És important tenir guardats els documents .txt que contenen les referències per
a les imatges de l'entrenament a dins del directori /train i els que fan
referència a les imatges que voldrem classificar a dins del directori /test.

Les imatges han d'anar als mateixos directoris que l'arxiu on s'hi fa
referència, és a dir, les imatges d'entrenament a /train i les de prova a
/test.

Inicialització del programa
---------------------------
Per inicialitzar el programa cal situar-se al directori classificador a través
del quadre de comandes de Matlab:

    >> cd(C:\directori\del\classificador)

Un cop situats al directori haurem d'inicialitzar la interfície per poder
accedir a les diferents característiques del programa:

    >> init

Interfície gràfica
------------------
A continuació es mostra una captura de la interfície gràfica del classificador
i l'explicació dels seus continguts.

![](http://img.photobucket.com/albums/v488/karneater/screenshot_ui_zps507c1cff.png)

1. Entrenament
Conté els elements necessaris per a realitzar l'entrenament amb les dades
corresponents.

2. Classificació
Conté els elements necessaris per a classificar les imatges de prova.

3. Anàlisi de resultats
Mostra un anàlisi dels resultats obtinguts per a poder obtenir un valor de
qualitat del classificador a través de varies dades.

4. Resultats
Mostra el nombre d'imatges correctament classificades i permet veure les que
no.

Funcionament
------------
Per a dur a terme la classificació d'un conjunt d'imatges referenciades en un
document .txt cal seguir els següents passos:

1. Guardar les imatges que es volen classificar i el seu corresponent .txt al
   directori /test.
2. Arrancar el classificador.
3. Entrenar el classificador fent _click_ al botó *Entrena*. Els llindars
   establerts pel classificador a través de l'entrenament es mostraràn al
   costat un cop aquest s'hagi dut a terme.
4. *Un cop han aparegut els valors dels llindars* és possible seleccionar el
   fitxer on hi ha contingudes les referències a les imatges que es volen
   classificar. També és possible delimitar el nombre d'imatges a classificar
   de la col·lecció. Un cop configurats ambdós paràmetres cal prémer
   *Classifica*.
5. Els valors de precisió i record, així com la gràfica de precisió i record i
   la matriu de confusió es dibuixaràn a l'apartat d'Anàlisi de resultats un
   cop la classificació s'hagi dut a terme.
6. A l'apartat de resultats es pot veure quantes imatges del total d'imatges a
   classificar han estat classificades correctament. A través del botó *mostra*
   és possible veure quines imatges han estat classificades de manera errònia.
