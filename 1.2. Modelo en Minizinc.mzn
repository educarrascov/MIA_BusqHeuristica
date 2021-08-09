  % Use this editor as a MiniZinc scratch book
include "globals.mzn"; % quiero usar cosas como all different

% Definición de variables -> comentario (sin ; no va a hacer nada)
var 1..9: s; % s=0,1,2,3,4,5,6,7,8,9 ||| PPL -> 0<=S<=9
var 0..9: e;
var 0..9: n;
var 0..9: d;
var 1..9: m;
var 0..9: o;
var 0..9: r;
var 0..9: y;

%Definición de condiciones:
constraint  1000*s+100*e+10*n+d +
            1000*m+100*o+10*r+e =
    10000*m+1000*o+100*n+10*e+y; % warning con el; (no funciona si no va)
    
 % ¿cómo escribir que s tiene que se diferente que e?
 % constraint s<>e s!=e lineal (formas rudimentarias de escribir que todas son diferentes)
 
 constraint alldifferent ([s,e,n,d,m,o,r,y]);
 
 solve satisfy;