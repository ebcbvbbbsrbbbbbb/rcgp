----Пересчет по 307 за несколько периодов по электричеству на один дом


use it_gh
DECLARE	
	@occ int,
	@summa money,
	@servid char(4),
	@domnach double precision,
	@domper double precision,
	@domitogo double precision,
	@lsnach double precision,
	--@lsper1 double precision,
	@sumpols money,
	@summakor money,
	@sumdelta money,
	@ftstart int,
	@ftend int,
	@Vodn double precision,
	@Vdom double precision
	;
set @servid='элек'	;  --По услуге
--set @Vdom=199193; -- Общий объем потрбления по домовому счетчику

declare	@cml_history_tmp table(
	finterm_id int, occ_id int, service_id char(4), source_id int, mode_id int, external_flag int,
	state int, units decimal(16,6), cntr_bit int, cntr_units decimal(16,6), rate_id int not null, norma decimal(16,6), ex_norms decimal(16,6),
	people_count int null, cntr_norm decimal(16,6) null, management_company_id int null, rate_coeff decimal(16,6)
	)


declare  @domodn table
(ft int,
Vodn double precision, --всего по дому
Vnej double precision, -- нежилые
Vjil double precision, -- жилые
Vjil_nej double precision -- сумма жилых и нежилых за месяц
)

insert into @domodn --Общий объем потрбления по домовому счетчику по месяцам
(ft,Vodn,Vnej)
values (6,0,0),(7,17270,123),(8,17238,147),(9,0,283),(10,0,454),(11,13242,741),(12,9592,135),(13,10642,323),(14,12132,299),(15,0,57),(16,24542,0),(17,0,0),(18,28773,0),(19,0,682),(20,0,222);




declare  @lsper table
(ft int,
fio varchar(32),
adres varchar(255),
occ_id int,
lsnach double precision,
lsper double precision,
lsitogo double precision,
lsALL9 double precision,
lsODN double precision,
lsODNnew double precision,
lsODNdelta double precision,
domODN double precision,
sumper money)

set @ftstart=6;  ---Финпериоды за которые надо пересчитать
set @ftend=20;

--goto finish;

insert @cml_history_tmp(
		finterm_id, occ_id, service_id, source_id, mode_id, external_flag,
		state, units, cntr_bit, cntr_units, rate_id, norma, ex_norms,
		people_count, cntr_norm, management_company_id, rate_coeff)
	select	ph.finterm_id, cmlh.occ_id, cmlh.service_id, cmlh.source_id, cmlh.mode_id, cmlh.external_flag,
		cmlh.state, cmlh.units, cmlh.cntr_bit, cmlh.cntr_units, cmlh.rate_id, cmlh.norma, cmlh.ex_norms,
		cmlh.people_count, cmlh.cntr_norm, cmlh.management_company_id, cmlh.rate_coeff
	 
	FROM occupations o
	inner join [paym_history] ph on ph.OCC_ID=o.id 
	left join CML_HISTORY cmlh(NOLOCK) on cmlh.occ_id=ph.occ_id and cmlh.service_id=ph.type_id
	inner join FLATS f on f.ID=o.flat_id
    inner join BUILDINGS b on b.ID=f.BLDN_ID
    inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
	WHERE	
	 ph.type_id in (@servid ,'1008','2008')
	and	ph.finterm_id between @ftstart and @ftend
	and 
    (b.street_id=368 and b.bldn_no ='83А')
	 and
	cmlh.FINTERM_ID = (
			select max(cmlh2.FINTERM_ID) from CML_HISTORY cmlh2
			where	cmlh2.OCC_ID = ph.OCC_ID
			and	cmlh2.SERVICE_ID = cmlh.SERVICE_ID
			and	cmlh2.FINTERM_ID <= ph.finterm_id
		)

--select * from @cml_history_tmp
--where  occ_id=87000899
--order by finterm_id

--goto finish;

insert into @lsper
(ft,
fio,
adres,
occ_id ,
lsnach ,
lsper ,
lsitogo)
SELECT ph.finterm_id,o.INITIALS,o.ADDRESS, o.id, 
SUM(case when clh.cntr_bit>0 then clh.cntr_units else (ph.VALUE/(case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end)) end ),
SUM(ph.added/(case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end) ),
SUM(case when clh.cntr_bit>0 then clh.cntr_units else (ph.VALUE/(case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end))end )
    + SUM(ph.added/(case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end) )

  FROM occupations o
inner join [paym_history] ph on ph.OCC_ID=o.id 
inner join @cml_history_tmp clh on clh.occ_id=ph.occ_id and clh.service_id=ph.type_id and clh.finterm_id=ph.finterm_id
inner join [RATES_HISTORY] rh on rh.ID=clh.rate_id and rh.FINTERM_ID=clh.finterm_id
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
where t.IS_HISTORY=1  and b.TECHSUBDIV_ID in (50) 
and ph.type_id =@servid
and ph.finterm_id>=@ftstart and ph.finterm_id<=@ftend  
and 
(b.street_id=368 and b.bldn_no ='83А')
group by o.id,ph.finterm_id,o.INITIALS,o.ADDRESS

update @lsper
set lsnach=0
,lsitogo=0
where ft=7 and occ_id=87000882;

update @lsper
set lsper=0
,lsitogo=0
where ft=8 and occ_id=87000882;

----

update @lsper
set lsnach=0
,lsitogo=0
where ft=12 and occ_id=87000894;

update @lsper
set lsper=0
,lsitogo=lsnach
where ft=8 and occ_id=87000894;


update  lsp  -- Считаем начисленную сумму за освещение на ЛС
set lsODN=isnull((select SUM(case when clh.cntr_bit>0 then clh.cntr_units else (ph.VALUE/(case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end))end ) +SUM(ph.added/(case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end)  ) 
           from [paym_history] ph  
           inner join @cml_history_tmp clh on clh.occ_id=ph.occ_id and clh.service_id=ph.type_id and clh.finterm_id=ph.finterm_id
           inner join [RATES_HISTORY] rh on rh.ID=clh.rate_id and rh.FINTERM_ID=clh.finterm_id
           where ph.occ_id=lsp.occ_id
           and ph.finterm_id=lsp.ft -->=@ftstart and ph.finterm_id<=@ftend   
           and ph.type_id in ('1008','2008')
          ) ,0)
,domODN=0000000000000000000000000          
from @lsper lsp

update dod
set Vjil_nej=Vnej+(select SUM(lsp.lsitogo) from @lsper lsp where lsp.ft=dod.ft),
 Vjil=(select SUM(lsp.lsitogo) from @lsper lsp where lsp.ft=dod.ft)
from @domodn dod

select 		CASE
			when	datepart(mm, ft.START_DATE) = 1 then 'Январь'
			when	datepart(mm, ft.START_DATE) = 2 then 'Февраль'
			when	datepart(mm, ft.START_DATE) = 3 then 'Март'
			when	datepart(mm, ft.START_DATE) = 4 then 'Апрель'
			when	datepart(mm, ft.START_DATE) = 5 then 'Май'
			when	datepart(mm, ft.START_DATE) = 6 then 'Июнь'
			when	datepart(mm, ft.START_DATE) = 7 then 'Июль'
			when	datepart(mm, ft.START_DATE) = 8 then 'Август'
			when	datepart(mm, ft.START_DATE) = 9 then 'Сентябрь'
			when	datepart(mm, ft.START_DATE) = 10 then 'Октябрь'
			when	datepart(mm, ft.START_DATE) = 11 then 'Ноябрь'
			when	datepart(mm, ft.START_DATE) = 12 then 'Декабрь'
		END + ' ' + convert(char(4), datepart(yy, ft.START_DATE)) DATA,

d.* from @domodn d
left join FIN_TERMS ft on ft.ID=d.ft

select SUM(Vodn)vod,sum(Vjil_nej) vjnj,SUM(Vjil) vj from @domodn
select SUM (lsODN) slssvet from  @lsper

select @domnach=SUM(ph.lsnach),@domper=SUM(ph.lsper) , @domitogo=sum(ph.lsitogo) -- объем всего дома по услуге за несколько финпериодов
FROM @lsper ph

set @domitogo = @domitogo+3466; --добавлем объем нежилых

set @Vodn=@Vdom-@domitogo;  --объем ОДН коррекции 
---set @summakor

--print 'nach '+convert(varchar(18),@domnach)+' per '+convert(varchar(18),@domper)+ ' itogo '+convert(varchar(18),@domitogo)



update lp
set lsODNnew=cast(cast(lsitogo as double precision)* (dod.Vodn/cast(dod.Vjil_nej as double precision)-1) as double precision),
lsAll9=cast(cast(lsitogo as double precision)* (dod.Vodn/cast(dod.Vjil_nej as double precision)) as double precision)
from @lsper lp
inner join @domodn dod on dod.ft=lp.ft

update @lsper
set lsODNdelta =lsODNnew-lsODN ;

update lp
set sumper =cast(lsODNdelta* ( case when rh.C_VALUE = 0 then 2  else rh.C_VALUE end) as numeric(18,2))
from  @lsper lp
inner join @cml_history_tmp cm on cm.occ_id=lp.occ_id and cm.service_id=@servid
inner join [RATES_HISTORY] rh on rh.ID=cm.rate_id and rh.FINTERM_ID=cm.finterm_id


select 		CASE
			when	datepart(mm, ft.START_DATE) = 1 then 'Январь'
			when	datepart(mm, ft.START_DATE) = 2 then 'Февраль'
			when	datepart(mm, ft.START_DATE) = 3 then 'Март'
			when	datepart(mm, ft.START_DATE) = 4 then 'Апрель'
			when	datepart(mm, ft.START_DATE) = 5 then 'Май'
			when	datepart(mm, ft.START_DATE) = 6 then 'Июнь'
			when	datepart(mm, ft.START_DATE) = 7 then 'Июль'
			when	datepart(mm, ft.START_DATE) = 8 then 'Август'
			when	datepart(mm, ft.START_DATE) = 9 then 'Сентябрь'
			when	datepart(mm, ft.START_DATE) = 10 then 'Октябрь'
			when	datepart(mm, ft.START_DATE) = 11 then 'Ноябрь'
			when	datepart(mm, ft.START_DATE) = 12 then 'Декабрь'
		END + ' ' + convert(char(4), datepart(yy, ft.START_DATE))DATA,


l.* from @lsper l
left join FIN_TERMS ft on ft.ID=l.ft
--where occ_id=87000859 ---87000899

order by occ_id,ft

select sum(lsODN)oldodn, sum(lsODNnew)newodn,sum(lsALL9)all9,sum(lsODNdelta)delta,sum(sumper)per from @lsper

---goto finish;

---set @servid='элод'; --Разовые на ОДН услугу
	
DECLARE cOcc CURSOR FOR
SELECT l.occ_id,sum(l.sumper)
  FROM @lsper l
  where l.sumper<>0
  group by l.occ_id

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@summa

	WHILE @@FETCH_STATUS =0
		BEGIN 
		print cast(@occ as varchar(12))+' =   '+cast(@summa as varchar(18))
       --- exec ad_SetTechCorrectWitchDoc @occ,@servid,49,@summa      -- 38 - Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@summa
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc      

finish:


------------------