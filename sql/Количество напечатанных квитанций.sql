  use Stack
declare @rasch_date date
set @rasch_date = '20191101'
;
with temp as (
SELECT distinct 
ki.[КвитИсполнители-Счет] as ls_id,
(select Номер from stack.[Лицевые счета] where row_id = ki.[КвитИсполнители-Счет]) as ЛС,
(select Улица from stack.[AddrLs_Table](ki.[КвитИсполнители-Счет],0)) as Улица,
(select Дом from stack.[AddrLs_Table](ki.[КвитИсполнители-Счет],0)) as Дом,
(select Квартира from stack.[AddrLs_Table](ki.[КвитИсполнители-Счет],0)) as Квартира,
ki.[КвитИсполнители-Макет] as Макет,
mk.Название as Назв_макета,
org1.ДЕЗНаим as Исп,
count(*) over(partition by ki.[КвитИсполнители-Счет], org1.ДЕЗНаим ) as [Кол-во квит.]
  FROM stack.Квит_Исполнители ki 
  left join stack.Квит_Организации org1 on ki.[КвитИсполнители-ОргИсп] = org1.ROW_ID
  left join stack.Квит_Организации org2 on ki.[КвитИсполнители-ОргПолуч] = org2.ROW_ID
  inner join stack.[Макеты квитанций] mk on mk.ROW_ID = ki.[КвитИсполнители-Макет]
  where cast (ki.Месяц as date) = @rasch_date  and [КвитИсполнители-ОргИсп] <> 17
    )
 select distinct лс, Улица,Дом,Квартира,/*Назв_макета,*/Исп, [Кол-во квит.],
   case when [Кол-во квит.]%2>0
	then FLOOR([Кол-во квит.]/2)+1
	else [Кол-во квит.]/2
  end as [Кол-во листов]  
  from temp
  order by Исп, Улица, Дом,Квартира