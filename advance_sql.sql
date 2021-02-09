
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
/*
Utilizing PARTITION BY allowed us to find the total change in followers for each user up to the current month and display it next to the current month.
*/
SELECT username, month,
change_in_followers,
    SUM(change_in_followers) OVER (
      PARTITION BY username
      ORDER BY month
    ) 'running_total_followers_change',
    
    AVG(change_in_followers) OVER (
      PARTITION BY username
      ORDER BY month
    )'running_avg_followers_change'
FROM social_media;


/*
FIRST_VALUE and LAST_VALUE

In the past, when we wanted to get the first or last value of a query, we might use the LIMIT clause, probably in conjunction with ORDER BY, which would return one result showing us the first or last value from our dataset.

With window functions, we can return our first or last values alongside our other data by using the FIRST_VALUE() or LAST_VALUE() functions. 

They work exactly as you would imagine:

    FIRST_VALUE() returns the first value in an ordered set of values.
    LAST_VALUE() returns the last value in an ordered set of values.

Let’s break down a query that is fetching the FIRST_VALUE() from our social media dataset
*/ 
/*
Let’s break down a query that is fetching the FIRST_VALUE() from our social media dataset:
*/
SELECT
   username,
   posts,
   FIRST_VALUE (posts) OVER (
      PARTITION BY username 
      ORDER BY posts
   ) fewest_posts
FROM
   social_media;
   
 /*
 This query should look familiar overall as it follows the standard window function format, however, we are using FIRST_VALUE now for posts. This means our window function will pull the first value from the posts column.
 OVER (PARTITION BY username ORDER BY posts) fewest_posts: here we can see that posts is going to be pulled based on username due to the PARTITION BY. We are naming this column fewest_posts because of the ORDER BY which defaults to ascending order.
 */
 /*
 The result is showing us each of the usernames from the table alongside how many posts they posted each month. Our fewest_posts column is showing the lowest number of posts that user made for any month.
 */
 /*
 If FIRST_VALUE is returning the fewest posts, then LAST_VALUE should return the most posts for each user.

Update the query now to use LAST_VALUE instead of FIRST_VALUE. 
*/
SELECT username,
   posts,
   LAST_VALUE (posts) OVER (
      PARTITION BY username 
      ORDER BY posts
   ) AS 'fewest_posts'
FROM social_media;
/*
Here we can see it is pulling the last value for each row. This is not showing us the last value for any user but instead the current row (which would be the last value!) 
*/
/*
We saw that LAST_VALUE didn’t work as we expected. This is because each row in our results set is the last row at the time it is outputted.

In order to get LAST_VALUE to show us the most posts for a user, we need to specify a frame for our window function.
*/
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
    
    /*
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING specifies the frame for our window function as the current partition and thus returns the highest number of posts in one month for each user.
    */



