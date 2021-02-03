/*
Churn rate is the percent of subscribers that have canceled within a certain period, usually a month. For a user base to grow, the churn rate must be less than the new subscriber rate for the same period.

To calculate the churn rate, we only will be considering users who are subscribed at the beginning of the month. The churn rate is the number of these users who cancel during the month divided by the total number:

Cancellations / total subscribers

For example, suppose you were analyzing data for a monthly video streaming service called CodeFlix. At the beginning of February, CodeFlix has 1,000 customers. In February, 250 of these customers cancel. The churn rate for February would be:

250 / 1000 = 25% churn rate

In March, CodeFlix started with 2,000 customers. During the month, 100 of these customers canceled.

What is the March churn rate as a ratio?

Use a SELECT statement to calculate the answer. Be sure to use a decimal in your calculations to force a float answer.
*/
SELECT 100. /2000;

-- Single Month

/*
Typically, there will be data in a subscriptions table available in the following format:

    id - the customer id
    subscription_start - the subscribe date
    subscription_end - the cancel date

When customers have a NULL value for their subscription_end, that’s a good thing. It means they haven’t canceled!
*/
