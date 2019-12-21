use it_gh
create table #occ(occ int,xv int ,kan int);

insert into #occ
select o.ID,0,0  from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and b.TECHSUBDIV_ID=50
  and exists (select 1 from CONSMODES_LIST cl 
              inner join PAYM_LIST pl on pl.OCC_ID=o.ID and pl.TYPE_ID=cl.SERVICE_ID
             where cl.OCC_ID=o.ID and cl.MODE_ID % 1000<>0 
             and pl.VALUE<>0 
              and o.COMBINED_SQ>0.0001
             )
             
 delete from oc from #occ oc
 where exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=oc.occ and cl.SOURCE_ID not in (4001,4000) and cl.SERVICE_ID='хвод')
 
 update  oc
 set xv=case when exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=oc.occ and cl.MODE_ID % 1000<>0 and cl.SERVICE_ID='хвод') then 1
 else 0
 end,
  kan=case when exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=oc.occ and cl.MODE_ID % 1000<>0 and cl.SERVICE_ID='1012') then 1
 else 0
 end
 from #occ oc
 
update  oc
 set xv=case when exists(select 1 from occupations o            --Коммуналки со счетчиком на одном ЛС
                         inner join FLATS f on f.ID=o.FLAT_ID
                         inner join OCCUPATIONS o2 on o2.FLAT_ID=f.ID and o2.ID<>o.id
                         inner join CONSMODES_LIST cl on cl.OCC_ID=o2.id and cl.CNTR_BIT>0
                         where o.ID=oc.occ  and cl.MODE_ID % 1000<>0 and cl.SERVICE_ID='хвод'
                         )
                          then 1
 else 0
 end
 from #occ oc
 where oc.xv=0

  

select aa.* ,round((cast(aa.kolXV as double precision)/aa.KolLS) * 100,2) ProcentXV from
(
select x.name Ul,b.bldn_no Dom,count(*) KolLS,sum(oc.xv) kolXV,sum(oc.kan) kolKan
 from #occ oc
  inner join occupations o on o.id=oc.occ
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join XSTREETS x on x.id=b.street_id
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
group by   x.name ,b.bldn_no
) aa
where KolLS>kolxv
order by 1,2
 drop table #occ

-------------
---Все дома с ХВ по ТО
use it_gh
create table #occ(occ int,xv int ,kan int);

insert into #occ
select o.ID,0,0  from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and b.TECHSUBDIV_ID=50
  and exists (select 1 from CONSMODES_LIST cl 
              inner join PAYM_LIST pl on pl.OCC_ID=o.ID and pl.TYPE_ID=cl.SERVICE_ID
             where cl.OCC_ID=o.ID and cl.MODE_ID % 1000<>0 
             and cl.SERVICE_ID='1000'
             and pl.VALUE<>0 
              and o.COMBINED_SQ>0.0001
             )
             
 delete from oc from #occ oc
 where exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=oc.occ and cl.SOURCE_ID not in (4001,4000) and cl.SERVICE_ID='хвод')
 
 update  oc
 set xv=case when exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=oc.occ and cl.MODE_ID % 1000<>0 and cl.SERVICE_ID='хвод') then 1
 else 0
 end,
  kan=case when exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=oc.occ and cl.MODE_ID % 1000<>0 and cl.SERVICE_ID='1012') then 1
 else 0
 end
 from #occ oc
 
update  oc
 set xv=case when exists(select 1 from occupations o            --Коммуналки со счетчиком на одном ЛС
                         inner join FLATS f on f.ID=o.FLAT_ID
                         inner join OCCUPATIONS o2 on o2.FLAT_ID=f.ID and o2.ID<>o.id
                         inner join CONSMODES_LIST cl on cl.OCC_ID=o2.id and cl.CNTR_BIT>0
                         where o.ID=oc.occ  and cl.MODE_ID % 1000<>0 and cl.SERVICE_ID='хвод'
                         )
                          then 1
 else 0
 end
 from #occ oc
 where oc.xv=0

  

select aa.* ,round((cast(aa.kolXV as double precision)/aa.KolLS) * 100,2) ProcentXV from
(
select x.name Ul,b.bldn_no Dom,count(*) KolLS,sum(oc.xv) kolXV,sum(oc.kan) kolKan
 from #occ oc
  inner join occupations o on o.id=oc.occ
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join XSTREETS x on x.id=b.street_id
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
group by   x.name ,b.bldn_no
) aa
--where KolLS>kolxv
where kolxv>0
order by 1,2
drop table #occ  
