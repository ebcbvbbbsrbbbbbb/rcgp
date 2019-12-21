
select s.name , b.BLDN_NO
 from  OCCUPATIONS  o 
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
  where t.IS_HISTORY=1 and not exists(select 1 from [buildings_etc] be where be.bldn_id=b.id and be.str in ('Изолированные стояки БЕЗ полотенцесушителей',
'Изолированные стояки с полотенцесушителями',
'Неизолированные стояки с полотенцесушителями','Неизолированные стояки БЕЗ полотенцесушителей') 
)
and exists (select 1 from it_gh.[dbo].[CONSMODES_LIST] cl3 where cl3.occ_id=o.id and cl3.service_id in ('1004','1014','1020') and cl3.[MODE_ID] %1000<>0)

----Количество по категориям

select cm.NAME,cm.id,be2.str,count(*) cnt
 from  OCCUPATIONS  o 
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
 inner join CONS_MODES cm on cm.ID=cl.MODE_ID and cm.SERVICE_ID=cl.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
  inner join [buildings_etc] be2 on be2.bldn_id=b.ID and  be2.str in ('Изолированные стояки БЕЗ полотенцесушителей',
'Изолированные стояки с полотенцесушителями',
'Неизолированные стояки с полотенцесушителями','Неизолированные стояки БЕЗ полотенцесушителей') 

  where t.IS_HISTORY=1 
  and cl.SERVICE_ID in ('1004') and cl.[MODE_ID] %1000<>0    ---  '1020' ,
group by  cm.NAME,cm.ID,be2.str
order by  cm.NAME,be2.str

-----Список категорий и режимов по домам
use it_gh
SELECT 
--o.id,cl.SERVICE_ID
t.NAME UK,x.NAME UL,b.BLDN_NO DOM,cm.NAME,be2.str,count(*) KOLLS
  FROM occupations o 
inner join consmodes_list cl on cl.occ_id=o.id  
inner join CONS_MODES cm on cm.ID=cl.MODE_ID and cm.SERVICE_ID=cl.SERVICE_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join XSTREETS x on x.ID=b.STREET_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID 
inner join [buildings_etc] be2 on be2.bldn_id=b.ID and  be2.str in ('Изолированные стояки БЕЗ полотенцесушителей','Неизолированные стояки с полотенцесушителями',

'Неизолированные стояки БЕЗ полотенцесушителей') --','Изолированные стояки с полотенцесушителями',
where t.IS_HISTORY=1 
and cl.SERVICE_ID in('1004')
and cl.mode_id in (17010)

group by t.NAME,x.NAME,b.BLDN_NO,be2.str,cm.NAME
order by 1,2,3