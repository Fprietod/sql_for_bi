# Windows Function

Las funciones de ventana, por otro lado, le permiten mantener los valores de su tabla original mientras muestra información agrupada o sumativa al lado en otra columna. Esta es la razón por la que a muchos científicos e ingenieros de datos les encanta usar funciones de ventana para análisis de datos complejos. 
```sql
SELECT 
   month,
   change_in_followers,
   SUM(change_in_followers) OVER (
      ORDER BY month
   ) AS 'running_total'
FROM
   social_media
WHERE
   username = 'instagram';
   ```
 SUM is only able to return one row of data that represents the sum of all months. running_total is able to show you what the total is after each month.
 
 ## Windows Function syntax
 
 ```sql
 SELECT 
   month,
   change_in_followers,
   SUM(change_in_followers) OVER (
      ORDER BY month
   ) AS 'running_total'
FROM
   social_media
WHERE
   username = 'instagram';
   ```

 - SELECT month, change_in_followers: Same as usual, selecting the columns.
 - SUM(change_in_followers): Here is our aggregate function to find the SUM of our chosen column.
 - OVER: This is the clause that designates SUM as a window function.
 - ORDER BY month: Here we declare what we would like our window function to do.
 - This window function is taking the sum of money raised each month.
 - So for each month, the window function adds the current month’s change_in_followers to our running total.
 - Then name the running total column 'running_total'.
 - And lastly, this is all coming from table social_media where the username is instagram.

More Complex SQL
```sql
SELECT 
   month,
   change_in_followers,
   SUM(change_in_followers) OVER (
      ORDER BY month
   ) AS 'running_total',
   AVG(change_in_followers) OVER (
      ORDER BY month
   ) AS 'running_avg',
   COUNT(change_in_followers) OVER (
      ORDER BY month
   ) AS 'running_count'
FROM
   social_media
WHERE
   username = 'instagram';
```
Here we can see how the sum, average and count of followers is changing each month rather than just the total sum, average or count.

 
 
### Partition By

In our last query, we were able to find the running total, average and count of only Instagram’s followers using window functions. But what about the other accounts in our social media table? What if we wanted to compare all of our users?

This is where we can use another feature of window functions: PARTITION BY.

PARTITION BY is a subclause of the OVER clause and divides a query’s result set into parts. It’s very similar to GROUP BY except it does not reduce the number of rows returned.

While using GROUP BY only allows one row to be returned for each group, PARTITION BY allows you to see all of the resultant rows.
```sql
SELECT 
    username,
    month,
    change_in_followers,
    SUM(change_in_followers) OVER (
      PARTITION BY username 
      ORDER BY month
    ) 'running_total_followers_change'
FROM
    social_media;
```

We can see the running total for all of our users. We can also see the change_in_followers next to our running total.

Example 2
```sql
SELECT 
    username,
    month,
    change_in_followers,
    SUM(change_in_followers) OVER (
      PARTITION BY username 
      ORDER BY month
    ) 'running_total_followers_change',
    posts,
    AVG(change_in_followers) OVER (
      PARTITION BY username 
      ORDER BY month
    ) 'running_avg_followers_change'
FROM
    social_media;
```
Looking at the results of your query, which user had the largest/smallest increase in new followers? Which user had the steadiest flow of followers?
 The steadiest flow of followers would be the user with the most consistent average.
 
### First value and Last Value

In the past, when we wanted to get the first or last value of a query, we might use the LIMIT clause, probably in conjunction with ORDER BY, which would return one result showing us the first or last value from our dataset.

With window functions, we can return our first or last values alongside our other data by using the FIRST_VALUE() or LAST_VALUE() functions. 

They work exactly as you would imagine:

   - FIRST_VALUE() returns the first value in an ordered set of values.
   - LAST_VALUE() returns the last value in an ordered set of values.

Let’s break down a query that is fetching the FIRST_VALUE() from our social media dataset:

```sql
SELECT
   username,
   posts,
   FIRST_VALUE (posts) OVER (
      PARTITION BY username 
      ORDER BY posts
   ) fewest_posts
FROM
   social_media;
```
- This query should look familiar overall as it follows the standard window function format, however, we are using FIRST_VALUE now for posts. This means our window function will pull the first value from the posts column.
- OVER (PARTITION BY username ORDER BY posts) fewest_posts: here we can see that posts is going to be pulled based on username due to the PARTITION BY. We are naming this column fewest_posts because of the ORDER BY which defaults to ascending order.
- And all of this is coming from our social_media table.

If we want to use the Last_value
In order to get LAST_VALUE to show us the most posts for a user, we need to specify a frame for our window function.
```sql
SELECT
   username,
   posts,
   LAST_VALUE (posts) OVER (
      PARTITION BY username 
      ORDER BY posts
      RANGE BETWEEN UNBOUNDED PRECEDING AND 
      UNBOUNDED FOLLOWING
    ) most_posts
FROM
    social_media;
```

### LAG 

Las funciones de ventana pueden usar LAG o LEAD para acceder a la información de una fila en un desplazamiento específico que viene antes (LAG) o después (LEAD) de la fila actual.

Esto significa que al usar LAG o LEAD puede acceder a cualquier fila antes o después de la fila actual, lo que puede ser muy útil para calcular la diferencia entre la fila actual y la adyacente. Primero nos centraremos en el uso de LAG. 

Veamos una función de ventana que usa LAG. Analizaremos la cantidad actual de transmisiones del artista y sus transmisiones de la semana anterior. 
```sql
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
```

LAG takes up to three arguments:

   - column (required)
   - offset (optional, default 1 row offset)
   - default (optional, what to replace default null values with)



Mostrar el valor de la fila anterior en cada fila puede ser útil, pero para nuestros propósitos, cambiemos nuestra función LAG para mostrar el cambio en las transmisiones de Lady Gaga por semana: 
```sql
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
```
Para hacer esto, solo necesitamos restar los streams_millions de la semana actual por el valor de nuestra función LAG (que devuelve los streams_millions de la semana anterior).
![alt text](https://fotos-11.s3.amazonaws.com/Query.PNG)

For calculating the chart position change, remember that a decrease in number on the chart is actually a good thing and considered positive so your subtraction will look a little different:
```sql
SELECT
   artist,
   week,
   streams_millions,
   streams_millions - LAG(streams_millions, 1, streams_millions) OVER ( 
      PARTITION BY artist
      ORDER BY week 
   ) AS 'streams_millions_change',
   chart_position,
   LAG(chart_position, 1, chart_position) OVER ( 
      PARTITION BY artist
      ORDER BY week 
) - chart_position AS 'chart_position_change'
FROM
   streams
WHERE 
   artist = 'Lady Gaga';
```
### LEAD

Vamos a modificar esto para usar LEAD, que mira a las filas futuras, en lugar de LAG, que mira a las filas anteriores. 

Ejemplo:

Debido a que LEAD mira a las filas futuras, debemos cambiar la forma en que restamos para encontrar las corrientes que cambian millones: 
```sql
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
```
Restaremos los millones de flujos de la fila actual de los millones de flujos de la siguiente fila para ver un reflejo preciso de cómo ha cambiado el número de flujos. 

![Imagen con lead](https://fotos-11.s3.amazonaws.com/metrocdmx/Query.PNG)

Posición en la tabla:


¡Recuerda invertir tu resta! Ahora desea restar la posición actual del gráfico de la posición del gráfico de la siguiente fila. Chart_position_change es lo opuesto a streams_millions_change porque una disminución en la posición del gráfico (pasando del número 10 al 1) está considerando subir en los gráficos. 
```sql
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
```

### Row number

Now that we have a good understanding of how to fetch data from different rows, let’s explore how we can use window functions to order and rank our results.
The most straight-forward way to order our results is by using the ROW_NUMBER function which adds sequential integer number to each row. 
Adding a ROW_NUMBER to each row can be useful for seeing where in your result set the row falls.

Example
```sql
SELECT
ROW_NUMBER() OVER(
  ORDER BY streams_millions
) AS 'row_num',
artist,
week,
streams_millions
FROM streams;
```
Question What happens for the row_num when the streams_millions are equal?
The rows continue to increase even when the values are equal because it is solely based on the number of the row in our results set.

An example of this is when 'row_num' is 7 and 8 and the streams_million is 26.3 for both.
![Row](https://fotos-11.s3.amazonaws.com/metrocdmx/row.PNG)

### RANK

Now that we understand how to use ROW_NUMBER, there is another function that is similar but provides an actual ranking: RANK.

If you were to modify your ROW_NUMBER query to use RANK instead, it might appear to be exactly the same at first glance. But if you look more closely, you can see that RANK will follow standard ranking rules so that when two values are the same, they will have the same rank whereas with ROW_NUMBER they would not.
```sql
SELECT 
   RANK() OVER (
      ORDER BY streams_millions
   ) AS 'rank', 
   artist, 
   week,
   streams_millions
FROM
   streams;
```
Because we are using RANK now and the 6th and 7th spot have the same value (26.3), they are both ranked as 7. Then, in standard ranking fashion, the next value is ranked as 9.

![example](https://fotos-11.s3.amazonaws.com/metrocdmx/Rank.PNG)

### NTILE

La última función de ventana que vamos a aprender se llama NTILE y puede usarse para encontrar cuartiles, quintiles o cualquier ntile que desee su corazón impulsado por datos.

NTILE le permite dividir sus datos en grupos aproximadamente iguales, según el ntile que le gustaría: por lo tanto, si estuviera usando un cuartil, dividiría los datos en cuatro grupos (trimestres).

Cuando utilice NTILE, debe proporcionar un depósito, que representa la cantidad de grupos en los que le gustaría que se desglosaran sus datos: NTILE (4) serían cuatro "depósitos" que representarían los cuartiles. 

```sql
SELECT 
   NTILE(5) OVER (
      ORDER BY streams_millions DESC
   ) AS 'weekly_streams_group', 
   artist, 
   week,
   streams_millions
FROM
   streams;
```
- ¿Qué representa cada NTILE?
- Si estás en Weekly_streams_group 1, ¿eres el artista más o menos reproducido?
- ¿Qué artistas componen el grupo más reproducido? 
![ejemplo](https://fotos-11.s3.amazonaws.com/metrocdmx/NTILE.PNG)

Debido a que tenemos 5 cubos, este NTILE representaría quintiles o quintos. El quintil superior está compuesto casi en su totalidad por Drake. The Weeknd y Bad Bunny también tuvieron suficientes transmisiones semanales para ubicarlos en algunos lugares en el quintil superior. 
```sql
SELECT 
   NTILE(4) OVER (
      ORDER BY streams_millions DESC
   ) AS 'weekly_streams_group', 
   artist, 
   week,
   streams_millions
FROM
   streams;
```
Con los cuartiles, cada grupo ahora es más grande y contiene más transmisiones semanales. Nuestro cuartil superior sigue siendo principalmente Drake y The Weeknd, con una semana de Bad Bunny y una semana de Lady Gaga (que no estaba en el quintil superior anterior). 


Ahora tenemos cuartiles para cada semana. Cada cuartil contiene dos artistas porque tenemos ocho artistas en total para cada semana en nuestro conjunto de datos. 
```sql
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
```
