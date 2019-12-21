use it_gh
SELECT  o.id
from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where  t.IS_HISTORY=1 
and
 exists(select oa.OCC_ID, sum((oa.SALDO-pl.PAID+pl.ADDED+oa.penalty)) from OCC_ACCOUNTS oa
  inner join CONSMODES_LIST cl on cl.OCC_ID=oa.OCC_ID and cl.SERVICE_ID=oa.SERVICE_ID 
  inner join PAYM_LIST pl on pl.OCC_ID=oa.OCC_ID and pl.TYPE_ID=oa.SERVICE_ID
  inner join PROPERTY_LIST prl on prl.PROPERTY_ID = 'плат' and prl.OBJECT_IDC=oa.SERVICE_ID
  where  
  cl.MANAGEMENT_COMPANY_ID=32 
  --and (oa.SALDO-pl.PAID+pl.ADDED)>0 
  and
 oa.OCC_ID=o.id and  prl.OBJECT_IDN in (323,325) 
 
           
  group by oa.OCC_ID
  having sum((oa.SALDO-pl.PAID+pl.ADDED+oa.penalty))>0
  
             )
order by b.STREET_ID,b.BLDN_NO,f.FLAT_NO  


-------------------------------------
use it_gh
SELECT  o.id
from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where  t.IS_HISTORY=1 
and
 exists(select oa.OCC_ID, sum((oa.SALDO-pl.PAID+pl.ADDED)) from OCC_ACCOUNTS oa
  inner join CONSMODES_LIST cl on cl.OCC_ID=oa.OCC_ID and cl.SERVICE_ID=oa.SERVICE_ID and cl.MANAGEMENT_COMPANY_ID not in (41,91,24,99)
  inner join PAYM_LIST pl on pl.OCC_ID=oa.OCC_ID and pl.TYPE_ID=oa.SERVICE_ID
  where  cl.MANAGEMENT_COMPANY_ID=50 
  --and (oa.SALDO-pl.PAID+pl.ADDED)>0 
  and
 oa.OCC_ID=o.id and oa.SERVICE_ID in 
             (--d1
             '1022','1023','1024','1025','1026','1027','1028','1029','1030','1031','1032','1033','1034','1035','1036',
  '1037','1038','1039','1040','1041','1042','1043','д1от','д1по','д1хп','д1до','д1нк','д1оп','д1хо'
 -- d2 
 --,
  --'1044','1045','1046','1047','1048','1049','1050','1051','1052','1053','1054','1055','1056','1057','1058',
  --'1059','1060','1061','1062','1063','1064','1065'

 --  d3
  --'1066','1067','1068','1069','1070','1071','1072','1073','1074','1075','1076','1077','1078','1079','1080',
  --'1081','1082','1083','1084','1085','1086','1087'
  )
  group by oa.OCC_ID
  having sum((oa.SALDO-pl.PAID+pl.ADDED))>0
  
             )
order by b.STREET_ID,b.BLDN_NO,f.FLAT_NO  

---------------
-------В недолговых ушедших домах на основных услугах
------------------
select o.ID,x.NAME ULICA,b.BLDN_NO DOM,f.FLAT_NO KV
  from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  inner join XSTREETS x on  x.ID=b.STREET_ID
  where t.IS_HISTORY=1 and b.TECHSUBDIV_ID=50
 and b.id not in (691017,1220004,1840004,1790004,5160047,2120019,5470007,5470008,770018,5160004,5981016,2990005,2992031,3180038,3900005,5980021,1060013,700006,1970020,2070005,3251026,3530003,5141062) --расселенные дома, некуда носить квитанции
  and not exists (select 1 from CONSMODES_LIST cl 
              inner join PAYM_LIST pl on pl.OCC_ID=o.ID and pl.TYPE_ID=cl.SERVICE_ID
             where cl.OCC_ID=o.ID and cl.MODE_ID % 1000<>0 
             and pl.VALUE<>0               
             )  
  and not exists (select 1 from -- Нет начислений во всем доме
    occupations o2
  inner join FLATS f2 on f2.ID=o2.flat_id
  inner join CONSMODES_LIST cl2 on cl2.OCC_ID=o2.id
  inner join PAYM_LIST pl2 on pl2.OCC_ID=o2.ID and pl2.TYPE_ID=cl2.SERVICE_ID
              where f2.BLDN_ID=f.BLDN_ID and cl2.MODE_ID % 1000<>0 
             and pl2.VALUE<>0               
             )   
                       
and exists(select oa.OCC_ID, sum((oa.SALDO-pl.PAID+pl.ADDED)) from OCC_ACCOUNTS oa  
  inner join PAYM_LIST pl on pl.OCC_ID=oa.OCC_ID and pl.TYPE_ID=oa.SERVICE_ID
 where oa.OCC_ID=o.id
 and oa.SERVICE_ID in('1004','1006','1008','1009','1012','1013','1014','1015','1016','1017','1019','1020','1021',
    '2008','анте','вывм','капр','лифт','найм','освл','отоп','пгаз','хвод','элво','элек','элпл','кх54','хв54','взно',
    'вптс','одхв','хпод','пдод','ипод','иход','элод','домф','заэл','удве','загв','зхвс','зкан','ремэ','упящ','дото','дпод','дхвп')
 group by oa.OCC_ID   
 having sum((oa.SALDO-pl.PAID+pl.ADDED))>0 
  )            
and exists  
       (select 1 from OCC_NOTPRINT op where op.OCC_ID=o.ID )
  order by 2,
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



----------------------
---9

use it_gh
SELECT  o.id
from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where  t.IS_HISTORY=1 
and
 exists(select 1 from OCC_ACCOUNTS oa
  inner join CONSMODES_LIST cl on cl.OCC_ID=oa.OCC_ID and cl.SERVICE_ID=oa.SERVICE_ID 
  inner join PAYM_LIST pl on pl.OCC_ID=oa.OCC_ID and pl.TYPE_ID=oa.SERVICE_ID
  where  b.TECHSUBDIV_ID  =98 and
 (oa.SALDO-pl.PAID+pl.ADDED)>0 and
 oa.OCC_ID=o.id and oa.SERVICE_ID in 
             ('1000','1004','1006','1008','1009','1012','1013','1014','1015','1016','1017','1019','1020','1021',
              '2008','анте','вывм','капр','лифт','найм','освл','отоп','пгаз','хвод','элво','элек','элпл','кх54','хв54'
             )
       )
order by b.STREET_ID,b.BLDN_NO,
		CASE
          WHEN PATINDEX ( '%[^0-9]%' , f.FLAT_NO ) = 0
	  THEN REPLICATE ( '0' , 7 - DATALENGTH ( f.FLAT_NO ) ) +f.FLAT_NO
          ELSE REPLICATE ( '0' , 8 - PATINDEX ( '%[^0-9]%' , f.FLAT_NO ) ) + f.FLAT_NO
	END



