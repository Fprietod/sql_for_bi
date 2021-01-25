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
