/*Тестовые задания на позицию Junior SQL Developer*/

-- Создание и заполнение таблиц
create table dbo.Promo (
	ID			int
	,Store		varchar(255)
	,Product	varchar(255)
	,DateBegin	date
	,DateEnd	date
	)

insert into dbo.Promo (ID, Store, Product, DateBegin, DateEnd)
values
	(1,		'Tesco',	'Gum',			'2018-07-21',	'2018-07-29')
	,(2,	'Tesco',	'Fish',			'2018-08-01',	'2018-08-17')
	,(3,	'Tesco',	'Juice',		'2018-06-06',	'2018-06-15')
	,(6,	'Tesco',	'Shampoo',		'2018-06-28',	'2018-07-07')
	,(7,	'Tesco',	'Coffee',		'2018-06-14',	'2018-06-30')
	,(9,	'Tesco',	'Sugar',		'2018-07-05',	'2018-07-19')
	,(10,	'Tesco',	'Tea',			'2018-06-01',	'2018-06-05')
	,(11,	'Tesco',	'Milk',			'2018-08-03',	'2018-08-14')
	,(12,	'Tesco',	'Wet Wipes',	'2018-08-20',	'2018-08-31')
	,(13,	'Billa',	'Shampoo',		'2018-06-28',	'2018-07-07')
	,(14,	'Billa',	'Coffee',		'2018-06-12',	'2018-06-27')
	,(15,	'Billa',	'Sugar',		'2018-08-01',	'2018-08-12')
	,(16,	'Billa',	'Tea',			'2018-06-04',	'2018-06-18')
	,(17,	'Billa',	'Milk',			'2018-07-07',	'2018-07-21')
	,(18,	'Billa',	'Wet Wipes',	'2018-08-10',	'2018-08-25')
	,(19,	'Auchan',	'Coffee',		'2018-06-05',	'2018-06-18')
	,(20,	'Auchan',	'Fish',			'2018-07-22',	'2018-08-02')
	,(21,	'Auchan',	'Sugar',		'2018-07-01',	'2018-07-31')

create table dbo.ProductPrice (
	Pricelist	varchar(255)
	,Product	varchar(255)
	,Price		decimal(18, 2)
	)

insert into dbo.ProductPrice (Pricelist, Product, Price)
values
	('Regular',		'T-shirt',		10)
	,('Regular',	'Pants',		20)
	,('Regular',	'Sweatshirt',	15)
	,('Regular',	'Bike',			100)
	,('Regular',	'Skate',		50)
	,('Exclusive',	'T-shirt',		8)
	,('Exclusive',	'Pants',		17)
	,('Exclusive',	'Sweatshirt',	13)
	,('Exclusive',	'Bike',			90)
	,('Exclusive',	'Skate',		43)
	,('Summer',		'T-shirt',		12)
	,('Summer',		'Pants',		20)
	,('Summer',		'Sweatshirt',	12)
	,('Summer',		'Bike',			110)
	,('Summer',		'Skate',		57)

create table dbo.ProductHierarchy (
	ID			int
	,Name		varchar(255)
	,ID_Parent	int null
	,Level		int
	)

insert into dbo.ProductHierarchy (ID, Name, ID_Parent, Level)
values
	(1,		'Food',					null,	1)
	,(2,	'Non food',				null,	1)
	,(3,	'Chocolates',			1,		2)
	,(4,	'Beverage',				1,		2)
	,(5,	'Sweets',				1,		2)
	,(6,	'Wet Wipes',			2,		2)
	,(7,	'Shampoo',				2,		2)
	,(8,	'Dark chocolate',		3,		3)
	,(9,	'White chocolate',		3,		3)
	,(10,	'Milk chocolate',		3,		3)
	,(11,	'Juices', 				4,		3)
	,(12,	'Water', 				4,		3)
	,(13,	'Boiled sweets',		5,		3)
	,(14,	'Chewy sweets',			5,		3)
	,(15,	'Buble Gum',			5,		3)
	,(16,	'Antibacterial wipes',	6,		3)
	,(17,	'Aroma wipes',			6,		3)
	,(18,	'Dry Shampoo',			7,		3)
	,(19,	'Clarifying Shampoo',	7,		3)

/*
Для каждой таблицы нужно выполнить соответствующее задание
Код нужно писать сразу под заданием и комментировать после решения задачи
После выполнения всех задач, сохранить и прислать файл в формате *.sql или ссылку на страницу
*/

-- 1. Таблица: dbo.Promo
--    Вывести номер акции, название магазина и название продукта, а также
--    номер акции и название продукта, где акция
--    пересекается по датам проведения для данного магазина

select * from promo p left join promo p2 on p.Store=p2.Store
and 
(
        (
            p2.DateBegin  between p.DateBegin and p.DateEnd
            or p2.DateEnd between p.DateBegin and p.DateEnd
        )
    or
       (
           p.DateBegin  between p2.DateBegin and p2.DateEnd 
           or p.DateEnd between p2.DateBegin and p2.DateEnd
       )
)
and p.ID <> p2.ID


-- 2. Таблица: dbo.Promo
--    Вывести номер акции, название магазина и название продукта, а также
--    названия магазинов и название продуктов, где акция
--    пересекается по датам проведения с акциями в других магазинах

select * 
from promo p left join promo p2 on 
(
     (
      p2.DateBegin  between p.DateBegin and p.DateEnd
      or p2.DateEnd between p.DateBegin and p.DateEnd
     )
or
     (
     p.DateBegin  between p2.DateBegin and p2.DateEnd
     or p.DateEnd between p2.DateBegin and p2.DateEnd
     )
)
and p.Store <> p2.Store


-- 3. Таблица: dbo.ProductPrice
--    Необходимо написать запрос, который выводит цены
--    по каждому продукту (в строках) и прайс-листам (в столбцах)

Select Product, Regular, Summer, Exclusive
from ProductPrice
pivot (sum(price) for pricelist in (Regular, Summer, Exclusive)) as p 


-- 4. Таблица: dbo.ProductHierarchy
--    Требуется написать запрос, который преобразует иерархию в плоскую (денормализованную) структуру, т.е.
--    у каждого уровня иерархии должен быть свой столбец (ID_Level1, Name_Level1, ID_Level2, Name_Level2, ID_Level3, Name_Level3)
--    Считаем, что иерархия сбалансирована, т.е. в каждой ветке иерархии одинаковое кол-во уровней

select lvl1.ID ID_Level1, lvl1.Name Name_Level1, lvl2.ID ID_Level2, lvl2.Name Name_Level1, 
       lvl3.ID ID_Level3, lvl3.Name Name_Level1
from 
(
    (select id, name from ProductHierarchy where level = 1) as lvl1 
    left join 
    (select id, name,ID_Parent from ProductHierarchy where Level = 2) as lvl2 
    on lvl1.id = lvl2.ID_Parent	
    left join 
    (select id, name,ID_Parent from ProductHierarchy where Level = 3) lvl3
    on lvl2.id = lvl3.ID_Parent
)