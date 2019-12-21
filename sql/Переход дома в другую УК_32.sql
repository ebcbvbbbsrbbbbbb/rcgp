
--------УК-----
---Установить новую УК на коммунальные услуги по нормативу

update cl 
 set MANAGEMENT_COMPANY_ID=117
 --
 --select *
  from [CONSMODES_LIST]cl
  inner join occupations o on o.id=cl.OCC_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  --left join STREETS s on s.ID=b.STREET_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  ---inner join umr_sup u  on u.sdivid=t.ID
  where coalesce(cl.MANAGEMENT_COMPANY_ID,0)=32
  and cl.mode_id %1000 <>0
  and b.TECHSUBDIV_ID=117
  and t.IS_HISTORY=1
  and cl.SERVICE_ID in('1004','1012','1013','1014','1019','1020','1021','хвод')
  and cl.CNTR_BIT=0

-----------------------
/*
Сальдо
*/
use it_gh
DECLARE	
	@occ int,
	@bldn int
	
DECLARE cOcc CURSOR FOR
select o.id,b.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 --and b. id in (   )
  and b.TECHSUBDIV_ID in (117 )

  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@bldn

	WHILE @@FETCH_STATUS =0
		BEGIN   ---меняем услуги ч-з служебную услугу на Долг 1
-----ТО------------------------------------------------		
	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='9999'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1022'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1022'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1000'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1000'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'	
		

		
----------------------------------------------------------

-------Вывоз мусора---------------------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1037'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1037'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1015'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1015'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
	--	
		
--------------------------------------------------------------------

--------------Лифт------------------------------------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1040'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1040'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='лифт'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='лифт'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
		--	
		
---------------------------------------------------------	

-----------Капремонт------------------------------------
if (not @bldn in (1300009,4250049,4900030))
   begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1033'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1033'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='капр'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='капр'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
	end

-------------------------------------------------------------

-----------Нач Капремонт------------------------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1нк'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1нк'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='кнач'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='кнач'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
	

-------------------------------------------------------------
	
--------------Хол вода---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='хвод'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1024'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1024'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='хвод'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='хвод'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------	    	   


--------------Канал Хол воды---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1012'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1034'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1034'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1012'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1012'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------	

--------------Отопл---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1023'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1023'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='отоп'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='отоп'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
            
---------------------------------------------

---------------------------------------------

--------------Подогрев---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1004'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1026'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1026'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1004'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1004'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------
----
            
---------------------------------------------

--------------ХВ для Подогрева---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1014'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1036'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1036'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1014'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1014'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------
---
---------------------------------------------

--------------Канал ГВ---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1013'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1035'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1035'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1013'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1013'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------

--------------ИТП Канал ГВ---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1021'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1043'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1043'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1021'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1021'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 end           
---------------------------------------------

--------------ИТП Подогрев---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1020'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1042'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1042'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1020'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1020'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------

--------------ИТП ХВ Под---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1019'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1041'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1041'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1019'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1019'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------

--------------СОИ ИТП ХВ Под---------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1ис'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1ис'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='соих'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='соих'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 ----    
--------------СОИ ИТП Под---------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1си'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1си'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='соип'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='соип'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 ---- 

  --------------СОИ Под---------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1сп'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1сп'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='сопо'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='сопо'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 ----     
  --------------СОИ ХВП---------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1сд'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1сд'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='сохп'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='сохп'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 ----     

   --------------СОИ ХВ---------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1сх'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1сх'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='сохв'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='сохв'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 ----        

    --------------СОИ Эл---------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1сэ'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1сэ'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='соэл'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='соэл'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 ----        
---------------------------------------------
---------------------------------------------
	    	   
	   FETCH NEXT FROM cOcc INTO  @occ,@bldn
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  

-----------------
------------------
---------------


-----пеня-------------

 use it_gh
  update op
  set op.SERVICE_ID=
  case op.SERVICE_ID
  when '1000' then '1022'
  when '1015' then '1037'
  when 'отоп' then '1023'
  when '1004' then '1026'
  when '1014' then '1036'
  when 'лифт' then '1040'
  else 
  op.SERVICE_ID
  end
 --select   op.*
  from [OCC_PENYA_HISTORY] op
  inner join occupations o on o.ID=op.OCC_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 --and b. id in (   )
  and b.TECHSUBDIV_ID in (117 )
  and NOT exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=o.ID and cl.SERVICE_ID=op.SERVICE_ID and cl.MANAGEMENT_COMPANY_ID=32 )
  and op.FINTERM_ID=70
 -- and o.ID=32004389



--------Платежи-----------

use it_gh
DECLARE	
	@occ int,
	@bldn int;
DECLARE cOcc CURSOR FOR
select o.id,b.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and b.TECHSUBDIV_ID=117

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@bldn

	WHILE @@FETCH_STATUS =0
		BEGIN   ---меняем услуги ч-з ДОлг4 на долг1


/*
-------------------
-------------------
--------------------
----------------------
-----------------------
*/

------


----------Капремонт---------
if (not @bldn in (1300009,4250049,4900030))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1033'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='капр'
and VALUE<>0
end
--------Лифт-----------
update [MONTHS_PAID]
set 
SERVICE_ID='1040'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='лифт'
and VALUE<>0

------------Мусор----------
update [MONTHS_PAID]
set 
SERVICE_ID='1037'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1015'
and VALUE<>0

----ТО---------------
update [MONTHS_PAID]
set 
SERVICE_ID='1022'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1000'
and VALUE<>0

-------------Хол вода--------------------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='хвод'and cl.MANAGEMENT_COMPANY_ID=32))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1024'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='хвод'
and VALUE<>0
end
-------------Канал Хол вод--------------------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1012'and cl.MANAGEMENT_COMPANY_ID=32))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1034'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1012'
and VALUE<>0
end
----------Отопл----------------
update [MONTHS_PAID]
set 
SERVICE_ID='1023'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='отоп'
and VALUE<>0


----------Подогрев----------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1004'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1026'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1004'
and VALUE<>0
end
----------ХВП------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1014'and cl.MANAGEMENT_COMPANY_ID=32))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1036'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1014'
and VALUE<>0
end
----------Канал ГВ-----------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1013'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1035'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1013'
and VALUE<>0
end


----ИТП канал--------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1021'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1043'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1021'
and VALUE<>0
end
----ИТП подогрев--------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1020'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1042'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1020'
and VALUE<>0
end
----ИТП ХВП--------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1019'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1041'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1019'
and VALUE<>0
end

----------Нач капремонт---------

update [MONTHS_PAID]
set 
SERVICE_ID='д1нк'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='кнач'
and VALUE<>0

-------------
update pl
set PAID=isnull((select SUM(mp.VALUE) from MONTHS_PAID mp where mp.OCC_ID=pl.OCC_ID and mp.SERVICE_ID=pl.TYPE_ID),0)
from PAYM_LIST pl
where OCC_ID=@occ
--------------
-------------------	    	   
	   FETCH NEXT FROM cOcc INTO  @occ,@bldn
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  



----------------------
--Остатки Сальдо по счетчикам через месяц

use it_gh
DECLARE	
	@occ int,
	@bldn int
	
DECLARE cOcc CURSOR FOR
select o.id,b.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 --and b. id in (   )
  and b.TECHSUBDIV_ID in (117 )

  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@bldn

	WHILE @@FETCH_STATUS =0
		BEGIN   ---меняем услуги ч-з служебную услугу на Долг 1

	
--------------Хол вода---------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='хвод'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1024'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1024'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='хвод'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='хвод'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------	    	   


--------------Канал Хол воды---------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1012'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1034'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1034'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1012'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1012'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------	


---------------------------------------------

--------------Подогрев---------------------
if (exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1004'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1026'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1026'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1004'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1004'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------
----
            
---------------------------------------------

--------------ХВ для Подогрева---------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1014'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1036'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1036'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1014'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1014'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------
---
---------------------------------------------

--------------Канал ГВ---------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1013'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1035'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1035'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1013'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1013'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------

--------------ИТП Канал ГВ---------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1021'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1043'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1043'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1021'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1021'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 end           
---------------------------------------------

--------------ИТП Подогрев---------------------
if (exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1020'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1042'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1042'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1020'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1020'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------

--------------ИТП ХВ Под---------------------
if (exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1019'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1041'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1041'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1019'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1019'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------
---Подогрев ОДН

	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='9999'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='д1до'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1до'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='пдод'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='пдод'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'	
		
---ХВП ОДН

	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='9999'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='д1оп'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1оп'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='хпод'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='хпод'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'	
		
---Холодная вода ОДН

	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='9999'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='д1хо'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1хо'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='одхв'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='одхв'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'	
		
---------------------------------------------

-----------Освещение------------------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1030'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1030'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1008'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1008'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
      ---
       

	    	   
	   FETCH NEXT FROM cOcc INTO  @occ,@bldn
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  


---------------
--Платежи по остаткам на следующий месяц


use it_gh
DECLARE	
	@occ int,
	@bldn int;
DECLARE cOcc CURSOR FOR
select o.id,b.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and b.TECHSUBDIV_ID=117

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@bldn

	WHILE @@FETCH_STATUS =0
		BEGIN   ---меняем услуги ч-з ДОлг4 на долг1


/*
-------------------
-------------------
--------------------
----------------------
-----------------------
*/

------


-------------Хол вода--------------------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='хвод'and cl.MANAGEMENT_COMPANY_ID=32))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1024'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='хвод'
and VALUE<>0
end
-------------Канал Хол вод--------------------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1012'and cl.MANAGEMENT_COMPANY_ID=32))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1034'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1012'
and VALUE<>0
end


----------Подогрев----------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1004'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1026'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1004'
and VALUE<>0
end
----------ХВП------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1014'and cl.MANAGEMENT_COMPANY_ID=32))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1036'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1014'
and VALUE<>0
end
----------Канал ГВ-----------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1013'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1035'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1013'
and VALUE<>0
end


----ИТП канал--------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1021'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1043'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1021'
and VALUE<>0
end
----ИТП подогрев--------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1020'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1042'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1020'
and VALUE<>0
end
----ИТП ХВП--------
if (exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1019'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1041'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1019'
and VALUE<>0
end

----------Свет---------

update [MONTHS_PAID]
set 
SERVICE_ID='1030'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1008'
and VALUE<>0

-------------

----------ХВ ОДН---------

update [MONTHS_PAID]
set 
SERVICE_ID='д1хо'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='одхв'
and VALUE<>0
-------------

----------Подгрев ОДН---------

update [MONTHS_PAID]
set 
SERVICE_ID='д1до'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='пдод'
and VALUE<>0
-------------

----------Подгрев ОДН---------

update [MONTHS_PAID]
set 
SERVICE_ID='д1оп'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='хпод'
and VALUE<>0
-------------

update pl
set PAID=isnull((select SUM(mp.VALUE) from MONTHS_PAID mp where mp.OCC_ID=pl.OCC_ID and mp.SERVICE_ID=pl.TYPE_ID),0)
from PAYM_LIST pl
where OCC_ID=@occ
--------------
-------------------	    	   
	   FETCH NEXT FROM cOcc INTO  @occ,@bldn
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  


--------Поставить поставщика

 use it_gh
  update cl
  set cl.source_id=
  case cl.SERVICE_ID
  when 'хвод' then '4021'
  when '1012' then '21017'
  when '1013' then '22013'
  when '1019' then '27011'
  when '1021' then '29008'
  when '1008' then '19059'
  when 'одхв' then '141013'
  else 
  cl.source_id
  end
 --select   op.*
  from consmodes_list cl
  inner join occupations o on o.ID=cl.OCC_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 --and b. id in (   )
  and b.TECHSUBDIV_ID in (117 )
  and cl.SERVICE_ID in ('хвод','1012','1013','1019','1021','1008','одхв')


