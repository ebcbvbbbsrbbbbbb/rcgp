SELECT s.NAME ulica,b.BLDN_NO dom ,f.FLAT_NO kv,t.NAME uchast, o.id ls
--COUNT(*) cnt
  FROM [dbo].[CONSMODES_LIST] cl
  inner join [dbo].[cons_modes] cm on cm.ID=cl.MODE_ID
  inner join [dbo].occupations o on o.id=cl.OCC_ID
  inner join [dbo].FLATS f on f.ID=o.flat_id
  inner join [dbo].BUILDINGS b on b.ID=f.BLDN_ID
  left join [dbo].STREETS s on s.ID=b.STREET_ID
  left join [dbo].TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
  where cl.SERVICE_ID='1014' --and b.TECHSUBDIV_ID in(31)
  and cl.CNTR_BIT=0
  and not exists(select * from [dbo].[CONSMODES_LIST] cl2 where cl2.OCC_ID=cl.OCC_ID and cl2.SERVICE_ID in ('1004') and cl2.CNTR_BIT=0 )--'1014',
  --group by s.NAME,b.BLDN_NO,t.NAME
  order by 3,1,2





---------------------------------------------
use it_gh
select cl.OCC_ID from COUNTER_LIST cl
inner join COUNTERS c on c.COUNTER_ID=cl.COUNTER_ID
inner join occupations o on o.id=cl.OCC_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  
where  t.IS_HISTORY=1 and
 cl.CNTR_TYPE_ID in (1,2) and c.MASTER_ID=0
and cl.SERVICE_ID in('1004')
and NOT exists(select * from COUNTER_LIST cl2
inner join COUNTERS c2 on c2.COUNTER_ID=cl2.COUNTER_ID
where cl2.CNTR_TYPE_ID in (1,2) and c2.MASTER_ID=cl.COUNTER_ID
and cl2.SERVICE_ID in('1013'))

use it_gh
select cl.OCC_ID from COUNTER_LIST cl
inner join COUNTERS c on c.COUNTER_ID=cl.COUNTER_ID
inner join occupations o on o.id=cl.OCC_ID
  inner join CONSMODES_LIST cm on cm.OCC_ID=o.id and cm.SERVICE_ID=cl.SERVICE_ID and right(cm.MODE_ID,3)<>'000'
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  
where  t.IS_HISTORY=1 and
 cl.CNTR_TYPE_ID in (1,2) and c.MASTER_ID=0
and cl.SERVICE_ID in('1004')
and exists(select 1 from COUNTER_LIST cl2
inner join COUNTERS c2 on c2.COUNTER_ID=cl2.COUNTER_ID
inner join CONSMODES_LIST cm2 on cm2.OCC_ID=o.id and cm2.SERVICE_ID=cl2.SERVICE_ID and right(cm2.MODE_ID,3)='000'
where cl2.CNTR_TYPE_ID in (1,2) and c2.MASTER_ID=cl.COUNTER_ID
and cl2.SERVICE_ID in('1014'))