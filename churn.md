## ¿Qué es Churn?

Un modelo de ingresos común para las empresas de SaaS (software como servicio) es cobrar una tarifa de suscripción mensual para acceder a su producto. Con frecuencia, estas empresas tienen como objetivo aumentar continuamente el número de usuarios que pagan por su producto. Una métrica útil para este objetivo es la tasa de abandono.

La tasa de abandono es el porcentaje de suscriptores que han cancelado dentro de un período determinado, generalmente un mes. Para que la base de usuarios crezca, la tasa de abandono debe ser menor que la tasa de suscriptores nuevos para el mismo período. 

Para calcular la tasa de abandono, solo consideraremos a los usuarios suscritos a principios de mes. La tasa de abandono es el número de estos usuarios que cancelan durante el mes dividido por el número total: 
![tasa_abandono](https://content.codecademy.com/courses/learn-sql/churn/churn1.png)

Por ejemplo, suponga que está analizando datos para un servicio de transmisión de video mensual llamado CodeFlix. A principios de febrero, CodeFlix tiene 1.000 clientes. En febrero, 250 de estos clientes cancelan. La tasa de abandono de febrero sería: 

250 / 1000 = 25% churn rate

In April, CodeFlix started with 3,000 customers. During the month, 450 of these customers canceled.

The service added 500 new customers during the same period.

What is the April churn rate as a ratio?
```sql
SELECT 450. / 3000;
```
### Single Month I
Now that we’ve gone over what churn is, let’s see how we can calculate it using SQL. In this example, we’ll calculate churn for the month of December 2016.

Typically, there will be data in a subscriptions table available in the following format:

   - id - the customer id
   - subscription_start - the subscribe date
   - subscription_end - the cancel date

When customers have a NULL value for their subscription_end, that’s a good thing. It means they haven’t canceled!

For the numerator, we only want the portion of the customers who cancelled during December:
```sql
SELECT COUNT(*)
FROM subscriptions
WHERE subscription_start < '2016-12-01'
  AND (
    subscription_end
    BETWEEN '2016-12-01' AND '2016-12-31'
  );
```
For the denominator, we only want to be considering customers who were active at the beginning of December:
```sql
SELECT COUNT(*)
FROM subscriptions
WHERE subscription_start < '2016-12-01'
  AND (
    (subscription_end >= '2016-12-01')
    OR (subscription_end IS NULL)
  );
```
When there are multiple conditions in a WHERE clause using AND and OR, it’s the best practice to always use the parentheses to enforce the order of execution. It reduces confusion and will make the code easier to understand. The condition within the brackets/parenthesis will always be executed first.

Anyways, now that we have the users who canceled during December, and total subscribers, let’s divide the two to get the churn rate.

When dividing, we need to be sure to multiply by 1.0 to cast the result as a float:
```sql
SELECT 1.0 * 
(
  SELECT COUNT(*)
  FROM subscriptions
  WHERE subscription_start < '2016-12-01'
  AND (
    subscription_end
    BETWEEN '2016-12-01'
    AND '2016-12-31'
  )
) / (
  SELECT COUNT(*) 
  FROM subscriptions 
  WHERE subscription_start < '2016-12-01'
  AND (
    (subscription_end >= '2016-12-01')
    OR (subscription_end IS NULL)
  )
) 
AS result;
```
Here, we have the numerator divided by the denominator, and then multiplying the answer by 1.0. At the very end, we are renaming the final answer to result using AS.
