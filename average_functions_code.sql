
/*
What are the most popular first names on Codeflix?

Use COUNT(), GROUP BY, and ORDER BY to create a list of first names and occurrences within the users table.

Order the data so that the most popular names are displayed first.
*/
SELECT first_name, COUNT(*) AS 'count'
FROM users
GROUP BY first_name
ORDER BY 2 DESC;
--
SELECT ROUND(watch_duration_in_minutes,0) AS
duration ,
COUNT(*) AS count
FROM watch_history
GROUP BY duration
ORDER BY duration ASC;
-- Tercer query
SELECT user_id, SUM(amount) AS amount
FROM payments
WHERE status = 'paid'SELECT pay_date, SUM(amount) as amount
FROM payments
WHERE status = 'paid'
GROUP BY pay_date
ORDER BY amount DESC;
GROUP BY user_id
ORDER BY amount DESC;
-- Quinto Quert
SELECT user_id, SUM(watch_duration_in_minutes) AS duracion_total
FROM watch_history
GROUP BY user_id
HAVING duracion_total > 400;
-- Sexto query
/*Which days in this period did Codeflix collect the most money?*/
-- Sexto query
SELECT MAX(watch_duration_in_minutes) as maximo,
MIN(watch_duration_in_minutes) as minimo
FROM watch_history;
-- Proyecto

