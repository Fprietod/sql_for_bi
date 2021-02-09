
/*Now that we have a good understanding of how to fetch data from different rows, let’s explore how we can use window functions to order and rank our results.

The most straight-forward way to order our results is by using the ROW_NUMBER function which adds sequential integer number to each row.

Adding a ROW_NUMBER to each row can be useful for seeing where in your result set the row falls.
*/
SELECT 
   ROW_NUMBER() OVER (
      ORDER BY streams_millions
   ) AS 'row_num', 
   artist, 
   week,
   streams_millions
FROM
   streams;
   /*
   ORDER BY returns numeric values in ascending order (lowest to highest) by default, so row_num = 1 would be our lowest value.
   */
  
  /*Modify our query to return the results with row_num = 1 being the most streams. */
  SELECT 
   ROW_NUMBER() OVER (
      ORDER BY streams_millions DESC
   ) AS 'row_num', 
   artist, 
   week,
   streams_millions
FROM
   streams;
