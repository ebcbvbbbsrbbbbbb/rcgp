---Доначисление за ВДГО с января по 0.06 на несколько домов
use it_gh
DECLARE	
	@occ int,
	@summa money,
	@servid char(4);
	
DECLARE cOcc CURSOR FOR
SELECT o.id,cl.SERVICE_ID,(cast(o.COMBINED_SQ * 0.06 * 4 as numeric(10,2)))sm
  FROM occupations o 
inner join consmodes_list cl on cl.occ_id=o.id  
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join XSTREETS x on x.ID=b.STREET_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
where t.IS_HISTORY=1  and b.TECHSUBDIV_ID in (50)
and b.id in (2330006,2331007,3350028)
and cl.SERVICE_ID in('1000')
and (cl.mode_id%1000)<>0
and exists(select 1 from [it_gh].[dbo].[ADDED_HISTORY] ap
  where ap.DOC_ID=51 and ap.occ_id=o.id and ap.service_id=cl.service_id
  and ap.[FINTERM_ID]=62)
  order by 1

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa

	WHILE @@FETCH_STATUS =0
		BEGIN 
		print '1';
        exec ad_SetTechCorrectWitchDoc @occ,@servid,16,@summa      --  Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc   
-----------------
-------------------

---Снятие за ВДГО с января по 0.06 на несколько домов
     
use it_gh
DECLARE	
	@occ int,
	@summa money,
	@servid char(4);
	
DECLARE cOcc CURSOR FOR
SELECT o.id,cl.SERVICE_ID,-(cast(o.COMBINED_SQ * 0.06 * 4 as numeric(10,2)))sm
  FROM occupations o 
inner join consmodes_list cl on cl.occ_id=o.id  
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join XSTREETS x on x.ID=b.STREET_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
where t.IS_HISTORY=1  and b.TECHSUBDIV_ID in (50)
and b.id in (700004,701006,700008,1300012,2222069,2610002,2611006,2620011,2620013,2990022,3310007,3310017,3310024,3360006,3360008,3455008,
             3470009,3470011,3470013,3900003,90006,90009,150002,370013,4090003,4090005,4095009,4220010,5140077,5520005,5520006,5640021,
             5650008,5650010,6080054,690017,2550030,5160021,5160031,1071003,1070005,1070007,1071009,2190001)
and cl.SERVICE_ID in('1000')
and (cl.mode_id%1000)<>0
and exists(select 1 from [it_gh].[dbo].[ADDED_HISTORY] ap
  where ap.DOC_ID=50 and ap.occ_id=o.id and ap.service_id=cl.service_id
  and ap.[FINTERM_ID]=62)
  order by 1

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa

	WHILE @@FETCH_STATUS =0
		BEGIN 
		print '1';
       -- exec ad_SetTechCorrectWitchDoc @occ,@servid,17,@summa      --  Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc   

----------------
------------------
--Действующие режимы

SELECT 
cm.NAME,cl.MODE_ID,COUNT(*)
  FROM [CONSMODES_LIST] cl
  inner join occupations o  on cl.occ_id=o.id  
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join CONS_MODES cm on cm.SERVICE_ID=cl.SERVICE_ID and cm.ID=cl.MODE_ID
  where b.TECHSUBDIV_ID in (50)
and b.id in (700004,701006,700008,1300012,2222069,2610002,2611006,2620011,2620013,2990022,3310007,3310017,3310024,3360006,3360008,3455008,
             3470009,3470011,3470013,3900003,90006,90009,150002,370013,4090003,4090005,4095009,4220010,5140077,5520005,5520006,5640021,
             5650008,5650010,6080054,690017,2550030,5160021,5160031,1071003,1070005,1070007,1071009,2190001)
and cl.SERVICE_ID in('1000')
and (cl.mode_id%1000)<>0
  group by cm.NAME,cl.MODE_ID
  order by 1

-----------
---------
--Заменить режимы

update cl
set mode_id=16091
--SELECT  cl.occ_id, cm.NAME,cl.MODE_ID --,COUNT(*)
  FROM [CONSMODES_LIST] cl
  inner join occupations o  on cl.occ_id=o.id  
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join CONS_MODES cm on cm.SERVICE_ID=cl.SERVICE_ID and cm.ID=cl.MODE_ID
  where b.TECHSUBDIV_ID in (50)
and b.id in (700004,701006,700008,1300012,2222069,2610002,2611006,2620011,2620013,2990022,3310007,3310017,3310024,3360006,3360008,3455008,
             3470009,3470011,3470013,3900003,90006,90009,150002,370013,4090003,4090005,4095009,4220010,5140077,5520005,5520006,5640021,
             5650008,5650010,6080054,690017,2550030,5160021,5160031,1071003,1070005,1070007,1071009,2190001)
and cl.SERVICE_ID in('1000')
and cl.mode_id=16027