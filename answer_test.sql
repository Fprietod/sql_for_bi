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
/* Esta opción puede que sea un poco lenta pero comparamos el número de asientos reservados, con la capacidad de cada vehículo en el viaje/*


