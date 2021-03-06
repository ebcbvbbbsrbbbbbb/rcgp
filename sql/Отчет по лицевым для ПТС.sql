﻿ use Stack
 IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME='PTS_ls' AND xtype='U')   
   
    create table Stack.PTS_ls
(
  LCOUNT NUMERIC(20,0),
  FIO char(50),
  ADRES char(100),
  KOD_UO numeric(5),
  NAME_UO char(70),
  DATE_NACH date,
  KOD_USL numeric(5,0),
  NAME_USL char (50),
  TARIF numeric(12,2),
  VID_NACH char(15),
  NORMA numeric (12,6),
  KOL_USL numeric(12,6),
  ED_USL char(10),
  SUM_USL numeric(10,2),
  SUM_PRR numeric(10,2),
  DESC_PRR char(50),
  SUM_OPL numeric(10,2),
  LDATE_OPL date,
  SALDO_IN numeric(10,2),
  SALDO_OUT numeric(10,2),
  SCH1 numeric (10,2),
  SCH2 numeric (10,2),
  SCH3 numeric (10,2),
  SCH4 numeric (10,2),
  SCH5 numeric (10,2),
  KOL_M2 numeric(10,2),
  KOL_CHEL numeric(5,0)
)

ELSE DELETE FROM stack.PTS_ls

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME='PTS_checktable' AND xtype='U')
create table Stack.PTS_checktable
(
  LCOUNT NUMERIC(20,0),
  KOD_UO numeric(5),
  KOD_USL numeric(5,0),
  SUM_PRR numeric(10,2),
  SUM_OPL numeric(10,2),
  SALDO_IN numeric(10,2),
  SALDO_OUT numeric(10,2),
  SUM_USL numeric (10,2)
 )
ELSE DELETE FROM stack.PTS_checktable
 
	 
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME='##occ' AND xtype='U')
DROP TABLE #occ	

 declare @rasch_date date
 set @rasch_date = '2019-11-01'

 create table #occ (
 occ_id int,
 ls varchar(255),
 service int,
 pservice int, 
 service_group int,
 service_name varchar(255),
 service_group_name varchar(255),
 uk_dog int,
 rasch_date date,
 isITP int,
 norma numeric(12,6),
 maxnorma numeric(12,6)
)
------------ входящее сальдо
insert into #occ
select t.*, isnull(norm.Значение,0) , max(isnull(norm.Значение,0)) over(partition by t.occ_id, t.pservice ) from (

select distinct ns.Счет occ_id, (select Номер from stack.[Лицевые счета] where row_id = ns.Счет) ls, ns.[Номер услуги] service, stack.dbo.getPNumber(ns.[Номер услуги],tui.РодительНомер) pservice, 
tui.РодительНомер service_group, tu1.Наименование service_name, tu2.Наименование service_group_name, ns.ДоговорУК uk_dog, @rasch_date as rasch_date, 
case when(select count(*) from stack.[Список услуг] su inner join stack.[Типы услуг] tu on tu.ROW_ID=su.[Вид-Услуги] 
where su.[Счет-Услуги]=ns.Счет and tu.[Внешний код 1]=28)	> 0
then 1 
else 0
end  as isitp
from stack.НСальдо ns inner join stack.[Типы услуг иерархия] tui on tui.ПотомокНомер = ns.[Номер услуги] 
inner join stack.[Типы услуг] tu1 on tu1.[Номер услуги] = ns.[Номер услуги]
inner join stack.[Типы услуг] tu2 on tu2.[Номер услуги] = tui.РодительНомер
where (CAST([Месяц расчета]	as date) = DATEADD(MONTH,-1,@rasch_date) and Поставщик = 1305 and tui.РодительТип=2 and ns.Сумма <> 0)
or (CAST([Месяц расчета]	as date) = DATEADD(MONTH,-1,@rasch_date) and Поставщик = 765 and tui.РодительТип=2 and ns.Сумма <> 0 and tui.РодительНомер in (400,2000,2100,4700))
or (CAST([Месяц расчета]	as date) = DATEADD(MONTH,-1,@rasch_date) and Поставщик = 972 and tui.РодительТип=2 and ns.Сумма <> 0 and tui.РодительНомер in (400,2000,2100,4700) and exists(select 1 from stack.[Лицевые иерархия] where Потомок=ns.Счет and Родитель=943))

------------- начисления
union	
select distinct ns.Счет occ_id, (select Номер from stack.[Лицевые счета] where row_id = ns.Счет) ls, ns.[Номер услуги] service,stack.dbo.getPNumber(ns.[Номер услуги],tui.РодительНомер) as pservice,
 tui.РодительНомер service_group, tu1.Наименование service_name, tu2.Наименование service_group_name, ns.ДоговорУК uk_dog, @rasch_date rasch_date, 
case when(select count(*) from stack.[Список услуг] su inner join stack.[Типы услуг] tu on tu.ROW_ID=su.[Вид-Услуги] 
where su.[Счет-Услуги]=ns.Счет and tu.[Внешний код 1]=28)	> 0
then 1 
else 0
end  as itp
from stack.НТариф ns inner join stack.[Типы услуг иерархия] tui on tui.ПотомокНомер = ns.[Номер услуги] 
inner join stack.[Типы услуг] tu1 on tu1.[Номер услуги] = ns.[Номер услуги]
inner join stack.[Типы услуг] tu2 on tu2.[Номер услуги] = tui.РодительНомер
where (CAST([Месяц расчета]	as date) = @rasch_date and Поставщик = 1305 and tui.РодительТип=2 and ns.Сумма <> 0)
or ((CAST([Месяц расчета]	as date) = @rasch_date and Поставщик = 765 and tui.РодительТип=2 and ns.Сумма <> 0 and tui.РодительНомер in (400,2000,2100,4700)))
or ((CAST([Месяц расчета]	as date) = @rasch_date and Поставщик = 972 and tui.РодительТип=2 and ns.Сумма <> 0 and tui.РодительНомер in (400,2000,2100,4700) and exists(select 1 from stack.[Лицевые иерархия] where Потомок=ns.Счет and Родитель=943)))
 
 ------------ разовые
union 		
select distinct ns.Счет occ_id, (select Номер from stack.[Лицевые счета] where row_id = ns.Счет) ls, ns.[Номер услуги] as service,
stack.dbo.getPNumber(ns.[Номер услуги],tui.РодительНомер) pservice, tui.РодительНомер service_group, tu1.Наименование service_name, tu2.Наименование service_group_name, ns.ДоговорУК uk_dog,  @rasch_date rasch_date, 
case when(select count(*) from stack.[Список услуг] su inner join stack.[Типы услуг] tu on tu.ROW_ID=su.[Вид-Услуги] 
where su.[Счет-Услуги]=ns.Счет and tu.[Внешний код 1]=28)	> 0
then 1 
else 0
end  as itp 
from stack.[РН список] ns inner join stack.[Типы услуг иерархия] tui on tui.ПотомокНомер = ns.[Номер услуги] 
inner join stack.[Типы услуг] tu1 on tu1.[Номер услуги] = ns.[Номер услуги]
inner join stack.[Типы услуг] tu2 on tu2.[Номер услуги] = tui.РодительНомер
where CAST([Месяц расчета]	as date) = @rasch_date and Поставщик = 1305 and tui.РодительТип=2 and ns.Сумма <> 0
or (CAST([Месяц расчета]	as date) = @rasch_date and Поставщик = 765 and tui.РодительТип=2 and ns.Сумма <> 0 and tui.РодительНомер in (400,2000,2100,4700))
or (CAST([Месяц расчета]	as date) = @rasch_date and Поставщик = 972 and tui.РодительТип=2 and ns.Сумма <> 0 and tui.РодительНомер in (400,2000,2100,4700) and exists(select 1 from stack.[Лицевые иерархия] where Потомок=ns.Счет and Родитель=943))

------------ платежи		
union 	
select distinct rsp.Счет occ_id, (select Номер from stack.[Лицевые счета] where row_id = rsp.Счет) ls, rsp.НомерУслуги service,
stack.dbo.getPNumber(rsp.НомерУслуги, rsp.Услуга) as pservice, rsp.Услуга service_group, tu1.Наименование service_name, tu2.Наименование service_group_name, rsp.УКДоговор uk_dog, @rasch_date rasch_date, 
case when(select count(*) from stack.[Список услуг] su inner join stack.[Типы услуг] tu on tu.ROW_ID=su.[Вид-Услуги] 
where su.[Счет-Услуги]=rsp.Счет and tu.[Внешний код 1]=28)	> 0
then 1 
else 0
end  as itp
from stack.[Расчеты с поставщиками (детально)] rsp inner join stack.[Типы услуг] tu1 on tu1.[Номер услуги] = rsp.НомерУслуги
inner join stack.[Типы услуг] tu2 on tu2.[Номер услуги] = rsp.Услуга
where CAST(rsp.Дата as date) BETWEEN @rasch_date and cast(EOMONTH(@rasch_date) as date) and Поставщик = 1305 
and rsp.Сумма <> 0 and rsp.ПризнакКоррекции <> 1 and rsp.Аналитика1 <> 'ПЕНИ'
or (CAST(rsp.Дата as date) BETWEEN @rasch_date and cast(EOMONTH(@rasch_date) as date) and Поставщик = 765 and rsp.Сумма <> 0 and rsp.Услуга in (400,2000,2100,4700) and rsp.Аналитика1 <> 'ПЕНИ')
or (CAST(rsp.Дата as date) BETWEEN @rasch_date and cast(EOMONTH(@rasch_date) as date) and Поставщик = 972 and rsp.Сумма <> 0 and rsp.Услуга in (400,2000,2100,4700) and exists(select 1 from stack.[Лицевые иерархия] where Потомок=rsp.Счет and Родитель=943) and rsp.Аналитика1 <> 'ПЕНИ')  
 ) as t 
-- норма потребления
left join (select * from  (select isnull(n.Значение,0) Значение, tu.[Номер услуги], ДатНач, MAX(ДатНач) OVER(partition by tu.[Номер услуги]) as maxdate from  stack.Нормы n left join stack.[Типы услуг] tu on n.[Вид-Нормы] = tu.ROW_ID where cast (n.ДатНач as date) <= @rasch_date) as r
where r.ДатНач = r.maxdate)
as norm on norm.[Номер услуги] = t.service

;
-------------- временная таблица
with temp as (																  
select #occ.occ_id as ЛС, ls as Номер_ЛС, stack.AddrLs(#occ.occ_id,1) Адрес, ukd.Номер, org.Название as УК,  #occ.rasch_date as Месяц, 
#occ.service as Ном_усл, #occ.service_group as Гр_усл, #occ.service_name as Услуга, stack.dbo.getPName(#occ.service,#occ.service_group_name) as Псевдоним, 
#occ.pservice as Псевд_номер,  #occ.uk_dog,
case when nt.Ед_изм is null then 
(select distinct [Единица измерения] as Ед_изм from stack.[Типы услуг] where [Номер услуги] = #occ.service)
else nt.Ед_изм
end as  Ед_изм,
-- тариф 
case when nt.ИспользованТариф is null and #occ.service <> 401
		then (select max(t.Значение) as Тариф from stack.[Список услуг] su	inner join stack.[Типы услуг иерархия] tui  on 
		su.[Вид-Услуги] = tui.Потомок inner join stack.Тарифы t on t.[Вид-Тарифы] = su.[Вид-Услуги]
		where su.[Счет-Услуги] = #occ.occ_id and РодительТип=2 and РодительНомер = #occ.service_group )
	when #occ.service = 401
		then (select t.Значение as Тариф from stack.[Типы услуг] tu  left join
		stack.Тарифы t on t.[Вид-Тарифы] = tu.ROW_ID
		where tu.[Номер услуги]=402 )
else nt.ИспользованТариф
end as Тариф, 
-- начисленный объем до 6 знаков
ROUND(isnull(
case when nt.Начисл_сумма <> 0 						-- drop table #occ
then
	case when #occ.service like ('21%')
		then nt.Начисл_сумма/nt.ИспользованТариф
		else nt.Начисл_объем 
	end
else 0
end,0
),6) as Начисл_объем,
isnull(nt.Начисл_сумма,0) as Начисл_сумма, isnull(rn.Сумма_разовых,0) as Разовые, 
--- разовые примечания
isnull(
(select top 1 rnd.Примечание 
from stack.[РН список] rns inner join stack.[РН документ] rnd on rns.[РН-Список] = rnd.ROW_ID where cast(rns.[Месяц расчета] as date)=@rasch_date
and (select РодительНомер from stack.[Типы услуг иерархия] where ПотомокНомер=rns.[Номер услуги] and РодительТип=2)= #occ.service_group 
and rns.Счет = #occ.occ_id and rns.ДоговорУК=#occ.uk_dog),'') as Разовые_прим,  

isnull(perer.Начисл_сумма,0) as Перерасчет,   isnull(opl.Сумма,0) as Сумма_платежей,
isnull(ns.Сумма,0) as ВХ_Сальдо, isnull(ks.Сумма,0) as ИСХ_Сальдо, 

-- последняя оплата
(select MAX(lopl.Дата) from (
  select MAX(so.Дата) as Дата 
  from stack.[Список оплаты] so inner join stack.[Оплата по видам] opv on so.ROW_ID = opv.[Распределение-Платеж]
  inner join stack.[Типы услуг] tu on tu.ROW_ID = opv.[Распределение-Услуга] 
  inner join stack.Организации org on opv.[Распределение-УК] = org.ROW_ID
  inner join stack.[УК договоры] ukd on ukd.[Организация-УКДоговор] = org.ROW_ID
  where ukd.ROW_ID = #occ.uk_dog and so.[Счет-Оплата] = #occ.occ_id and (select РодительНомер from stack.[Типы услуг иерархия] 
  where ПотомокНомер=tu.[Номер услуги] and РодительТип=2)= #occ.service_group and opv.Тип <> 0 and opv.Тип is not null
  union
  select MAX(Дата) as Дата from stack.[Расчеты с поставщиками (детально)]
  where УКДоговор= #occ.uk_dog and Счет= #occ.occ_id and Услуга = #occ.service_group) as lopl
  ) as Посл_опл, 

 isnull(ls.Площадь,0) as Площадь, 
 -- счетчики
 ---------если дом с ИТП, берем счетчик с услуги 2000 (вода для подогрева)
 case when #occ.service_group = 2100 and #occ.isITP = 1 then 
 (select top 1 Показание	from stack.[Показания счетчиков] ps inner join stack.[Список объектов] so on so.ROW_ID = ps.[Объект-Показания]
						inner join stack.[Типы услуг] tu on tu.ROW_ID = so.[Объект-Услуга] 
						where ps.[Показания-Счет] = #occ.occ_id and tu.[Номер услуги] =  2000
						and cast(ps.Дата as date) <= EOMONTH(@rasch_date)
						and so.[N п/п] = 1
order by ps.Дата desc,ps.ROW_ID desc)
else 
---------иначе - с соответствующей услуги
(select top 1 Показание	from stack.[Показания счетчиков] ps inner join stack.[Список объектов] so on so.ROW_ID = ps.[Объект-Показания]
						inner join stack.[Типы услуг] tu on tu.ROW_ID = so.[Объект-Услуга] 
						where ps.[Показания-Счет] = #occ.occ_id and tu.[Номер услуги] =  #occ.service_group
						and cast(ps.Дата as date) <= EOMONTH(@rasch_date)
						and so.[N п/п] = 1
order by ps.Дата desc,ps.ROW_ID desc)
end
 as SCH1,
 case when #occ.service_group = 2100 and #occ.isITP = 1 then 
 (select top 1 Показание	from stack.[Показания счетчиков] ps inner join stack.[Список объектов] so on so.ROW_ID = ps.[Объект-Показания]
						inner join stack.[Типы услуг] tu on tu.ROW_ID = so.[Объект-Услуга] 
						where ps.[Показания-Счет] = #occ.occ_id and tu.[Номер услуги] =  2000
						and cast(ps.Дата as date) <= EOMONTH(@rasch_date)
						and so.[N п/п] = 2
order by ps.Дата desc,ps.ROW_ID desc)
else 
(select top 1 Показание	from stack.[Показания счетчиков] ps inner join stack.[Список объектов] so on so.ROW_ID = ps.[Объект-Показания]
						inner join stack.[Типы услуг] tu on tu.ROW_ID = so.[Объект-Услуга] 
						where ps.[Показания-Счет] = #occ.occ_id and tu.[Номер услуги] =  #occ.service_group
						and cast(ps.Дата as date) <= EOMONTH(@rasch_date)
						and so.[N п/п] = 2
order by ps.Дата desc,ps.ROW_ID desc)
end
 as SCH2,
  case when #occ.service_group = 2100 and #occ.isITP = 1 then 
 (select top 1 Показание	from stack.[Показания счетчиков] ps inner join stack.[Список объектов] so on so.ROW_ID = ps.[Объект-Показания]
						inner join stack.[Типы услуг] tu on tu.ROW_ID = so.[Объект-Услуга] 
						where ps.[Показания-Счет] = #occ.occ_id and tu.[Номер услуги] =  2000
						and cast(ps.Дата as date) <= EOMONTH(@rasch_date)
						and so.[N п/п] = 3
order by ps.Дата desc,ps.ROW_ID desc)
else 
(select top 1 Показание	from stack.[Показания счетчиков] ps inner join stack.[Список объектов] so on so.ROW_ID = ps.[Объект-Показания]
						inner join stack.[Типы услуг] tu on tu.ROW_ID = so.[Объект-Услуга] 
						where ps.[Показания-Счет] = #occ.occ_id and tu.[Номер услуги] =  #occ.service_group
						and cast(ps.Дата as date) <= EOMONTH(@rasch_date)
						and so.[N п/п] = 3
order by ps.Дата desc,ps.ROW_ID desc)
end
 as SCH3,
  case when #occ.service_group = 2100 and #occ.isITP = 1 then 
 (select top 1 Показание	from stack.[Показания счетчиков] ps inner join stack.[Список объектов] so on so.ROW_ID = ps.[Объект-Показания]
						inner join stack.[Типы услуг] tu on tu.ROW_ID = so.[Объект-Услуга] 
						where ps.[Показания-Счет] = #occ.occ_id and tu.[Номер услуги] =  2000
						and cast(ps.Дата as date) <= EOMONTH(@rasch_date)
						and so.[N п/п] = 4
order by ps.Дата desc,ps.ROW_ID desc)
else 
(select top 1 Показание	from stack.[Показания счетчиков] ps inner join stack.[Список объектов] so on so.ROW_ID = ps.[Объект-Показания]
						inner join stack.[Типы услуг] tu on tu.ROW_ID = so.[Объект-Услуга] 
						where ps.[Показания-Счет] = #occ.occ_id and tu.[Номер услуги] =  #occ.service_group
						and cast(ps.Дата as date) <= EOMONTH(@rasch_date)
						and so.[N п/п] = 4
order by ps.Дата desc,ps.ROW_ID desc)
end
 as SCH4,
  case when #occ.service_group = 2100 and #occ.isITP = 1 then 
 (select top 1 Показание	from stack.[Показания счетчиков] ps inner join stack.[Список объектов] so on so.ROW_ID = ps.[Объект-Показания]
						inner join stack.[Типы услуг] tu on tu.ROW_ID = so.[Объект-Услуга] 
						where ps.[Показания-Счет] = #occ.occ_id and tu.[Номер услуги] =  2000
						and cast(ps.Дата as date) <= EOMONTH(@rasch_date)
						and so.[N п/п] = 5
order by ps.Дата desc,ps.ROW_ID desc)
else 
(select top 1 Показание	from stack.[Показания счетчиков] ps inner join stack.[Список объектов] so on so.ROW_ID = ps.[Объект-Показания]
						inner join stack.[Типы услуг] tu on tu.ROW_ID = so.[Объект-Услуга] 
						where ps.[Показания-Счет] = #occ.occ_id and tu.[Номер услуги] =  #occ.service_group
						and cast(ps.Дата as date) <= EOMONTH(@rasch_date)
						and so.[N п/п] = 5
order by ps.Дата desc,ps.ROW_ID desc)
end
 as SCH5, isnull(ppl.total_ppl,0) as Прописано, 
  #occ.isITP as ITP, ks.сумма as REAL_SALDO_OUT, 
case 
when RIGHT(#occ.service,2)=51 or #occ.service in (453,482,452,483)
then 'по счетчику'
else 'по нормативу'
end as VID_NACH, 
-- норматив потребления
#occ.maxnorma as NORMA 

from #occ 
-- управляющая компания
left join stack.[УК договоры] ukd on #occ.uk_dog=ukd.ROW_ID
left join stack.Организации org on org.ROW_ID = ukd.[Организация-УКДоговор]
-- входящее сальдо
left join (select sum(Сумма) as сумма, [Номер услуги], ДоговорУК, Счет from stack.НСальдо where CAST([Месяц расчета] as date) = DATEADD(MONTH,-1,@rasch_date)   group by [Номер услуги], ДоговорУК, Счет)
as ns on ns.ДоговорУК=#occ.uk_dog and ns.[Номер услуги] = #occ.service and #occ.occ_id = ns.Счет 
-- исходящее сальдо
left join (select sum(Сумма) as сумма, [Номер услуги], ДоговорУК, Счет from stack.НСальдо where CAST([Месяц расчета] as date) = @rasch_date   group by [Номер услуги], ДоговорУК, Счет)
as ks on ks.ДоговорУК=#occ.uk_dog and ks.[Номер услуги] = #occ.service and #occ.occ_id = ks.Счет 
-- начисления
left join (select sum(Сумма) as Начисл_сумма, sum(Объем) as Начисл_объем, [Номер услуги], ДоговорУК, Счет, ИспользованТариф, (select top 1 [Единица измерения] from stack.[Типы услуг] tu where tu.[Номер услуги] = nl.[Номер услуги]) as Ед_изм 
from stack.[Начисления лицевых] nl where cast([Месяц расчета] as date)=@rasch_date and Сумма <> 0 and 
Поставщик = 
	case when exists (select 1 from stack.[Лицевые иерархия] where Потомок = Счет and Родитель = 943 and РодительТип=3)
	then 972
	else 1305
	end 
and Аналитика2<>777 and Тип <> 'ПТариф'   group by [Номер услуги], ДоговорУК, Счет, ИспользованТариф)
as nt on nt.[Номер услуги] = #occ.service and #occ.occ_id = nt.Счет and	nt.ДоговорУК= #occ.uk_dog
-- перерасчеты
left join (select sum(Сумма) as Начисл_сумма, sum(Объем) as Начисл_объем, [Номер услуги], ДоговорУК, Счет
from stack.[Начисления лицевых] nl where cast([Месяц расчета] as date)=@rasch_date and Сумма <> 0 and Поставщик = 1305 and Тип='Птариф'   group by [Номер услуги], ДоговорУК, Счет)
as perer on perer.ДоговорУК=#occ.uk_dog and perer.[Номер услуги] = #occ.service and #occ.occ_id = perer.Счет 
-- разовые
left join (select sum(rns.Сумма) as Сумма_разовых, rns.[Номер услуги], rns.ДоговорУК, rns.Счет 
from stack.[РН список] rns inner join stack.[РН документ] rnd on rns.[РН-Список] = rnd.ROW_ID where cast(rns.[Месяц расчета] as date)=@rasch_date
group by  rns.[Номер услуги], rns.ДоговорУК, rns.Счет) as rn
on rn.[Номер услуги]  = #occ.service and rn.Счет = #occ.occ_id and rn.ДоговорУК=#occ.uk_dog 
-- платежи
left join (select sum(Сумма) as Сумма, НомерУслуги, УКДоговор, Счет from stack.[Расчеты с поставщиками (детально)]
where CAST(Дата as date) BETWEEN @rasch_date and cast(EOMONTH(@rasch_date) as date) and Аналитика1 <> 'ПЕНИ' group by НомерУслуги, УКДоговор, Счет) as opl on
opl.НомерУслуги = #occ.service and opl.Счет = #occ.occ_id and opl.УКДоговор=#occ.uk_dog
-- площадь лицевых 
left join (select s.Значение as Площадь, s.[Счет-Параметры] as Счет  from stack.свойства s  
where s.[Виды-Параметры]=5 and @rasch_date BETWEEN cast(s.ДатНач as date) and cast(s.ДатКнц as date)) as ls on
ls.Счет=#occ.occ_id
-- кол-во проживающих с учетом временного движения
left join
( select (isnull(total_ppl,0)-isnull(total_dv,0)) as total_ppl, prop.Лицевой лиц_пр  
  from (SELECT [Человек-Лицевой] as Лицевой, count(*) as total_ppl
  FROM [Stack].[stack].[Карточки регистрации]  
  where (CAST([Дата прописки] as date) <= EOMONTH(@rasch_date) and (CAST([Дата выписки] as date) > EOMONTH(@rasch_date) or [Дата выписки] is null) )
  group by [Человек-Лицевой]) as prop
  left join 
  (select count(*) as total_dv, [Счет-Движения] as Лицевой from stack.[Временное движение] where cast(ДатНач as date) < @rasch_date 
  and (cast(ДатКнц as date) > EOMONTH(@rasch_date) or ДатКнц is null)
  and Тип=0
  group by [Счет-Движения]) as dv
  on dv.Лицевой = prop.Лицевой) as ppl on ppl.лиц_пр = #occ.occ_id

) 

--------------------- заполнение таблицы для проверки исходящего сальдо ------------------------

--insert into stack.pts_checktable select Номер_ЛС as LCOUNT, Номер as KOD_UO, Гр_усл as KOD_USL, 
--sum(Разовые+Перерасчет) as SUM_PRR, sum(Сумма_платежей) as SUM_OPL, sum(ВХ_Сальдо) as SALDO_IN, sum(REAL_SALDO_OUT) as SALDO_OUT,
--sum(Начисл_сумма) as SUM_USL
--from temp

--group by  Номер_ЛС, Номер, Гр_усл
--order by KOD_UO,LCOUNT,KOD_USL
--select * from stack.PTS_checktable where SALDO_IN + SUM_USL + SUM_PRR - SUM_OPL <> SALDO_OUT


	    
------------------- заполнение таблицы для выгрузки -----------------------

insert into stack.pts_ls select Номер_ЛС as LCOUNT,'' as FIO, Адрес as ADRES, Номер as KOD_UO, УК as NAME_UO, Месяц as DATE_NACH, Псевд_номер as KOD_USL, Псевдоним as NAME_USL,
Тариф as TARIF, VID_NACH, NORMA as NORMA, sum(isnull(Начисл_объем,0)) as KOL_USL, Ед_изм as  ED_USL, sum(Начисл_сумма) as SUM_USL, sum(Разовые+Перерасчет) as SUM_PRR, Разовые_прим as DESC_PRR, sum(Сумма_платежей) as SUM_OPL,
Посл_опл as LDATE_OPL, sum(ВХ_Сальдо) as SALDO_IN, sum(ВХ_Сальдо + Начисл_сумма + Разовые + Перерасчет - Сумма_платежей) as SALDO_OUT, SCH1, SCH2, SCH3, SCH4, SCH5, Площадь as KOL_M2, Прописано as KOL_CHEL
from temp
where Номер <> 0 
group by  Номер_ЛС, Адрес, Номер, УК, Месяц, Псевд_номер, Псевдоним, Тариф, Ед_изм, Разовые_прим, Посл_опл, Площадь, Прописано, SCH1, SCH2, SCH3, SCH4, SCH5,VID_NACH, NORMA
order by KOD_UO,LCOUNT,KOD_USL

select * from stack.PTS_ls order by LCOUNT, KOD_UO, ADRES


drop table #occ

