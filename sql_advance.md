# Windows Function

Window functions, on the other hand, allow you to maintain the values of your original table while displaying grouped or summative information alongside in another column. This is why many Data Scientists and Data Engineers love to use window functions for complex data analysis.
```sql
SELECT 
   month,
   change_in_followers,
   SUM(change_in_followers) OVER (
      ORDER BY month
   ) AS 'running_total'
FROM
   social_media
WHERE
   username = 'instagram';
   ```
 SUM is only able to return one row of data that represents the sum of all months. running_total is able to show you what the total is after each month.
 
 
