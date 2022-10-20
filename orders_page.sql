
-- Выбрать все заказы, отсортировать по required_date (по убыванию) и
-- отсортировать по дате отгрузке (по возрастанию)
select *
from orders as o
ORDER by o.required_date DESC, o.shipped_date


-- Найти среднее значение дней уходящих на доставку с даты формирования заказа в USA
SELECT AVG(o.shipped_date - o.order_date)
FROM orders as o
where o.ship_country = 'USA'


-- Найти сумму, на которую имеется товаров (количество * цену) причём таких,
-- которые не сняты с продажи (см. на поле discontinued)
select sum(pr.unit_price * pr.units_in_stock)
from products as pr
WHERE pr.discontinued = 0

