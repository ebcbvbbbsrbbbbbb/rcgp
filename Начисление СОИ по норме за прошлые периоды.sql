
 ---Начисление СОИ по текущей норме за прошлые периоды.
use it_gh
go 
DECLARE	
	@occ int,
	@summa money,
	@servid char(4);
	
DECLARE cOcc CURSOR FOR
SELECT --fi.ID,cml.OCC_ID,cl.CNTR_NORM,rh.C_VALUE,rh.VALUE,CASE when rh.VALUE=0 then rh.C_VALUE else rh.VALUE end tarif
--,b.OI_SQ_DIV_OB_SQ,bss.OI_SQ_DIV_OB_SQ,ISNULL(bss.OI_SQ_DIV_OB_SQ,b.OI_SQ_DIV_OB_SQ) obdivsq,--rh.*, 
cml.OCC_ID,cml.service_id,
sum(round(cl.CNTR_NORM*o.COMBINED_SQ*ISNULL(bss.OI_SQ_DIV_OB_SQ,b.OI_SQ_DIV_OB_SQ)*(CASE when rh.VALUE=0 then rh.C_VALUE else rh.VALUE end),2))
normnach

--cml.*
  FROM FIN_TERMS fi 
  inner join
  CML_HISTORY cml (NOLOCK) on cml.finterm_id= (
			select max(cmlh2.FINTERM_ID) from CML_HISTORY cmlh2
			where	cmlh2.OCC_ID = cml.OCC_ID
			and	cmlh2.SERVICE_ID = cml.SERVICE_ID
			and	cmlh2.FINTERM_ID <= fi.ID
		)
  inner join consmodes_list cl on cl.occ_id=cml.occ_id and cl.service_id=cml.service_id
  inner join occupations o on o.ID=cml.occ_id
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  left join [BUILDINGS_SOI_SERVICES] bss on bss.BLDN_ID=b.ID and bss.SERVICE_ID=cl.SERVICE_ID
  inner join RATES_HISTORY rh on rh.ID=cml.rate_id
  where  f.BLDN_ID=2310004
  and fi.ID >=78 and fi.id<=91
 and cml.SERVICE_ID in ( 'сопо','сохв','сохп')
-- and cml.occ_id=87004700
 and rh.MODE_ID=cml.mode_id
 and rh.PROPTYPE_ID=o.PROPTYPE_ID
 and rh.RATE_ZONE_ID=0
 and rh.SOURCE_ID=cml.source_id
 and rh.STATUS_ID=o.STATUS_ID
 and rh.ROOMTYPE_ID=f.ROOMTYPE_ID
 and rh.FINTERM_ID=fi.ID
 group by cml.OCC_ID,cml.service_id
 having sum(round(cl.CNTR_NORM*o.COMBINED_SQ*ISNULL(bss.OI_SQ_DIV_OB_SQ,b.OI_SQ_DIV_OB_SQ)*(CASE when rh.VALUE=0 then rh.C_VALUE else rh.VALUE end),2))<>0
 order by cml.occ_id
OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa

	WHILE @@FETCH_STATUS =0
		BEGIN 
		
     --   exec ad_SetTechCorrectWitchDoc @occ,@servid,49,@summa      -- 15 - Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc     