/****** Сценарий для команды SelectTopNRows среды SSMS  ******/
select top 100 *
  FROM [it_gh].[dbo].[KOD25]
  
  
  "Машиниста Переулок"
--update k
  set DOM= case when DOM='' then null else ltrim(rtrim(DOM)) end
  FROM [it_gh].[dbo].[KOD25] k
  
  ------------------------
  
  select l.*,
   (select top 1 UL from [it_gh].[dbo].[KOD25] k where k.ls=l.ls8) UL,
   (select top 1 DOM from [it_gh].[dbo].[KOD25] k where k.ls=l.ls8) DOM,
   (select top 1 KV from [it_gh].[dbo].[KOD25] k where k.ls=l.ls8) KV
  from [it_gh].[dbo].LS25 l
  --left join [it_gh].[dbo].[KOD25] k on k.ls=l.ls8
  where l.occ is null
  order by 3,4,5
  
  -----------
  
   update l
  set occ=25000976  
  from [it_gh].[dbo].LS25 l
  where ls8=2500976
  
 ---------------- 
  select *    
  FROM [it_gh].[dbo].LS25 l
  where not exists (select 1 from it_gh.dbo.OCCUPATIONS o where o.ID=l.occ)
  
  --insert into [it_gh].[dbo].LS25
  (LS8)
  select distinct LS FROM [it_gh].[dbo].[KOD25] k
  
  --update l
  set occ=ls8+25000000
  from [it_gh].[dbo].LS25 l
  where exists(select 1 from  [it_gh].[dbo].[KOD25] k where k.ls=l.ls8 and k.ul='Машиниста Переулок' and k.dom='9')
  
  
-----------------------



use it_gh
select kk.*,l.* , o.ADDRESS  from
ls25 l 
  inner join 
  (SELECT distinct ls,KUL,UL,DOMN,KV
   FROM [KOD25]
   ) kk 
   on kk.LS=l.LS8
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID and b.TECHSUBDIV_ID=25 
  inner join xSTREETS s on s.ID=b.STREET_ID
  
  where kk.KUL<>b.STREET_ID or kk.DOMN<>b.BLDN_NO
  or kk.KV<>f.FLAT_NO
 -- or b.TECHSUBDIV_ID<>25
order by 3,4,5
---------------------


use it_gh
select kk.*,o.ID LS ,o.HEATING_SQ OTOPPL,o.COMBINED_SQ SOVOKPL,o.TOTAL_SQ OBPL, o.ADDRESS  from
ls25 l 
  inner join 
  (SELECT ls LS8 ,max(k.OTOPPL)PLOTOP8,MAX(k.SOVPL) PLSOVOK8
   FROM [KOD25] k
   group by ls
   ) kk 
   on kk.LS8=l.LS8
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID and b.TECHSUBDIV_ID=25 
  inner join xSTREETS s on s.ID=b.STREET_ID
  
  where abs(kk.PLOTOP8-o.HEATING_SQ)>0.001  
  or abs(kk.PLSOVOK8-o.COMBINED_SQ)>0.001  
  
 -- or b.TECHSUBDIV_ID<>25
order by  ADDRESS ---3,4,5
------------------------------

select top 1000 o.ADDRESS,o.ID LS ,o.INITIALS FIO, kk.LS8,kk.fio8  from
ls25 l 
  inner join 
  (SELECT ls LS8 ,max(k.FIO) fio8
   FROM [KOD25] k
   group by ls
   ) kk 
   on kk.LS8=l.LS8
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID and b.TECHSUBDIV_ID=25 
  inner join xSTREETS s on s.ID=b.STREET_ID
  
  where kk.fio8<>(select top 1
	             p.LAST_NAME
                from
	            people		p
                where
	            p.who_id = 'отвл'
	            and p.OCC_ID=o.ID)
  
 -- or b.TECHSUBDIV_ID<>25
order by  ADDRESS ---3,4,5
-------------------------------



use it_gh

select top 1000 o.ADDRESS,o.ID LS ,o.INITIALS FIO,o.TOTAL_PEOPLE PIPL,  kk.LS8,kk.chel CHEL8  from
ls25 l 
  inner join 
  (SELECT ls LS8 ,max(k.CHEL) chel
   FROM [KOD25] k
   group by ls
   ) kk 
   on kk.LS8=l.LS8
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID and b.TECHSUBDIV_ID=25 
  inner join xSTREETS s on s.ID=b.STREET_ID
  
  where kk.chel<>o.TOTAL_PEOPLE
  
 -- or b.TECHSUBDIV_ID<>25
order by  ADDRESS ---3,4,5
 
--------------------------------


select *
from
ls25 l 
  inner join 
  (SELECT ls LS8 , max(k.RATE) tarif,(select  isnull(max(cast(k2.SOVPL as numeric(18,3))),0) m  FROM [KOD25] k2 where k2.LS=k.LS) sovpl
   FROM [KOD25] k
   where k.USL='ВМ' 
   group by ls
   ) kk 
  on kk.LS8=l.LS8    and kk.sovpl>0.0
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
where NOT exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=o.ID and cl.SERVICE_ID='1015' and cl.MODE_ID % 1000 <>0)

--------------------------------

select  *
from
ls25 l 
  inner join 
  (SELECT ls LS8 , max(k.RATE) tarif,(select  isnull(max(cast(k2.SOVPL as numeric(18,3))),0) m  FROM [KOD25] k2 where k2.LS=k.LS) sovpl
   FROM [KOD25] k
   where k.USL='ТО' 
   group by ls
   ) kk 
  on kk.LS8=l.LS8    and kk.sovpl>0.0
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID and b.TECHSUBDIV_ID=25 
where NOT exists(select 1 from CONSMODES_LIST cl 
                 inner join RATES r on r.ID=cl.RATE_ID
                 where cl.OCC_ID=o.ID and cl.SERVICE_ID='1000' and cl.MODE_ID % 1000 <>0 and r.VALUE=kk.tarif)
order by o.ADDRESS

---------------------------

select top 100 *
from
ls25 l 
  inner join 
  (SELECT ls LS8 , max(k.RATE) tarif,(select  isnull(max(cast(k2.SOVPL as numeric(18,3))),0) m  FROM [KOD25] k2 where k2.LS=k.LS) sovpl
   FROM [KOD25] k
   where k.USL='ХВ' 
   group by ls
   ) kk 
  on kk.LS8=l.LS8    and kk.sovpl>0.0
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID and b.TECHSUBDIV_ID=25 
where NOT exists(select 1 from CONSMODES_LIST cl 
                 inner join RATES r on r.ID=cl.RATE_ID
                 where cl.OCC_ID=o.ID and cl.SERVICE_ID='хвод' and cl.MODE_ID % 1000 <>0 and r.VALUE=kk.tarif
                 
                 )
     and o.STATUS_ID<>'своб'
order by o.ADDRESS


------------------------------------------


select top 1000 (select max(ll.LS8) from  ls25 ll where ll.OCC=o.id ) ls8,  o.* 
  from
  OCCUPATIONS  o 
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID and b.TECHSUBDIV_ID=25 
  inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID in ('хвод') and cl.MODE_ID % 1000 <>0 
  where not exists 
  (select 1
  from
    ls25 l  inner join 
           (SELECT ls LS8 -- , max(k.RATE) tarif,(select  isnull(max(cast(k2.SOVPL as numeric(18,3))),0) m  FROM [KOD25] k2 where k2.LS=k.LS) sovpl
           FROM [KOD25] k
           where k.USL='ХВ' 
            group by ls
           ) kk   on kk.LS8=l.LS8   --- and kk.sovpl>0.0
   where o.ID=l.OCC
  )          
order by o.ADDRESS


---------------------------------
DECLARE	
	@occ int;
DECLARE cOcc CURSOR FOR
select o.id
  from
  OCCUPATIONS  o 
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID and b.TECHSUBDIV_ID=25 
  inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID in ('хвод') and cl.MODE_ID % 1000 <>0 
  where not exists 
  (select 1
  from
    ls25 l  inner join 
           (SELECT ls LS8 -- , max(k.RATE) tarif,(select  isnull(max(cast(k2.SOVPL as numeric(18,3))),0) m  FROM [KOD25] k2 where k2.LS=k.LS) sovpl
           FROM [KOD25] k
           where k.USL='ХВ' 
            group by ls
           ) kk   on kk.LS8=l.LS8   --- and kk.sovpl>0.0
   where o.ID=l.OCC
  )          
order by o.ADDRESS


OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN
	    update CONSMODES_LIST
	    set MODE_ID=MODE_ID-MODE_ID%1000
	    where OCC_ID=@occ and SERVICE_ID in ('хвод','1012')
	   	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  



--------------------


  select distinct s.usl,
  CASE s.usl 
  when 'ХВ на подогрев' then '1014'
  when 'Холодная вода' then 'хвод'
  when 'Канализ. ХВ' then '1012'
  when 'Отопление' then 'отоп'
  when 'Содерж.ремонт' then '1000'
  when 'ХВна подИТП' then '1019'
  when 'КапРемМаш9' then 'капр'
  when 'Подогрев ХВ' then '1004'
  when 'Канализ. ГВ' then '1013'
  when 'Освещ.л/ клет' then '1008'
  when 'Капитал.ремонт' then 'капр'
  when 'Хол.вода на ОДН' then 'одхв'
  when 'Вывоз мусора' then '1015'
  else null 
  end NUSL
   FROM [it_gh].[dbo].[saldo5] s
    where s.saldo<>0