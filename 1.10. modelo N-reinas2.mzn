% Use this editor as a MiniZinc scratch book
include "globals.mzn"; % usamos esta librería que incluye alldifferent

% Parámetro
int: n;

% Definición de variables
array [1..n] of var 1..n: rows;

%Definición de condiciones:
 constraint alldifferent (rows); 
 constraint forall (i, j in 1..n where i < j)(
% rows[i]-rows[j]   /\ %reemplaza la función alldifferent
 rows[i] -rows[j]!= i - j /\
 rows[i] -rows[j]!= j - i );
 
% búsqueda y solución
 solve satisfy;
 
% salida
 output [
 show(rows)++"\n" 
 ];
 n = 8;           
                   
