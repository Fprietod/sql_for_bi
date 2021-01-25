/*
As the name suggests, a subquery is an internal query nested inside of an external query. They can be nested inside of SELECT, INSERT, UPDATE, or DELETE statements. Anytime a subquery is present, it gets executed before the external statement is run.

Subqueries are very similar to joins in terms of functionality; however, joins are more efficient and subqueries are typically more readable. 

For example, if we had two tables listing students in two different clubs, book_club and art_club, we could find out which students are in both tables by using a join such as: 
*/
SELECT id, first_name, last_name
FROM book_club
JOIN art_club
  ON book_club.id = art_club.id;
  
 /*However, a subquery can be used to achieve the same result and is more readable: 
 */
 SELECT id, first_name, last_name
FROM book_club
WHERE id IN (
   SELECT id 
   FROM art_club);
   /*In this statement, the subquery SELECT statement would be executed first, resulting in a list of student ids from the art_club table. Then, the outer query would run and select the student ids from book_club table which also appear in the subquery results.
   */
   SELECT first_name, last_name
FROM band_students
WHERE id IN(
  SELECT id
  FROM drama_students
);/*
Inserts, Updates, and Deletes

Now that we know what a subquery is and some syntax for using subqueries, let’s begin looking at some of the ways subqueries can be used.

Previously, we mentioned subqueries can be placed inside of SELECT, INSERT, UPDATE, or DELETE statements. Recall that subqueries are always executed prior to the external query being run. 
In the same way that the external query selects from the internal query’s results, it is important to note that this same behavior takes place when the external query is an INSERT, UPDATE, or DELETE. Therefore, when a subquery is nested in a DELETE statement, the rows to be deleted will be among the results from the subquery. 
For example, suppose students are unable to take both history and statistics. If we wanted to delete the rows for statistics students who are also enrolled in history, we could execute a statement such as: 
*/
Select grade
FROM band_students
WHERE EXISTS (
  SELECT grade
  FROM drama_students
);
DELETE FROM statistics_students
WHERE id in (
  SELECT id 
  FROM history_students);
  
 /*
 Comparison Operators

Subqueries have the unique ability to take the place of expressions in SQL queries. As such, one way of using subqueries in SQL statements is with comparison operators.

We can use operators such as <, >, =, and != to compare the results of the external query to those of the inner query. 

For example, if Olivia decided to drop statistics and take history, we could find out how many history students are at or below her grade level by performing the following query:
Emlynne Torritti (id 20), has decided to drop band and join drama. She wants to know how many other students in her grade level are already enrolled in dram
*/
SELECT * 
FROM drama_students
WHERE grade = (
   SELECT grade
   FROM band_students
   WHERE id = 20);
   /* 
   In and Not In Clauses

One of the more common ways to use subqueries is with the use of an IN or NOT IN clause. Recall that the subquery is always executed first followed by the external query.

When an IN clause is used, results retrieved from the external query must appear within the subquery results. Similarly, when a NOT IN clause is used, results retrieved from the external query must not appear within the subquery results. 

For example, we could use the below query to find out which students are enrolled in statistics and history:
*/
SELECT * 
FROM statistics_students
WHERE id 
IN (
  SELECT id
  FROM history_students);
 
 /*
 Write a query that gives the first and last names of students enrolled in band but not in drama.
 */
 SELECT first_name, last_name
FROM band_students
WHERE id NOT IN (
   SELECT id
   FROM drama_students);
 /*
 Exists and Not Exists

In the previous exercise we discussed the use of IN and NOT IN clauses. We also have the option of EXISTS and NOT EXISTS clauses. While EXISTS/NOT EXISTS are similar to IN/NOT IN clauses, there are some key differences. Let’s explore those differences now.

If we compare this functionality in terms of efficiency, EXISTS/NOT EXISTS are usually more efficient than IN/NOT IN clauses; this is because the IN/NOT IN clause has to return all rows meeting the specific criteria whereas the EXISTS/NOT EXISTS only needs to find the presence of one row to determine if a true or false value needs to be returned.
Write a query to find out which grade levels are represented in both band and drama.
/*

