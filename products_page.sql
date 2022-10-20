-- Найти активные (см. поле discontinued) продукты из категории Beverages и Seafood,
-- которых в продаже менее 20 единиц. Вывести наименование продуктов, кол-во единиц в продаже,
-- имя контакта поставщика и его телефонный номер.
SELECT pr.product_name,
		pr.units_in_stock,
		s.name_contact,
		s.phone
from products as pr
	join categories as ca on ca.category_id = pr.category_id
	join suppliers as s on s.id_supplier = pr.fk_supplier
WHERE pr.units_in_stock < 20 and pr.discontinued = 0
and (ca.category_name = 'Beverages' or ca.category_name = 'Seafood')
