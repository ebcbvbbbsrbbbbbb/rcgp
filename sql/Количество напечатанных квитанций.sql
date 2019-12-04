use Stack
select Улица, Дом, Тек_УК, count(distinct лс) as [Количество лицевых на дом],
sum(count(distinct лс)) Over(partition by Тек_УК) as [Лицевых по УК],
sum([Кол-во квит.]) [Количество квитанций на дом], sum([Кол-во листов]) [Количество листов на дом],
sum(sum([Кол-во квит.])) over (partition by Тек_УК) as [Количество квитанций по УК],
sum(sum([Кол-во листов])) over (partition by Тек_УК) as [Количество листов по УК],
sum(sum([Кол-во квит.])) over () as [Количество квитанций всего],
sum(sum([Кол-во листов])) over () as [Количество листов всего],	
sum(count(distinct лс)) Over() as [Лицевых всего]
 from dbo.getKvitPrinted('2019-11-01')
group by Улица, Дом, Тек_УК
order by Тек_УК, Улица, Дом 
