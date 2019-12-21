--Разделить ТО на мусор и лифт

 use it_gh
 select o.*
 from  OCCUPATIONS  o 
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (32)
  and cl.service_id='1000'
and not exists (select 1 from it_gh.[dbo].[CONSMODES_LIST] cl3 where cl3.occ_id=o.id and cl3.service_id='1015' )---and cl3.[MODE_ID] %1000<>0

-----

 select distinct cl.MODE_ID,cm.NAME
 from  OCCUPATIONS  o 
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
 inner join CONS_MODES cm on cm.ID=cl.MODE_ID and cm.SERVICE_ID=cl.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (32)
  and cl.service_id='1000'

-------
SELECT TOP 1000 [ID]
      ,[SERVICE_ID]
      ,[NAME]
  FROM [it_gh].[dbo].[CONS_MODES]
  where SERVICE_ID='1000'
--------
---- Режим по ТО
update cl
set MODE_ID=CASE MODE_ID 
when 16079 then 16004
when 16080 then 16003
when 16081 then 16002
when 16082 then 16001

end
from  OCCUPATIONS  o 
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
 inner join CONS_MODES cm on cm.ID=cl.MODE_ID and cm.SERVICE_ID=cl.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (32)
  and cl.service_id='1000'
  and cl.MODE_ID in (16079,
16080,
16081,
16082)
------
--Режим по мусору
update cl
set MODE_ID=24001
--select o.*
from  OCCUPATIONS  o 
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
 inner join CONS_MODES cm on cm.ID=cl.MODE_ID and cm.SERVICE_ID=cl.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (32)
  and cl.service_id='1015'
  and exists (select 1 from it_gh.[dbo].[CONSMODES_LIST] cl3 where cl3.occ_id=o.id and cl3.service_id='1000' and cl3.[MODE_ID] %1000<>0)
---------
---Лифт
select distinct o.*
 from  OCCUPATIONS  o 
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
 inner join CONS_MODES cm on cm.ID=cl.MODE_ID and cm.SERVICE_ID=cl.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (32)
  and cl.service_id='1000'
  and cl.MODE_ID=16001
  and not exists (select 1 from it_gh.[dbo].[CONSMODES_LIST] cl3 where cl3.occ_id=o.id and cl3.service_id='лифт' )---and cl3.[MODE_ID] %1000<>0
---
update cl
set MODE_ID=10001
--select o.*
from  OCCUPATIONS  o 
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
 inner join CONS_MODES cm on cm.ID=cl.MODE_ID and cm.SERVICE_ID=cl.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (32)
  and cl.service_id='лифт'
  and exists (select 1 from it_gh.[dbo].[CONSMODES_LIST] cl3 where cl3.occ_id=o.id and cl3.service_id='1000' and cl3.MODE_ID=16001)