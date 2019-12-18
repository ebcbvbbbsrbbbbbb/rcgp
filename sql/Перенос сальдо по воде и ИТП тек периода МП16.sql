--Перенос сальдо на долги МП 16

select x.ID street_id ,x.NAME street,b.BLDN_NO dom,b.ID bldn_id from BUILDINGS b
inner join XSTREETS x on x.ID=b.STREET_ID
where lower(x.NAME) like lower('%алексея алех%') and lower(b.BLDN_NO) in ('1','2','5','8','10')

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
	  FROM it_gh.dbo.occ_accounts oa
	  inner join it_gh.dbo.consmodes_list cl on cl.occ_id=oa.occ_id and cl.service_id=oa.service_id --and cl.management_company_id=36
	 -- inner join it_gh.dbo.paym_list pl on pl.occ_id=oa.occ_id and pl.type_id=oa.service_id
	  inner join it_gh.dbo.occupations o on o.id=oa.occ_id
	  inner join it_gh.dbo.flats f on f.id=o.flat_id
	 --- inner join it_gh.dbo.buildings b on b.id=f.bldn_id
	  where  f.bldn_id in (--680001,680002,680005,680008,680010 --Алехина
	                      --- ,2120035,2120037,2120039,2120043, -- Ижорского 35 37 39 43
	                       2120045,2120047,2120049) -- Ижорского 45,47,49
	  and oa.saldo<>0 and oa.service_id='1019' -- 'хвод'
	 ORDER BY oa.occ_id


--BEGIN TRANSACTION

OPEN cSaldo
	FETCH NEXT FROM cSaldo INTO @OCC_ID, @SERVICE_ID, @SALDO

	WHILE @@FETCH_STATUS <> -1 
		BEGIN
		set @SALDOMINUS=-@SALDO;
	   /* update oa
	    set SALDO=@SALDO
	    from it_gh.dbo.occ_accounts oa
	    where oa.SERVICE_ID='хв54' and oa.OCC_ID=@OCC_ID */
	    
	  /*  update oa
	    set SALDO=0
	    from it_gh.dbo.occ_accounts oa
	    where oa.SERVICE_ID='хвод' and oa.OCC_ID=@OCC_ID */
	    
	   /* update oa
	    set SALDO=0
	    from it_gh.dbo.occ_accounts oa
	    where oa.SERVICE_ID='1019' and oa.OCC_ID=@OCC_ID
	    
	    update oa
	    set SALDO=@SALDO
	    from it_gh.dbo.occ_accounts oa
	    where oa.SERVICE_ID='дхвп' and oa.OCC_ID=@OCC_ID*/
	    
			FETCH NEXT FROM cSaldo INTO @OCC_ID, @SERVICE_ID, @SALDO
		END;  
		

CLOSE cSaldo
DEALLOCATE cSaldo

--ROLLBACK TRANSACTION



----- Платежи переместить

update oa
set SERVICE_ID=CASE oa.service_id when '1019' then 'дхвп' when 'хвод' then 'хв54' else oa.service_id end
--  select CASE oa.service_id when '1019' then 'дхвп' when 'хвод' then 'хв54' else oa.service_id end newserv, oa.*
  FROM it_gh.dbo.[MONTHS_PAID] oa
	  inner join it_gh.dbo.consmodes_list cl on cl.occ_id=oa.occ_id and cl.service_id=oa.service_id --and cl.management_company_id=36
	 -- inner join it_gh.dbo.paym_list pl on pl.occ_id=oa.occ_id and pl.type_id=oa.service_id
	  inner join it_gh.dbo.occupations o on o.id=oa.occ_id
	  inner join it_gh.dbo.flats f on f.id=o.flat_id
	 --- inner join it_gh.dbo.buildings b on b.id=f.bldn_id
	  where  f.bldn_id in (680001,680002,680005,680008,680010 --Алехина
	                       ,2120035,2120037,2120039,2120043, -- Ижорского 35 37 39 43
	                       2120045,2120047,2120049) -- Ижорского 45,47,49
	  and oa.VALUE<>0 and oa.service_id in ('1019','хвод')

update pl
set PAID=isnull((select sum(mp.VALUE) from it_gh.dbo.[MONTHS_PAID] mp where mp.OCC_ID=pl.OCC_ID and mp.SERVICE_ID=pl.TYPE_ID ),0)
--  select CASE oa.service_id when '1019' then 'дхвп' when 'хвод' then 'хв54' else oa.service_id end newserv, oa.*
  FROM it_gh.dbo.PAYM_LIST pl  
	 
	  inner join it_gh.dbo.occupations o on o.id=pl.occ_id
	  inner join it_gh.dbo.flats f on f.id=o.flat_id
	 --- inner join it_gh.dbo.buildings b on b.id=f.bldn_id
	  where  f.bldn_id in (680001,680002,680005,680008,680010 --Алехина
	                       ,2120035,2120037,2120039,2120043, -- Ижорского 35 37 39 43
	                       2120045,2120047,2120049) -- Ижорского 45,47,49



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
