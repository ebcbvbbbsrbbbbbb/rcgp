use Stack
----  АВИЗО ПТС
SELECT doc.дата as [Дата], ist.Наименование as Источник, isp.Наименование as Исполнитель, sum(opv.Сумма) as Сумма 
 from Stack.Документ doc  inner join stack.Организации ist on ist.ROW_ID = doc.[Источник-Платежи]		-- источник платежей
inner join stack.[Список оплаты] so on so.[Платеж-Список] = doc.ROW_ID	                                 -- платеж
inner join stack.[Оплата по видам] opv on opv.[Распределение-Платеж]=so.ROW_ID
left join stack.[Типы услуг] tu on tu.ROW_ID = opv.[Распределение-Услуга]
left join stack.Организации isp on isp.ROW_ID = opv.[Распределение-УК]	   
where doc.[Тип документа]=67 and cast(doc.Дата	as date) = '2019-11-05' and doc.[Наш р/с-Платежи] = -1	and ist.ROW_ID=500
group by  doc.дата, ist.Наименование, isp.Наименование

----  АВИЗО УК
SELECT doc.дата as [Дата], ist.Наименование as Источник, isp.Наименование as Исполнитель, sum(opv.Сумма) as Сумма 
 from Stack.Документ doc  inner join stack.Организации ist on ist.ROW_ID = doc.[Источник-Платежи]		-- источник платежей
inner join stack.[Список оплаты] so on so.[Платеж-Список] = doc.ROW_ID	                                 -- платеж
inner join stack.[Оплата по видам] opv on opv.[Распределение-Платеж]=so.ROW_ID
left join stack.[Типы услуг] tu on tu.ROW_ID = opv.[Распределение-Услуга]
left join stack.Организации isp on isp.ROW_ID = opv.[Распределение-УК]	   
where doc.[Тип документа]=67 and cast(doc.Дата	as date) = '2019-11-06' and doc.[Наш р/с-Платежи] = -1	and ist.ROW_ID=451
group by  doc.дата, ist.Наименование, isp.Наименование