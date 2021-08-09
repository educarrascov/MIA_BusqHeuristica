% Modelo de sudoku
include "globals.mzn"; % permite usar la condición alldifferent

%valores inidicales en las casillas. El 0 se usa para indicar que no hay valor. 
%corresponde al ejemplo en clase (página 65)
array[int,int] of int: start=[|5,3,0,0,7,0,0,0,0|
                               6,0,0,1,9,5,0,0,0|
                               0,9,8,0,0,0,0,6,0|
                               8,0,0,0,6,0,0,0,3|
                               4,0,0,8,0,3,0,0,1|
                               7,0,0,0,2,0,0,0,6|
                               0,6,0,0,0,0,2,8,0|
                               0,0,0,4,1,9,0,0,5|
                               0,0,0,0,8,0,0,7,9|];

array[1..9,1..9] of var 1..9: s; %solucion;

%valores iniciales (si start >0, entonces el número en la solución tiene que ser el mismo que en start)
constraint forall(r in 1..9, c in 1..9 where start[r,c]>0) ( s[r,c]=start[r,c]);
%cada número en cada fila
constraint forall(r in 1..9) ( alldifferent([s[r,c] | c in 1..9]) );
%cada número en cada columna
constraint forall(c in 1..9) ( alldifferent([s[r,c] | r in 1..9]) );
%cada número en las macro casillas
constraint forall(rB in 0..2,cB in 0..2) ( alldifferent([s[rB*3+r,cB*3+c] | c in 1..3, r in 1..3]));
%encontrar una solución
solve satisfy;
