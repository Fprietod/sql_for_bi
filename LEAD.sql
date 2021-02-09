/*
Because LEAD looks to future rows, we need to flip how we subtract in order to find the streams_millions_change:
*/
SELECT
   artist,
   week,
   streams_millions,
   LEAD(streams_millions, 1) OVER (
      PARTITION BY artist
      ORDER BY week
   ) - streams_millions AS 'streams_millions_change'
FROM
   streams;
   /*
   We will subtract the current row’s streams_millions from the next row’s streams_millions in order to see an accurate reflection of how the number of streams has changed.
   */
   /*
   ¡Recuerda invertir tu resta! Ahora desea restar la posición actual del gráfico de la posición del gráfico de la siguiente fila. Chart_position_change es lo opuesto a streams_millions_change porque una disminución en la posición del gráfico (pasando del número 10 al 1) está considerando subir en los gráficos. 
   */
   SELECT
   artist,
   week,
   streams_millions,
   LEAD(streams_millions, 1) OVER (
      PARTITION BY artist
      ORDER BY week
   ) - streams_millions AS 'streams_millions_change',
   chart_position,
   chart_position - LEAD(chart_position, 1) OVER ( 
      PARTITION BY artist
      ORDER BY week 
) AS 'chart_position_change'
FROM
   streams;
