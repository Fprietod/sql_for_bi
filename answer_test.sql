select count(client_id) from client;
--30,000
-- Which are the 10 clients that have spent more money with their reservations?
-- La manera en que se resolvio esto fue igualando el id del cliente, con sus diferentes reservaciones y así sumar sus costos totales
select c.first_name , c.last_name,sum(r.total_price) as maximo_monto_gastado
from reservation r, client c
where c.client_id = r.client_id
group by c.first_name, c.last_name 
order by maximo_monto_gastado desc 
limit 10;

