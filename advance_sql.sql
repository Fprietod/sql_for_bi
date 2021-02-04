
/*
Introduction to Window Functions

So far we’ve learned how to retrieve information from tables and perform calculations on them. But we’ve seen that GROUP BY and SUM reduce the number of rows in your query results because they are combining or grouping rows.

Window functions, on the other hand, allow you to maintain the values of your original table while displaying grouped or summative information alongside in another column. This is why many Data Scientists and Data Engineers love to use window functions for complex data analysis.

In this lesson, you will build upon the knowledge you’ve gained about aggregate functions and other clauses in order to write window functions.

Let’s start by looking at data from some of the most followed accounts on Instagram.
*/
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
   /*
   SUM is only able to return one row of data that represents the sum of all months. running_total is able to show you what the total is after each month.
   */
   
   -- Explication of the query
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
   
   -- SELECT month, change_in_followers: Same as usual, selecting the columns.
   -- SUM(change_in_followers): Here is our aggregate function to find the SUM of our chosen column.
   -- OVER: This is the clause that designates SUM as a window function.
   -- ORDER BY month: Here we declare what we would like our window function to do.
   -- This window function is taking the sum of money raised each month.
   -- So for each month, the window function adds the current month’s change_in_followers to our running total.
   --Then name the running total column 'running_total'.
   --And lastly, this is all coming from table social_media where the username is instagram.
   
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
   /* Here we can see how the sum, average and count of followers is changing each month rather than just the total sum, average or count.*/
   
  /*
  PARTITION BY

In our last query, we were able to find the running total, average and count of only Instagram’s followers using window functions. But what about the other accounts in our social media table? What if we wanted to compare all of our users?

This is where we can use another feature of window functions: PARTITION BY.

PARTITION BY is a subclause of the OVER clause and divides a query’s result set into parts. It’s very similar to GROUP BY except it does not reduce the number of rows returned.

While using GROUP BY only allows one row to be returned for each group, PARTITION BY allows you to see all of the resultant rows.
*/
SELECT 
   username,
   month,
   SUM(change_in_followers) AS 'total_change_in_followers'
FROM
   social_media
GROUP BY 
   username, month;
   /*
   No, this is no longer showing you a sum because each user has 8 different months of data, therefore 8 different groups.
   */
   SELECT username, month,
change_in_followers,
    SUM(change_in_followers) OVER (
      PARTITION BY username
      ORDER BY month
    ) 'running_total_followers_change'
FROM social_media;
/*
We can see the running total for all of our users. We can also see the change_in_followers next to our running total.
*/
