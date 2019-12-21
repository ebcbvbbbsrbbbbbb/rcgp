----Пересчет по 307 за несколько периодов по услуге на один дом
--- в @summakor ставится сумма данная ПТС

use it_gh
DECLARE	
	@occ int,
	@summa money,
	@servid char(4),
	@domnach money,
	@domper money,
	@domitogo money,
	@lsnach money,
	@lsper money,
	@sumpols money,
	@summakor money,
	@sumdelta money
	;
set @servid='1020'	;  --По услуге
set @summakor=327095.90;  --Сумма коррекции из ПТС

create table #lsper
(occ_id int,
lsnach money,
lsper money,
lsitogo money,
sumper money)


insert into #lsper
(occ_id ,
lsnach ,
lsper ,
lsitogo)
SELECT o.id, SUM(ph.VALUE),SUM(ph.added),SUM(ph.VALUE)+SUM(ph.added)
  FROM occupations o
inner join [paym_history] ph on ph.OCC_ID=o.id 
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
where t.IS_HISTORY=1  and b.TECHSUBDIV_ID in (67)
and ph.type_id =@servid
and ph.finterm_id>=3 and ph.finterm_id<=17  ---Финпериоды за которые надо пересчитать
and 
(b.street_id=287 and b.bldn_no ='12')
group by o.id

select @domnach=SUM(ph.lsnach),@domper=SUM(ph.lsper) -- начисление всего дома по услуге за несколько финпериодов
FROM #lsper ph

set @domitogo=@domnach+@domper;

print 'nach '+convert(varchar(18),@domnach)+' per '+convert(varchar(18),@domper)+ ' itogo '+convert(varchar(18),@domitogo)



update #lsper
set sumper=cast(cast(lsitogo as double precision)/cast(@domitogo as double precision)* @summakor as decimal(18,2))
;

select @sumpols=SUM(l.sumper)
from #lsper l

print @sumpols

set @sumdelta=@summakor-@sumpols

print @sumdelta

select top 1 @occ=occ_id
from #lsper l
order by sumper desc

update #lsper 
set sumper=sumper+@sumdelta
where occ_id=@occ

select @sumpols=SUM(l.sumper)
from #lsper l

print @sumpols

--drop table  #lsper

	
DECLARE cOcc CURSOR FOR
SELECT l.occ_id,l.sumper
  FROM #lsper l
  where l.sumper<>0

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@summa

	WHILE @@FETCH_STATUS =0
		BEGIN 
		print cast(@occ as varchar(12))+' - '+cast(@summa as varchar(18))
        exec ad_SetTechCorrectWitchDoc @occ,@servid,38,@summa      -- 38 - Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@summa
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc      

drop table  #lsper

------------------