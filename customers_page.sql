
-- Посчитать количество заказчиков
select count(*) from customers


-- Выбрать все уникальные сочетания городов и стран, в которых "зарегестрированы" заказчики
select city,
       country
from customers
group by city, country


-- Найти заказчиков и обслуживающих их заказы сотрудников, таких,
-- что и заказчики и сотрудники из города London, а доставка идёт компанией Speedy Express.
-- Вывести компанию заказчика и ФИО сотрудника.
select ca.company_name,
		e.last_name,
		e.first_name
from orders as o
    join customers ca on ca.customer_id = o.customer_id
    join employees e on e.employee_id = o.employee_id
    join shippers s on o.ship_via = s.shipper_id
WHERE ca.city = 'London' AND e.city = 'London' AND s.company_name = 'Speedy Express'


-- Найти заказчиков, не сделавших ни одного заказа. Вывести имя заказчика и order_id.
SELECT ca.company_name,
		o.order_id
FROM orders as o
	RIGHT JOIN customers as ca ON ca.customer_id = o.customer_id
WHERE o.order_id is NULL
