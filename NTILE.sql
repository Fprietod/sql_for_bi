
/*
La última función de ventana que vamos a aprender se llama NTILE y se puede usar para encontrar cuartiles, quintiles o cualquier ntile que desee su corazón impulsado por datos.

NTILE le permite dividir sus datos en grupos aproximadamente iguales, según el ntile que le gustaría: por lo tanto, si estuviera usando un cuartil, dividiría los datos en cuatro grupos (trimestres). 
*/
/*
Cuando use NTILE, debe proporcionar un depósito, que representa la cantidad de grupos en los que le gustaría que sus datos se dividan en: NTILE (4) serían cuatro "depósitos" que representarían los cuartiles. 
*/
SELECT 
   NTILE(5) OVER (
      ORDER BY streams_millions DESC
   ) AS 'weekly_streams_group', 
   artist, 
   week,
   streams_millions
FROM
   streams;
   /*
   
    What does each NTILE represent?
    If you’re in weekly_streams_group 1, are you the most or least streamed artist?
    What artists make up the most streamed grouping?
*/
/*
Dado que tenemos 5 cubos, este NTILE representaría quintiles o quintos. El quintil superior está compuesto casi en su totalidad por Drake. The Weeknd y Bad Bunny también tuvieron suficientes transmisiones semanales para ubicarlos en algunos lugares en el quintil superior. 
*/
SELECT 
   NTILE(4) OVER (
      PARTITION BY week
      ORDER BY streams_millions DESC
   ) AS 'quartile', 
   artist, 
   week,
   streams_millions
FROM
   streams;
