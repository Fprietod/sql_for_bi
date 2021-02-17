select count(client_id) from client;
--30,000
-- Which are the 10 clients that have spent more money with their reservations?
-- La manera en que se resolvio esto fue igualando el id del cliente, con sus diferentes reservaciones y así sumar sus costos totales
--Which are the 10 clients that have spent more money with their reservations?
select c.first_name , c.last_name,sum(r.total_price) as maximo_monto_gastado
from reservation r, client c
where c.client_id = r.client_id
group by c.first_name, c.last_name 
order by maximo_monto_gastado desc 
limit 10;
--How many trips have more seats reserved than their vehicle_capacity?
select count(*) from reservation r, trip t 
where r.seats > t.vehicle_capacity;
/* Esta opción puede que sea un poco lenta pero comparamos el número de asientos reservados, con la capacidad de cada vehículo en el viaje*/
/* How many different full names (first_name + last_name) are in tables client & driver
combined.
*/
with full_name AS (
select  concat(d.first_name, ' ', d.last_name) as nombre_driver from driver d
)
select count(distinct(nombre_driver)) from full_name;
                      -- Primero se tuvo que dividir este query en varias partes, se intento hacer en uno solo, pero por la complejidad
                      -- Se separaron los resultados, creando dos tablas temporales donde se alojaba el resultado y al último combinando los resultados

with client_name as(
select concat(c.first_name, ' ', c.last_name) as nombre_client from client c
)
                      -- Esta tabla temporal almacena todos los nombres completos de los clientes
select count(distinct (nombre_client)) from client_name; --aquí ya filtramos los nombres que sean repetidos para reducir la carga


select sum(16048+967);


