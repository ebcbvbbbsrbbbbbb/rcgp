----Пересчет по 307 за несколько периодов по услуге на один дом
--- в @summakor ставится сумма данная ПТС

use it_gh
DECLARE	
	@occ int,
	@summa money,
	@servid char(4),
	@domnach double precision,
	@domper double precision,
	@domitogo double precision,
	@lsnach double precision,
	@lsper double precision,
	@sumpols money,
	@summakor money,
	@sumdelta money,
	@ftstart int,
	@ftend int,
	@Vodn double precision,
	@Vdom double precision
	;
set @servid='элек'	;  --По услуге
set @Vdom=199193; -- Общий объем потрбления по домовому счетчику

create table #lsper
(occ_id int,
lsnach double precision,
lsper double precision,
lsitogo double precision,
lsODN double precision,
lsODNnew double precision,
lsODNdelta double precision,
sumper money)

set @ftstart=6;  ---Финпериоды за которые надо пересчитать
set @ftend=20;

insert into #lsper
(occ_id ,
lsnach ,
lsper ,
lsitogo)
SELECT o.id, 
SUM(ph.VALUE/(case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end) ),
SUM(ph.added/(case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end) ),
SUM(ph.VALUE/(case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end) )+
SUM(ph.added/(case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end) )

  FROM occupations o
inner join [paym_history] ph on ph.OCC_ID=o.id 
inner join CML_HISTORY clh on clh.occ_id=ph.occ_id and clh.service_id=ph.type_id and clh.finterm_id=ph.finterm_id
inner join [RATES_HISTORY] rh on rh.ID=clh.rate_id and rh.FINTERM_ID=clh.finterm_id
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
where t.IS_HISTORY=1  and b.TECHSUBDIV_ID in (50)
and ph.type_id =@servid
and ph.finterm_id>=@ftstart and ph.finterm_id<=@ftend  
and 
(b.street_id=368 and b.bldn_no ='83А')
group by o.id

update  lsp  -- Считаем начисленную сумму за освещение на ЛС
set lsODN=isnull((select SUM(ph.VALUE/(case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end) )+SUM(ph.added/(case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end) ) from [paym_history] ph  
           inner join CML_HISTORY clh on clh.occ_id=ph.occ_id and clh.service_id=ph.type_id and clh.finterm_id=ph.finterm_id
           inner join [RATES_HISTORY] rh on rh.ID=clh.rate_id and rh.FINTERM_ID=clh.finterm_id
           where ph.occ_id=lsp.occ_id
           and ph.finterm_id>=@ftstart and ph.finterm_id<=@ftend   
           and ph.type_id in ('1008','2008')
          ) ,0)
from #lsper lsp



select @domnach=SUM(ph.lsnach),@domper=SUM(ph.lsper) , @domitogo=sum(ph.lsitogo) -- объем всего дома по услуге за несколько финпериодов
FROM #lsper ph

set @domitogo = @domitogo+3466; --добавлем объем нежилых

set @Vodn=@Vdom-@domitogo;  --объем ОДН коррекции 
---set @summakor

print 'nach '+convert(varchar(18),@domnach)+' per '+convert(varchar(18),@domper)+ ' itogo '+convert(varchar(18),@domitogo)



update #lsper
set lsODNnew=cast(cast(lsitogo as double precision)/cast(@domitogo as double precision)* @Vodn as double precision)

update #lsper
set lsODNdelta =lsODNnew-lsODN ;

update #lsper
set sumper =cast(lsODNdelta*2.0 as numeric(18,2));

select * from #lsper
order by 1

---goto finish;

set @servid='элод'; --Разовые на ОДН услугу
	
DECLARE cOcc CURSOR FOR
SELECT l.occ_id,l.sumper
  FROM #lsper l
  where l.sumper<>0

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@summa

	WHILE @@FETCH_STATUS =0
		BEGIN 
		print cast(@occ as varchar(12))+' - '+cast(@summa as varchar(18))
       --- exec ad_SetTechCorrectWitchDoc @occ,@servid,49,@summa      -- 38 - Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@summa
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc      

finish:
drop table  #lsper

------------------