/****** Сценарий для команды SelectTopNRows среды SSMS  ******/
SELECT TOP 1000 [KOD]
      ,[NAIM]
      ,[ADRES]
      ,[USLKOD]
      ,[SUMMA]
      ,[ZDANIE]
      ,[SALL]
      ,[SHZIL]
      ,[NACH_Y]
      ,[DATENACH]
      ,[KOLHZIL]
      ,[KATEG]
      ,[FAM]
      ,[NAME]
      ,[OTCH]
      ,[FIO]
      ,[occ]
      ,[kv]
  FROM [it_gh].[dbo].[ls32]
  
  update l
  set l.kv=replace(upper(l.kv),'(9)','')
     FROM [it_gh].[dbo].[ls32] l
     
 update l
  set l.NAIM=rtrim(ltrim(replace(upper(l.NAIM),'л/с №','')))
     FROM [it_gh].[dbo].[ls32] l     

 update l
  set l.kv='3a'
     FROM [it_gh].[dbo].[ls32] l     
where l.kv='3'  and l.KOD= 32017475
--and l.ZDANIE='20 037   '
     
     select l.*,d.ADRES  FROM [it_gh].[dbo].[ls32] l
     left join [it_gh].[dbo].doma32 d on d.KOD=l.ZDANIE
     where l.occ is null --l.KOD<>l.NAIM
     
     
 update l
  set l.occ=(select o.ID from [it_gh].[dbo].OCCUPATIONS o 
             inner join [it_gh].[dbo].FLATS f on f.ID=o.FLAT_ID 
             inner join [it_gh].[dbo].BUILDINGS b on b.ID=f.BLDN_ID
             where b.ID=d.bldn_id and upper(l.kv)=upper(f.FLAT_NO) and l.NAIM=o.ID
              )
     FROM [it_gh].[dbo].[ls32] l   
     left join [it_gh].[dbo].doma32 d on d.KOD=l.ZDANIE    

--------------------------
-- 
update l
set fam= case when b.fam_last > a.fam_first then substring(n.fio, a.fam_first, b.fam_last - a.fam_first + 1) else '' end ,
name=case when c.im_first <n.len_fio then substring(n.fio, c.im_first,  d.im_last  - c.im_first  + 1) else '' end,
otch=right(rtrim(ltrim(n.fio)) , n.len_fio - d.im_last)
 --select *
 from     
    [it_gh].[dbo].[ls32] l
    inner join 
      (select kod, fio, len(fio) as len_fio from [it_gh].[dbo].[ls32]) n on n.kod=l.kod
     cross apply (select patindex('%[^ ]%', n.fio) as fam_first) a
     cross apply (select isnull(nullif(charindex(' ', n.fio, a.fam_first), 0) - 1, n.len_fio) as fam_last) b
     cross apply (select patindex('%[^ ]%', substring(n.fio, b.fam_last + 1, n.len_fio)) + b.fam_last as im_first) c
     cross apply (select isnull(nullif(charindex(' ', n.fio, c.im_first), 0) - 1, n.len_fio) as im_last) d;     
     
-------------------------

------ ФИО ответственных обновить
use it_gh
update p
set p.[LAST_NAME]=l.FAM
,p.[FIRST_NAME]=l.NAME
,p.[SECOND_NAME]=l.OTCH

--select l.fam,l.name,l.otch, p.* 
from [it_gh].[dbo].[PEOPLE] p 
  inner join OCCUPATIONS  o on  p.occ_id=o.id
   inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC   
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID     
where p.[WHO_ID]='отвл' and  b.TECHSUBDIV_ID in (32) and
(
 p.[LAST_NAME]<>l.FAM
or p.[FIRST_NAME]<>l.NAME
or p.[SECOND_NAME]<>l.OTCH
   )  
 -------
 ------------
 ---Несовпадение количества людей
 select  o.ID,MAX(o.REALLY_LIVE)oldpipl ,MAX(l.KOLHZIL) newpipl
 --p.* 
from 
  OCCUPATIONS  o 
  inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC   
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID    
where p.[WHO_ID]<>'отвл' and  b.TECHSUBDIV_ID in (32) and
(l.KOLHZIL<>o.REALLY_LIVE    )
group by o.ID
---------------------


--Установить различающиеся общие площади

DECLARE	
	@occ int,
	@plos decimal(16,6),
	@fl_id int;
DECLARE cOcc CURSOR FOR
select distinct o.id, l.sall ,o.flat_id
 from OCCUPATIONS  o
inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC   
  
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (32)
  and l.kateg='Отдельная'
and (--abs(o11.TOTAL_SQ-o.TOTAL_SQ)>0.001
abs(l.sall-f.TOTAL_SQ)>0.001
    )
OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@plos,@fl_id

	WHILE @@FETCH_STATUS =0
		BEGIN
		print 'ls= '+cast(@occ as varchar(10))+ ' plos= '+cast(@plos as varchar(16))
	    exec CliSquareTotalSet @fl_id,@plos
	   	   
	FETCH NEXT FROM cOcc INTO  @occ,@plos,@fl_id
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  
-------------
select distinct o.id, l.sall ,l.shzil,o.flat_id
 from OCCUPATIONS  o
inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC   
  
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (32)
  and l.kateg='Коммунальная'
and (--abs(o11.TOTAL_SQ-o.TOTAL_SQ)>0.001
abs(l.shzil-o.[LIVING_SQ])>0.001
or abs(l.sall-o.[COMBINED_SQ])>0.001
    )      
------------------------
SELECT  --u.*,
 [KOD]
      ,[NAIM]
      ,[SPOSOB]
      ,[SSCHET]
      ,[VIDPLOSH]
      ,[SRAPOKLS]
  FROM [it_gh].[dbo].[uslugi32] u
  where  exists(select 1 from [it_gh].[dbo].[ls32] l where l.USLKOD=u.KOD and l.NACH_Y='T' and cast(l.tarif as numeric(18,4))>0)
    order by 1
----------------

    select o.ADDRESS,u.NAIM,l.* from [it_gh].[dbo].[ls32] l 
    inner join [it_gh].[dbo].[uslugi32] u on l.USLKOD=u.KOD
    inner join [it_gh].[dbo].OCCUPATIONS o on o.ID=l.occ
    where   l.NACH_Y='T' and cast(l.tarif as numeric(18,4))>0
    and not exists(select 1 from 
                   [it_gh].[dbo].CONSMODES_LIST cl 
                   where cl.OCC_ID=o.ID and cl.SERVICE_ID=u.serv_id                  
                  )
    
---------------------
      select o.ADDRESS,u.NAIM,t.* from
     [it_gh].[dbo].[tarif32] t
  left join [it_gh].[dbo].[lsocc32] lo on lo.ls=t.KOD
    left join [it_gh].[dbo].[uslugi32] u on t.USLKOD=u.KOD
    left join [it_gh].[dbo].[usl32mode] um on um.USLKOD=u.KOD and um.TARIF=t.TARIF
    left join [it_gh].[dbo].OCCUPATIONS o on o.ID=lo.occ
    where  
     not exists(select 1 from 
                   [it_gh].[dbo].CONSMODES_LIST cl 
                   where cl.OCC_ID=o.ID and cl.SERVICE_ID=u.serv_id                  
                  )
    order by 1              


  UPDATE cl 
  set 
  cl.MODE_ID=um.mode_id
  
    --  select o.ADDRESS,u.NAIM,t.* from
    
  from   [it_gh].[dbo].[tarif32] t
  inner join [it_gh].[dbo].[lsocc32] lo on lo.ls=t.KOD
    inner join [it_gh].[dbo].[uslugi32] u on t.USLKOD=u.KOD
    inner join [it_gh].[dbo].[usl32mode] um on um.USLKOD=u.KOD and um.TARIF=t.TARIF
    inner join [it_gh].[dbo].OCCUPATIONS o on o.ID=lo.occ
    inner join [it_gh].[dbo].CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=um.serv_id
    where         
 um.mode_id is not null                  

    order by 1              
----------

select l.USLKOD,u.serv_id,u.NAIM Usluga,count(*) kolvo,SUM(l.SUMMA)saldo from [it_gh].[dbo].[ls32] l
 left join [it_gh].[dbo].[uslugi32] u on L.USLKOD=u.KOD
 left join [it_gh].[dbo].[lsocc32] lo on lo.ls=l.KOD
 left join [it_gh].[dbo].OCCUPATIONS o on o.ID=lo.occ
 left join [it_gh].[dbo].CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=u.serv_id
 where u.serv_id is null
GROUP BY  l.USLKOD,u.serv_id,
u.NAIM
ORDER BY 1

select u.NAIM,d.ADRES,l.*
from [it_gh].[dbo].[ls32] l
left join [it_gh].[dbo].[uslugi32] u on L.USLKOD=u.KOD
left join [it_gh].[dbo].doma32 d on d.KOD=l.ZDANIE
where l.USLKOD in (000054,000055,000056,000057,000065)
order by 2,1

------

   
select o.ADDRESS,u.NAIM,l.* from
   [it_gh].[dbo].[ls32] l
  inner join [it_gh].[dbo].[lsocc32] lo on lo.ls=l.KOD
    inner join [it_gh].[dbo].[uslugi32] u on l.USLKOD=u.KOD
    inner join [it_gh].[dbo].OCCUPATIONS o on o.ID=lo.occ
  inner join [it_gh].[dbo].FLATS f on f.ID=o.flat_id
  inner join [it_gh].[dbo].BUILDINGS b on b.ID=f.BLDN_ID    
    where  b.TECHSUBDIV_ID in (32) and
  --  l.USLKOD='000080' and
    l.USLKOD is not null 
   -- and exists(select 1 from  [it_gh].[dbo].[ls32] l2 where l2.KOD=l.KOD and l2.USLKOD=000031)
   and  not exists(select 1 from 
                   [it_gh].[dbo].CONSMODES_LIST cl 
                   where cl.OCC_ID=o.ID and cl.SERVICE_ID=u.serv_id                  
                  )
    order by 1  
-----------------
update l
set USLKOD='000010'
from  [it_gh].[dbo].[ls32] l
where l.USLKOD in ('000073','000074') and l.ZDANIE='20 003'
--Сальдо
update oa
set oa.SALDO=aa.summa
from
   -- select aa.* from 
    ( select cl.occ_id,cl.SERVICE_ID, count(*) cnt,SUM(l.summa) summa --o.ADDRESS,u.NAIM,l.* 
      from
   [it_gh].[dbo].[ls32] l
  inner join [it_gh].[dbo].[lsocc32] lo on lo.ls=l.KOD
    inner join [it_gh].[dbo].[uslugi32] u on l.USLKOD=u.KOD
    inner join [it_gh].[dbo].OCCUPATIONS o on o.ID=lo.occ
  inner join [it_gh].[dbo].FLATS f on f.ID=o.flat_id
  inner join [it_gh].[dbo].BUILDINGS b on b.ID=f.BLDN_ID    
  inner join  [it_gh].[dbo].CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=u.serv_id     
    where  b.TECHSUBDIV_ID in (32) and
    l.USLKOD is not null 
    and l.SUMMA<>0
    group by cl.occ_id,cl.SERVICE_ID
    --having count(*)>1
       )    aa
        inner join  [it_gh].[dbo].OCC_ACCOUNTS oa on oa.OCC_ID=aa.OCC_ID and oa.SERVICE_ID=aa.SERVICE_ID
   order by 1 


 --update oa
 set SALDO=6094.02
 from 
 [it_gh].[dbo].OCC_ACCOUNTS oa where oa.OCC_ID=32007497 and oa.SERVICE_ID='капр'

 --update oa
 set SALDO=4541.16
 from 
 [it_gh].[dbo].OCC_ACCOUNTS oa where oa.OCC_ID=32007497 and oa.SERVICE_ID='кнач'

-------------------
--Удалить людей и документы кроме ответственных, где отличается количество человек
delete from pd
--select p.* 
from 
[it_gh].[dbo].[PEOPLE] p 
inner join [it_gh].[dbo].[people_documents] pd on pd.[people_id]=p.id
  inner join OCCUPATIONS  o on  p.occ_id=o.id
  inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC  
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID   
  --inner join  mr11.[dbo].[PEOPLE] p11  on p11.occ_id=o11.id  and p11.[WHO_ID]='отвл'
where p.[WHO_ID]<>'отвл' and  b.TECHSUBDIV_ID in (32) and
(l.KOLHZIL<>o.REALLY_LIVE    )


delete from p
--select p.* 
from [it_gh].[dbo].[PEOPLE] p 
  inner join OCCUPATIONS  o on  p.occ_id=o.id
   inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC  
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID   
  --inner join  mr11.[dbo].[PEOPLE] p11  on p11.occ_id=o11.id  and p11.[WHO_ID]='отвл'
where p.[WHO_ID]<>'отвл' and  b.TECHSUBDIV_ID in (32) and
(l.KOLHZIL<>o.REALLY_LIVE    )   


-- Заменить прописку на владельца где ноль человек
 --select  o.ID LS,o.ADDRESS,o.INITIALS FIO,MAX(l.KOLHZIL) chel, MAX(o.REALLY_LIVE)oldpipl--- ,
 --p.* 
update  p
set p.[STATUS_ID]='дком'
from [it_gh].[dbo].[PEOPLE] p
inner join   OCCUPATIONS o on  p.occ_id=o.id
--inner join [it_gh].[dbo].[people_documents] pd on pd.[people_id]=p.id   
  inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC   
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID    
where  b.TECHSUBDIV_ID in (32) and
o.PROPTYPE_ID='прив' and
 p.[WHO_ID]='отвл' and
(l.KOLHZIL<>o.REALLY_LIVE    ) --- p.[WHO_ID]<>'отвл' and
and (l.KOLHZIL=0)
--group by  o.ID,o.ADDRESS,o.INITIALS
--order by 2,1
--------------------

-- Допрописать людей
   DECLARE			
	@occ int,
	@vidprop char(4),
	@kolch int,
	@flid int,
	@fam varchar(32),
	@im varchar(32),
	@ot varchar(32),
	@fio varchar(50),
	@kolprop int,	
	@curpos int	,
	@tmpfio varchar(50),
	@oldprop int
	;
	
DECLARE cBldn CURSOR FOR
 select  o.ID LS,o.flat_id,o.INITIALS FIO,MAX(l.KOLHZIL) chel, MAX(o.REALLY_LIVE)oldpipl--- ,
 --p.* 
from OCCUPATIONS o
--left join  [it_gh].[dbo].[PEOPLE] p  on  p.occ_id=o.id
--inner join [it_gh].[dbo].[people_documents] pd on pd.[people_id]=p.id
   
  inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC   
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID    
where  b.TECHSUBDIV_ID in (32) and
(l.KOLHZIL<>o.REALLY_LIVE  ) 
--and p.[WHO_ID]<>'отвл' -- and
and (l.KOLHZIL>0)
--and o.PROPTYPE_ID<>'прив' 
--and o.REALLY_LIVE =0
group by   o.ID ,o.flat_id,o.INITIALS
order by 2,1

OPEN cBldn
	FETCH NEXT FROM cBldn INTO  @occ,@flid,@fio,@kolch,@oldprop
	   WHILE @@FETCH_STATUS =0
	   BEGIN 
	   set @tmpfio=@fio
	   set @curpos = CHARINDEX(' ',@fio,1);
	   set @fam=LEFT(@fio,@curpos);
	   set @fio=ltrim(SUBSTRING(@fio,@curpos,LEN(@fio)));
	   
	   set @curpos = CHARINDEX(' ',@fio,1);
	   if @curpos=0 set @curpos=LEN(@fio);
	   set @im=LEFT(@fio,@curpos);
	   set @ot=ltrim(SUBSTRING(@fio,@curpos,LEN(@fio)));
	   
	   print  'FIO= '+@tmpfio+'  FAM= '+@fam+'   IM= '+@im+'  OT= '+@ot;	   
	   set @vidprop='пост' 	  
	   set @kolprop=@oldprop
	  -- if (@kolch>1)
	   while (@kolprop<@kolch)
	    begin
	    --print @kolch
	    exec CliPeopleIns @flid,@occ,@fam,@im,@ot,null,@vidprop,'????', null, 0, NULL, NULL, NULL, 0, '01/09/2015'
	    set @kolprop=@kolprop+1
	    end
	 
	   FETCH NEXT FROM cBldn INTO  @occ,@flid,@fio,@kolch,@oldprop
       END;  		
CLOSE cBldn
DEALLOCATE cBldn  		

------------------



 
  update t
  set
      [NAIM]=LTRIM(RTRIM([NAIM]))
      ,[USLKOD]=LTRIM(RTRIM([USLKOD]))
      ,[NACH_Y]=LTRIM(RTRIM([NACH_Y]))           
      ,[NAIMUSL]=LTRIM(RTRIM([NAIMUSL]))
      ,[ORG]=LTRIM(RTRIM([ORG]))
      ,[OBJ]=LTRIM(RTRIM([OBJ]))
  FROM [it_gh].[dbo].[tarif32] t

 
  delete from t
  --select * 
  from [it_gh].[dbo].[tarif32] t
  where exists(select 1 from [it_gh].[dbo].[tarif32] t2 where t2.KOD=t.KOD and t2.USLKOD=t.USLKOD and t2.OBJ=cast(t.KOD as varchar(10)) )
  and t.OBJ<>cast(t.KOD as varchar(10))

  delete from t
  --select * 
  from [it_gh].[dbo].[tarif32] t
  where exists(select 1 from [it_gh].[dbo].[tarif32] t2 where t2.KOD=t.KOD and t2.USLKOD=t.USLKOD and t2.OBJ<>'' )
  and t.OBJ=''
----------------

 -- люди не совпадают 2
 select  o.ID,MAX(o.REALLY_LIVE)oldpipl ,MAX(t.KOLHZIL) newpipl
 --p.* 
from 
  OCCUPATIONS  o 
  inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC   
  inner join [it_gh].[dbo].tarif32 t on t.KOD=l.KOD and t.USLKOD=l.USLKOD
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID    
where  b.TECHSUBDIV_ID in (32) and
(t.KOLHZIL<>o.REALLY_LIVE    )
group by o.ID



--Удалить людей и документы кроме ответственных, где отличается количество человек
delete from pd
--select p.* 
from 
[it_gh].[dbo].[PEOPLE] p 
inner join [it_gh].[dbo].[people_documents] pd on pd.[people_id]=p.id
  inner join OCCUPATIONS  o on  p.occ_id=o.id
  inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC  
  inner join [it_gh].[dbo].tarif32 t on t.KOD=l.KOD and t.USLKOD=l.USLKOD
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID   
  --inner join  mr11.[dbo].[PEOPLE] p11  on p11.occ_id=o11.id  and p11.[WHO_ID]='отвл'
where p.[WHO_ID]<>'отвл' and  b.TECHSUBDIV_ID in (32) and
(t.KOLHZIL<>o.REALLY_LIVE    )


delete from p
--select p.* 
from [it_gh].[dbo].[PEOPLE] p 
  inner join OCCUPATIONS  o on  p.occ_id=o.id
   inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC  
   inner join [it_gh].[dbo].tarif32 t on t.KOD=l.KOD and t.USLKOD=l.USLKOD
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID   
  --inner join  mr11.[dbo].[PEOPLE] p11  on p11.occ_id=o11.id  and p11.[WHO_ID]='отвл'
where p.[WHO_ID]<>'отвл' and  b.TECHSUBDIV_ID in (32) and
(t.KOLHZIL<>o.REALLY_LIVE    )   

----------

-- Заменить прописку на владельца где ноль человек
 --select  o.ID LS,o.ADDRESS,o.INITIALS FIO,MAX(l.KOLHZIL) chel, MAX(o.REALLY_LIVE)oldpipl--- ,
 --p.* 
update  p
set p.[STATUS_ID]='дком'
-- select *
from [it_gh].[dbo].[PEOPLE] p
inner join   OCCUPATIONS o on  p.occ_id=o.id
--inner join [it_gh].[dbo].[people_documents] pd on pd.[people_id]=p.id   
  inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC   
  inner join [it_gh].[dbo].tarif32 t on t.KOD=l.KOD and t.USLKOD=l.USLKOD
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID    
where  b.TECHSUBDIV_ID in (32) and
o.PROPTYPE_ID='прив' and
 p.[WHO_ID]='отвл' and
(t.KOLHZIL<>o.REALLY_LIVE    ) --- p.[WHO_ID]<>'отвл' and
and (t.KOLHZIL=0)
--group by  o.ID,o.ADDRESS,o.INITIALS
--order by 2,1
--------------------



-- Допрописать людей 2
   DECLARE			
	@occ int,
	@vidprop char(4),
	@kolch int,
	@flid int,
	@fam varchar(32),
	@im varchar(32),
	@ot varchar(32),
	@fio varchar(50),
	@kolprop int,	
	@curpos int	,
	@tmpfio varchar(50),
	@oldprop int
	;
	
DECLARE cBldn CURSOR FOR
 select  o.ID LS,o.flat_id,o.INITIALS FIO,MAX(t.KOLHZIL) chel, MAX(o.REALLY_LIVE)oldpipl--- ,
 --p.* 
from OCCUPATIONS o
--left join  [it_gh].[dbo].[PEOPLE] p  on  p.occ_id=o.id
--inner join [it_gh].[dbo].[people_documents] pd on pd.[people_id]=p.id
   
  inner join  [it_gh].[dbo].[ls32] l on o.ID=l.OCC   
   inner join [it_gh].[dbo].tarif32 t on t.KOD=l.KOD and t.USLKOD=l.USLKOD
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID    
where  b.TECHSUBDIV_ID in (32) and
(t.KOLHZIL<>o.REALLY_LIVE  ) 
--and p.[WHO_ID]<>'отвл' -- and
and (t.KOLHZIL>0)
--and o.PROPTYPE_ID<>'прив' 
--and o.REALLY_LIVE =0
group by   o.ID ,o.flat_id,o.INITIALS
order by 2,1

OPEN cBldn
	FETCH NEXT FROM cBldn INTO  @occ,@flid,@fio,@kolch,@oldprop
	   WHILE @@FETCH_STATUS =0
	   BEGIN 
	   set @tmpfio=@fio
	   set @curpos = CHARINDEX(' ',@fio,1);
	   set @fam=LEFT(@fio,@curpos);
	   set @fio=ltrim(SUBSTRING(@fio,@curpos,LEN(@fio)));
	   
	   set @curpos = CHARINDEX(' ',@fio,1);
	   if @curpos=0 set @curpos=LEN(@fio);
	   set @im=LEFT(@fio,@curpos);
	   set @ot=ltrim(SUBSTRING(@fio,@curpos,LEN(@fio)));
	   
	   print  'FIO= '+@tmpfio+'  FAM= '+@fam+'   IM= '+@im+'  OT= '+@ot;	   
	   set @vidprop='пост' 	  
	   set @kolprop=@oldprop
	  -- if (@kolch>1)
	   while (@kolprop<@kolch)
	    begin
	    --print @kolch
	    exec CliPeopleIns @flid,@occ,@fam,@im,@ot,null,@vidprop,'????', null, 0, NULL, NULL, NULL, 0, '01/09/2015'
	    set @kolprop=@kolprop+1
	    end
	 
	   FETCH NEXT FROM cBldn INTO  @occ,@flid,@fio,@kolch,@oldprop
       END;  		
CLOSE cBldn
DEALLOCATE cBldn  		

------------------

select *
   FROM [it_gh].[dbo].[uslugi32] u
  where -- not exists(select 1 from [it_gh].[dbo].[ls32] l where l.USLKOD=u.kod) and
  not exists(select 1 from [it_gh].[dbo].[tarif32] t where t.USLKOD=u.kod)
---------------

SELECT  s.* 
  FROM [it_gh].[dbo].[schet32] s
  where  ---KODOBJ='32003520'
   s.TIPOBJ='ЛС     'and
  not exists(select 1 from [it_gh].[dbo].[ls32] l where l.KOD=s.kodobj)
  --not exists(select 1 from [it_gh].[dbo].[tarif32] t where t.KOD=s.kodobj)
  --not exists(select 1 from [it_gh].[dbo].[lsocc32] l where l.ls=s.kodobj)

------------
select --top 1000
ro.id occ,
s.nachpok,
u.[serv_id]
,rf.id flid,
     (select count(*) from  [it_gh].[dbo].[schet32] s2 where s2.kodobj=s.kodobj ) numcnt
--f.BLDN_ID 
,s.[NACHPOK]+s.[DVIZH] newpok
from 
 [it_gh].[dbo].[schet32] s 
 inner join [it_gh].[dbo].[lsocc32] l on l.ls=s.kodobj
 inner join [it_gh].[dbo].[uslugi32] u on u.KOD=s.KODUSL
 inner join [it_gh].dbo.occupations ro on ro.ID=l.occ
 inner join [it_gh].[dbo].flats rf on rf.id=ro.flat_id
 inner join [it_gh].[dbo].BUILDINGS rb on rb.ID=rf.BLDN_ID   
   where 
    s.TIPOBJ='ЛС     'and
  -- s.KODUSL not in ('000036','000077','000039' ) and
     rb.TECHSUBDIV_ID in (32) and s.KODOBJ='32000276 '
   order by s.TIPOBJ,rb.BLDN_NO,rf.FLAT_NO
------------
/****** Сценарий для команды SelectTopNRows среды SSMS  ******/
SELECT
      [USLKOD]   
      ,[TARIF]
      ,[NAIMUSL]
      ,COUNT(*) cnt
  FROM [it_gh].[dbo].[tarif32]
 -- where KOD=32005144
 group by [USLKOD]   
      ,[TARIF]
      ,[NAIMUSL]
      order by 3

