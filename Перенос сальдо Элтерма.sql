--Сальдо суммированием  с Д1 на основные

/*
Делается в самом начале финансового периода
*/
use it_gh
DECLARE	
	@occ int,
	@saldo money;
DECLARE cOcc CURSOR FOR
select o.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and (
  ( (b.STREET_ID=300 and b.BLDN_NO in('7','14','16А'))
   or
    (b.STREET_ID=519 and b.BLDN_NO in('7'))
  )  
  )

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN   

---------------------------------------------------------	

-----------Отопление------------------------------------------		
set @saldo=0

	    select @saldo=saldo 	    
	    from
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='отоп'

if @saldo is null set @saldo=0

       update OCC_ACCOUNTS
		set 
		saldo=@saldo
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='дото'

		/*update OCC_ACCOUNTS
		set 
		saldo=0
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='отоп'
		*/
				
----------------------------------------------------------


-----------Подогрев------------------------------------------		
set @saldo=0

	    select @saldo=saldo 	    
	    from
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1004'

if @saldo is null set @saldo=0

       update OCC_ACCOUNTS
		set 
		saldo=@saldo
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='дпод'

		/*update OCC_ACCOUNTS
		set 
		saldo=0
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1004'
		*/
				
----------------------------------------------------------

-----------ХВП------------------------------------------		
set @saldo=0

	    select @saldo=saldo 	    
	    from
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1014'

if @saldo is null set @saldo=0

       update OCC_ACCOUNTS
		set 
		saldo=@saldo
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='дхвп'

		/*update OCC_ACCOUNTS
		set 
		saldo=0
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1014'
		*/
				
----------------------------------------------------------	
	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  

