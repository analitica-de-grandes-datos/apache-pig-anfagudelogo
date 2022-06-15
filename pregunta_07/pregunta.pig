/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' USING PigStorage('\t') AS 
        ( letter:charArray,
          letter_bag:bag{},
          lista:map[]);

data = FOREACH data GENERATE letter ,SIZE(letter_bag) as c2,SIZE(lista) as c3;
data = ORDER data BY letter ASC, c2 ASC, c3 ASC;

STORE data INTO 'output' USING PigStorage(',');