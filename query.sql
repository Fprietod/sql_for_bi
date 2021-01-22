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
/*

SELECT * 
FROM movies
WHERE name LIKE 'Se_en';
