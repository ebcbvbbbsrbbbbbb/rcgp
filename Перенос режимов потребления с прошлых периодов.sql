DECLARE	
	@occ int,
	@servid char(4),
	@srcid int,
	@modeid int,
	@rateid int,
	@MANAGEMENT_COMPANY_ID int,
	@CNTR_BIT int,
	@RATE_COEFF decimal(16,8),
	@uk int
	
	;
DECLARE cOcc CURSOR FOR
select --top 10 
o.id,cl.service_id ,cl.[SOURCE_ID],cl.[MODE_ID],cl.[RATE_ID],cl.[MANAGEMENT_COMPANY_ID],[RATE_COEFF],[CNTR_BIT]
from [pskov0112].dbo.occupations o
  inner join [pskov0112].dbo.consmodes_list cl on cl.occ_id=o.id  
  inner join [it_gh].dbo.FLATS f on f.ID=o.flat_id
  inner join [it_gh].dbo.BUILDINGS b on b.ID=f.BLDN_ID
  inner join [it_gh].dbo.TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and
  b.TECHSUBDIV_ID in (76,87)
  --and (
  --(b.STREET_ID=370 and b.BLDN_NO='20')
  --)
  order by o.id,cl.service_id
  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid,@srcid,@modeid,@rateid,@uk,@RATE_COEFF,@CNTR_BIT
		WHILE @@FETCH_STATUS =0
	BEGIN  

	if exists(select 1 from it_gh.dbo.COUNTER_LIST cnl where cnl.OCC_ID=@occ and cnl.SERVICE_ID=@servid)
	set @CNTR_BIT=1 else set @CNTR_BIT=0
	
    if not exists(select 1 from it_gh.dbo.CONSMODES_LIST cl2 where cl2.OCC_ID=@occ and cl2.SERVICE_ID=@servid) 
    
     insert into it_gh.dbo.CONSMODES_LIST
     ([OCC_ID],[SERVICE_ID],[SOURCE_ID],[MODE_ID],[external_flag],[STATE]
      ,[UNITS],[CNTR_BIT],[CNTR_UNITS],[RATE_ID],[NORMA],[EX_NORMS]
      ,[PEOPLE_COUNT],[CNTR_NORM],[MANAGEMENT_COMPANY_ID],[RATE_COEFF])
     values(@occ,@servid,@srcid,@modeid,0,1
      ,0,@CNTR_BIT,0,@rateid,0,0
      ,0,0,@uk,@RATE_COEFF)
      
     if not exists(select 1 from it_gh.dbo.[OCC_ACCOUNTS] oa2 where oa2.OCC_ID=@occ and oa2.SERVICE_ID=@servid) 
    
     insert into it_gh.dbo.[OCC_ACCOUNTS]
     ([OCC_ID],[SERVICE_ID],[CHARGE],[SALDO],[OLD_DEBT],[PENALTY]
      ,[LAST_PAID],[DAYS],[MONTHS],[NEW_CHANGE_DEBT])
      values(@occ,@servid,0,0,0,0
      ,null,null,null,null)
 
     if not exists(select 1 from it_gh.dbo.PAYM_LIST pl2 where pl2.OCC_ID=@occ and pl2.TYPE_ID=@servid) 
    
     insert into it_gh.dbo.PAYM_LIST
     ([OCC_ID],[TYPE_ID],[VALUE],[DISCOUNT],[EXPENSES]
      ,[ADDED],[PENALTY],[COMPENS],[PAID])
      values(@occ,@servid,0,0,0
      ,0,0,0,0)
 
   update it_gh.dbo.CONSMODES_LIST
   set [SOURCE_ID]=@srcid,
       [MODE_ID]=@modeid,
       [CNTR_BIT]=@CNTR_BIT,
       [RATE_ID]=@rateid,
       [MANAGEMENT_COMPANY_ID]=@uk,
       [RATE_COEFF]=@RATE_COEFF
   where [OCC_ID]=@occ and [SERVICE_ID]=@servid
       
	    	   
	    	   
	    	   
	   FETCH NEXT FROM cOcc INTO   @occ,@servid,@srcid,@modeid,@rateid,@uk,@RATE_COEFF,@CNTR_BIT
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  		