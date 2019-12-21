select '' aa,47 tip ,oa.OCC_ID ,oa.SALDO-pl.PAID+pl.ADDED pereplat,''qq
from OCC_ACCOUNTS oa
  inner join occupations o on o.id=oa.OCC_ID
  inner join PAYM_LIST pl on pl.OCC_ID=o.ID and  pl.TYPE_ID=oa.SERVICE_ID
  inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=oa.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1  and oa.SERVICE_ID in ('1008','2008','элек','элпл','элво','освл','элод')
  and b.TECHSUBDIV_ID not in (76,87,22,51,41,91,48)
  --and cl.MODE_ID %1000 =0
   and oa.SALDO-pl.PAID+pl.ADDED<0    
  and exists(select 1 from OCC_ACCOUNTS oa2 inner join PAYM_LIST pl2 on pl2.OCC_ID=oa2.OCC_ID and pl2.TYPE_ID=oa2.SERVICE_ID where (((oa2.SALDO-pl2.PAID+pl2.VALUE+pl2.ADDED)>0)or(pl2.VALUE>0)) and oa2.OCC_ID=oa.OCC_ID  ) 
  and pl.VALUE=0
  order by oa.OCC_ID

-------------

select '' aa,137 tip ,oa.OCC_ID ,-(oa.SALDO-pl.PAID+pl.ADDED) pereplat,''qq
from OCC_ACCOUNTS oa
  inner join occupations o on o.id=oa.OCC_ID
  inner join PAYM_LIST pl on pl.OCC_ID=o.ID and  pl.TYPE_ID=oa.SERVICE_ID
  inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=oa.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1  and oa.SERVICE_ID in ('1008','2008','элек','элпл','элво','освл')
  and b.TECHSUBDIV_ID not in (76,87,22,51,41,91,48)
  --and cl.MODE_ID %1000 =0
   and oa.SALDO-pl.PAID+pl.ADDED<0    
  and exists(select 1 from OCC_ACCOUNTS oa2 inner join PAYM_LIST pl2 on pl2.OCC_ID=oa2.OCC_ID and pl2.TYPE_ID=oa2.SERVICE_ID where (((oa2.SALDO-pl2.PAID+pl2.VALUE+pl2.ADDED)>0)or(pl2.VALUE>0)) and oa2.OCC_ID=oa.OCC_ID  ) 
  and pl.VALUE=0
  order by oa.OCC_ID

----------

use it_gh
select '' aa,169 tip ,oa.OCC_ID ,(oa.SALDO-pl.PAID+pl.ADDED+pl.VALUE) pereplat,''qq
from OCC_ACCOUNTS oa
  inner join occupations o on o.id=oa.OCC_ID
  inner join PAYM_LIST pl on pl.OCC_ID=o.ID and  pl.TYPE_ID=oa.SERVICE_ID
  inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=oa.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1  and oa.SERVICE_ID in ('1008','2008','элек','элпл','элво','освл')
  --and b.TECHSUBDIV_ID not in (76,87,22,51,41,91,48)
  --and cl.MODE_ID %1000 =0
   and oa.SALDO-pl.PAID+pl.ADDED+pl.VALUE<0    
  and exists(select 1 from OCC_ACCOUNTS oa2 
                inner join PAYM_LIST pl2 on pl2.OCC_ID=oa2.OCC_ID and pl2.TYPE_ID=oa2.SERVICE_ID 
                where (((oa2.SALDO-pl2.PAID+pl2.VALUE+pl2.ADDED)>0)or(pl2.VALUE>0))and 
                 oa2.SERVICE_ID in ('1008','2008','элек','элпл','элво','освл') and oa2.OCC_ID=oa.OCC_ID  ) 
  and pl.VALUE=0
  order by oa.OCC_ID