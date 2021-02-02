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
 /*
 The Product team at Mattresses and More has created a new design for the pop-ups that they believe will lead more users to complete the workflow.

They’ve set up an A/B test where:

    50% of users view the original control version of the pop-ups
    50% of users view the new variant version of the pop-ups
Eventually, we’ll want to answer the question:

How is the funnel different between the two groups?

We will be using a table called onboarding_modals with the following columns:

    user_id - the user identifier
    modal_text - the modal step
    user_action - the user response (Close Modal or Continue)
    ab_group - the version (control or variant)


Using GROUP BY, count the number of distinct user_id‘s for each value of modal_text. This will tell us the number of users completing each step of the funnel.

This time, sort modal_text so that your funnel is in order.
*/
SELECT modal_text, COUNT(DISTINCT(user_id))
FROM onboarding_modals
GROUP BY 1
ORDER BY 1;
 /*We can use a CASE statement within our COUNT() aggregate so that we only count user_ids whose ab_group is equal to ‘control’:
                                  */
 SELECT modal_text,
  COUNT(DISTINCT CASE
    WHEN ab_group = 'control' THEN user_id
    END) AS 'control_clicks'
FROM onboarding_modals
GROUP BY 1
ORDER BY 1;
-------------------------------------------------------------------------
 SELECT modal_text,
  COUNT(DISTINCT CASE
    WHEN ab_group = 'control' THEN user_id
    END) as control_clicks,
  COUNT(DISTINCT CASE
    WHEN ab_group = 'variant' THEN user_id
    END) as variant_clicks
FROM onboarding_modals
GROUP BY modal_text
ORDER BY modal_text;
     /*
                                  Build a Funnel from Multiple Tables 1

Scenario: Mattresses and More sells bedding essentials from their e-commerce store. Their purchase funnel is:

    The user browses products and adds them to their cart
    The user proceeds to the checkout page
    The user enters credit card information and makes a purchase

Three steps! Simple and easy.

As a sales analyst, you want to examine data from the shopping days before Christmas. As Christmas approaches, you suspect that customers become more likely to purchase items in their cart (i.e., they move from window shopping to buying presents).
                                  */
   /*
             Each row will represent a single user:

    If the user has any entries in checkout, then is_checkout will be True.
    If the user has any entries in purchase, then is_purchase will be True.

If we use an INNER JOIN to create this table, we’ll lose information from any customer who does not have a row in the checkout or purchase table.

Therefore, we’ll need to use a series of LEFT JOIN commands.
                                  */
                                  
      SELECT DISTINCT b.browse_date,
 b.user_id, c.user_id IS NOT NULL AS is_checkout, p.user_id IS NOT NULL AS is_purchase
 FROM browse AS 'b'
 LEFT JOIN checkout AS 'c'
 ON c.user_id = b.user_id
 LEFT JOIN purchase AS 'p'
 ON p.user_id = c.user_id
 LIMIT 50;
                                  
                                  /*
                                  Finally, let’s do add some more calculations to make the results more in depth.

Let’s add these two columns:

    Percentage of users from browse to checkout
    Percentage of users from checkout to purchase
*/
   WITH funnels AS (
  SELECT DISTINCT b.browse_date,
     b.user_id,
     c.user_id IS NOT NULL AS 'is_checkout',
     p.user_id IS NOT NULL AS 'is_purchase'
  FROM browse AS 'b'
  LEFT JOIN checkout AS 'c'
    ON c.user_id = b.user_id
  LEFT JOIN purchase AS 'p'
    ON p.user_id = c.user_id)
SELECT COUNT(*) as num_browse,
SUM(is_checkout) as num_checkout,
SUM(is_purchase) as num_purchase,
1.0 * SUM(is_checkout)/ COUNT(user_id) as porciento,
1.0 * SUM(is_purchase) / SUM(is_checkout)
FROM funnels;
                              
                                  
