
-- Выбрать записи работников (включить колонки имени, фамилии, телефона, региона)
-- в которых регион неизвестен
select e.first_name,
		e.last_name,
		e.home_phone,
		e.region
from employees as e
where e.region is null


-- Выбрать такие страны в которых "зарегистированы" одновременно заказчики
-- и поставщики, но при этом в них не "зарегистрированы" работники
SELECT customers.country
FROM customers
INTERSECT
SELECT suppliers.country
FROM suppliers
EXCEPT
SELECT employees.country
FROM employees
