  update cl3
  set 
   CNTR_UNITS=cl.cntr_units
--SELECT cl.*
  FROM it_gh.[dbo].[CONSMODES_LIST] cl3
  inner join [n1pskov].[dbo].[CONSMODES_LIST] cl on cl.OCC_ID=cl3.OCC_ID and cl3.SERVICE_ID=cl.SERVICE_ID
  inner join it_gh.[dbo].occupations o on o.id=cl3.OCC_ID
  inner join it_gh.[dbo].FLATS f on f.ID=o.flat_id  
  inner join it_gh.[dbo].BUILDINGS b on b.ID=f.BLDN_ID

  where b.ID=760013 and
  cl.SERVICE_ID='1004'
  
  and not exists(select 1 from it_gh.[dbo].[CONSMODES_LIST] cl2 
  where cl2.SERVICE_ID=cl.SERVICE_ID and cl2.OCC_ID=cl.OCC_ID and cl2.CNTR_UNITS=cl.CNTR_UNITS)

----------------------------------------------------

  update cl3
  set 
   [ACTUAL_UNITS]=cl.[ACTUAL_UNITS]
--SELECT cl.*
  FROM it_gh.[dbo].[COUNTER_LIST] cl3
  inner join [n1pskov].[dbo].[COUNTER_LIST] cl on cl.OCC_ID=cl3.OCC_ID and cl3.SERVICE_ID=cl.SERVICE_ID and cl3.COUNTER_ID=cl.COUNTER_ID
  inner join it_gh.[dbo].occupations o on o.id=cl3.OCC_ID
  inner join it_gh.[dbo].FLATS f on f.ID=o.flat_id  
  inner join it_gh.[dbo].BUILDINGS b on b.ID=f.BLDN_ID

  where b.ID=760013 and
  cl.SERVICE_ID='1004'
  
  and not exists(select 1 from it_gh.[dbo].[COUNTER_LIST] cl2 
  where cl2.SERVICE_ID=cl.SERVICE_ID and cl2.OCC_ID=cl2.OCC_ID and cl2.[ACTUAL_UNITS]=cl.[ACTUAL_UNITS] and cl2.COUNTER_ID=cl.COUNTER_ID)  

---------------------------------
update c
  set 
[GROUP_NORMATIV_C]=c2.[GROUP_NORMATIV_C],
[GROUP_NORMATIV_CG]=c2.[GROUP_NORMATIV_CG],
[GROUP_VOLUME_10]=c2.[GROUP_VOLUME_10],
[GROUP_VOLUME]=c2.[GROUP_VOLUME],
[SUB_PERS_VOLUME_10_JIL]=c2.[SUB_PERS_VOLUME_10_JIL],
[SUB_GR_VOLUME_10_JIL]=c2.[SUB_GR_VOLUME_10_JIL],
[SUB_PERS_VOLUME_10_NEJ]=c2.[SUB_PERS_VOLUME_10_NEJ],
[SUB_GR_VOLUME_10_NEJ]=c2.[SUB_GR_VOLUME_10_NEJ],
[SUB_PERS_VOLUME_10]=c2.[SUB_PERS_VOLUME_10],
[SUB_GR_VOLUME_10]=c2.[SUB_GR_VOLUME_10],
[GROUP_DELTA_N]=c2.[GROUP_DELTA_N],
[GROUP_VOLUME_ODN]=c2.[GROUP_VOLUME_ODN]
    FROM [it_gh].[dbo].[COUNTERS] c
    inner join n1pskov.[dbo].[COUNTERS] c2 on  c2.COUNTER_ID=c.COUNTER_ID
  where c.COUNTER_ID=336432

-----------------------
update cl3
  set 
   [CNTR_UNITS]=cl.[CNTR_UNITS],
   [VALUE]=cl.VALUE
   --SELECT cl.*
  FROM it_gh.[dbo].[ADDED_PAYMENTS] cl3
  inner join [n1pskov].[dbo].[ADDED_PAYMENTS] cl on cl3.OCC_ID=cl.OCC_ID and cl3.SERVICE_ID=cl.SERVICE_ID and cl.ID=cl3.ID
  
  inner join it_gh.[dbo].occupations o on o.id=cl.OCC_ID
  inner join it_gh.[dbo].FLATS f on f.ID=o.flat_id  
  inner join it_gh.[dbo].BUILDINGS b on b.ID=f.BLDN_ID

  where b.ID=760013 and
  cl.SERVICE_ID='1004'
  
  and not exists(select 1 from it_gh.[dbo].[ADDED_PAYMENTS] cl2 
  where cl2.OCC_ID=cl.OCC_ID and cl2.SERVICE_ID=cl.SERVICE_ID and cl.ID=cl2.ID and cl2.[CNTR_UNITS]=cl.[CNTR_UNITS] and cl2.[VALUE]=cl.[VALUE])
  
----------------
  
  update cb
  set [MAIN_VOLUME]=c2.[MAIN_VOLUME],
  [BIND_VOLUME]=c2.[BIND_VOLUME],
  [TRANSFER_COEFF]=c2.[TRANSFER_COEFF]
  -- select *
   FROM [it_gh].[dbo].[CNTR_BINDING_BLOCKS] cb
   inner join [n1pskov].[dbo].[CNTR_BINDING_BLOCKS] c2 on c2.BIND_COUNTER_ID=cb.BIND_COUNTER_ID and c2.MAIN_COUNTER_ID=cb.MAIN_COUNTER_ID
   and c2.TRANSFER_COEFF<>cb.TRANSFER_COEFF  
-----------------
update p
set ADDED=(select SUM(VALUE) from [it_gh].[dbo].[ADDED_PAYMENTS] a where a.OCC_ID=p.OCC_ID and a.SERVICE_ID=p.TYPE_ID)
from [it_gh].[dbo].PAYM_LIST p
where exists(select * from [it_gh].[dbo].[ADDED_PAYMENTS] a2 where a2.OCC_ID=p.OCC_ID and a2.SERVICE_ID=p.TYPE_ID)