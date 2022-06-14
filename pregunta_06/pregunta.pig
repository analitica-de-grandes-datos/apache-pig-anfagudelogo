/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' USING PigStorage('\t') AS 
        ( letter:charArray,
          letter_bag:bag{},
          lista:map[]);

data = FOREACH data GENERATE FLATTEN(lista) as flatten_lista;
data = FOREACH data GENERATE FLATTEN(flatten_lista) as flatten_lista_2;
data = FOREACH (GROUP data BY flatten_lista_2) GENERATE group,COUNT(data.flatten_lista_2);

STORE data INTO 'output' USING PigStorage(',');