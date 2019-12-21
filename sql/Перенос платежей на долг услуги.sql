use it_gh
DECLARE	
	@occ int;
DECLARE cOcc CURSOR FOR
select o.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and (b.id=3180017
  )

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN   ---меняем услуги ч-з ДОлг4 на долг1


/*
-------------------
-------------------
--------------------
----------------------
-----------------------
*/
----- Освещение------------
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
------

update [MONTHS_PAID]
set 
SERVICE_ID='1030'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='2008'
and VALUE<>0
------

update [MONTHS_PAID]
set 
SERVICE_ID='1030'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='освл'
and VALUE<>0
------

------------Старый лифт----------
update [MONTHS_PAID]
set 
SERVICE_ID='1031'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1009'
and VALUE<>0

----------Старый мусор-----------
update [MONTHS_PAID]
set 
SERVICE_ID='1028'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1006'
and VALUE<>0

----------Капремонт---------
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

-------------Канал Хол вод--------------------------------
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

----------ХВП------------
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

----------Канал ГВ-----------
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



----Найм--------
update [MONTHS_PAID]
set 
SERVICE_ID='1032'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='найм'
and VALUE<>0

----ИТП канал--------
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

----ИТП подогрев--------
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

----ИТП ХВП--------
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


----долг Отопление--------
update [MONTHS_PAID]
set 
SERVICE_ID='д1от'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='дото'
and VALUE<>0

----долг Подогрев--------
update [MONTHS_PAID]
set 
SERVICE_ID='д1по'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='дпод'
and VALUE<>0

----долг ХВП--------
update [MONTHS_PAID]
set 
SERVICE_ID='д1хп'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='дхвп'
and VALUE<>0


-------------
update pl
set PAID=isnull((select SUM(mp.VALUE) from MONTHS_PAID mp where mp.OCC_ID=pl.OCC_ID and mp.SERVICE_ID=pl.TYPE_ID),0)
from PAYM_LIST pl
where OCC_ID=@occ
--------------
-------------------	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  


