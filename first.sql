
   /* Writing basic queries
    Calculating aggregates
      Combining data from multiple tables
     Determining web traffic attribution
     Creating usage funnels
     Analyzing user churn
     */

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
   
   /* Catherine wants to know how many visits come from each utm_source.  */
   SELECT utm_source,
 	COUNT(DISTINCT user_id) AS num_users
FROM page_visits
GROUP BY 1
ORDER BY 2 DESC;

/* What is a Relational Database Management System (RDBMS)?

A relational database management system (RDBMS) is a program that allows you to create, update, and administer a relational database. Most relational database management systems use the SQL language to access the database. 
*/

/*
A relational database is a database that organizes information into one or more tables. Here, the relational database contains one table.

A table is a collection of data organized into rows and columns. Tables are sometimes referred to as relations. Here the table is celebs.

A column is a set of data values of a particular type. Here, id, name, and age are the columns. 

/* 
 Let’s break down the components of a statement:

    CREATE TABLE is a clause. Clauses perform specific tasks in SQL. By convention, clauses are written in capital letters. Clauses can also be referred to as commands.
    table_name refers to the name of the table that the command is applied to.
    (column_1 data_type, column_2 data_type, column_3 data_type) is a parameter. A parameter is a list of columns, data types, or values that are passed to a clause as an argument. Here, the parameter is a list of column names and the associated data type.

The structure of SQL statements vary. The number of lines used does not matter. A statement can be written all on one line, or split up across multiple lines if it makes it easier to read. In this course, you will become familiar with the structure of common statements.

*/
