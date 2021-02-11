
/*
To practice what you’ve learned about window functions, you are going to use climate data from each state in the United States. A labeled map of the United States can be found here.

These data will show the average annual temperature for each state – this is the average temperature of every day in all parts of the state for that year.

For this project, you will be working with one table:

    state_climate

*/
/*
Write a query that returns the state, year, tempf or tempc, and running_avg_temp (in either Celsius or Fahrenheit) for each state.

(The running_avg_temp should use a window function.)
*/

SELECT state, year, tempf, tempc,
AVG(tempc) OVER (
  PARTITION BY state
  ORDER BY year
 
) AS 'running_avg_temp'
FROM state_climate
LIMIT 10;

/*To find the lowest temperature for each state, you need to use the FIRST_VALUE function with the temperature (tempf or tempc as the parameter). Then you need to PARTITION BY the state and ORDER BY the temperature.
*/
SELECT state, year, tempf, tempc,
FIRST_VALUE(tempc) OVER (
  PARTITION BY state
  ORDER BY tempc
 
) lowest_temperature
FROM state_climate

/*
Let’s see how temperature has changed each year in each state.
*/
SELECT state, year, tempf, tempc,
LAST_VALUE(tempc) OVER (
  PARTITION BY state
  ORDER BY tempc
   RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
 
 
) highest_temp
FROM state_climate
/*

Write a query to select the same columns but now you should write a window function that returns the change_in_temp from the previous year (no null values should be returned).
*/
SELECT state, year, tempf, tempc,
tempf - LAG(tempf,1,tempf) OVER(
  PARTITION BY state
  ORDER BY year
)change_in_temp
FROM state_climate
ORDER BY change_in_temp ASC;
/*
Write a query to return a rank of the coldest temperatures on record (coldest_rank) along with year, state, and tempf or tempc. Are the coldest ranked years recent or historic? The coldest years should be from any state or year.
*/
SELECT 
RANK() OVER (
  ORDER BY tempc
) AS 'coldest_rank',
year,
state,
tempc
FROM state_climate;

/*
Modify your coldest_rank query to now instead return the warmest_rank for each state, meaning your query should return the warmest temp/year for each state. Again, are the warmest temperatures more recent or historic for each state?
*/
SELECT 
RANK() OVER (
  PARTITION BY state
  ORDER BY tempc DESC
) AS 'coldest_rank',
year,
state,
tempc
FROM state_climate;
/*
Let’s now write a query that will return the average yearly temperatures in quartiles instead of in rankings for each state.

Your query should return quartile, year, state and tempf or tempc. The top quartile should be the coldest years. 
*/
SELECT
NTILE(4) OVER(
  PARTITION BY state
  ORDER BY tempf DESC
 
) AS 'quartile',
year,
state,
tempf
FROM state_climate;
/*
Lastly, we will write a query that will return the average yearly temperatures in quintiles (5).

Your query should return quintile, year, state and tempf or tempc. The top quintile should be the coldest years overall, not by state. 
*/
SELECT
NTILE(5) OVER(
 
  ORDER BY tempf DESC
 
) AS 'quartile',
year,
state,
tempf
FROM state_climate;
