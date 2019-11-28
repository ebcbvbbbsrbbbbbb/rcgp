 use Stack
 IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME='PTS_dolg' AND xtype='U')   
   
    create table Stack.PTS_dolg
(
  LS NUMERIC(10,0),
  FIO char(33),
  ULICA char(51),
  DOM char(16),
  KV char(11),
  KOD_UO numeric(5,0),
  NAME_UO char (50),
  DATE_NACH date,
  DOLG_GV numeric(15,2),
  DOLG_OTOP numeric(15,2),
  DOLG numeric (10,2),
  KOL_CHEL numeric(10,0),
  KOL_M2 numeric(10,2)
)

ELSE DELETE FROM stack.PTS_dolg

 declare @rasch_date date
 set @rasch_date = '2019-11-01'

create table #occ 
(
 occ_id int,
 ls varchar(255),
 service int,
 service_group int,
 uk_dog int,
 rasch_date date,
 isITP int,
)
	 --drop table #occ
----------- Входящее сальдо
insert into #occ
select distinct ns.Счет occ_id, (select Номер from stack.[Лицевые счета] where row_id = ns.Счет) ls, ns.[Номер услуги] service, 
tui.РодительНомер service_group, ns.ДоговорУК uk_dog, @rasch_date as rasch_date, 
case when(select count(*) from stack.[Список услуг] su inner join stack.[Типы услуг] tu on tu.ROW_ID=su.[Вид-Услуги] 
where su.[Счет-Услуги]=ns.Счет and tu.[Внешний код 1]=28)	> 0
then 1 
else 0
end as isitp
from stack.НСальдо ns inner join stack.[Типы услуг иерархия] tui on tui.ПотомокНомер = ns.[Номер услуги] 
where (CAST([Месяц расчета]	as date) = DATEADD(MONTH,-2,@rasch_date) and Поставщик = 1305 and tui.РодительТип=2 and ns.Сумма <> 0)
or (CAST([Месяц расчета]	as date) = DATEADD(MONTH,-2,@rasch_date) and Поставщик = 765 and tui.РодительТип=2 and ns.Сумма <> 0 and tui.РодительНомер in (400,2000,2100,4700))
or (CAST([Месяц расчета]	as date) = DATEADD(MONTH,-2,@rasch_date) and Поставщик = 972 and tui.РодительТип=2 and ns.Сумма <> 0 and tui.РодительНомер in (400,2000,2100,4700) and exists(select 1 from stack.[Лицевые иерархия] where Потомок=ns.Счет and Родитель=943))

------------- начисления
union	
select distinct ns.Счет occ_id, (select Номер from stack.[Лицевые счета] where row_id = ns.Счет) ls, ns.[Номер услуги] service,
 tui.РодительНомер service_group, ns.ДоговорУК uk_dog, @rasch_date rasch_date, 
case when(select count(*) from stack.[Список услуг] su inner join stack.[Типы услуг] tu on tu.ROW_ID=su.[Вид-Услуги] 
where su.[Счет-Услуги]=ns.Счет and tu.[Внешний код 1]=28)	> 0
then 1 
else 0
end  as itp
from stack.НТариф ns inner join stack.[Типы услуг иерархия] tui on tui.ПотомокНомер = ns.[Номер услуги] 
where (CAST([Месяц расчета]	as date) = DATEADD(MONTH,-1,@rasch_date) and Поставщик = 1305 and tui.РодительТип=2 and ns.Сумма <> 0)
or ((CAST([Месяц расчета]	as date) = DATEADD(MONTH,-1,@rasch_date) and Поставщик = 765 and tui.РодительТип=2 and ns.Сумма <> 0 and tui.РодительНомер in (400,2000,2100,4700)))
or ((CAST([Месяц расчета]	as date) = DATEADD(MONTH,-1,@rasch_date) and Поставщик = 972 and tui.РодительТип=2 and ns.Сумма <> 0 and tui.РодительНомер in (400,2000,2100,4700) and exists(select 1 from stack.[Лицевые иерархия] where Потомок=ns.Счет and Родитель=943)))

------------ разовые
union 		
select distinct ns.Счет occ_id, (select Номер from stack.[Лицевые счета] where row_id = ns.Счет) ls, ns.[Номер услуги] as service,
 tui.РодительНомер service_group,  ns.ДоговорУК uk_dog,  @rasch_date rasch_date, 
case when(select count(*) from stack.[Список услуг] su inner join stack.[Типы услуг] tu on tu.ROW_ID=su.[Вид-Услуги] 
where su.[Счет-Услуги]=ns.Счет and tu.[Внешний код 1]=28)	> 0
then 1 
else 0
end  as itp 
from stack.[РН список] ns inner join stack.[Типы услуг иерархия] tui on tui.ПотомокНомер = ns.[Номер услуги] 
where CAST([Месяц расчета]	as date) = DATEADD(MONTH,-1,@rasch_date) and Поставщик = 1305 and tui.РодительТип=2 and ns.Сумма <> 0
or (CAST([Месяц расчета]	as date) = DATEADD(MONTH,-1,@rasch_date) and Поставщик = 765 and tui.РодительТип=2 and ns.Сумма <> 0 and tui.РодительНомер in (400,2000,2100,4700))
or (CAST([Месяц расчета] 	as date) = DATEADD(MONTH,-1,@rasch_date) and Поставщик = 972 and tui.РодительТип=2 and ns.Сумма <> 0 and tui.РодительНомер in (400,2000,2100,4700) and exists(select 1 from stack.[Лицевые иерархия] where Потомок=ns.Счет and Родитель=943))

----------- платежи
union 	
 select distinct so.[Счет-Оплата] as occ_id, (select Номер from stack.[Лицевые счета] where row_id = so.[Счет-Оплата]) as ls,
 tu.[Номер услуги] as service, tui.РодительНомер as service_group, ukd.ROW_ID as uk_dog, @rasch_date rasch_date,
 case when(select count(*) from stack.[Список услуг] su inner join stack.[Типы услуг] tu on tu.ROW_ID=su.[Вид-Услуги] 
where su.[Счет-Услуги]=so.[Счет-Оплата] and tu.[Внешний код 1]=28)	> 0
then 1 
else 0
end  as itp
 from stack.[Оплата по видам] opv left join stack.[Список оплаты] so on so.ROW_ID = opv.[Распределение-Платеж]
 left join stack.[Типы услуг] tu on tu.ROW_ID = opv.[Распределение-Услуга]
 left join stack.[Типы услуг иерархия] tui  on tui.ПотомокНомер = tu.[Номер услуги]
 left join stack.Организации org on opv.[Распределение-УК] =  org.ROW_ID
 left join stack.[УК договоры] ukd on ukd.[Организация-УКДоговор] = org.ROW_ID
 where 
 (opv.Тип <> 2 and cast (so.Дата as date) between DATEADD(month,-1,@rasch_date) and EOMONTH(@rasch_date) and tui.РодительТип = 2 and opv.[Распределение-Пост] = 1305 and ukd.Номер<>0) or 
 ((opv.Тип <> 2 and cast (so.Дата as date) between DATEADD(month,-1,@rasch_date) and EOMONTH(@rasch_date) and tui.РодительТип = 2 and opv.[Распределение-Пост] = 765) and tui.РодительНомер in (400,2000,2100,4700) and ukd.Номер<>0) or
 ((opv.Тип <> 2 and cast (so.Дата as date) between DATEADD(month,-1,@rasch_date) and EOMONTH(@rasch_date) and tui.РодительТип = 2 and opv.[Распределение-Пост] = 972) and tui.РодительНомер in (400,2000,2100,4700) 
 and exists(select 1 from stack.[Лицевые иерархия] where Потомок=so.[Счет-Оплата] and Родитель=943) and ukd.Номер<>0) 
 ;


 with temp as (																  
select #occ.occ_id as ЛС, ls as Номер_ЛС,
cast ((select ФИО  from stack.[Карточки регистрации] where [Счет-Наниматель] = #occ.occ_id) as char(33)) as ФИО, 
(select Улица from stack.[AddrLs_Table](#occ.occ_id,0)) as Улица,
(select Дом from stack.[AddrLs_Table](#occ.occ_id,0)) as Дом,
(select Квартира from stack.[AddrLs_Table](#occ.occ_id,0)) as Квартира,
 stack.AddrLs(#occ.occ_id,1) Адрес, ukd.Номер, org.Название as УК,  #occ.rasch_date as Месяц, 
#occ.service as Ном_усл, #occ.service_group as Гр_усл, #occ.uk_dog,
isnull(nt.Начисл_сумма,0) as Начисл_сумма, 
isnull(rn.Сумма_разовых,0) as Разовые, 
isnull(perer.Начисл_сумма,0) as Перерасчет,
isnull(opl.Сумма,0) as Сумма_платежей,
isnull(ns.Сумма,0) as ВХ_Сальдо, 
isnull(ls.Площадь,0) as Площадь, 
isnull(ppl.total_ppl,0) as Прописано, 
#occ.isITP as ITP

from #occ 
-- управляющая компания
left join stack.[УК договоры] ukd on #occ.uk_dog=ukd.ROW_ID
left join stack.Организации org on org.ROW_ID = ukd.[Организация-УКДоговор]
-- входящее сальдо
left join (select sum(Сумма) as сумма, [Номер услуги], ДоговорУК, Счет from stack.НСальдо where CAST([Месяц расчета] as date) = DATEADD(MONTH,-2,@rasch_date)  
 group by [Номер услуги], ДоговорУК, Счет)
as ns on ns.ДоговорУК=#occ.uk_dog and ns.[Номер услуги] = #occ.service and #occ.occ_id = ns.Счет 
-- начисления
left join (select sum(Сумма) as Начисл_сумма, [Номер услуги], ДоговорУК, Счет, ИспользованТариф 
from stack.[Начисления лицевых] nl where cast([Месяц расчета] as date)=DATEADD(MONTH,-1,@rasch_date) and Сумма <> 0 and 
Поставщик = 
	case when exists (select 1 from stack.[Лицевые иерархия] where Потомок = Счет and Родитель = 943 and РодительТип=3)
	then 972
	else 1305
	end 
and Аналитика2<>777 and Тип <> 'ПТариф'   group by [Номер услуги], ДоговорУК, Счет, ИспользованТариф)
as nt on nt.[Номер услуги] = #occ.service and #occ.occ_id = nt.Счет and	nt.ДоговорУК= #occ.uk_dog
-- перерасчеты
left join (select sum(Сумма) as Начисл_сумма, sum(Объем) as Начисл_объем, [Номер услуги], ДоговорУК, Счет
from stack.[Начисления лицевых] nl where cast([Месяц расчета] as date)=DATEADD(MONTH,-1,@rasch_date) and Сумма <> 0 and Поставщик = 1305 and Тип='Птариф'   group by [Номер услуги], ДоговорУК, Счет)
as perer on perer.ДоговорУК=#occ.uk_dog and perer.[Номер услуги] = #occ.service and #occ.occ_id = perer.Счет 
-- разовые
left join (select sum(rns.Сумма) as Сумма_разовых, rns.[Номер услуги], rns.ДоговорУК, rns.Счет 
from stack.[РН список] rns inner join stack.[РН документ] rnd on rns.[РН-Список] = rnd.ROW_ID where cast(rns.[Месяц расчета] as date)=DATEADD(MONTH,-1,@rasch_date)
group by  rns.[Номер услуги], rns.ДоговорУК, rns.Счет) as rn
on rn.[Номер услуги]  = #occ.service and rn.Счет = #occ.occ_id and rn.ДоговорУК=#occ.uk_dog 
-- платежи
 left join 
(
select sum(opv.Сумма) Сумма, tu.[Номер услуги], ukd.ROW_ID, so.[Счет-Оплата] from stack.[Оплата по видам] opv 
 left join stack.[Список оплаты] so on so.ROW_ID = opv.[Распределение-Платеж]
 left join stack.[Типы услуг] tu on tu.ROW_ID = opv.[Распределение-Услуга]
 left join stack.[Типы услуг иерархия] tui  on tui.ПотомокНомер = tu.[Номер услуги]
 left join stack.Организации org on opv.[Распределение-УК] =  org.ROW_ID
 left join stack.[УК договоры] ukd on ukd.[Организация-УКДоговор] = org.ROW_ID
  where 
 (opv.Тип <> 2 and cast (so.Дата as date) between DATEADD(month,-1,@rasch_date) and EOMONTH(@rasch_date) and tui.РодительТип = 2 and opv.[Распределение-Пост] = 1305 and ukd.Номер<>0) or 
 ((opv.Тип <> 2 and cast (so.Дата as date) between DATEADD(month,-1,@rasch_date) and EOMONTH(@rasch_date) and tui.РодительТип = 2 and opv.[Распределение-Пост] = 765) and tui.РодительНомер in (400,2000,2100,4700) and ukd.Номер<>0) or
 ((opv.Тип <> 2 and cast (so.Дата as date) between DATEADD(month,-1,@rasch_date) and EOMONTH(@rasch_date) and tui.РодительТип = 2 and opv.[Распределение-Пост] = 972) and tui.РодительНомер in (400,2000,2100,4700) 
 and exists(select 1 from stack.[Лицевые иерархия] where Потомок=so.[Счет-Оплата] and Родитель=943) and ukd.Номер<>0) 
 group by tu.[Номер услуги], ukd.ROW_ID, so.[Счет-Оплата]
) as opl on opl.[Счет-Оплата] = #occ.occ_id and opl.[Номер услуги] = #occ.service and opl.ROW_ID = #occ.uk_dog
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
 
--select * from temp where Номер_ЛС=25001407

insert into stack.pts_dolg	
	select Номер_ЛС, ФИО, Улица, Дом, Квартира, Номер, УК, @rasch_date,
	sum(case when Гр_усл in (2000,2100) 
		then ВХ_Сальдо + Начисл_сумма + Разовые + Перерасчет - Сумма_платежей
		else 0
	end),
		sum(case when Гр_усл in (400) 
		then ВХ_Сальдо + Начисл_сумма + Разовые + Перерасчет - Сумма_платежей
		else 0
	end),
		sum(ВХ_Сальдо + Начисл_сумма + Разовые + Перерасчет - Сумма_платежей
	),
	 Прописано, Площадь	
	 from temp 
 	 group by Номер_ЛС, Улица, Дом, Квартира, Номер, УК, Площадь, Прописано, ФИО

 
  select 
  LS,
  FIO,
  ULICA,
  DOM,
  KV,
  KOD_UO,
  NAME_UO,
  DATE_NACH,
  case when DOLG_GV<0 or DOLG_OTOP <0
  then
	  case when DOLG_GV+DOLG_OTOP<=0
		then 0
		else 
			case when DOLG_GV>DOLG_OTOP
			then DOLG_GV-DOLG_OTOP
			else 0
		end
	  end
  else DOLG_GV
  end as DOLG_GV,
  case when DOLG_GV<0 or DOLG_OTOP <0
   then
    case when DOLG_GV+DOLG_OTOP<=0
	then 0
	else 
		case when DOLG_OTOP>DOLG_GV
		then DOLG_OTOP-DOLG_GV
		else 0
	end
  end 
  else DOLG_OTOP
  end as DOLG_OTOP,
  DOLG,
	KOL_CHEL,
	KOL_M2  
   from stack.PTS_dolg where DOLG>0
  order by KOD_UO ,ULICA,DOM,KV,LS
 
  --drop table #occ

 
 
 
 
   select * from #occ


 
