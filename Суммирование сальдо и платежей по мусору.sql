use it_gh
DECLARE	
	@occ int;
DECLARE cOcc CURSOR FOR
select o.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and b.TECHSUBDIV_ID=25
  and exists(select 1 from OCC_ACCOUNTS oa where oa.OCC_ID=o.ID and oa.SERVICE_ID='1000')
  and exists(select 1 from OCC_ACCOUNTS oa where oa.OCC_ID=o.ID and oa.SERVICE_ID='1015')

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN   
-----ТО------------------------------------------------		
	    update oa  
		SET 
		SALDO=SALDO+isnull((select saldo from OCC_ACCOUNTS o2 where o2.OCC_ID=@occ and o2.SERVICE_ID='1015'),0)
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1000'
        
        update pl
		SET 
		PAID=PAID+isnull((select PAID from PAYM_LIST p2 where p2.OCC_ID=@occ and p2.TYPE_ID='1015'),0)
		FROM 
		PAYM_LIST PL
		WHERE PL.OCC_ID=@OCC
		AND PL.TYPE_ID='1000'

        update mp  --- При наличии нескольких платежей возникнет проблема. Надо решать в ручном режиме или добавить and p2.PAYING_ID=p.PAYING_ID и смотреть чтобы обе услуги там были
		SET 
		VALUE=VALUE+isnull((select VALUE from MONTHS_PAID p2 where p2.OCC_ID=@occ and p2.SERVICE_ID='1015'),0)	
		FROM 
		MONTHS_PAID mp
		WHERE mp.OCC_ID=@OCC
		AND mp.SERVICE_ID='1000'
		
		
		-----------

		update oa
		set 
		SALDO=0
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1015'

		update pl
		SET 
		PAID=0	
		FROM 
		PAYM_LIST PL
		WHERE PL.OCC_ID=@OCC
		AND PL.TYPE_ID='1015'
		
	    update mp 
		SET 
		VALUE=0		
		FROM 
		MONTHS_PAID mp
		WHERE mp.OCC_ID=@OCC
		AND mp.SERVICE_ID='1015'

		
----------------------------------------------------------



	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  