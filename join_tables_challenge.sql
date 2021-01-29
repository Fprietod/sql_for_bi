
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
