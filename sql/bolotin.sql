select aa.*,(select sum(oa.SALDO) from [it_gh].[dbo].[OCC_ACCOUNTS] oa where oa.OCC_ID=aa.OCC_ID and oa.SALDO<>0 and oa.SERVICE_ID in ('1022','1023','1024','1025','1026','1027','1028','1029','1030','1031','1032','1033','1034','1035','1036',
  '1037','1038','1039','1040','1041','1042','1043'))sumsaldo
 from
(select -- top 1000
 --mp.* 
 --distinct 
 mp.OCC_ID--,sum(mp.VALUE) sump
 from [pskov1011].[dbo].[MONTHS_PAID] mp
  inner join [pskov1011].[dbo].occupations o on o.id=mp.OCC_ID
 -- inner join [pskov1011].[dbo].PAYM_LIST pl on pl.OCC_ID=o.ID and  pl.TYPE_ID=mp.SERVICE_ID
  --inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=mp.SERVICE_ID
  inner join [pskov1011].[dbo].FLATS f on f.ID=o.flat_id
  inner join [pskov1011].[dbo].BUILDINGS b on b.ID=f.BLDN_ID
  inner join [pskov1011].[dbo].TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
  and b.STREET_ID=605 
  and b.BLDN_NO=1 and mp.PLAT_TYPE_ID=139
  and exists(select 1 from [it_gh].[dbo].[OCC_ACCOUNTS] oa where oa.OCC_ID=mp.OCC_ID and oa.SALDO<>0 and oa.SERVICE_ID in ('1022','1023','1024','1025','1026','1027','1028','1029','1030','1031','1032','1033','1034','1035','1036',
  '1037','1038','1039','1040','1041','1042','1043') )
  group by mp.OCC_ID
union
select  mp.OCC_ID --,sum(mp.VALUE) sump  
from [pskov1111].[dbo].[MONTHS_PAID] mp
  inner join [pskov1111].[dbo].occupations o on o.id=mp.OCC_ID
 -- inner join [pskov111].[dbo].PAYM_LIST pl on pl.OCC_ID=o.ID and  pl.TYPE_ID=mp.SERVICE_ID
  --inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=mp.SERVICE_ID
  inner join [pskov1111].[dbo].FLATS f on f.ID=o.flat_id
  inner join [pskov1111].[dbo].BUILDINGS b on b.ID=f.BLDN_ID
  inner join [pskov1111].[dbo].TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
  and b.STREET_ID=605 
  and b.BLDN_NO=1 and mp.PLAT_TYPE_ID=139
  and exists(select 1 from [it_gh].[dbo].[OCC_ACCOUNTS] oa where oa.OCC_ID=mp.OCC_ID and oa.SALDO<>0 and oa.SERVICE_ID in ('1022','1023','1024','1025','1026','1027','1028','1029','1030','1031','1032','1033','1034','1035','1036',
  '1037','1038','1039','1040','1041','1042','1043') )
  group by mp.OCC_ID
union
select  mp.OCC_ID--,sum(mp.VALUE) sump  
  from [pskov1211].[dbo].[MONTHS_PAID] mp
  inner join [pskov1211].[dbo].occupations o on o.id=mp.OCC_ID
 -- inner join [pskov111].[dbo].PAYM_LIST pl on pl.OCC_ID=o.ID and  pl.TYPE_ID=mp.SERVICE_ID
  --inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=mp.SERVICE_ID
  inner join [pskov1211].[dbo].FLATS f on f.ID=o.flat_id
  inner join [pskov1211].[dbo].BUILDINGS b on b.ID=f.BLDN_ID
  inner join [pskov1211].[dbo].TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
  and b.STREET_ID=605 
  and b.BLDN_NO=1 and mp.PLAT_TYPE_ID=139
  and exists(select 1 from [it_gh].[dbo].[OCC_ACCOUNTS] oa where oa.OCC_ID=mp.OCC_ID and oa.SALDO<>0 and oa.SERVICE_ID in ('1022','1023','1024','1025','1026','1027','1028','1029','1030','1031','1032','1033','1034','1035','1036',
  '1037','1038','1039','1040','1041','1042','1043') )
  group by mp.OCC_ID
  union
select  mp.OCC_ID --,sum(mp.VALUE) sump  
  from [pskov0112].[dbo].[MONTHS_PAID] mp
  inner join [pskov0112].[dbo].occupations o on o.id=mp.OCC_ID
 -- inner join [pskov0112].[dbo].PAYM_LIST pl on pl.OCC_ID=o.ID and  pl.TYPE_ID=mp.SERVICE_ID
  --inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=mp.SERVICE_ID
  inner join [pskov0112].[dbo].FLATS f on f.ID=o.flat_id
  inner join [pskov0112].[dbo].BUILDINGS b on b.ID=f.BLDN_ID
  inner join [pskov0112].[dbo].TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
  and b.STREET_ID=605 
  and b.BLDN_NO=1 and mp.PLAT_TYPE_ID=139
  and exists(select 1 from [it_gh].[dbo].[OCC_ACCOUNTS] oa where oa.OCC_ID=mp.OCC_ID and oa.SALDO<>0 and oa.SERVICE_ID in ('1022','1023','1024','1025','1026','1027','1028','1029','1030','1031','1032','1033','1034','1035','1036',
  '1037','1038','1039','1040','1041','1042','1043') )
  group by mp.OCC_ID
  )aa