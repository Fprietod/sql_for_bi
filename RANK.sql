
/*
Ahora que entendemos cómo usar ROW_NUMBER, hay otra función que es similar pero proporciona una clasificación real: RANK.

Si modificara su consulta ROW_NUMBER para usar RANK en su lugar, podría parecer exactamente lo mismo a primera vista. Pero si observa más de cerca, puede ver que RANK seguirá las reglas de clasificación estándar de modo que cuando dos valores son iguales, tendrán el mismo rango, mientras que con ROW_NUMBER no lo tendrían. 
*/
SELECT 
   RANK() OVER (
      ORDER BY streams_millions
   ) AS 'rank', 
   artist, 
   week,
   streams_millions
FROM
   streams;
   /*
   Because we are using RANK now and the 6th and 7th spot have the same value (26.3), they are both ranked as 7. Then, in standard ranking fashion, the next value is ranked as 9.
   */
   SELECT 
   RANK() OVER (
    PARTITION BY WEEK
      ORDER BY streams_millions DESC
       
   ) rank, 
   artist, 
   week,
   streams_millions
FROM
   streams;
   /*
   We need to add PARTITION BY week before our ORDER BY clause in our window function. This will group each week together and return rankings 1-8 for each week (because we have 8 artists).
   */
