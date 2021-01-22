/* Max and min
MAX() takes the name of a column as an argument and returns the largest value in that column. Here, we returned the largest value in the downloads column.

MIN() works the same way but it does the exact opposite; it returns the smallest value.
*/
SELECT MAX(downloads)
FROM fake_apps;

/*
Average

SQL uses the AVG() function to quickly calculate the average value of a particular column.

The statement below returns the average number of downloads for an app in our database:

The AVG() function works by taking a column name as an argument and returns the average value for that column.
*/ 
SELECT AVG(downloads)
FROM fake_apps;

/*
Round

By default, SQL tries to be as precise as possible without rounding. We can make the result table easier to read using the ROUND() function.

ROUND() function takes two arguments inside the parenthesis:

    a column name
    an integer

It rounds the values in the column to the number of decimal places specified by the integer. 
*/
SELECT ROUND(price, 0)
FROM fake_apps;
/*
Here, we pass the column price and integer 0 as arguments. SQL rounds the values in the column to 0 decimal places in the output.
*/
SELECT ROUND(AVG(price),2) as resultado
FROM fake_apps;

/*
Group By I

Oftentimes, we will want to calculate an aggregate for data with certain characteristics. 

For instance, we might want to know the mean IMDb ratings for all movies each year. We could calculate each number by a series of queries with different WHERE statements, like so:

*/
SELECT AVG(imdb_rating)
FROM movies
WHERE year = 1999;
 
SELECT AVG(imdb_rating)
FROM movies
WHERE year = 2000;
 
SELECT AVG(imdb_rating)
FROM movies
WHERE year = 2001;

/* We can use Group by for this */ 
SELECT year,
   AVG(imdb_rating)
FROM movies
GROUP BY year
ORDER BY year;
/*
GROUP BY is a clause in SQL that is used with aggregate functions. It is used in collaboration with the SELECT statement to arrange identical data into groups.

The GROUP BY statement comes after any WHERE statements, but before ORDER BY or LIMIT.
*/
SELECT price, COUNT(*) 
FROM fake_apps
GROUP BY price;

/*
Group By II

Sometimes, we want to GROUP BY a calculation done on a column.

For instance, we might want to know how many movies have IMDb ratings that round to 1, 2, 3, 4, 5. We could do this using the following syntax:
*/
SELECT ROUND(imdb_rating),
   COUNT(name)
FROM movies
GROUP BY ROUND(imdb_rating)
ORDER BY ROUND(imdb_rating);
/*
However, this query may be time-consuming to write and more prone to error.

SQL lets us use column reference(s) in our GROUP BY that will make our lives easier.

    1 is the first column selected
    2 is the second column selected
    3 is the third column selected

and so on.

The following query is equivalent to the one above:
*/
SELECT ROUND(imdb_rating),
   COUNT(name)
FROM movies
GROUP BY 1
ORDER BY 1;
/*Here, the 1 refers to the first column in our SELECT statement, ROUND(imdb_rating). */
SELECT category, 
   price,
   AVG(downloads)
FROM fake_apps
GROUP BY 1,2;
/*
These numbers represent the selected columns:

    1 refers to category.
    2 refers to price.
    3 refers to AVG(downloads)
*/
