use it_gh  -- Используем основную рабочую базу

---Получить ИД дома
-----------------------------------
select x.ID street_id ,x.NAME street,b.BLDN_NO dom,b.ID bldn_id from BUILDINGS b
inner join XSTREETS x on x.ID=b.STREET_ID
where x.NAME like '%ленина%' and b.BLDN_NO)='1а'
-------------------------------------
-------------------------------------

---Список начисляемых домов и ЛС
------------------------------------
select --SUM(aa.KOLLS)
aa.* 
from
(select b.BLDN_NO DOM,x.NAME ULICA,rtrim(t.NAME) UCHASTOK,(select count(*) from occupations o inner join FLATS f on f.ID=o.flat_id and f.BLDN_ID=b.ID
where    exists (select 1 from CONSMODES_LIST cl 
              inner join PAYM_LIST pl on pl.OCC_ID=o.ID and pl.TYPE_ID=cl.SERVICE_ID
             where cl.OCC_ID=o.ID and cl.MODE_ID % 1000<>0 
             and pl.VALUE<>0 
              and o.COMBINED_SQ>0.0001
             )
)KOLLS from BUILDINGS b 
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  inner join XSTREETS x on  x.ID=b.STREET_ID  
  where t.IS_HISTORY=1 
 )aa 
where aa.KOLLS>0 
  order by 3,2,
	CASE
          WHEN PATINDEX ( '%[^0-9]%' , DOM ) = 0
	  THEN REPLICATE ( '0' , 7 - DATALENGTH ( DOM ) ) + DOM
          ELSE REPLICATE ( '0' , 8 - PATINDEX ( '%[^0-9]%' , DOM ) ) + DOM
	END
--------------------------------------------
---------------------------------------------

--Список начисляемых ЛС
--------------------------------------------
select --top 100
x.NAME ULICA,b.BLDN_NO DOM,f.FLAT_NO KV,o.INITIALS FIO,o.ID LS ,cast(o.TOTAL_SQ as numeric(18,2)) Plosh,
 case o.PROPTYPE_ID when 'непр' then 'Найм' 
                    else 'Собственность' 
 end Sobstv
from   occupations o 
  inner join FLATS f on f.ID=o.flat_id 
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  inner join XSTREETS x on  x.ID=b.STREET_ID
  where t.IS_HISTORY=1 
  and o.TOTAL_SQ >0
  --and o.COMBINED_SQ<>o.TOTAL_SQ 
  and 
  exists (select 1 from OCCUPATIONS o2 
         inner join FLATS f2 on f2.ID=o2.flat_id 
         inner join PAYM_LIST pl on pl.OCC_ID=o2.ID
         where f2.BLDN_ID=f.BLDN_ID and pl.VALUE>0
         )
  order by 1,
	CASE
          WHEN PATINDEX ( '%[^0-9]%' , b.BLDN_NO ) = 0
	  THEN REPLICATE ( '0' , 7 - DATALENGTH ( b.BLDN_NO ) ) + b.BLDN_NO
          ELSE REPLICATE ( '0' , 8 - PATINDEX ( '%[^0-9]%' , b.BLDN_NO ) ) + b.BLDN_NO
	END,
	CASE
          WHEN PATINDEX ( '%[^0-9]%' , f.FLAT_NO ) = 0
	  THEN REPLICATE ( '0' , 7 - DATALENGTH ( f.FLAT_NO ) ) + f.FLAT_NO
          ELSE REPLICATE ( '0' , 8 - PATINDEX ( '%[^0-9]%' , f.FLAT_NO ) ) + f.FLAT_NO
	END
	
-----------------------------------------
-----------------------------------------	


-- Не совпадают отапливаемая и совокупная площади в отдельных квартирах
---------------------------------------------
 use it_gh
 select o.ID LS ,o.ADDRESS, o.INITIALS FIO,o.HEATING_SQ S_OTOPL, o.COMBINED_SQ s_SOVOK from OCCUPATIONS o 
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID      
  where  
  o.COMBINED_SQ<>o.HEATING_SQ and f.ROOMTYPE_ID='отдк'
  order by o.ADDRESS
------------------------------------------------ 
------------------------------------------------ 

--Большие начисления
---------------------------
use it_gh
select
o.ID,o.ADDRESS,pl.VALUE
from 
  occupations o 
  inner join PAYM_LIST pl on pl.OCC_ID=o.ID   
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
   and pl.VALUE>10000  --от суммы
order by 1
--------------------------------------------------
------------------------------------------------

---Объем по счетчикам по услуге за период
------------------------------------
SELECT cml.occ_id LS,f.FLAT_NO KV, sum(cml.cntr_units) KVT
  FROM 
FROM FIN_TERMS fi 
  inner join
  CML_HISTORY cml (NOLOCK) on cml.finterm_id= (
			select max(cmlh2.FINTERM_ID) from CML_HISTORY cmlh2
			where	cmlh2.OCC_ID = cml.OCC_ID
			and	cmlh2.SERVICE_ID = cml.SERVICE_ID
			and	cmlh2.FINTERM_ID <= fi.ID
		) 
  inner join occupations o on o.ID=cml.occ_id
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  where --- f.BLDN_ID=1111   -- ИД дома
  and fi.id>=13 and fi.id<=20  --периоды
  and service_id='хвод' -- услуга
  group by cml.occ_id,f.FLAT_NO
  ----------------------------------------
  ---------------------------------------
  
  -------Платежи по типам и услугам в текущем месяце 
  ---------------------------------
  SELECT 
  pt.NAME,x.NAME,sum(mp.VALUE)
  FROM [MONTHS_PAID] mp
  inner join PAYING_TYPES pt on pt.ID=mp.PAY_TYPE_ID
  inner join occupations o on o.id=mp.OCC_ID
  inner join FLATS f on f.ID=o.flat_id  
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join XSERVICES x on x.ID=mp.SERVICE_ID
  where b.id= 11 -- по дому
  group by pt.NAME,x.NAME
  order by 1,2
  ----------------------------------------
  ----------------------------------------
  
  -----Список людей
  --------------------------------
  SELECT ---top 100
x.NAME ULICA,b.BLDN_NO DOM,f.FLAT_NO KV,
 o.id LS,
 (select top 1	
	rtrim(p.last_name) +' '+
	rtrim(p.first_name) +' '+
	rtrim(p.second_name)
from
	people		p
where
	p.who_id = 'отвл' and p.OCC_ID=o.ID)
  FIO
from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join XSTREETS x on x.ID=b.STREET_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where  t.IS_HISTORY=1 
  order by b.TECHSUBDIV_ID,x.NAME,
	CASE
          WHEN PATINDEX ( '%[^0-9]%' , b.BLDN_NO ) = 0
	  THEN REPLICATE ( '0' , 7 - DATALENGTH ( b.BLDN_NO ) ) + b.BLDN_NO
          ELSE REPLICATE ( '0' , 8 - PATINDEX ( '%[^0-9]%' , b.BLDN_NO ) ) + b.BLDN_NO
	END
	,
		CASE
          WHEN PATINDEX ( '%[^0-9]%' , f.FLAT_NO ) = 0
	  THEN REPLICATE ( '0' , 7 - DATALENGTH ( f.FLAT_NO ) ) +f.FLAT_NO
          ELSE REPLICATE ( '0' , 8 - PATINDEX ( '%[^0-9]%' , f.FLAT_NO ) ) + f.FLAT_NO
	END
  -----------------------------------------
  -----------------------------------------
  
  ----Добавка отсутствующих режимов потребления на дом(на ЛС они фактически есть, а на доме в кодификаторе их не видно, это обычно после прямого ковыряния в базе)
  -----------------------------------------------------
   DECLARE	
	@servid char(4),
	@srcid int,
	@modeid int,
	@bldn int;	

DECLARE cBldn CURSOR FOR
SELECT f.BLDN_ID,cl.SERVICE_ID,cl.SOURCE_ID,cl.MODE_ID
  FROM CONSMODES_LIST cl
  inner join occupations o on o.id=cl.OCC_ID
  inner join FLATS f on f.ID=o.flat_id  
  inner join BUILDINGS b on b.ID=f.BLDN_ID
where 
 NOT exists(select 1 from BLDN_CONSMODES bc where bc.BLDN_ID=f.BLDN_ID and bc.SERVICE_ID=cl.SERVICE_ID and bc.SOURCE_ID=cl.SOURCE_ID and bc.MODE_ID=cl.MODE_ID)
group by   f.BLDN_ID,cl.SERVICE_ID,cl.SOURCE_ID,cl.MODE_ID
OPEN cBldn
	FETCH NEXT FROM cBldn INTO  @bldn,@servid,@srcid,@modeid
	   WHILE @@FETCH_STATUS =0
	   BEGIN   	   
	   exec	AdmAddConsModetoBLDN @bldn,@servid,@srcid,@modeid;		
	   FETCH NEXT FROM cBldn INTO  @bldn, @servid,@srcid,@modeid
       END;  		
CLOSE cBldn
DEALLOCATE cBldn  		
-------------------------------------------
---------------------------------------------

----Убрать неначисляемые услуги  с дома 
-------------------------------------------
--Убираются услуги, на которых на ВСЕХ ЛС в доме стоит режим Нет и нет сальдо, платежей, разовых
--Если условие не соблюдается, то ничего страшного, на этом доме удаление не отработает
set nocount on
DECLARE	
	@bldnid int,
	@servid char(4) ='найм', -- Услуга
	@supid int,
	@stname varchar(255),
	@bldnno varchar(15)
	
DECLARE cBldn CURSOR FOR
select b.ID,bc.[SOURCE_ID],b.bldn_no,st.name from
  BUILDINGS b 
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  inner join [BLDN_CONSMODES] bc on bc.[BLDN_ID]=b.id and bc.[SERVICE_ID]=@servid
  left join streets st on st.id=b.street_id
    where  
  not exists 
  (select 1 from occupations o inner join FLATS f on b.ID=f.BLDN_ID and f.ID=o.flat_id 
  inner join occ_accounts oa on oa.occ_id=o.id and oa.service_id=@servid
  inner join paym_list pl on pl.occ_id=o.id and pl.type_id=oa.service_id
  inner join consmodes_list cl on cl.occ_id=o.id and cl.service_id=oa.service_id 
  where
  isnull(oa.saldo,0)<>0 or isnull(pl.paid,0)<>0 or isnull(pl.added,0)<>0 or isnull(cl.mode_id,0) % 1000<>0)
  --and b.TECHSUBDIV_ID=1
     
  OPEN cBldn  
	FETCH NEXT FROM cBldn INTO  @bldnid, @supid, @bldnno, @stname
	WHILE @@FETCH_STATUS =0
		BEGIN
		print  'Дом '+rtrim(@bldnno)+' , '+@stname
	    EXEC AdmDeleteSupfromBLDN @bldnid,@servid,@supid   
	    
	   FETCH NEXT FROM cBldn INTO  @bldnid,@supid, @bldnno, @stname
    END;  
		
CLOSE cBldn
DEALLOCATE cBldn     

-------------------------------------------------
--------------------------------------------------

----Статистика по платежам по банкам, количество квитанций, сумма и их процентное соотношение в разрезе банков
-------------------------
SELECT 
NAME,docs,summa,CAST(1. * docs/sum(docs) over (PARTITION BY 1)*100 AS DECIMAL(5,2)) docprocent,CAST(1. * summa/sum(summa)over (PARTITION BY 1)*100 AS DECIMAL(5,2)) sumprocent 

from
(SElect 
      pp.SOURCE_ID,
      po.NAME
      ,sum([DOCSNUM])docs
      ,sum([TOTAL])summa 
      
  FROM [PAYDOC_PACKS] pp
  inner join [PAYCOLL_ORGS]  po on po.ID=pp.SOURCE_ID
  where 
  --SOURCE_ID in (1,3,17)and --Банки
  -- TYPE_ID in ('1005') and -- Типы пачек  
  pp.DAY between '2016-03-01' and '2016-03-31'
  group by [SOURCE_ID],po.NAME 
  )aa
  --------------------------------------
  ---------------------------------------