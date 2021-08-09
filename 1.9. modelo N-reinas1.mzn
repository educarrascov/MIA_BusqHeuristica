  int: n; %cantidad de reinas
  array [1..n] of var 1..n: q; %definir el vector de variables n
  predicate
  noattack(int: i, int: j, var int: qi, var int: qj) =
    qi !=qj /\ %reinas en filas no pueden ser iguales a reina en columna).
    qi + i != qj + j /\ %reinas no pueden estar en una misma diagonal directa
    qi - i != qj - j; %reinas no pueden estar en una misma diagonal inversa

  constraint
    forall (i in 1..n, j in i+1..n) (
      noattack(i, j, q[i], q[j])
    );

 solve satisfy;

    output [show(n)] ++ [" queens, CP version:"] ++ 
        [   if j = 1 then "\n" else "" endif ++ 
    show_cond(q[i] = j, "Q ", ". ")
    | i, j in 1..n
    ];
    n = 8
    
