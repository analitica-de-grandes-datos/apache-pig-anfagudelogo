/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' USING PigStorage('\t') AS 
        ( letter:charArray,
          letter_bag:bag{},
          lista:map[]);

data = FOREACH data GENERATE FLATTEN(letter_bag) as flatten_letter;

data = FOREACH (GROUP data BY flatten_letter) GENERATE group,COUNT(data.flatten_letter);

-- data = FOREACH data GENERATE letter_bag;
STORE data INTO 'output' USING PigStorage(',');