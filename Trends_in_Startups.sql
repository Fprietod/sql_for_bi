/*To get you started with your research, your boss emailed you a project.sqlite file that contains a table called startups. It is a portfolio of some of the biggest names in the industry.

Write queries with aggregate functions to retrieve some interesting insights about these companies.*/
--SELECT COUNT(name) FROM startups;
--SELECT SUM(valuation) FROM startups;
--SELECT MAX(raised) FROM startups
--WHERE stage = 'Seed';
--SELECT MIN(founded) FROM startups;
SELECT category, ROUND(AVG(valuation),2)
FROM startups
GROUP BY category;

SELECT category, COUNT(*) FROM startups
GROUP BY category
HAVING COUNT(*) > 3
ORDER BY 2 DESC;

/*What is the average size of a startup in each location?*/


SELECT location, AVG(employees)
FROM startups
GROUP BY location;
-------------------------------------------------
/*What is the average size of a startup in each location, with average sizes above 500?*/
SELECT location, AVG(employees)
FROM startups
GROUP BY location
HAVING AVG(employees) > 500;
