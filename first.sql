
   // Writing basic queries
    //Calculating aggregates
     // Combining data from multiple tables
    // Determining web traffic attribution
    // Creating usage funnels
    // Analyzing user churn

/*  Spreadsheets, like Microsoft Excel and Google Sheets, allow you to view and manipulate data directly: with selecting, filtering, sorting, etc. By applying a number of these operations you can obtain the subset of data you are seeking.

SQL (pronounced “S-Q-L” or “sequel”) allows you to write queries which define the subset of data you are seeking.
*/  

/* Not all users who browse on the website will find something that they like enough to checkout, and not all users who begin the checkout process will finish entering their payment information to make a purchase.

This type of multi-step process where some users leave at each step is called a funnel.
*/

/*
Catherine is going to combine data from three different tables:

    browse - gives the timestamps of users who visited different item description pages
    checkout - gives the timestamps of users who visited the checkout page
    purchase - gives the timestamps of when users complete their purchase

Using SQL, she finds that 24% of all users who browse move on to checkout. 89% of those who reach checkout purchase.
*/
 SELECT ROUND(
   100.0 * COUNT(DISTINCT c.user_id) /
   COUNT(DISTINCT b.user_id)
 ) AS browse_to_checkout_percent,
 ROUND(
   100.0 * COUNT(DISTINCT p.user_id) /
   COUNT(DISTINCT c.user_id)
 ) AS checkout_to_purchase_percent
 FROM browse b
 LEFT JOIN checkout c
 	ON b.user_id = c.user_id
 LEFT JOIN purchase p
 	ON c.user_id = p.user_id;
