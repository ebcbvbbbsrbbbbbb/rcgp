USE [Stack]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[getKvitPrinted] (@rasch_date date)
    RETURNS TABLE
    AS RETURN (
	with temp as (
SELECT distinct 
ki.[КвитИсполнители-Счет] as ls_id,
(select Номер from stack.[Лицевые счета] where row_id = ki.[КвитИсполнители-Счет]) as ЛС,
(
	case when (select Улица from stack.[AddrLs_Table](ki.[КвитИсполнители-Счет],0)) = ''
	then (select НП from stack.[AddrLs_Table](ki.[КвитИсполнители-Счет],0))
	else (select Улица from stack.[AddrLs_Table](ki.[КвитИсполнители-Счет],0))
	end
)	
as Улица,
(select Дом from stack.[AddrLs_Table](ki.[КвитИсполнители-Счет],0)) as Дом,
(select Квартира from stack.[AddrLs_Table](ki.[КвитИсполнители-Счет],0)) as Квартира,
ki.[КвитИсполнители-Макет] as Макет,
mk.Название as Назв_макета,
org1.ДЕЗНаим as Исп, org2.Наименование as Тек_УК,
count(*) over(partition by ki.[КвитИсполнители-Счет], org1.ДЕЗНаим ) as [Кол-во квит.]
  FROM stack.Квит_Исполнители ki 
  left join stack.Квит_Организации org1 on ki.[КвитИсполнители-ОргИсп] = org1.ROW_ID
  left join stack.[Макеты квитанций] mk on mk.ROW_ID = ki.[КвитИсполнители-Макет]
  left join stack.[УК лицевого] ukl on ukl.Счет = ki.[КвитИсполнители-Счет] and @rasch_date BETWEEN cast(ukl.ДатНач as date) and cast(ukl.ДатКнц as date)
  left join stack.Организации org2 on ukl.УК = org2.ROW_ID
  where cast (ki.Месяц as date) = @rasch_date  and [КвитИсполнители-ОргИсп] <> 17
    )
 select distinct TOP 9999999 лс, Улица, Дом,Квартира,/*Назв_макета,*/Исп, isnull(Тек_УК,Исп) Тек_УК, [Кол-во квит.],
   case when [Кол-во квит.]%2>0
	then FLOOR([Кол-во квит.]/2)+1
	else [Кол-во квит.]/2
  end as [Кол-во листов]  
  from temp
  order by Исп, Улица, Дом,Квартира
)


GO


