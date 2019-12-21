use it_gh
select '' q, 
221 tip   -- 
,oa.OCC_ID ,
-(sum(oa.saldo)-sum(pl.paid)+sum(pl.ADDED)+SUM(pl.VALUE)),''
from OCC_ACCOUNTS oa
  inner join occupations o on o.id=oa.OCC_ID
  inner join PAYM_LIST pl on pl.OCC_ID=o.ID and  pl.TYPE_ID=oa.SERVICE_ID
  inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=oa.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  inner join PROPERTY_LIST prl on prl.PROPERTY_ID = 'плат' and prl.OBJECT_IDC=oa.SERVICE_ID
  where t.IS_HISTORY=1 -- and b.TECHSUBDIV_ID=87  
 -- and b.id in(2310004)
  and
 prl.OBJECT_IDN in (221)  and oa.SALDO+pl.VALUE-pl.PAID+pl.ADDED<0 
 and exists (select 1 from 
  OCC_ACCOUNTS oa2
   inner join PAYM_LIST pl2 on pl2.OCC_ID=o.ID and  pl2.TYPE_ID=oa2.SERVICE_ID
    inner join PROPERTY_LIST prl2 on prl2.PROPERTY_ID = 'плат' and prl2.OBJECT_IDC=oa2.SERVICE_ID
   where oa2.OCC_ID=o.ID and oa2.SALDO+pl2.VALUE-pl2.PAID+pl2.ADDED>0 
   and prl2.OBJECT_IDN in (221)
   
 )
 
group by oa.occ_id
order by oa.occ_id

----------------------------------------
--Вода водоканала 2
use it_gh
select '' q, 
345 tip   -- 
,oa.OCC_ID ,
(sum(oa.saldo)-sum(pl.paid)+sum(pl.ADDED)+SUM(pl.VALUE)),''
from OCC_ACCOUNTS oa
  inner join occupations o on o.id=oa.OCC_ID
  inner join PAYM_LIST pl on pl.OCC_ID=o.ID and  pl.TYPE_ID=oa.SERVICE_ID
  inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=oa.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  inner join PROPERTY_LIST prl on prl.PROPERTY_ID = 'плат' and prl.OBJECT_IDC=oa.SERVICE_ID
  inner join SUPPLIERS su on su.ID=cl.SOURCE_ID
  where t.IS_HISTORY=1 -- and b.TECHSUBDIV_ID=87  
 -- and b.id in(2310004)
 and su.SUP_ACCEPT_ID  in (9)
  and
 prl.OBJECT_IDN in (345)  and oa.SALDO+pl.VALUE-pl.PAID+pl.ADDED<0 
 and exists (select 1 from 
  OCC_ACCOUNTS oa2
   inner join PAYM_LIST pl2 on pl2.OCC_ID=o.ID and  pl2.TYPE_ID=oa2.SERVICE_ID
    inner join PROPERTY_LIST prl2 on prl2.PROPERTY_ID = 'плат' and prl2.OBJECT_IDC=oa2.SERVICE_ID
    inner join CONSMODES_LIST cl2 on cl2.OCC_ID=o.ID and cl2.SERVICE_ID=oa2.SERVICE_ID
     inner join SUPPLIERS su2 on su2.ID=cl2.SOURCE_ID
   where oa2.OCC_ID=o.ID and oa2.SALDO+pl2.VALUE-pl2.PAID+pl2.ADDED>0 
    and su.SUP_ACCEPT_ID  in (9)
   and prl2.OBJECT_IDN in (345)   
 )
 
  and not exists (select 1 from 
  OCC_ACCOUNTS oa2
   inner join PAYM_LIST pl2 on pl2.OCC_ID=o.ID and  pl2.TYPE_ID=oa2.SERVICE_ID
    inner join PROPERTY_LIST prl2 on prl2.PROPERTY_ID = 'плат' and prl2.OBJECT_IDC=oa2.SERVICE_ID
    inner join CONSMODES_LIST cl2 on cl2.OCC_ID=o.ID and cl2.SERVICE_ID=oa2.SERVICE_ID
     inner join SUPPLIERS su2 on su2.ID=cl2.SOURCE_ID
   where oa2.OCC_ID=o.ID 
    and su.SUP_ACCEPT_ID not in (9)
   and prl2.OBJECT_IDN in (345)   
 )
 
group by oa.occ_id
order by oa.occ_id

-----------
use it_gh
select '' q, 
149 tip   -- 
,oa.OCC_ID ,
-(sum(oa.saldo)-sum(pl.paid)+sum(pl.ADDED)),''
from OCC_ACCOUNTS oa
  inner join occupations o on o.id=oa.OCC_ID
  inner join PAYM_LIST pl on pl.OCC_ID=o.ID and  pl.TYPE_ID=oa.SERVICE_ID
  inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=oa.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  inner join PROPERTY_LIST prl on prl.PROPERTY_ID = 'плат' and prl.OBJECT_IDC=oa.SERVICE_ID
  where t.IS_HISTORY=1  and b.TECHSUBDIV_ID=87  
  and b.id in(2310004) and
 prl.OBJECT_IDN in (149)  and oa.SALDO+pl.VALUE-pl.PAID+pl.ADDED<0 
 
group by oa.occ_id
order by oa.occ_id