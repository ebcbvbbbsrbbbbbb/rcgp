--Перенос сальдо разовыми по данным прошлого периода на другую услугу с нужным поставщиком


select o.id,o.address,b.ID bldnid,f.FLAT_NO,f.ID flid,b.BLDN_NO 
from pskov1212.dbo.occupations o 
left join pskov1212.dbo.FLATS f on f.ID=o.flat_id
left join pskov1212.dbo.BUILDINGS b on b.ID=f.BLDN_ID
where o.id=36001201--26002601

680012
680004
680006
5490015


--------------------------------------
use it_gh;
DECLARE
	@OCC_ID			VARCHAR(20),
	@SERVICE_ID		VARCHAR(20),
	@SALDO			NUMERIC(10, 2),
	@SALDOMINUS		NUMERIC(10, 2),
	@PRED_OCC_ID	VARCHAR(20),
	@sumoasaldo     NUMERIC(10, 2);
	
DECLARE cSaldo CURSOR FOR
	SELECT oa.occ_id,oa.service_id,oa.saldo saldon --, oa.*,pl.*
	  FROM pskov1212.dbo.occ_accounts oa
	  inner join pskov1212.dbo.consmodes_list cl on cl.occ_id=oa.occ_id and cl.service_id=oa.service_id --and cl.management_company_id=36
	 -- inner join pskov1212.dbo.paym_list pl on pl.occ_id=oa.occ_id and pl.type_id=oa.service_id
	  inner join pskov1212.dbo.occupations o on o.id=oa.occ_id
	  inner join pskov1212.dbo.flats f on f.id=o.flat_id
	 --- inner join pskov1212.dbo.buildings b on b.id=f.bldn_id
	  where  f.bldn_id in (680012,680004,680006,5490015) 
	  and oa.saldo<>0 and oa.service_id='хвод'
	 ORDER BY oa.occ_id


--BEGIN TRANSACTION

OPEN cSaldo
	FETCH NEXT FROM cSaldo INTO @OCC_ID, @SERVICE_ID, @SALDO

	WHILE @@FETCH_STATUS <> -1 
		BEGIN
		set @SALDOMINUS=-@SALDO;
		exec it_gh.dbo.ad_SetTechCorrectWitchDoc @OCC_ID,'хв54',55,@SALDO  ;    -- 55 - Номер док получить по exec ad_GetDocsList 1	
        exec it_gh.dbo.ad_SetTechCorrectWitchDoc @OCC_ID,'хвод',55,@SALDOMINUS      -- 55 - Номер док получить по exec ad_GetDocsList 1													
			FETCH NEXT FROM cSaldo INTO @OCC_ID, @SERVICE_ID, @SALDO
		END;  
		

CLOSE cSaldo
DEALLOCATE cSaldo

--ROLLBACK TRANSACTION


----------------------
--Перенос переплат обратно на воду
	SELECT  '' aa,155 tip ,oa.occ_id,(oa.saldo-pl.PAID+pl.ADDED+pl.VALUE)saldon,''qq --, oa.*,pl.*
	  FROM it_gh.dbo.occ_accounts oa
	  inner join it_gh.dbo.consmodes_list cl on cl.occ_id=oa.occ_id and cl.service_id=oa.service_id --and cl.management_company_id=36
	  inner join it_gh.dbo.paym_list pl on pl.occ_id=oa.occ_id and pl.type_id=oa.service_id
	  inner join it_gh.dbo.occupations o on o.id=oa.occ_id
	  inner join it_gh.dbo.flats f on f.id=o.flat_id
	 --- inner join it_gh.dbo.buildings b on b.id=f.bldn_id
	  where  f.bldn_id in (680012,680004,680006,5490015) 
	  and oa.saldo-pl.PAID+pl.ADDED+pl.VALUE<0 and oa.service_id='хв54'
	 ORDER BY oa.occ_id

	SELECT  '' aa,17 tip ,oa.occ_id,-(oa.saldo-pl.PAID+pl.ADDED+pl.VALUE)saldon,''qq --, oa.*,pl.*
	  FROM it_gh.dbo.occ_accounts oa
	  inner join it_gh.dbo.consmodes_list cl on cl.occ_id=oa.occ_id and cl.service_id=oa.service_id --and cl.management_company_id=36
	  inner join it_gh.dbo.paym_list pl on pl.occ_id=oa.occ_id and pl.type_id=oa.service_id
	  inner join it_gh.dbo.occupations o on o.id=oa.occ_id
	  inner join it_gh.dbo.flats f on f.id=o.flat_id
	 --- inner join it_gh.dbo.buildings b on b.id=f.bldn_id
	  where  f.bldn_id in (680012,680004,680006,5490015) 
	  and oa.saldo-pl.PAID+pl.ADDED+pl.VALUE<0 and oa.service_id='хв54'
	 ORDER BY oa.occ_id

--------------------------
--переплаты по воде в мп
	select aa,tip,OCC_ID,
	-(case when sumdol+saldon>=0 then saldon
	else -sumdol
	end)
	,qq
	
	--,sumdol,sumdol+saldon
	 from
	(
	SELECT  '' aa,155 tip ,oa.occ_id,(oa.saldo)saldon,''qq --, oa.*,pl.*
	,(select oa2.SALDO from it_gh.dbo.occ_accounts oa2 where oa2.OCC_ID=oa.OCC_ID and oa2.SERVICE_ID='хв54') sumdol
	  FROM it_gh.dbo.occ_accounts oa
	  inner join it_gh.dbo.consmodes_list cl on cl.occ_id=oa.occ_id and cl.service_id=oa.service_id --and cl.management_company_id=36
	  inner join it_gh.dbo.paym_list pl on pl.occ_id=oa.occ_id and pl.type_id=oa.service_id
	  inner join it_gh.dbo.occupations o on o.id=oa.occ_id
	  inner join it_gh.dbo.flats f on f.id=o.flat_id
	 --- inner join it_gh.dbo.buildings b on b.id=f.bldn_id
	  where  f.bldn_id in (680012,680004,680006,5490015) 
	  and oa.saldo<0 and oa.service_id='хвод'
	 ) zz
	 ORDER BY occ_id
