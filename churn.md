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

Excersise

We’ve imported 4 months of data for a company from when they began selling subscriptions. This company has a minimum commitment of 1 month, so there are no cancellations in the first month.

The subscriptions table contains:

  -  id
  -  subscription_start
  -  subscription_end

Use the methodology provided in the narrative to calculate the churn for January 2017.
```sql
SELECT 1.0 * 
(
  SELECT COUNT(*)
  FROM subscriptions
  WHERE subscription_start < '2017-01-01'
  AND (
    subscription_end
    BETWEEN '2017-01-01'
    AND '2017-01-31'
  )
) / (
  SELECT COUNT(*) 
  FROM subscriptions 
  WHERE subscription_start < '2017-01-01'
  AND (
    (subscription_end >= '2017-01-01')
    OR (subscription_end IS NULL)
  )
) 
AS result;
```

### Single Month II
El método anterior funcionó, pero es posible que haya notado que seleccionamos el mismo grupo de clientes dos veces durante el mismo mes y repetimos una serie de declaraciones condicionales.

Las empresas suelen analizar los datos de abandono durante un período de varios meses. Necesitamos modificar un poco el cálculo para que sea más fácil moldearlo en un resultado de varios meses. Esto se hace utilizando WITH y CASE. 

To start, use WITH to create the group of customers that are active going into December:
```sql
WITH enrollments AS
(SELECT *
FROM subscriptions
WHERE subscription_start < '2016-12-01'
AND (
  (subscription_end >= '2016-12-01')
  OR (subscription_end IS NULL)
)),
```
Creemos otra tabla temporal que contenga un estado cancelado para cada uno de estos clientes. Este será 1 si cancelan en diciembre y 0 en caso contrario (su fecha de cancelación es posterior a diciembre o NULL). 

```sql
status AS 
(SELECT
CASE
  WHEN (subscription_end > '2016-12-31')
    OR (subscription_end IS NULL) THEN 0
    ELSE 1
  END as is_canceled,

```
Podríamos simplemente COUNT () las filas para determinar el número de usuarios. Sin embargo, para respaldar el cálculo de varios meses, agreguemos una columna is_active a la tabla temporal de estado. Esto usa la misma condición con la que creamos las inscripciones: 

```sql
status AS
  ...
  CASE
    WHEN subscription_start < '2016-12-01'
      AND (
        (subscription_end >= '2016-12-01')
        OR (subscription_end IS NULL)
      ) THEN 1
    ELSE 0
  END as is_active
  FROM enrollments
  )
  ```
  Esto nos dice si alguien está activo a principios de mes.

El último paso es hacer los cálculos en la tabla de estado para calcular la deserción del mes: 
```sql
SELECT 1.0 * SUM(is_canceled) / SUM(is_active)
FROM status;
```

Final querie will be like this:
```sql
WITH enrollments AS
(SELECT *
FROM subscriptions
WHERE subscription_start < '2017-01-01'
AND (
  (subscription_end >= '2017-01-01')
  OR (subscription_end IS NULL)
)),
status AS
(SELECT
CASE
  WHEN (subscription_end > '2017-01-31')
    OR (subscription_end IS NULL) THEN 0
    ELSE 1
  END as is_canceled,
  CASE
    WHEN subscription_start < '2017-01-01'
      AND (
        (subscription_end >= '2017-01-01')
        OR (subscription_end IS NULL)
      ) THEN 1
    ELSE 0
  END as is_active
  FROM enrollments
  )
  SELECT 1.0 * SUM(is_canceled) / SUM(is_active)
FROM status;
```

