/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' USING PigStorage('\t') AS 
        ( letter:charArray,
          letter_bag:bag{},
          lista:map[]);

data = FOREACH data GENERATE letter_bag,FLATTEN(lista) as flatten_lista;
data = FOREACH data GENERATE letter_bag,FLATTEN(flatten_lista) as flatten_lista_2;
data = FOREACH data GENERATE flatten_lista_2,FLATTEN(letter_bag) as flatten_letter;
data = GROUP data BY (flatten_letter,flatten_lista_2) ;
data_final = FOREACH data GENERATE group as c1, COUNT(data) as c2;

data_final = ORDER data_final BY c1 ASC, c2 ASC;
STORE data_final INTO 'output' USING PigStorage(',');