/*

Distinct

When we are examining data in a table, it can be helpful to know what distinct values exist in a particular column.
DISTINCT is used to return unique values in the output. It filters out all duplicate values in the specified column(s).


*/

SELECT DISTINCT name From movies

/*

How does it work?

    WHERE clause filters the result set to only include rows where the following condition is true.

    imdb_rating > 8 is the condition. Here, only rows with a value greater than 8 in the imdb_rating column will be returned.

The > is an operator. Operators create a condition that can be evaluated as either true or false.

Comparison operators used with the WHERE clause are:

    = equal to
    != not equal to
    > greater than
    < less than
    >= greater than or equal to
    <= less than or equal to

There are also some special operators that we will learn more about in the upcoming exercises.


*/

/*
How could we select all movies that start with ‘Se’ and end with ‘en’ and have exactly one character in the middle?
SELECT * 
FROM movies
WHERE name LIKE 'Se_en';

    LIKE is a special operator used with the WHERE clause to search for a specific pattern in a column.

    name LIKE 'Se_en' is a condition evaluating the name column for a specific pattern.

    Se_en represents a pattern with a wildcard character.

The _ means you can substitute any individual character here without breaking the pattern. The names Seven and Se7en both match this pattern.


% is a wildcard character that matches zero or more missing letters in the pattern. For example:

    A% matches all movies with names that begin with letter ‘A’
    %a matches all movies that end with ‘a’

We can also use % both before and after a pattern:

*/

SELECT * 
FROM movies
WHERE name LIKE 'Se_en';

SELECT * 
FROM movies 
WHERE name LIKE '%man%';

/*
Is Null

By this point of the lesson, you might have noticed that there are a few missing values in the movies table. More often than not, the data you encounter will have missing values.

Unknown values are indicated by NULL.

It is not possible to test for NULL values with comparison operators, such as = and !=.

Instead, we will have to use these operators:

    IS NULL
    IS NOT NULL
*/
To filter for all movies with an IMDb rating:
SELECT name
FROM movies 
WHERE imdb_rating IS NOT NULL;


/*
Sometimes we want to combine multiple conditions in a WHERE clause to make the result set more specific and useful.

One way of doing this is to use the AND operator. Here, we use the AND operator to only return 90’s romance movies.
*/
SELECT * 
FROM movies
WHERE year BETWEEN 1990 AND 1999
   AND genre = 'romance';
   
   /*
   With AND, both conditions must be true for the row to be included in the result.
   /*
   
   
   */ OR
   Similar to AND, the OR operator can also be used to combine multiple conditions in WHERE, but there is a fundamental difference:

    AND operator displays a row if all the conditions are true.
    OR operator displays a row if any condition is true.
    With OR, if any of the conditions are true, then the row is added to the result.
*/
SELECT *
FROM movies
WHERE genre = 'romance'
   OR genre = 'comedy';

/*
Order By

That’s it with WHERE and its operators. Moving on!

It is often useful to list the data in our result set in a particular order.

We can sort the results using ORDER BY, either alphabetically or numerically. Sorting the results often makes the data more useful and easier to analyze.

For example, if we want to sort everything by the movie’s title from A through Z:
*/
SELECT *
FROM movies
ORDER BY name;
/*


    ORDER BY is a clause that indicates you want to sort the result set by a particular column.

    name is the specified column.

Sometimes we want to sort things in a decreasing order. For example, if we want to select all of the well-received movies, sorted from highest to lowest by their year:
*/
SELECT *
FROM movies
WHERE imdb_rating > 8
ORDER BY year DESC;
/*


    DESC is a keyword used in ORDER BY to sort the results in descending order (high to low or Z-A).

    ASC is a keyword used in ORDER BY to sort the results in ascending order (low to high or A-Z).

The column that we ORDER BY doesn’t even have to be one of the columns that we’re displaying.
*/ 
SELECT name, year, imdb_rating
FROM movies
ORDER BY  imdb_rating DESC;

/*
Case

A CASE statement allows us to create different outputs (usually in the SELECT statement). It is SQL’s way of handling if-then logic.

Suppose we want to condense the ratings in movies to three levels:

    If the rating is above 8, then it is Fantastic.
    If the rating is above 6, then it is Poorly Received.
    Else, Avoid at All Costs.
*/
SELECT name,
 CASE
  WHEN imdb_rating > 8 THEN 'Fantastic'
  WHEN imdb_rating > 6 THEN 'Poorly Received'
  ELSE 'Avoid at All Costs'
 END
FROM movies;
/*

    Each WHEN tests a condition and the following THEN gives us the string if the condition is true.
    The ELSE gives us the string if all the above conditions are false.
    The CASE statement must end with END.

In the result, you have to scroll right because the column name is very long. To shorten it, we can rename the column to ‘Review’ using AS:
*/

SELECT name,
 CASE
  WHEN imdb_rating > 8 THEN 'Fantastic'
  WHEN imdb_rating > 6 THEN 'Poorly Received'
  ELSE 'Avoid at All Costs'
 END AS 'Review'
FROM movies;



