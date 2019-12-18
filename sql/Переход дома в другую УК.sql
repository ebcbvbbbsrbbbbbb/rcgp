/*
Делается в самом начале финансового периода
*/
use it_gh
DECLARE	
	@occ int;
DECLARE cOcc CURSOR FOR
select o.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and b. id in (   )
  and b.TECHSUBDIV_ID in (  )

  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

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

--------------Найм---------------------
/*		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1032'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1032'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='найм'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='найм'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
*/            
---------------------------------------------
-------------------Старый мусор------------------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1028'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1028'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1006'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1006'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
              --	
		
---------------------------------------    

--------------Старый лифт---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1031'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1031'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1009'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1009'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
     ---
        
---------------------------------------------

-----------Освещение------------------------------
/*  
--- Через месяц после основного переноса
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
       
*/


------------------------------------

--------------Антена---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1027'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1027'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='анте'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='анте'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
            
---------------------------------------------

--------------Газ---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1025'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1025'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='пгаз'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='пгаз'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
            
---------------------------------------------

--------------Элетричество---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1029'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1029'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='элек'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='элек'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
            
---------------------------------------------
	
--------------Хол вода---------------------
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
            
---------------------------------------------	    	   


--------------Канал Хол воды---------------------
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
------------------
--------------Долг Отопл---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1от'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1от'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='дото'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='дото'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
            
---------------------------------------------

--------------Подогрев---------------------
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
            
---------------------------------------------
----
--------------Долг Подогрев---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1по'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1по'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='дпод'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='дпод'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
            
---------------------------------------------

--------------ХВ для Подогрева---------------------
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
            
---------------------------------------------
---
--------------Долг ХВ для Подогрева---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1хп'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='д1хп'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='дхвп'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='дхвп'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
            
---------------------------------------------

--------------Канал ГВ---------------------
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
            
---------------------------------------------

--------------ИТП Канал ГВ---------------------
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
            
---------------------------------------------

--------------ИТП Подогрев---------------------
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
            
---------------------------------------------

--------------ИТП ХВ Под---------------------
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
            
---------------------------------------------

--------------ХВ Под ОДН---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1оп'

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
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
            
---------------------------------------------

--------------Под ОДН---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1до'

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
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
            
---------------------------------------------

--------------ХВ ОДН---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='д1хо'

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
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
            
---------------------------------------------
	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  


----------------
----------------
-------------

ДОЛГ 2

/*
Делается в самом начале финансового периода
*/
use it_gh
DECLARE	
	@occ int;
DECLARE cOcc CURSOR FOR
select o.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and (
  (b.STREET_ID=388 and b.BLDN_NO='19А')) 

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN   ---меняем услуги ч-з ДОлг4 на долг2
-----ТО------------------------------------------------		
	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='1088'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1044'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1044'
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
		and oa.SERVICE_ID='1088'	
		

		
----------------------------------------------------------

-------Вывоз мусора---------------------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1103'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1059'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1059'
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
		and oa.SERVICE_ID='1103'
	--	
		
--------------------------------------------------------------------

-----------Капремонт------------------------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1099'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1055'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1055'
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
		and oa.SERVICE_ID='1099'
	


-----------Освещение------------------------------
  
--- Через месяц после основного переноса
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1096'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1052'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1052'
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
		and oa.SERVICE_ID='1096'
      ---
       



------------------------------------



	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  

-------также перенести услуги в [OCC_PENYA_HISTORY] тоже с учетом [FINTERM_ID]=текущему

--select id from fin_terms where closed = 0  -- текущий период

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

-----------------------
----------------------
-------------------
--Сальдо суммированием  с Д1 на основные

/*
Делается в самом начале финансового периода
*/
use it_gh
DECLARE	
	@occ int,
	@saldo money;
DECLARE cOcc CURSOR FOR
select o.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and (
  (b.STREET_ID=370 and b.BLDN_NO='32')  
  )

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN   ---меняем услуги ч-з ДОлг4 на долг1

---------------------------------------------------------	

-----------Мусор------------------------------------------		
set @saldo=0

	    select @saldo=saldo 	    
	    from
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1037'

if @saldo is null set @saldo=0

       update OCC_ACCOUNTS
		set 
		saldo=saldo+@saldo
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1015'

		update OCC_ACCOUNTS
		set 
		saldo=0
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1037'
		
		

		
----------------------------------------------------------

	
	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  


----------------
----------------
-------------




----------------------------

/*
Делается в самом начале финансового периода
*/
use it_gh
DECLARE	
	@occ int,
	@saldo money;
DECLARE cOcc CURSOR FOR
select o.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and (
  (b.STREET_ID=239 and b.BLDN_NO='18А')or
  (b.STREET_ID=239 and b.BLDN_NO in ('29/23'))or
  (b.STREET_ID=255 and b.BLDN_NO='28')or
  (b.STREET_ID=255 and b.BLDN_NO='30')  
  )

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN   

        
---------------------------------------------
           
-----Добавялем на долг 1 электричество из электр. по челам

--------------Элетричество---------------------
set @saldo=0

	    select @saldo=saldo 	    
	    from
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='элво'

if @saldo is null set @saldo=0

if @saldo<>0 
 begin
print '--'+cast(@OCC as varchar(12))+'=='+cast(@saldo as varchar(12))

       update OCC_ACCOUNTS
		set 
		saldo=saldo+@saldo
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1029'

		update OCC_ACCOUNTS
		set 
		saldo=0
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='элво';
		
 end		
-------------------------------
	
---------------------------------------------
	
	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  


--------------------------
----------------------------
---=========================================================

--- Долг 3 ----------------------

-----------------------------------------------------------------
-----------------------------------------------------------------
	  -----ТО------------------------------------------------		
	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='1088'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1066'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1066'
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
		and oa.SERVICE_ID='1088'	
		

		
----------------------------------------------------------

-------Вывоз мусора---------------------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1103'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1081'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1081'
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
		and oa.SERVICE_ID='1103'
	--	
		
--------------------------------------------------------------------
-----------Капремонт------------------------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1099'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1077'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1077'
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
		and oa.SERVICE_ID='1099'
	

-------------------------------------------------------------
--------------Найм---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1098'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1076'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1076'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='найм'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='найм'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1098'
            
---------------------------------------------

	  
	-----------Освещение------------------------------

--- Через месяц после основного переноса
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1096'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1074'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1074'
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
		and oa.SERVICE_ID='1096'
      ---
       

--------------Хол вода---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1090'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1068'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1068'
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
		and oa.SERVICE_ID='1090'
            
---------------------------------------------	    	   


--------------Канал Хол воды---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1100'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1078'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1078'
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
		and oa.SERVICE_ID='1100'
            
---------------------------------------------	

--------------Отопл---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1089'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1067'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1067'
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
		and oa.SERVICE_ID='1089'
            
---------------------------------------------

--------------Подогрев---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1092'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1070'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1070'
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
		and oa.SERVICE_ID='1092'
            
---------------------------------------------

--------------ХВ для Подогрева---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1102'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1080'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1080'
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
		and oa.SERVICE_ID='1102'
            
---------------------------------------------

--------------Канал ГВ---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1101'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1079'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1079'
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
		and oa.SERVICE_ID='1101'
            
---------------------------------------------
---===========================================

-- ДОЛГ1 -> ДОЛГ 2


use it_gh
DECLARE	
	@occ int;
DECLARE cOcc CURSOR FOR
select o.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and (b.id=3881019) 

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN   ---меняем услуги ч-з 9999 на долг2
-----ТО------------------------------------------------		
	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='9999'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1044'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1044'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1022'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1022'
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
		and oa.SERVICE_ID='1059'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1059'
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
		and oa.SERVICE_ID='9999'
	--	
		
--------------------------------------------------------------------



-----------Освещение------------------------------
  
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1052'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1052'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1030'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1030'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
      ---
       
-------Старый Вывоз мусора---------------------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1050'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1050'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1028'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1028'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
	--	
		
--------------------------------------------------------------------


------------------------------------



	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  
