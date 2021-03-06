﻿USE [Stack]
GO
/****** Object:  StoredProcedure [dbo].[kassaGetDataFirstWithInn]    Script Date: 15.10.2019 11:41:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[kassaGetDataFirstWithInn] 
	
AS
BEGIN
	
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='kassa_export_history' AND xtype='U')	
	
	create table Stack.kassa_export_history      
		(
		[id] [int] IDENTITY(1,1) NOT NULL,
		[pack_id] [int] NOT NULL,
		[export_date] [date] NOT NULL,
		constraint pk_kassa_export_history primary key (id)
		) 
	
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='kassa_history' AND xtype='U')	
	
	create table Stack.kassa_history       
		(
		[id] [int] IDENTITY(1,1) NOT NULL,
		[vipiska_id] [int] NOT NULL,
		[vipiska_date] [date] NOT NULL,
		[pack_id] [int] NOT NULL,
		[pack_date] [date] NOT NULL,
		[pack_total] [numeric](29,2) NOT NULL,
		[occ_id] [int] NOT NULL,
		[email] [varchar] (255) default '',
		[paying_id] [int] NOT NULL,
		[service_name] [varchar](50) NOT NULL,
		[value]  [numeric](29,2) NOT NULL,
		[paying_date] [date] not null,
		[post_id] [int] NOT NULL,
		[post_name] [varchar] (255) NOT NULL,
		[isp_id] [int] NOT NULL,
		[isp_name] [varchar] (255) NOT NULL,
		[isp_inn] [int] NOT NULL,
		constraint pk_kassa_history primary key (id)
		) 
	

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='kassa_packs' AND xtype='U')	
	
	delete from Stack.kassa_packs
	
ELSE

/*
- платежи, пришедшие на счет РЦ
- платежи не от почты
*/
	create table [Stack].kassa_packs 
	(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[vipiska_id] [int] NOT NULL,
	[vipiska_date] [date] NOT NULL,
	[pack_id] [int] NOT NULL,
	[pack_date] [date] NOT NULL,
	[pack_total] [numeric](29,2) NOT NULL,
	[docsnum] int not null,
	[source] varchar (255) NOT NULL,
	[last_send] [date] default null,    
	[is_correct] [int] not null default 0  	
	constraint pk_kassa_packs primary key (id)

	) 	  
 
 
insert into Stack.kassa_packs
select distinct doc2.row_id as vipiska_id,  cast(doc2.Дата as date) as vipiska_date, doc.ROW_ID as pack_id, cast(doc.Дата as date) as pack_date, doc.Сумма as pack_total, 
doc.Кол_во as docsnum, org.Наименование as source , NULL as last_send, '0' as is_correct    
from stack.Документ doc inner join 	stack.[Список оплаты] so on so.[Платеж-Список] = doc.ROW_ID
inner join stack.[Расчеты с поставщиками (детально)] rsp on rsp.Платеж = so.ROW_ID  inner join 
stack.Документ doc2 on doc2.ROW_ID = doc.[Платеж-Выписка] inner join stack.Организации org on doc.[Источник-Платежи] = org.ROW_ID
where doc.[Тип документа]=67 and doc.ROW_ID not in (select pack_id from stack.kassa_export_history)  -- 67 тип - пачка платежей


IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='kassa_payments' AND xtype='U')	
	delete from Stack.kassa_payments
ELSE

	
	create table Stack.kassa_payments 
		(
		[id] [int] IDENTITY(1,1) NOT NULL,
		[pack_id] [int] NOT NULL,
		[occ_id] [int] NOT NULL,
		[email] [varchar] (255) default '',
		[paying_id] [int] NOT NULL,
		[service_name] [varchar](50) NOT NULL,
		[value]  [numeric](29,2) NOT NULL,
		[paying_date] [date] not null,
		[post_id] [int] NOT NULL,
		[post_name] [varchar] (255) NOT NULL,
		[isp_id] [int] NOT NULL,
		[isp_name] [varchar] (255) NOT NULL,
		[isp_inn] [varchar](255) default '',
		
		constraint pk_kassa_payments primary key (id)
		) 
		   	
INSERT INTO stack.kassa_payments select doc.ROW_ID as pack_id, ls.Номер as occ_id, kr.email as email, rsp.Платеж as paying_id, 
tu.Наименование as service_name, sum(rsp.Сумма) as value, rsp.ДатаОплаты as paying_date, org.ROW_ID as post_id, org.Наименование as post_name,
case 
	when uk.[Вид договора] = 2
	then org.ROW_ID
	else org2.ROW_ID
end as isp_id, 

case 
	when uk.[Вид договора] = 2
	then org.Наименование
	else org2.Наименование
end as isp_name,
case 
	when uk.[Вид договора] = 2
	then org.ИНН
	else org2.ИНН
end as isp_inn 
from stack.[Расчеты с поставщиками (детально)] rsp	inner join stack.[Лицевые счета] ls on ls.ROW_ID = rsp.Счет 
inner join stack.[Список оплаты] so on so.ROW_ID = rsp.Платеж 
inner join stack.Документ doc on doc.ROW_ID = so.[Платеж-Список]
inner join stack.[Карточки регистрации] kr on kr.row_id =  ls.[Счет-Наниматель]
inner join stack.Организации org on org.ROW_ID = rsp.Поставщик 
inner join stack.[УК договоры] uk on uk.ROW_ID = rsp.УКДоговор 
inner join stack.Организации org2 on org2.ROW_ID = uk.[Организация-УКДоговор]
inner join stack.[Типы услуг] tu on tu.[Номер услуги] = rsp.Услуга
where rsp.Платеж  in (select row_id from stack.[Список оплаты] 
where [Платеж-Список] in (select pack_id from stack.kassa_packs ) )
group by  ls.Номер, kr.email , rsp.Платеж, rsp.Услуга, rsp.ДатаОплаты, org.Наименование, org2.Наименование, uk.[Вид договора],
org.ИНН, org2.ИНН, tu.Наименование, doc.ROW_ID, org.ROW_ID, org2.ROW_ID
order by doc.ROW_ID

-------------------------------------------------------

declare @pack_id int, @occ_id int, @otr money, @pol money
declare cur_packs cursor for 
select distinct pack_id from
stack.kassa_payments where value<0 
open cur_packs
fetch next from cur_packs into @pack_id -- Ищем номера пачек kassa_payments, в которых присутсвуют отрицательные платежи
	while @@fetch_status=0              
begin
	print('Работаем с пачкой: '+cast(@pack_id as varchar));
		declare cur_occ cursor for select distinct occ_id from stack.kassa_payments where pack_id = @pack_id and value<0 
		open cur_occ                -- Все уникальные ЛС с отрицательными платежами из таблицы kassa_payments
		fetch next from cur_occ into @occ_id
		while @@fetch_status = 0
		  begin
			
			print('Лицевой счет: '+cast(@occ_id as varchar));
			select @otr = (select sum(value) from stack.kassa_payments where value<0 and occ_id=@occ_id and pack_id = @pack_id) -- Сумма отрицательных платежей в пачке с данного ЛС
			select @pol = (select sum(value) from stack.kassa_payments where value>0 and occ_id=@occ_id and pack_id = @pack_id) -- Сумма положительных платежей в пачке с данного ЛС 
			print('Сумма отрицательных значений: '+cast(@otr as varchar));
			print('Сумма положительных значений: '+cast(@pol as varchar));
			IF (@otr + @pol) = 0 -- Если сумма положительных и отрицательных платежей с данного ЛС = 0, удаляем все платежи из таблицы kassa_payments
			begin 
				print('Удаляем платежи из пачки ' +cast(@pack_id as varchar) + ' по лицевому счету ' + cast(@occ_id as varchar)) 
				delete from stack.kassa_payments where pack_id = @pack_id and occ_id = @occ_id
			end
			ELSE
			begin
				print('Сумма положительных и отрицательных платежей не сходится, ничего не делаю.') --Если сумма положительных и отрицательных платежей <> 0 - ничего не делаем
				update stack.kassa_packs set is_correct=1 where pack_id = @pack_id;
			end
			fetch next from cur_occ into @occ_id											    --помечаем поле is_correct в таблице payment_packs для данной пачки
		  end
		close cur_occ
		deallocate cur_occ	
	fetch next from cur_packs into @pack_id
end
close cur_packs
deallocate cur_packs

-- Проверяем на наличие пустых пачек (могли возникнуть после удаления платежей) 

declare @payments_quantity int -- Номер пачки и количество платежей в ней
declare cur_check cursor for
select pack_id from stack.kassa_packs 
open cur_check
fetch next from cur_check into @pack_id

while @@fetch_status = 0
begin
SELECT @payments_quantity =  (select COUNT(1) FROM stack.kassa_payments WHERE pack_id = @pack_id)
if @payments_quantity <> 0 
print ('# Пачка: '+ cast (@pack_id as varchar) +' Платежей: '+ cast (@payments_quantity as varchar)+' #)
else
	begin
		print ('# Пачка: '+ cast (@pack_id as varchar) +' не содержит платежей. Удаляем. #')
		delete from stack.kassa_packs where pack_id = @pack_id
	end
fetch next from cur_check into @pack_id
end
close cur_check
deallocate cur_check

--Проставляем дату последней выгрузки в поле last_send таблицы kassa_packs 

declare @last_send date -- Номер пачки и дата отправки из таблицы kassa_export_history
declare cur_set_senddate cursor  for
select pack_id from stack.kassa_packs 
open cur_set_senddate
fetch next from cur_set_senddate into @pack_id

while @@fetch_status = 0
begin
SELECT @last_send = export_date FROM stack.kassa_export_history kh WHERE kh.pack_id = @pack_id 
if  @last_send is not null
	begin
		print ('---------Пачка: '+ cast (@pack_id as varchar) +' была отправлена. Устанавливаем дату в payment_packs.'+ cast (@last_send as varchar)+'---------')
		Update stack.kassa_packs SET last_send = @last_send where pack_id = @pack_id
		select @last_send = null
	end
else
print ('# Пачка: '+ cast (@pack_id as varchar) +' еще не отправлялась #')
fetch next from cur_set_senddate into @pack_id
end
close cur_set_senddate
deallocate cur_set_senddate

END


