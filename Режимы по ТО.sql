--Используемые режимы
SELECT 
cm.NAME,cl.MODE_ID,COUNT(*)
  FROM it_gh.[dbo].[CONSMODES_LIST] cl
  inner join it_gh.[dbo].[CONS_MODES] cm on cm.SERVICE_ID=cl.SERVICE_ID and cm.ID=cl.MODE_ID
  where cl.SERVICE_ID='1000'
  group by cm.NAME,cl.MODE_ID
  order by 1

-- Неиспользуемые режимы  
  select * from 
  it_gh.[dbo].[CONS_MODES] cm 
  where cm.SERVICE_ID='1000'
  and NOT exists(select 1 from it_gh.[dbo].[CONSMODES_LIST] cl where cm.SERVICE_ID=cl.SERVICE_ID and cm.ID=cl.MODE_ID)
  order by 3

------------------

use it_gh
DECLARE	
	@occ int,
	@summa money,
	@servid char(4);
	
DECLARE cOcc CURSOR FOR
SELECT o.id,cl.SERVICE_ID,-(cast(o.COMBINED_SQ * 0.43 as numeric(10,2)))sm
  FROM occupations o 
inner join consmodes_list cl on cl.occ_id=o.id  
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join XSTREETS x on x.ID=b.STREET_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
where t.IS_HISTORY=1  and b.TECHSUBDIV_ID in (25,31,50,102,55,61,63,76,87,111)
and cl.SERVICE_ID in('1000')
and (cl.mode_id%1000)<>0
and cl.mode_id in (16018,16020,16029,16042,16075,16027,16028,16001,16002,16003,16004)
and exists(select * from [it_gh].[dbo].[paym_history] ph

  where ph.occ_id=o.id and ph.finterm_id=61 and ph.[value]>0)
and not exists(select 1 from [it_gh].[dbo].[ADDED_PAYMENTS] ap
  where ap.DOC_ID=50 and ap.occ_id=o.id and ap.service_id=cl.service_id)
  order by 1

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa

	WHILE @@FETCH_STATUS =0
		BEGIN 
		print '1';
       -- exec ad_SetTechCorrectWitchDoc @occ,@servid,50,@summa      --  Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc   

------------
-----------
use it_gh
DECLARE	
	@occ int,
	@summa money,
	@servid char(4);
	
DECLARE cOcc CURSOR FOR
SELECT o.id,cl.SERVICE_ID,-(cast(o.COMBINED_SQ * 0.49 as numeric(10,2)))sm
  FROM occupations o 
inner join consmodes_list cl on cl.occ_id=o.id  
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join XSTREETS x on x.ID=b.STREET_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
where t.IS_HISTORY=1  and b.TECHSUBDIV_ID in (50)
and cl.SERVICE_ID in('1000')
and (cl.mode_id%1000)<>0
and cl.mode_id in (16060,16040,16092,16093,16091,16054,16100,16103,16056,16098,16057,16101,16058,16099,16059,16102 )
and exists(select * from [it_gh].[dbo].[paym_history] ph
  where ph.occ_id=o.id and ph.finterm_id=61 and ph.[value]>0)
and not exists(select 1 from [it_gh].[dbo].[ADDED_PAYMENTS] ap
  where ap.DOC_ID=51 and ap.occ_id=o.id and ap.service_id=cl.service_id)
  order by 1

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa

	WHILE @@FETCH_STATUS =0
		BEGIN 
		print '1';
        exec ad_SetTechCorrectWitchDoc @occ,@servid,51,@summa      --  Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc     