--- По количеству домов в разрезе тарифов на ТО 
use pskov1118
select  t.NAME,r.VALUE Teh,r3.VALUE Musor,r4.VALUE lift,count(distinct b.ID) bldncnt
--,(select top 1 ch.mode_id from CML_HISTORY ch where ch.occ_id=cl.OCC_ID and ch.service_id=cl.SERVICE_ID and ch.mode_id%1000 <>0 order by ch.finterm_id desc)
from 
   OCCUPATIONS  o 
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
  inner join CONSMODES_LIST cl2  on o.ID=cl2.OCC_ID and cl2.SERVICE_ID in ('1000','тех2','тех3')
  inner join RATES r on r.MODE_ID=cl2.MODE_ID and r.ID=cl2.RATE_ID and r.PROPTYPE_ID=o.PROPTYPE_ID and r.ROOMTYPE_ID=f.ROOMTYPE_ID
  
  left join CONSMODES_LIST cl3  on o.ID=cl3.OCC_ID and cl3.SERVICE_ID in ('1015','вым2','вым3','1006') and cl3.MODE_ID%1000<>0
  left join RATES r3 on r3.MODE_ID=cl3.MODE_ID and r3.ID=cl3.RATE_ID and r3.PROPTYPE_ID=o.PROPTYPE_ID and r3.ROOMTYPE_ID=f.ROOMTYPE_ID

 left join CONSMODES_LIST cl4  on o.ID=cl4.OCC_ID and cl4.SERVICE_ID in ('лифт','лиф2') and cl4.MODE_ID%1000<>0
  left join RATES r4 on r4.MODE_ID=cl4.MODE_ID and r4.ID=cl4.RATE_ID and r4.PROPTYPE_ID=o.PROPTYPE_ID and r4.ROOMTYPE_ID=f.ROOMTYPE_ID


  where t.IS_HISTORY=1 
  --and b.TECHSUBDIV_ID in (66,87)
  and cl2.MODE_ID%1000<>0
 
--and not exists (select 1 from  [CONSMODES_LIST] cl where cl.OCC_ID=o.ID and cl.SERVICE_ID in ('соип','с2ип','соих','с2их','сопо','соп2'))-- and cl.MODE_ID%1000<>0
and exists (select 1 from  [CONSMODES_LIST] cl where cl.OCC_ID=o.ID and cl.SERVICE_ID in ('сохв','сох2','сох3') and cl.MODE_ID in (182009,182005,182006,233005,233006,233007,249005,249006,249007))-- and cl.MODE_ID%1000<>0 водогреи
--and  exists (select 1 from  [CONSMODES_LIST] cl where cl.OCC_ID=o.ID and cl.SERVICE_ID in ('лифт','лиф2') and cl.MODE_ID%1000<>0)
   group by t.NAME,r.VALUE,r3.VALUE,r4.VALUE
  order by 1,2,3