## Combining Tables with SQL 

Combining tables manually is time-consuming. Luckily, SQL gives us an easy sequence for this: it’s called a JOIN.
If we want to combine orders and customers, we would type:
```sql
SELECT *
FROM orders
JOIN customers
  ON orders.customer_id = customers.customer_id;
```
 Let’s break down this command:
  - The first line selects all columns from our combined table. If we only want to select certain columns, we can specify which ones we want.
  - The second line specifies the first table that we want to look in, orders
  - The third line uses JOIN to say that we want to combine information from orders with customers.
  - The fourth line tells us how to combine the two tables. We want to match orders table’s customer_id column with customers table’s customer_id column.

#### Inner Join (Join)
When we perform a simple JOIN (often called an inner join) our result only includes rows that match our ON condition.

Consider the following animation, which illustrates an inner join of two tables on table1.c2 = table2.c2:
![texto](https://content.codecademy.com/courses/learn-sql/multiple-tables/inner-join.gif)

La primera y la última fila tienen valores coincidentes de c2. Las filas del medio no coinciden. El resultado final tiene todos los valores de la primera y última fila, pero no incluye la fila del medio que no coincide. 
```sql
SELECT COUNT(*) FROM newspaper
JOIN online
ON newspaper.id = online.id;
```

### Left Joins

What if we want to combine two tables and keep some of the un-matched rows?

SQL lets us do this through a command called LEFT JOIN. A left join will keep all rows from the first table, regardless of whether there is a matching row in the second table.
![imagen](https://content.codecademy.com/courses/learn-sql/multiple-tables/left-join.gif)

The first and last rows have matching values of c2. The middle rows do not match. The final result will keep all rows of the first table but will omit the un-matched row from the second table.
```sql
SELECT *
FROM table1
LEFT JOIN table2
  ON table1.c2 = table2.c2;
 ```
 
    
 - The first line selects all columns from both tables.
 - The second line selects table1 (the “left” table).
 - The third line performs a LEFT JOIN on table2 (the “right” table).
 - The fourth line tells SQL how to perform the join (by looking for matching values in column c2).
 
 
Example
Suppose we want to know how many users subscribe to the print newspaper, but not to the online. 
```sql
Select * FROM newspaper
LEFT JOIN online
ON newspaper.id = online.id;
WHERE online.id IS NULL
```
### Cross JOIN
So far, we’ve focused on matching rows that have some information in common.

Sometimes, we just want to combine all rows of one table with all rows of another table.

For instance, if we had a table of shirts and a table of pants, we might want to know all the possible combinations to create different outfits.

```sql
SELECT shirts.shirt_color,
   pants.pants_color
FROM shirts
CROSS JOIN pants;
```

 - The first two lines select the columns shirt_color and pants_color.
 - The third line pulls data from the table shirts.
 - The fourth line performs a CROSS JOIN with pants.

Notice that cross joins don’t require an ON statement. You’re not really joining on any columns!

If we have 3 different shirts (white, grey, and olive) and 2 different pants (light denim and black), the results might look like this:
This clothing example is fun, but it’s not very practically useful.

A more common usage of CROSS JOIN is when we need to compare each row of a table to a list of values.

Excersise:
 This table contains two columns that we haven’t discussed yet:

 - start_month: the first month where the customer subscribed to the print newspaper (i.e., 2 for February)
 -  end_month: the final month where the customer subscribed to the print newspaper

Suppose we wanted to know how many users were subscribed during each month of the year. For each month (1, 2, 3) we would need to know if a user was subscribed. Follow the steps below to see how we can use a CROSS JOIN to solve this problem.
```sql
SELECT month, COUNT(*) 
FROM newspaper 
CROSS JOIN months
WHERE start_month <=month
AND end_month >=month
Group BY month;
```

### UNION

Sometimes we just want to stack one dataset on top of the other. Well, the UNION operator allows us to do that.
table1:
pokemon 	type
Bulbasaur 	Grass
Charmander 	Fire
Squirtle 	Water

table2:
pokemon 	type
Snorlax 	Normal

If we combine these two with UNION:
```sql
SELECT *
FROM table1
UNION
SELECT *
FROM table2;
```
The result would be:
pokemon 	type
Bulbasaur 	Grass
Charmander 	Fire
Squirtle 	Water
Snorlax 	Normal

SQL has strict rules for appending data:

   - Tables must have the same number of columns.
   - The columns must have the same data types in the same order as the first table.



















 




