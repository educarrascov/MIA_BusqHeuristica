% se deben ingresar dos variables:
% paciente: indica el número de pacientes ej: 3.
% compatible: indica la tabla de compatibilidad en función de los pacientes. ej: [{A,B,C},{1,2,5},{2,5,4}]

include "globals.mzn"; 
%se define la variable de cantidad de pacientes
int: paciente;
% vector de cantidad de personas en una variable de compatibilidad
array[1..paciente] of set of int: compatibilidad;

% personas que no pueden recibir un riñón.
set of 1..paciente: non_compatibilidad = { p | p in 1..paciente where card(compatibilidad[p]) = 0 };

% Enuncia el dominio de cada variable, compatibilidad podada (pruned).
array[1..paciente] of set of int: 
   compatibilidad_pruned = [ %si hay comptabilidad igual a 0, entonces no hay compatibilidad.
            if card(compatibilidad[p]) = 0 then {p} else (compatibilidad[p] diff non_compatibilidad) union {p} endif
   | p in 1..paciente];

% selecciona cual riñón queda con cada persona
array[1..paciente] of var 1..paciente: x;
var 0..paciente: z = sum([bool2int(x[i] != i) | i in 1..paciente]);


solve :: int_search(
      x,
      first_fail, 
      indomain_median,
      complete) 
    maximize z;

% permitir ingreso de personas compatibles sin poda, también restringe a que no pueda donarse a si mismo.
constraint
  forall(p in 1..paciente) (
     x[p] in compatibilidad_pruned[p]    
  )
  /\
  alldifferent(x);
% completamos como queremos presentar el output de salida, primero mostrando la maximización de z= y posteriormente una tabla que contenga paciente donante.
output [
  "z: " ++ show(z) ++ "\n"
]
++
[
  "Paciente: Donante\n"
]
++
[
  if fix(x[i] = i) then 
     show_int(6, i) ++ ":   -\n"
  else 
     show_int(6, i) ++ ": " ++  show_int(6, x[i]) ++ "\n"
  endif
  | i in 1..paciente
]
;