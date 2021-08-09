% Send more money en minizinc
include "globals.mzn"; % permite usar la condición alldifferent

% definimos el dominio de cada variable
var 1..9: s;
var 0..9: e;
var 0..9: n;
var 0..9: d;
var 1..9: m;
var 0..9: o;
var 0..9: r;
var 0..9: y;

%condición que impone la suma
constraint         1000*s+100*e+10*n+d +
                   1000*m+100*o+10*r+e =
           10000*m+1000*o+100*n+10*e+y;

% cada letra debe tener un número diferente
constraint alldifferent([s,e,n,d,m,o,r,y]);
            
% busca una solución
solve satisfy;
