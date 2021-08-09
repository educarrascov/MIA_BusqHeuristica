% Modelo car sequencing (láminas 96 en adelante)
% include "globals.mzn";
int: nModelos=6;
int: nOpciones=5;
int: nCoches=10;
 
array[1..nModelos] of int: demanda=[1,1,2,2,2,2];
 
array[1..nModelos,1..nOpciones] of int: uso=[|1,0,1,1,0|
                                              0,0,0,1,0|
                                              0,1,0,0,1|
                                              0,1,0,1,0|
                                              1,0,1,0,0|
                                              1,1,0,0,0|];
array[1..nOpciones] of int: maximo=[1,2,1,2,1]; % límite numerador
array[1..nOpciones] of int: de=[2,3,3,5,5]; % límite denominador

% variables
array[1..nCoches] of var 1..nModelos: coche; % qué modelo de auto se hace en cada posición
% auxiliar
array[1..nOpciones, 1..nCoches] of var 0..1: pieza; %asocio el uso de una opción con el auto realizado en la posición
 
% hay que hacer todos los autos que se piden
constraint forall(m in 1..nModelos) (
  sum(c in 1..nCoches) (bool2int(coche[c]==m)) = demanda[m] );

%asociar "pieza" con "coche"
constraint forall(o in 1..nOpciones, c in 1..nCoches) (
  pieza[o,c]=uso[coche[c],o]);

% nunca sobrepasar el máximo de autos cada susecuencia de unidades idénticas
constraint forall(o in 1..nOpciones, c in 1..nCoches-de[o]+1) (
  sum(cc in c..c+de[o]-1) (pieza[o,cc]) <= maximo[o] );

%resolver  
solve satisfy;
      
