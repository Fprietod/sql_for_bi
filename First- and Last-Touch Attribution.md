### Introducción
Piense en su sitio web favorito: ¿cómo lo encontró? ¿Usaste un motor de búsqueda? ¿O hacer clic en un anuncio? ¿O seguir un enlace en una publicación de blog?

Los desarrolladores web, los especialistas en marketing y los analistas de datos utilizan esa información para mejorar sus fuentes (a veces llamadas canales o puntos de contacto) en línea. Si una campaña publicitaria genera muchas visitas a su sitio, entonces saben que la fuente está funcionando. Decimos que esas visitas se atribuyen a la campaña publicitaria.

Pero, ¿cómo capturan los sitios web esa información? La respuesta son los parámetros UTM. Estos parámetros capturan cuándo y cómo un usuario encuentra el sitio. Los propietarios de sitios utilizan enlaces especiales que contienen parámetros UTM en sus anuncios, publicaciones de blog y otras fuentes. Cuando un usuario hace clic en uno, se agrega una fila a una base de datos que describe su visita a la página. Puede ver un esquema común para una tabla de "visitas a la página" a continuación y en este enlace. 


  - user_id - A unique identifier for each visitor to a page
  - timestamp - The time at which the visitor came to the page
  - page_name - The title of the section of the page that was visited
  - utm_source - Identifies which touchpoint sent the traffic (e.g. google, email, or facebook)
  - utm_medium - Identifies what type of link was used (e.g. cost-per-click or email)
  - utm_campaign - Identifies the specific ad or email blast (e.g. retargetting-ad or weekly-newsletter)

### First touch example 
Ejemplo de primer toque

Imagínese junio. Quiere comprar una camiseta nueva para su madre, que está de visita desde fuera de la ciudad. Lee sobre CoolTShirts.com en un artículo de Buzzfeed y hace clic en un enlace a su página de destino. June encuentra una fabulosa camiseta de las Tortugas Ninja y la agrega a su carrito. Antes de que pueda avanzar a la página de pago, su mamá llama y pide direcciones. June navega fuera de CoolTShirts.com para buscar direcciones. 
June’s initial visit is logged in the page_visits table as follows:
 user_id 	timestamp 	page_name 	utm_source
10069 	2018-01-02 23:14:01 	1 - landing_page 	buzzfeed
10069 	2018-01-02 23:55:01 	2 - shopping_cart 	buzzfed

## Ultimo toque
Atribución de primer y último toque
Ejemplo de último toque

Dos días después, CoolTShirts.com publica un anuncio en la página de Facebook de June. June recuerda cuánto quería esa camiseta de las Tortugas Ninja y sigue el anuncio hasta CoolTShirts.com.

Ahora tiene las siguientes filas en la tabla page_visits: 
user_id 	timestamp 	page_name 	utm_source
10069 	2018-01-02 23:14:01 	1 - landing_page 	buzzfeed
10069 	2018-01-02 23:14:01 	2 - shopping_cart 	buzzfeed
10069 	2018-01-04 08:12:01 	3 - checkout 	facebook
10069 	2018-01-04 08:13:01 	4 - purchase 	facebook

```sql
SELECT * FROM page_visits
where user_id = 10069;
```


  - June’s last touch — the exposure to CoolTShirts.com that led to a purchase — is attributed to facebook
  -  She visited the checkout page at 08:12:01 and the purchase page at 08:13:01

Si desea aumentar las ventas en CoolTShirts.com, ¿contaría con buzzfeed o aumentaría los anuncios de Facebook? La verdadera pregunta es: ¿debería atribuirse la compra de junio a buzzfeed o a Facebook?

Hay dos formas de analizar esto:

  -  La atribución de primer toque solo considera el primer utm_source de cada cliente, que sería buzzfeed en este caso. Esta es una buena forma de saber cómo los visitantes descubren inicialmente un sitio web.
  -   La atribución de último toque solo considera el último utm_source de cada cliente, que en este caso sería facebook. Esta es una buena forma de saber cómo los visitantes regresan a un sitio web, especialmente para realizar una compra final.

Los resultados pueden ser cruciales para mejorar el marketing y la presencia en línea de una empresa. La mayoría de las empresas analizan la atribución de primer y último toque y muestran los resultados por separado. 
```sql
SELECT * FROM page_visits
WHERE user_id = 10329;
```
Result
| page_name |	| timestamp |	 | user_id | 	| utm_campaign | 	| utm_source |
| --------- | |---------- | -----------|  |--------------|  |------------|
| 1 - landing_page 	2018-01-18 05:27:25 	10329 	interview-with-cool-tshirts-founder 	medium |
| 2 - shopping_cart 	2018-01-18 07:15:25 	10329 	interview-with-cool-tshirts-founder 	medium |
| 3 - checkout 	2018-01-22 16:31:25 	10329 	retargetting-campaign 	email |
| 4 - purchase 	2018-01-22 16:35:25 	10329 	retargetting-campaign 	email |

### The atribution Query

Acabamos de aprender a atribuir los primeros y últimos toques de un usuario. ¿Y si queremos atribuir los primeros y últimos toques a TODOS los usuarios? Aquí es donde SQL resulta útil: con una consulta podemos encontrar todas las atribuciones de primer o último toque (la primera y la última versión son casi idénticas). Podemos guardar esta consulta para ejecutarla más tarde o modificarla para un subconjunto de usuarios. Aprendamos la consulta ...

Para obtener atribuciones de primer contacto, necesitamos encontrar la primera vez que un usuario interactuó con nuestro sitio web. Hacemos esto usando un GROUP BY. Llamemos a esta tabla first_touch: 
```sql
SELECT user_id,
   MIN(timestamp) AS 'first_touch_at'
FROM page_visits
GROUP BY user_id;
```
Esto nos dice la primera vez que cada usuario visitó nuestro sitio, pero no nos dice cómo llegaron a nuestro sitio - ¡los resultados de la consulta no tienen parámetros UTM! Veremos cómo conseguirlos en el próximo ejercicio. 

Find all last touches. Your query will look similar to the first_touch query above.

```sql
SELECT user_id,
  MAX(timestamp) as last_touch_at
  MIN(timestamp) as first_touch_at
FROM page_visits
WHERE user_id = 10069
GROUP BY user_id;
```
### The atribution query II
Para obtener los parámetros UTM, necesitaremos UNIR estos resultados con la tabla original.

Uniremos las tablas first_touch, akaft y page_visits, también conocido como pv, en user_id y timestamp 
```sql
ft.user_id = pv.user_id
AND ft.first_touch_at = pv.timestamp
```
Recuerde que first_touch_at es la marca de tiempo más temprana para cada usuario. Aquí está la consulta simplificada: 
```sql
WITH first_touch AS (
      /* ... */
    )
SELECT *
FROM first_touch AS 'ft'
JOIN page_visits AS 'pv'
  ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp;
```
Ahora complete la cláusula WITH usando la consulta first_touch del ejercicio anterior. También especificaremos las columnas para SELECCIONAR. 
```sql
WITH first_touch AS (
   SELECT user_id,
      MIN(timestamp) AS 'first_touch_at'
   FROM page_visits
   GROUP BY user_id)
SELECT ft.user_id,
  ft.first_touch_at,
  pv.utm_source
FROM first_touch AS 'ft'
JOIN page_visits AS 'pv'
  ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp;
```
The diagram on the right illustrates the JOIN we need to get the UTM parameters of each first touch:

  - On the left is page_visits (just three columns from the original table). We get the UTM parameters from there.
  - On the right is first_touch (the result of the GROUP BY query). We get the first touches from there. 

![texto](https://content.codecademy.com/courses/sql-intensive/join_diagram.svg)

Example:
Using the query above as a guide, write the LAST-touch attribution query and run it.
```sql
WITH last_touch AS (
  SELECT user_id,
    MAX(timestamp) as last_touch_at
  FROM page_visits
  GROUP BY user_id)
SELECT lt.user_id,
  lt.last_touch_at,
  pv.utm_source
FROM last_touch lt
JOIN page_visits pv
  ON lt.user_id = pv.user_id
  AND lt.last_touch_at = pv.timestamp
WHERE lt.user_id = 10069;
```
### Review
You can now wield SQL to find where, when, and how users are visiting a website. Well done! Here’s a summary of what you learned:
- Los parámetros UTM son una forma de realizar un seguimiento de las visitas a un sitio web. Los desarrolladores, especialistas en marketing y analistas los utilizan para capturar información como la hora, la fuente de atribución y el medio de atribución para cada visita de usuario. 
- La atribución de primer toque solo considera la primera fuente para cada cliente. Esta es una buena forma de saber cómo los visitantes descubren inicialmente un sitio web. 
- La atribución de último toque solo considera la última fuente de cada cliente. Esta es una buena forma de saber cómo los visitantes regresan a un sitio web, especialmente para realizar una compra final. 
- Encuentra los primeros y últimos toques agrupando page_visits por user_id y encontrando el MIN y MAX de la marca de tiempo 
- Para encontrar la atribución de primer y último toque, vuelva a unir esa tabla con la tabla page_visits original en user_id y timestamp. 




