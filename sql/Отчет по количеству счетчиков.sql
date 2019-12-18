--- По количеству квартир и  человек со счетчиками по горячей воде по домам
use it_gh
select  t.NAME,s.NAME,b.BLDN_NO,(select count(*) from FLATS f2 where f2.BLDN_ID=b.ID and f2.TOTAL_SQ>0)totalkv,
(select sum(o2.REALLY_LIVE) from  OCCUPATIONS o2 
   inner join FLATS f2 on f2.ID=o2.FLAT_ID where f2.BLDN_ID=b.ID and f2.TOTAL_SQ>0 and o2.COMBINED_SQ>0) totalpipl,
SUM(o.REALLY_LIVE) sumpiplcnt,
count(distinct f.ID) kvcnt
--,(select top 1 ch.mode_id from CML_HISTORY ch where ch.occ_id=cl.OCC_ID and ch.service_id=cl.SERVICE_ID and ch.mode_id%1000 <>0 order by ch.finterm_id desc)
from 
   OCCUPATIONS  o 
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 and t.ID in (117,32)
and exists (select 1 from  [CONSMODES_LIST] cl
            inner join COUNTER_LIST cn  on o.ID=cn.OCC_ID and cn.SERVICE_ID =cl.SERVICE_ID 
            inner join COUNTERS c on c.COUNTER_ID=cn.COUNTER_ID and c.CNTR_TYPE_ID in (1,2)
            where cl.OCC_ID=o.ID and cl.SERVICE_ID in ('1014','2014','1020','2020') 
            and cl.MODE_ID%1000<>0)
   group by t.NAME,s.NAME,b.BLDN_NO,b.ID
  order by 1,2


--- По количеству квартир со счетчиками по горячей воде 
use pskov1218
select  t.NAME,count(distinct f.ID) kvcnt
--,(select top 1 ch.mode_id from CML_HISTORY ch where ch.occ_id=cl.OCC_ID and ch.service_id=cl.SERVICE_ID and ch.mode_id%1000 <>0 order by ch.finterm_id desc)
from 
   OCCUPATIONS  o 
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 and t.ID in (117,32)
and exists (select 1 from  [CONSMODES_LIST] cl
            inner join COUNTER_LIST cn  on o.ID=cn.OCC_ID and cn.SERVICE_ID =cl.SERVICE_ID 
            inner join COUNTERS c on c.COUNTER_ID=cn.COUNTER_ID and c.CNTR_TYPE_ID in (1,2)
            where cl.OCC_ID=o.ID and cl.SERVICE_ID in ('1014','2014','1020','2020') 
            and cl.MODE_ID%1000<>0)
   group by t.NAME
  order by 1,2

---Количество квартир без счетчиков горячей воды 
use pskov1218
select  t.NAME,count(distinct f.ID) kvcnt
--,(select top 1 ch.mode_id from CML_HISTORY ch where ch.occ_id=cl.OCC_ID and ch.service_id=cl.SERVICE_ID and ch.mode_id%1000 <>0 order by ch.finterm_id desc)
from 
   OCCUPATIONS  o 
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 and t.ID in (117,32)
and exists (select 1 from  [CONSMODES_LIST] cl            
            where cl.OCC_ID=o.ID and cl.SERVICE_ID in ('1014','2014','1020','2020') 
            and cl.MODE_ID%1000<>0)
and not exists (select 1 from  [CONSMODES_LIST] cl
            inner join COUNTER_LIST cn  on o.ID=cn.OCC_ID and cn.SERVICE_ID =cl.SERVICE_ID 
            inner join COUNTERS c on c.COUNTER_ID=cn.COUNTER_ID and c.CNTR_TYPE_ID in (1,2)
            where cl.OCC_ID=o.ID and cl.SERVICE_ID in ('1014','2014','1020','2020') 
            and cl.MODE_ID%1000<>0)            
   group by t.NAME
  order by 1,2

---- ('хвод','хво2') 

-----------
