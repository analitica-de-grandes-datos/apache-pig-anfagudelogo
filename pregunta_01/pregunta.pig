/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.

docker run --rm -it --name pig -p 50070:50070 -p 8088:8088 -p 8888:8888 -v "%cd%":/workspace jdvelasq/pig:0.17.0

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/


-- carga de datos desde la carpeta local
data = LOAD 'data.tsv' USING PigStorage('\t') AS (letter:chararray, date:chararray, number:chararray);

data = FOREACH (GROUP data BY letter) GENERATE group,COUNT(data.letter);

-- escribe el archivo de salida en el sistema local
STORE data INTO '/workspace/output/' USING PigStorage(',');

