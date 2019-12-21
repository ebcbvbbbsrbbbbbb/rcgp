--Восстановление случайно затертого сальдо по данным прошлого периода


--select o.id,o.address,b.ID bldnid,f.FLAT_NO,f.ID flid,b.BLDN_NO 
--from occupations o 
--left join FLATS f on f.ID=o.flat_id
--left join BUILDINGS b on b.ID=f.BLDN_ID
--where o.id=26401634--26002601

---ВОКЗАЛЬНАЯ д.44 кв.2	1070044
--ГРАЖДАНСКАЯ д.11Б кв.1	1312011
--ЛЬВА ТОЛСТОГО д.24А кв.1	3181024
---СТАХАНОВСКАЯ д.4 кв.1	5390004


--------------------------------------
use it_gh;
DECLARE
	@OCC_ID			VARCHAR(20),
	@SERVICE_ID		VARCHAR(20),
	@SALDO			NUMERIC(10, 2),
	@SALDO_SUM		NUMERIC(10, 2),
	@PRED_OCC_ID	VARCHAR(20),
	@sumoasaldo     NUMERIC(10, 2);
	
DECLARE cSaldo CURSOR FOR
	SELECT oa.occ_id,oa.service_id,oa.saldo+pl.value+pl.added-pl.paid saldon --, oa.*,pl.*
	  FROM pskov1212.dbo.occ_accounts oa
	  inner join pskov1212.dbo.consmodes_list cl on cl.occ_id=oa.occ_id and cl.service_id=oa.service_id and cl.management_company_id=26
	  inner join pskov1212.dbo.paym_list pl on pl.occ_id=oa.occ_id and pl.type_id=oa.service_id
	  inner join pskov1212.dbo.occupations o on o.id=oa.occ_id
	  inner join pskov1212.dbo.flats f on f.id=o.flat_id
	 --- inner join pskov1212.dbo.buildings b on b.id=f.bldn_id
	  where  f.bldn_id in (1070044,1312011,3181024,5390004) 
	  and oa.saldo+pl.value+pl.added-pl.paid<>0
	 ORDER BY oa.occ_id


--BEGIN TRANSACTION

OPEN cSaldo
	FETCH NEXT FROM cSaldo INTO @OCC_ID, @SERVICE_ID, @SALDO
	SELECT @PRED_OCC_ID = @OCC_ID,
	       @SALDO_SUM = 0  ;
	
	WHILE @@FETCH_STATUS <> -1 
		BEGIN
			IF @PRED_OCC_ID <> @OCC_ID
				BEGIN
				select @sumoasaldo=(select SUM(saldo) from pskov0113.dbo.OCC_ACCOUNTS oa where  oa.OCC_ID=@PRED_OCC_ID);
					UPDATE pskov0113.dbo.occupations
					   SET saldo = @sumoasaldo
					     , current_saldo = @sumoasaldo
					 WHERE id = @PRED_OCC_ID    
					   
					SELECT @SALDO_SUM = 0
					     , @PRED_OCC_ID = @OCC_ID
				END	
			
			UPDATE pskov0113.dbo.OCC_ACCOUNTS
			   SET SALDO = @SALDO
			 WHERE OCC_ID = @OCC_ID
			   AND SERVICE_ID = @SERVICE_ID  --and SALDO <> @SALDO  
						
				SELECT @SALDO_SUM = @SALDO_SUM + @SALDO
						
			FETCH NEXT FROM cSaldo INTO @OCC_ID, @SERVICE_ID, @SALDO
		END;  
		
select @sumoasaldo=(select SUM(saldo) from pskov0113.dbo.OCC_ACCOUNTS oa where  oa.OCC_ID=@OCC_ID);
					UPDATE pskov0113.dbo.occupations
					   SET saldo = @sumoasaldo
					     , current_saldo = @sumoasaldo
					 WHERE id = @OCC_ID		
CLOSE cSaldo
DEALLOCATE cSaldo

--ROLLBACK TRANSACTION
