include "globals.mzn"; 
% datos
int: pacientes=3;
array[1..pacientes] of set of int: compatible = 
  [
    {2,3,4}, % 1
    {1,3,6}, % 2
    {1,2,3}, % 3

  ];

array[1..pacientes] of var 0..pacientes: x;
var 0..pacientes: z;

 constraint z = sum([bool2int(x[i] > 0) | i in 1..pacientes]); %despliega como valor la cantidad de aciertos


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
         
