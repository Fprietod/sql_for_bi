## Introduction to subqueries

At this point in our SQL journey we know we can query a database to retrieve desired results. However, what happens when we query a database but we really only need a subset of the results returned? How is this situation handled when the subset of data needed spans across multiple tables?

One option that may immediately come to mind could be the use of a join. However, in this lesson, we’ll explore the use something called a subquery that give us the same functionality as a join, but with much more readability.

### Subqueries

Subqueries

As the name suggests, a subquery is an internal query nested inside of an external query. They can be nested inside of SELECT, INSERT, UPDATE, or DELETE statements. Anytime a subquery is present, it gets executed before the external statement is run.

Subqueries are very similar to joins in terms of functionality; however, joins are more efficient and subqueries are typically more readable.

For example, if we had two tables listing students in two different clubs, book_club and art_club, we could find out which students are in both tables by using a join such as: 
```sql
SELECT id, first_name, last_name
FROM book_club
JOIN art_club
  ON book_club.id = art_club.id;
```
However, a subquery can be used to achieve the same result and is more readable: 
```sql
SELECT id, first_name, last_name
FROM book_club
WHERE id IN (
   SELECT id 
   FROM art_club);
```
In this statement, the subquery SELECT statement would be executed first, resulting in a list of student ids from the art_club table. Then, the outer query would run and select the student ids from book_club table which also appear in the subquery results.
Complete the subquery to find students taking both band and drama.
```sql
SELECT first_name, last_name
FROM band_students
WHERE id IN (
  SELECT id
  FROM drama_students
);
```
### INSERT, UPDATE AND DELETE
Now that we know what a subquery is and some syntax for using subqueries, let’s begin looking at some of the ways subqueries can be used.

Previously, we mentioned subqueries can be placed inside of SELECT, INSERT, UPDATE, or DELETE statements. Recall that subqueries are always executed prior to the external query being run.

In the same way that the external query selects from the internal query’s results, it is important to note that this same behavior takes place when the external query is an INSERT, UPDATE, or DELETE. Therefore, when a subquery is nested in a DELETE statement, the rows to be deleted will be among the results from the subquery. 
For example, suppose students are unable to take both history and statistics. If we wanted to delete the rows for statistics students who are also enrolled in history, we could execute a statement such as: 
```sql
DELETE FROM statistics_students
WHERE id in (
  SELECT id 
  FROM history_students);
 ```
 Delethe the students that are in drama and band and stay in 9 grade
 ```sql
 DELETE FROM drama_students
WHERE id IN (
  Select id
  FROM band_students
  where grade = 9
);
```

### Comparasion and Operators

Subqueries have the unique ability to take the place of expressions in SQL queries. As such, one way of using subqueries in SQL statements is with comparison operators.

We can use operators such as <, >, =, and != to compare the results of the external query to those of the inner query. 

For example, if Olivia decided to drop statistics and take history, we could find out how many history students are at or below her grade level by performing the following query:
```sql
SELECT * 
FROM history_students
WHERE grade <= (
  SELECT grade
  FROM statistics_students
  WHERE id = 1);
  ```
  ### In and Not In Clauses
  One of the more common ways to use subqueries is with the use of an IN or NOT IN clause. Recall that the subquery is always executed first followed by the external query.

When an IN clause is used, results retrieved from the external query must appear within the subquery results. Similarly, when a NOT IN clause is used, results retrieved from the external query must not appear within the subquery results.

For example, we could use the below query to find out which students are enrolled in statistics and history:
```sql
SELECT * 
FROM statistics_students
WHERE id 
IN (
  SELECT id
  FROM history_students);
  ```
 ### Exists and Not Exists
 In the previous exercise we discussed the use of IN and NOT IN clauses. We also have the option of EXISTS and NOT EXISTS clauses. While EXISTS/NOT EXISTS are similar to IN/NOT IN clauses, there are some key differences. Let’s explore those differences now.

Recall that when a subquery is included, the inner query runs before the external query. When the inner query is included using an IN or NOT IN clause, all rows meeting the inner query’s criteria are returned and then compared against the external query’s criteria. However, when the inner query is included using an EXISTS or NOT EXISTS clause, we are only checking for the presence of rows meeting the specified criteria, so the inner query only returns a true or false. 

Efficiency 

If we compare this functionality in terms of efficiency, EXISTS/NOT EXISTS are usually more efficient than IN/NOT IN clauses; this is because the IN/NOT IN clause has to return all rows meeting the specific criteria whereas the EXISTS/NOT EXISTS only needs to find the presence of one row to determine if a true or false value needs to be returned. 
Excersise
Write a query to find out which grade levels are represented in both band and drama.
```sql
Select grade from band_students
where EXISTS(
  Select grade
  from drama_students
);
```
