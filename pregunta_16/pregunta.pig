/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT
       firstname,
       color
   FROM 
       u
   WHERE color = 'blue' OR firstname LIKE 'K%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

         >>> Escriba su respuesta a partir de este punto <<< 
*/

data = LOAD 'data.csv' USING PigStorage(',') AS 
        ( number:int,
          nombre:charArray,
          apellido:charArray,
          fecha:charArray,
          color:charArray,
          end_number:int);


data = FOREACH data GENERATE nombre,color;
data = FILTER data BY (color == 'blue')
                    OR (nombre matches '.*K.*');                    

STORE data INTO 'output' USING PigStorage(',');