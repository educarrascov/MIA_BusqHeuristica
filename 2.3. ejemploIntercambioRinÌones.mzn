include "globals.mzn"; 
% datos
int: pacientes=8;
array[1..pacientes] of set of int: compatible = 
  [
    {2,3}, % 1
    {1,6}, % 2
    {1,4,7}, % 3
    {2}, % 4  
    {2}, % 5
    {5}, % 6
    {8}, % 7
    {3}, % 8
  ];

%variables (mi pregunta)
% que donante da el riñón al paciente (0 si no recibe riñón)
array[1..pacientes] of var 0..pacientes: x;
%x[3] -> el riñón que recibe el paciente 3
% calculamos el número de pacientes con transplante
var 0..pacientes: z;

 constraint z = sum([bool2int(x[i] > 0) | i in 1..pacientes]);

%condición 1: cada paciente un riñón diferente
% "de regalo" asegura que un donante no dona su riñón 2 veces.
constraint alldifferent_except_0(x); 

%condición 2: 

%una de dos: el paciente no recibe riñón ó 
%si el paciente recibe riñón entonces el paciente de su donante también recibe riñón

constraint forall(p in 1..pacientes) (
  ( %no recibe riñón
    x[p]=0  
  )
  \/ %ó recibe riñón
  (
    x[p] in compatible[p] %ese riñón tiene que estar en la lista de compatibles
    /\ %también se debe cumplir
    x[x[p]]>0  
  )
);
% solve satisfy;
solve maximize z;
