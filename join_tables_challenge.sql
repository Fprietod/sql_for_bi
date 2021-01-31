
SELECT premium_users.user_id,
   plans.description
FROM premium_users
JOIN plans
  ON plans.id = premium_users.membership_plan_id;
  
  /*played by each user!

The column song_id in plays should match the column id in songs.

Join plays to songs and select:

    user_id from plays
    play_date from plays
    title from songs
*/
SELECT plays.user_id, plays.play_date, songs.title FROM
 songs
 JOIN plays
 ON plays.song_id = songs.id;
 
 /*
 Use a LEFT JOIN to combine users and premium_users and select id from users.

The column id in users should match the column user_id in premium_users.

Use a WHERE clause to limit the results to users where premium_users.user_id IS NULL. This will remove premium users and leave you with only free users.
*/
 SELECT users.id FROM users
 LEFT JOIN premium_users
 ON users.id = premium_users.user_id
 WHERE premium_users.user_id IS NULL;
 -- Five query
 /*We’ve used a WITH statement to create two temporary tables:

    january contains all song plays from January 2017
    february contains all song plays from February 201
    */

WITH january AS (
  SELECT *
  FROM plays
  WHERE strftime("%m", play_date) = '01'
),
february AS (
  SELECT *
  FROM plays
  WHERE strftime("%m", play_date) = '02'

)

-- Query

SELECT january.user_id
FROM january
LEFT JOIN february
ON january.user_id = february.user_id
WHERE february.user_id IS NULL;

-- Next query
/*
For each month in months, we want to know if each user in premium_users was active or canceled. Cross join months and premium_users and select:

    user_id from premium_users
    purchase_date from premium_users
    cancel_date from premium_users
    months from months
*/
SELECT premium_users.user_id, premium_users.purchase_date, premium_users.cancel_date, months.months FROM months
 CROSS JOIN premium_users;
-- Code challenge 6
SELECT premium_users.user_id,
  months.months,
  CASE
    WHEN (
      premium_users.purchase_date <=
             months.months
      )
      AND
      (
        (premium_users.cancel_date >=
                months.months)
        OR
        premium_users.cancel_date IS NULL
      )
    THEN 'active'
    ELSE 'not_active'
  END as status

FROM premium_users
CROSS JOIN months;
/* This will tell us if a particular user is 'active' or 'not_active' each month.
*/
 
 
/*
Combine songs and bonus_songs using UNION and select all columns from the result.

Since the songs table is so big, just look at a sample by LIMITing the results to 10 rows.
*/
SELECT * 
FROM songs 
UNION 
SELECT *
FROM bonus_songs
LIMIT 10;
-- Query final
/*
The following query will give us the number of times that each song was played:
SELECT song_id,
   COUNT(*) AS 'times_played'
FROM plays
GROUP BY song_id;
Use a WITH statement to alias this code as play_count.

Join play_count with songs and select (in this order):

    songs table’s title column
    songs table’s artist column
    play_count‘s times_played column

Remember that play_count.song_id will match songs.id.
*/
WITH play_count AS (
  SELECT song_id,
     COUNT(*) as times_played
  FROM plays
  GROUP BY song_id)
SELECT songs.title,
	songs.artist,
  play_count.times_played
FROM play_count
JOIN songs
	ON play_count.song_id = songs.id;

