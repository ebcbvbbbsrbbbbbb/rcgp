declare @text varchar(4000)
declare @ls int
declare @date_start date
declare @date_end date
declare @parent_folder int
declare @template_id int -- id сообщения, с которого берем текст и адрес родительской папки

set @template_id = 574
set @text = (select Текст from stack.[Сообщения в квитанции] where ROW_ID=@template_id) 
set @parent_folder = (select Папки from stack.[Сообщения в квитанции] where ROW_ID=@template_id)	
set @date_start = '20200101' 
set @date_end  = '20200101' 

declare cur cursor
for
(
	select Счет from stack.НСальдо	where Счет in 
	(select nt.Счет from stack.НПТариф nt	
	where [Номер услуги] = 6101	 and [Месяц расчета] = '20200101'
	and Поставщик=464  
	and Счет <> (select [Лицевой-Сообщение] from stack.[Сообщения в квитанции] where ROW_ID = @template_id) -- чтобы не дублировать уже введенное сообщение
	)
	and [Номер услуги]=6101   	
)  

open cur
fetch next from cur into @ls
while @@FETCH_STATUS=0
begin

insert into stack.[Сообщения в квитанции]
([Лицевой-Сообщение], [Договор-Сообщение], [УК Договор-Сообщение], ДатНач, ДатКнц, Признаки, Текст, Название, Папки, Папки_ADD, ТипАдресата, [Организация-Сообщение])
values (@ls, -1, -1, @date_start, @date_end, 0, @text, '', @parent_folder, 1, 1, -1)
fetch next from cur into @ls
end
close cur
deallocate cur

						