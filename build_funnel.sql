/*What is a Funnel?

In the world of marketing analysis, “funnel” is a word you will hear time and time again.

A funnel is a marketing model which illustrates the theoretical customer journey towards the purchase of a product or service. Oftentimes, we want to track how many users complete a series of steps and know which steps have the most number of users giving up. 

We will be using a table called survey_responses with the following columns:

    question_text - the survey question
    user_id - the user identifier
    response - the user answer

Count the number of distinct user_id who answered each question_text.

You can do this by using a simple GROUP BY command.
*/
 SELECT question_text,
 COUNT(DISTINCT user_id)
 FROM survey_responses
 GROUP BY 1;
