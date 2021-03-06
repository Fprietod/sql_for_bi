# Windows Function

Window functions, on the other hand, allow you to maintain the values of your original table while displaying grouped or summative information alongside in another column. This is why many Data Scientists and Data Engineers love to use window functions for complex data analysis.
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
