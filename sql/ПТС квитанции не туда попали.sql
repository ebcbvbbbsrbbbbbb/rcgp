--Общая сумма ПТС
select  --x.NAME,mp.SERVICE_ID,
'',85 tip,
mp.OCC_ID,
sum(mp.value) 
--mp.*
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where --mp.OCC_ID=26404957
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85  --=0
and mp.VALUE<>0
and mp.SERVICE_ID not in('1004','1014','1020','отоп','1023')-- '1023'- Д1 отопл
--group by x.NAME,mp.SERVICE_ID
group by mp.OCC_ID


-------------------------
------------------------- Списко посторонних услуг на которые ушли ПТСные деньги
select  x.NAME,mp.SERVICE_ID,
sum(mp.value) 
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID not in('1004','1014','1020','отоп','1023')--
group by x.NAME,mp.SERVICE_ID

/*

Техническое обслуживание        	1000	14208.82
Старый ВывозМусора              	1006	30.43
Освещение                       	1008	775.49
Старый Лифт (только долги)      	1009	7.86
Канализирование холодной воды   	1012	3373.12
Канализирование горячей воды    	1013	2111.73
Вывоз мусора                    	1015	1394.64
Капитальный ремонт (фонд ЖКХ)   	1016	0.28
ИТП ХВ для подогрева            	1019	246.41
ИТП канализирование ГВ          	1021	206.63
Долг 1 ТО                       	1022	341.18
Долг 1 Освещение                	1030	57.11
Долг 1 Вывоз мусора             	1037	35.83
Капитальный ремонт              	капр	406.51
Лифт                            	лифт	568.06
Найм жилья                      	найм	357.54
Газ                             	пгаз	20.84
Холодная вода                   	хвод	4075.43
Электроэнергия общежития по чел 	элво	163.21
Электричество                   	элек	127.97
*/

---Электроэнергия общежития по чел 	элво
---Электричество                   	элек

select  --x.NAME,mp.SERVICE_ID,
'',127 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('элво','элек')
group by mp.OCC_ID

---Газ                             	пгаз
select  --x.NAME,mp.SERVICE_ID,
'',25 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('пгаз')
group by mp.OCC_ID

---Найм жилья                      	найм
select  --x.NAME,mp.SERVICE_ID,
'',117 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('найм')
group by mp.OCC_ID


---Лифт                            	лифт
select  --x.NAME,mp.SERVICE_ID,
'',79 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('лифт')
group by mp.OCC_ID


---Капитальный ремонт              	капр
select  --x.NAME,mp.SERVICE_ID,
'',111 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('капр')
group by mp.OCC_ID

---Долг 1 Вывоз мусора             	1037
select  --x.NAME,mp.SERVICE_ID,
'',77 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1037')
group by mp.OCC_ID


---Долг 1 Освещение                	1030
select  --x.NAME,mp.SERVICE_ID,
'',49 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1030')
group by mp.OCC_ID

---Долг 1 ТО                       	1022
select  --x.NAME,mp.SERVICE_ID,
'',5 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1022')
group by mp.OCC_ID

---ИТП ХВ для подогрева            	1019
---Холодная вода                   	хвод
select  --x.NAME,mp.SERVICE_ID,
'',73 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1019','хвод')
group by mp.OCC_ID

---Капитальный ремонт (фонд ЖКХ)   	1016
select  --x.NAME,mp.SERVICE_ID,
'',99 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1016')
group by mp.OCC_ID


---Вывоз мусора                    	1015
select  --x.NAME,mp.SERVICE_ID,
'',75 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1015')
group by mp.OCC_ID


---Канализирование холодной воды   	1012
--- Канализирование горячей воды  	1013
---ИТП канализирование ГВ          	1021
select  --x.NAME,mp.SERVICE_ID,
'',71 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1012','1013','1021')
group by mp.OCC_ID

---Старый Лифт (только долги)      	1009
select  --x.NAME,mp.SERVICE_ID,
'',55 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1009')
group by mp.OCC_ID

---Освещение                       	1008
select  --x.NAME,mp.SERVICE_ID,
'',125 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1008')
group by mp.OCC_ID

---Старый ВывозМусора              	1006
select  --x.NAME,mp.SERVICE_ID,
'',39 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1006')
group by mp.OCC_ID

---Техническое обслуживание        	1000
select  --x.NAME,mp.SERVICE_ID,
'',3 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1000')
group by mp.OCC_ID

