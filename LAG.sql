
/*
Ahora que sabemos cómo extraer el primer o el último valor de nuestro conjunto de datos y mostrarlo junto con los resultados de nuestra consulta, veamos cómo obtener datos de otras partes de nuestros resultados.

Las funciones de ventana pueden usar LAG o LEAD para acceder a la información de una fila en un desplazamiento especificado que viene antes (LAG) o después (LEAD) de la fila actual.

Esto significa que al usar LAG o LEAD puede acceder a cualquier fila antes o después de la fila actual, lo que puede ser muy útil para calcular la diferencia entre la fila actual y la adyacente. Primero nos centraremos en el uso de LAG. 
*/
/*
Let’s look at a window function that uses LAG. We will look at the artist’s current number of streams and their streams from the previous week.*/
SELECT
   artist,
   week,
   streams_millions,
   LAG(streams_millions, 1, 0) OVER (
      ORDER BY week 
   ) previous_week_streams 
FROM
   streams 
WHERE
   artist = 'Lady Gaga';
   /*
   LAG takes up to three arguments:

    column (required)
    offset (optional, default 1 row offset)
    default (optional, what to replace default null values with)
    
    Aunque el desplazamiento y el valor predeterminado son opcionales para LAG y LEAD, debemos pasar ambos porque nos gustaría que nuestro valor predeterminado sea 0 en lugar de nulo. 
*/
/*
Displaying the previous row value in each row can be useful, but for our purposes let’s change our LAG function to instead show the change in streams for Lady Gaga per week:
*/
SELECT
   artist,
   week,
   streams_millions,
   streams_millions - LAG(streams_millions, 1, streams_millions) OVER ( 
      ORDER BY week 
   ) streams_millions_change
FROM
   streams 
WHERE
   artist = 'Lady Gaga';
   /*
   To do this, we just need to subtract the current week’s streams_millions by our LAG function value (which is returning the previous week’s streams_millions). 
   */
   /*For calculating the chart position change, remember that a decrease in number on the chart is actually a good thing and considered positive so your subtraction will look a little different:
   */
   SELECT
   artist,
   week,
   streams_millions,
   streams_millions - LAG(streams_millions, 1, streams_millions) OVER ( 
      ORDER BY week 
   ) AS 'streams_millions_chane',
   chart_position,
   LAG(chart_position, 1, chart_position)
   OVER (
     PARTITION BY artist
     ORDER BY week
   ) - chart_position AS
   'chart_position_change'
FROM
   streams 
WHERE
   artist = 'Lady Gaga';
  
