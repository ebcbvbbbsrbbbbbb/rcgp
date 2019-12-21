
SELECT TOP 1000 [OCC_ID]
      ,[SERVICE_ID],
      sum([ACTUAL_UNITS]),
      MAX(COUNTER_ID)      
  FROM [it_gh].[dbo].[COUNTER_LIST]
   -- where COUNTER_ID=324698 
   where service_id='1020'
    group by [OCC_ID],[SERVICE_ID]
     having  sum([ACTUAL_UNITS])<0


exec [it_gh].[dbo].ad_GetDocsList 1


  insert into [it_gh].[dbo].[ADDED_PAYMENTS](
       [OCC_ID]
      ,[SERVICE_ID]
      ,[ADD_TYPE]
      ,[DOC_ID]
      ,[VALUE]
      ,[DATE_SET]
      ,[DATE_FROM]
      ,[DATE_TO]
      ,[PCT]
      ,[UNITS]
      ,[CNTR_UNITS]
      ,[HOURS]
      ,[DSC_ID]
      ,[UNITS2]
      ,[ACCOUNT_ID]
      ,[PEOPLE_ID]
      ,[GROUP_OP_ID])
values(
       34007220 -- [OCC_ID]
      ,'1020' ---[SERVICE_ID]
      ,12 --[ADD_TYPE]
      ,55 -- docid
      ,cast((-3.594880*1598.78)as numeric(18,2)) 
      ,'2015-09-16 09:17:22.517'--[DATE_SET]
      ,null--[DATE_FROM]
      ,null --[DATE_TO]
      ,null --[PCT]
      ,0  --[UNITS]
      ,-3.594880 --[CNTR_UNITS]
      ,0 --[HOURS]
      ,0 --[DSC_ID]
      ,324698 --[UNITS2]
      ,null --[ACCOUNT_ID]
      ,null --[PEOPLE_ID]
      ,null --[GROUP_OP_ID]
      )



  insert into [it_gh].[dbo].[ADDED_PAYMENTS](
       [OCC_ID]
      ,[SERVICE_ID]
      ,[ADD_TYPE]
      ,[DOC_ID]
      ,[VALUE]
      ,[DATE_SET]
      ,[DATE_FROM]
      ,[DATE_TO]
      ,[PCT]
      ,[UNITS]
      ,[CNTR_UNITS]
      ,[HOURS]
      ,[DSC_ID]
      ,[UNITS2]
      ,[ACCOUNT_ID]
      ,[PEOPLE_ID]
      ,[GROUP_OP_ID])
values(
       34007220 -- [OCC_ID]
      ,'1021' ---[SERVICE_ID]
      ,12 --[ADD_TYPE]
      ,55 -- docid
     --- ,cast((-3.594880*1598.78)as numeric(18,2)) 
     ,cast((-52.480000*18.73)as numeric(18,2)) 
      ,'2015-09-16 09:17:22.517'--[DATE_SET]
      ,null--[DATE_FROM]
      ,null --[DATE_TO]
      ,null --[PCT]
      ,0  --[UNITS]
      ,-52.48 --[CNTR_UNITS]
      ,0 --[HOURS]
      ,0 --[DSC_ID]
      ,324700 --[UNITS2]
      ,null --[ACCOUNT_ID]
      ,null --[PEOPLE_ID]
      ,null --[GROUP_OP_ID]
      )


  insert into [it_gh].[dbo].[ADDED_PAYMENTS](
       [OCC_ID]
      ,[SERVICE_ID]
      ,[ADD_TYPE]
      ,[DOC_ID]
      ,[VALUE]
      ,[DATE_SET]
      ,[DATE_FROM]
      ,[DATE_TO]
      ,[PCT]
      ,[UNITS]
      ,[CNTR_UNITS]
      ,[HOURS]
      ,[DSC_ID]
      ,[UNITS2]
      ,[ACCOUNT_ID]
      ,[PEOPLE_ID]
      ,[GROUP_OP_ID])
values(
       34007220 -- [OCC_ID]
      ,'1019' ---[SERVICE_ID]
      ,12 --[ADD_TYPE]
      ,55 -- docid
     --- ,cast((-3.594880*1598.78)as numeric(18,2)) 
     ,cast((-52.480000*22.73)as numeric(18,2)) 
      ,'2015-09-16 09:17:22.517'--[DATE_SET]
      ,null--[DATE_FROM]
      ,null --[DATE_TO]
      ,null --[PCT]
      ,0  --[UNITS]
      ,-52.48 --[CNTR_UNITS]
      ,0 --[HOURS]
      ,0 --[DSC_ID]
      ,324699 --[UNITS2]
      ,null --[ACCOUNT_ID]
      ,null --[PEOPLE_ID]
      ,null --[GROUP_OP_ID]
      )

update p
set ADDED=(select SUM(VALUE) from [it_gh].[dbo].[ADDED_PAYMENTS] a where a.OCC_ID=p.OCC_ID and a.SERVICE_ID=p.TYPE_ID)
from [it_gh].[dbo].PAYM_LIST p
where exists(select * from [it_gh].[dbo].[ADDED_PAYMENTS] a2 where a2.OCC_ID=p.OCC_ID and a2.SERVICE_ID=p.TYPE_ID)

