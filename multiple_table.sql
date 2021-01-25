
/*Combining Tables with SQL

Combining tables manually is time-consuming. Luckily, SQL gives us an easy sequence for this: it’s called a JOIN.

If we want to combine orders and customers, we would type:
*/
SELECT *
FROM orders
JOIN customers
  ON orders.customer_id = customers.customer_id;
 
 /*
 Let’s break down this command:

    The first line selects all columns from our combined table. If we only want to select certain columns, we can specify which ones we want.
    The second line specifies the first table that we want to look in, orders
    The third line uses JOIN to say that we want to combine information from orders with customers.
    The fourth line tells us how to combine the two tables. We want to match orders table’s customer_id column with customers table’s customer_id column.
*/
SELECT *
FROM orders
JOIN subscriptions
	ON orders.subscription_id = subscriptions.subscription_id;

  -- Second query 
  SELECT * 
  FROM orders
  JOIN subscriptions
  ON orders.subscription_id = subscriptions.subscription_id
  WHERE description = 'Fashion Magazine';
  
  /*
  Inner Joins

Let’s revisit how we joined orders and customers. For every possible value of customer_id in orders, there was a corresponding row of customers with the same customer_id.

What if that wasn’t true?

For instance, imagine that our customers table was out of date, and was missing any information on customer 11. If that customer had an order in orders, what would happen when we joined the tables?
When we perform a simple JOIN (often called an inner join) our result only includes rows that match our ON condition.
The first and last rows have matching values of c2. The middle rows do not match. The final result has all values from the first and last rows but does not include the non-matching middle row.
*/
SELECT COUNT(*) FROM newspaper
JOIN online
ON newspaper.id = online.id;
/*
Left Joins

What if we want to combine two tables and keep some of the un-matched rows?

SQL lets us do this through a command called LEFT JOIN. A left join will keep all rows from the first table, regardless of whether there is a matching row in the second table.
The first and last rows have matching values of c2. The middle rows do not match. The final result will keep all rows of the first table but will omit the un-matched row from the second table.

This animation represents a table operation produced by the following command:
*/
SELECT *
FROM table1
LEFT JOIN table2
  ON table1.c2 = table2.c2;
  /*
  
    The first line selects all columns from both tables.
    The second line selects table1 (the “left” table).
    The third line performs a LEFT JOIN on table2 (the “right” table).
    The fourth line tells SQL how to perform the join (by looking for matching values in column c2).
*/
-- First query
SELECT *
FROM newspaper
LEFT JOIN online
	ON newspaper.id = online.id;
  
-- Second query
SELECT *
FROM newspaper
LEFT JOIN online
	ON newspaper.id = online.id
WHERE online.id IS NULL;
/* This will select rows where there was no corresponding row from the online table.
*/

/*
Cross Join

So far, we’ve focused on matching rows that have some information in common.

Sometimes, we just want to combine all rows of one table with all rows of another table.

For instance, if we had a table of shirts and a table of pants, we might want to know all the possible combinations to create different outfits.
*/
SELECT shirts.shirt_color,
   pants.pants_color
FROM shirts
CROSS JOIN pants;

/*

    The first two lines select the columns shirt_color and pants_color.
    The third line pulls data from the table shirts.
    The fourth line performs a CROSS JOIN with pants.
*/
/*
Let’s return to our newspaper subscriptions. This table contains two columns that we haven’t discussed yet:

    start_month: the first month where the customer subscribed to the print newspaper (i.e., 2 for February)
    end_month: the final month where the customer subscribed to the print newspaper

Suppose we wanted to know how many users were subscribed during each month of the year. For each month (1, 2, 3) we would need to know if a user was subscribed. Follow the steps below to see how we can use a CROSS JOIN to solve this problem.
*/
SELECT month, 
  COUNT(*)
FROM newspaper
CROSS JOIN months
WHERE start_month <= month 
  AND end_month >= month
GROUP BY month;

/*Union

Sometimes we just want to stack one dataset on top of the other. Well, the UNION operator allows us to do that.

Suppose we have two tables and they have the same columns.
*/
SELECT *
FROM table1
UNION
SELECT *
FROM table2;
/*SQL has strict rules for appending data:

    Tables must have the same number of columns.
    The columns must have the same data types in the same order as the first table.
*/
/*
With

Often times, we want to combine two tables, but one of the tables is the result of another calculation.

Let’s return to our magazine order example. Our marketing department might want to know a bit more about our customers. For instance, they might want to know how many magazines each customer subscribes to. We can easily calculate this using our orders table:
*/
SELECT customer_id,
   COUNT(subscription_id) AS 'subscriptions'
FROM orders
GROUP BY customer_id;
/*
This query is good, but a customer_id isn’t terribly useful for our marketing department, they probably want to know the customer’s name.

We want to be able to join the results of this query with our customers table, which will tell us the name of each customer. We can do this by using a WITH clause.
*/
WITH previous_results AS (
   SELECT ...
   ...
   ...
   ...
)
SELECT *
FROM previous_results
JOIN customers
  ON _____ = _____;
  /*
  
    The WITH statement allows us to perform a separate query (such as aggregating customer’s subscriptions)
    previous_results is the alias that we will use to reference any columns from the query inside of the WITH clause
    We can then go on to do whatever we want with this temporary table (such as join the temporary table with another table)

Essentially, we are putting a whole first query inside the parentheses () and giving it a name. After that, we can use this name as if it’s a table and write a new query using the first query.
*/
WITH previous_query AS(
  SELECT customer_id,
   COUNT(subscription_id) AS 'subscriptions'
FROM orders
GROUP BY customer_id
)
SELECT customers.customer_name, previous_query.subscriptions FROM previous_query
JOIN customers
ON previous_query.customer_id = customers.customer_id;
/* Do not include ; inside of the () of your WITH statement.
*/
