use it_gh
set nocount on
DECLARE	
	@occ int,
	@servid char(4),
	@cntrid int,
	@nservid char(4),
	@saldo numeric(18,2),
	@uk int
	;
DECLARE cOcc CURSOR FOR
select
-- top 20 
ml.occ,sum(oa.SALDO),case oa.service_id when 'Ý/Ý ' then 'Îñâ ' when 'Îñâ×' then 'Îñâ ' else oa.service_id end
from 
  mr11.dbo.occupations mo
  inner join mr11.dbo.OCC_ACCOUNTS oa on oa.OCC_ID=mo.ID
  inner join [it_gh].[dbo].[LS11] ml on ml.occ11=mo.id 
  inner join [it_gh].dbo.occupations o on o.id=ml.occ
  inner join [it_gh].dbo.FLATS f on f.ID=o.flat_id
  inner join [it_gh].dbo.BUILDINGS b on b.ID=f.BLDN_ID
  inner join [it_gh].dbo.TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 
 and b.TECHSUBDIV_ID in (41,91) 
 and oa.service_id in ('ÀÄ_Ã','ÀÄ_Ñ','ÂÌ  ','Ë   ','Îñâ×','Îñâ ','ÎÒ  ','ÃÂ  ','ÃÂ_È','ÕÂ_Ã','Ý/Ý ')
  and oa.saldo<>0
  
 -- and not exists(select 1 from [it_gh].dbo.occ_accounts noa where noa.occ_id=ml.occ and noa.service_id=ms.serv) and not ms.SERV in ('2008','1008')
group by ml.occ,case oa.service_id when 'Ý/Ý ' then 'Îñâ ' when 'Îñâ×' then 'Îñâ ' else oa.service_id end
  order by ml.occ
  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@saldo,@servid
		WHILE @@FETCH_STATUS =0
	BEGIN 
	--print 'LS '+cast(@occ as varchar(15))+' srv '+cast(@servid as varchar(5))+' sald '+cast(@saldo as varchar(15))
	set @servid=case @servid 
	when 'Îñâ ' then '1008' 
	when 'ÀÄ_Ã' then 'àäãà'
	when 'ÀÄ_Ñ' then 'àâäè'
	when 'ÂÌ  ' then '1015'
	when 'Ë   ' then 'ëèôò'
	when 'ÃÂ  ' then '1004'
	when 'ÃÂ_È' then '1020'
	when 'ÕÂ_Ã' then '1014'
	when 'ÎÒ  ' then 'îòîï'
	else @servid
	 end
	set @nservid=@servid 
	
	if @servid in ('1004','1020')
   	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1004' and  cl.MANAGEMENT_COMPANY_ID in (41,91))
	    set @nservid='1004'
	    else
	   if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1020' and cl.MANAGEMENT_COMPANY_ID in (41,91))--ÈÒÏ
	   set @nservid='1020'
	   
	   
	if @servid in ('1013','1021')
	
  	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1013' and  cl.MANAGEMENT_COMPANY_ID in (41,91))
	    set @nservid='1013'
	   else
	   if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1021' and cl.MANAGEMENT_COMPANY_ID in (41,91))--ÈÒÏ
	   set @nservid='1021'
	      
	   
	if @servid in ('1014','1019')
  	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1014' and  cl.MANAGEMENT_COMPANY_ID in (41,91))
	    set @nservid='1014'
	    else
	   if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1019' and cl.MANAGEMENT_COMPANY_ID in (41,91))--ÈÒÏ
	   set @nservid='1019'
	     
	   	   
	   
	if @servid in ('ýëåê','ýëâî','ýëïë')
	begin
	   if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='ýëåê' and  cl.MANAGEMENT_COMPANY_ID in (41,91))
	    set @nservid='ýëåê'
	   else 
	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='ýëâî' and cl.MANAGEMENT_COMPANY_ID in (41,91))--
	   set @nservid='ýëâî'
	   else
	    if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='ýëïë' and  cl.MANAGEMENT_COMPANY_ID in (41,91))--
	   set @nservid='ýëïë'
	   else 	
	   if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1008'  and cl.MANAGEMENT_COMPANY_ID in (41,91))
	    set @nservid='1008'	
	    else
    if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='2008' and cl.MANAGEMENT_COMPANY_ID in (41,91))--
	   set @nservid='2008'	   
	   else
    if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='îñâë' and cl.MANAGEMENT_COMPANY_ID in (41,91))--
	   set @nservid='îñâë'	
	end   
	-- 
	   
	if @servid='1015'
	   if not exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1015'  and cl.MANAGEMENT_COMPANY_ID in (41,91))
	   begin
	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='âûâì' and cl.MANAGEMENT_COMPANY_ID in (41,91))--
	   set @nservid='âûâì'	
	   	   
	   end  
	   
		   
	if @servid in ('1008','2008','îñâë')
	begin
	 if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1008'  and cl.MANAGEMENT_COMPANY_ID in (41,91))
	    set @nservid='1008'	
	    else
    if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='2008' and cl.MANAGEMENT_COMPANY_ID in (41,91))--
	   set @nservid='2008'	   
	   else
    if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='îñâë' and cl.MANAGEMENT_COMPANY_ID in (41,91))--
	   set @nservid='îñâë'	
       else
    if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='ýëåê' and  cl.MANAGEMENT_COMPANY_ID in (41,91))
      set @nservid='ýëåê'
      else
    if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='ýëâî' and cl.MANAGEMENT_COMPANY_ID in (41,91))--
	   set @nservid='ýëâî'
	   else
    if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='ýëïë' and  cl.MANAGEMENT_COMPANY_ID in (41,91))--
	   set @nservid='ýëïë'	      


    end
	        
	 
   
   ----------

      if not exists(select 1 from [it_gh].[dbo].OCC_ACCOUNTS oa inner join [it_gh].[dbo].CONSMODES_LIST cl on cl.OCC_ID=oa.OCC_ID and cl.SERVICE_ID=oa.SERVICE_ID where oa.OCC_ID=@occ and oa.SERVICE_ID=@nservid  and cl.MANAGEMENT_COMPANY_ID in (41,91))    
      print '   NOT exists SERV OA LS '+cast(@occ as varchar(15))+' srv '+cast(@nservid as varchar(5))+' sald '+cast(@saldo as varchar(15))
      else
         begin
        --print 'SET SALDO RAZ LS '+cast(@occ as varchar(15))+' srv '+cast(@nservid as varchar(5))+' sald '+cast(@saldo as varchar(15))
    Begin TRY   
    Begin Transaction tran1 
       update  oa
         set oa.saldo=@saldo 
         from [it_gh].[dbo].OCC_ACCOUNTS oa
         where oa.OCC_ID=@occ and oa.SERVICE_ID=@nservid 
         
             update [it_gh].[dbo].occupations --Íåýôôåêòèâíî êîíå÷íî êàæäûé ðàç äåðãàòü
    set saldo=(select SUM(saldo) from OCC_ACCOUNTS where OCC_ID=@occ)
    where id=@occ;

     
   -- exec [it_gh].[dbo].ad_SetTechCorrectWitchDoc @occ,@nservid,45,@saldo      -- 15 - Íîìåð äîê ïîëó÷èòü ïî exec ad_GetDocsList 1
    Commit Transaction tran1
    End Try
     Begin Catch
	  Begin
	  Rollback Transaction tran1
	  print 'ERROR ADDED - LS '+cast(@occ as varchar(15))+' nsrv '+cast(@nservid as varchar(5))+' sald '+cast(@saldo as varchar(15))+ ' srv '+cast(@servid as varchar(5))
	  --print  '===ERROR_NUMBER '+ERROR_NUMBER()+' ERROR_SEVERITY '+ERROR_SEVERITY()+' ERROR_STATE '+ERROR_STATE()+' ERROR_PROCEDURE '+ERROR_PROCEDURE()+'ERROR_LINE'+ERROR_LINE()+' ERROR_MESSAGE '+ERROR_MESSAGE()
	  print ' ===ERROR_MESSAGE '+ERROR_MESSAGE()
      End
     End Catch
      
         end
  
    FETCH NEXT FROM cOcc INTO   @occ,@saldo,@servid
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  	--Ïîñëå âñåãî íàäî ïåðåðàñ÷åò çàïóñòèòü	

-------------------------
-------------------------
--Õîëîäíàÿ âîäà è êàíàëèçàöèÿ

use it_gh
set nocount on
DECLARE	
	@occ int,
	@servid char(4),
	@cntrid int,
	@nservid char(4),
	@saldo numeric(18,2),
	@uk int
	;
DECLARE cOcc CURSOR FOR
select
-- top 20 
ml.occ,sum(oa.SALDO),case oa.service_id when 'ÕÂÃÂ' then 'ÕÂÎÄ' when 'ÕÂÂÊ' then 'ÕÂ  ' when 'ÕÂÏ ' then 'ÈÒÃÂ'
                when 'ÊÈÃÂ' then 'ÊàíÈ' when 'ÊÃÃÂ' then 'ÊàíÃ' when 'ÊÕÃÂ' then 'ÊàíÕ'
                else oa.service_id end
from 
  mr11.dbo.occupations mo
  inner join mr11.dbo.OCC_ACCOUNTS oa on oa.OCC_ID=mo.ID
  inner join [it_gh].[dbo].[LS11] ml on ml.occ11=mo.id 
  inner join [it_gh].dbo.occupations o on o.id=ml.occ
  inner join [it_gh].dbo.FLATS f on f.ID=o.flat_id
  inner join [it_gh].dbo.BUILDINGS b on b.ID=f.BLDN_ID
  inner join [it_gh].dbo.TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 
 and b.TECHSUBDIV_ID in (41,91) 
 and oa.service_id in ('ÈÒÃÂ','ÕÂÏ ','ÊàíÈ  ','ÊÈÃÂ','ÊàíÃ','ÊàíÕ ','ÊÃÃÂ','ÊÕÃÂ  ','ÕÂÂÊ','ÕÂ  ','ÕÂÃÂ','ÕÂÎÄ')
  and oa.saldo<>0
 

group by ml.occ,case oa.service_id when 'ÕÂÃÂ' then 'ÕÂÎÄ' when 'ÕÂÂÊ' then 'ÕÂ  ' when 'ÕÂÏ ' then 'ÈÒÃÂ'
                when 'ÊÈÃÂ' then 'ÊàíÈ' when 'ÊÃÃÂ' then 'ÊàíÃ' when 'ÊÕÃÂ' then 'ÊàíÕ'
                else oa.service_id end
  order by ml.occ
  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@saldo,@servid
		WHILE @@FETCH_STATUS =0
	BEGIN 
	--print 'LS '+cast(@occ as varchar(15))+' srv '+cast(@servid as varchar(5))+' sald '+cast(@saldo as varchar(15))
	set @servid=case @servid 
	when 'ÕÂÎÄ' then 'îäõâ'
	when 'ÕÂ  ' then 'õâîä'
	when 'ÈÒÃÂ' then '1019'
	when 'ÊàíÈ' then '1021'
	when 'ÊàíÃ' then '1013'
	when 'ÊàíÕ' then '1012'
	
	else @servid
	 end
	set @nservid=@servid 

   ----------

      if not exists(select 1 from [it_gh].[dbo].OCC_ACCOUNTS oa inner join [it_gh].[dbo].CONSMODES_LIST cl on cl.OCC_ID=oa.OCC_ID and cl.SERVICE_ID=oa.SERVICE_ID where oa.OCC_ID=@occ and oa.SERVICE_ID=@nservid  and cl.MANAGEMENT_COMPANY_ID in (41,91))    
      print '   NOT exists SERV OA LS '+cast(@occ as varchar(15))+' srv '+cast(@nservid as varchar(5))+' sald '+cast(@saldo as varchar(15))
      else
         begin
        print 'SET SALDO RAZ LS '+cast(@occ as varchar(15))+' srv '+cast(@nservid as varchar(5))+' sald '+cast(@saldo as varchar(15))
    Begin TRY   
    Begin Transaction tran1 
       update  oa
         set oa.saldo=@saldo 
         from [it_gh].[dbo].OCC_ACCOUNTS oa
         where oa.OCC_ID=@occ and oa.SERVICE_ID=@nservid 
         
             update [it_gh].[dbo].occupations --Íåýôôåêòèâíî êîíå÷íî êàæäûé ðàç äåðãàòü
    set saldo=(select SUM(saldo) from OCC_ACCOUNTS where OCC_ID=@occ)
    where id=@occ;

     
   -- exec [it_gh].[dbo].ad_SetTechCorrectWitchDoc @occ,@nservid,45,@saldo      -- 15 - Íîìåð äîê ïîëó÷èòü ïî exec ad_GetDocsList 1
    Commit Transaction tran1
    End Try
     Begin Catch
	  Begin
	  Rollback Transaction tran1
	  print 'ERROR ADDED - LS '+cast(@occ as varchar(15))+' nsrv '+cast(@nservid as varchar(5))+' sald '+cast(@saldo as varchar(15))+ ' srv '+cast(@servid as varchar(5))
	  --print  '===ERROR_NUMBER '+ERROR_NUMBER()+' ERROR_SEVERITY '+ERROR_SEVERITY()+' ERROR_STATE '+ERROR_STATE()+' ERROR_PROCEDURE '+ERROR_PROCEDURE()+'ERROR_LINE'+ERROR_LINE()+' ERROR_MESSAGE '+ERROR_MESSAGE()
	  print ' ===ERROR_MESSAGE '+ERROR_MESSAGE()
      End
     End Catch
      
         end
  
    FETCH NEXT FROM cOcc INTO   @occ,@saldo,@servid
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  	--Ïîñëå âñåãî íàäî ïåðåðàñ÷åò çàïóñòèòü	
-------------------
------------------------
---- ÒÎ
use it_gh
set nocount on
DECLARE	
	@occ int,
	@servid char(4),
	@cntrid int,
	@nservid char(4),
	@saldo numeric(18,2),
	@uk int
	;
DECLARE cOcc CURSOR FOR
select
-- top 20 
ml.occ,sum(oa.SALDO),oa.service_id
from 
  mr11.dbo.occupations mo
  inner join mr11.dbo.OCC_ACCOUNTS oa on oa.OCC_ID=mo.ID
  inner join [it_gh].[dbo].[LS11] ml on ml.occ11=mo.id 
  inner join [it_gh].dbo.occupations o on o.id=ml.occ
  inner join [it_gh].dbo.FLATS f on f.ID=o.flat_id
  inner join [it_gh].dbo.BUILDINGS b on b.ID=f.BLDN_ID
  inner join [it_gh].dbo.TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 
 and b.TECHSUBDIV_ID in (41,91) 
 and oa.service_id in ('ÒÎ  ')
  and oa.saldo<>0
 

group by ml.occ, oa.service_id 
  order by ml.occ
  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@saldo,@servid
		WHILE @@FETCH_STATUS =0
	BEGIN 
	--print 'LS '+cast(@occ as varchar(15))+' srv '+cast(@servid as varchar(5))+' sald '+cast(@saldo as varchar(15))
	set @servid=case @servid 
	when 'ÒÎ  ' then '1000'
		
	else @servid
	 end
	set @nservid=@servid 

   ----------

      if not exists(select 1 from [it_gh].[dbo].OCC_ACCOUNTS oa inner join [it_gh].[dbo].CONSMODES_LIST cl on cl.OCC_ID=oa.OCC_ID and cl.SERVICE_ID=oa.SERVICE_ID where oa.OCC_ID=@occ and oa.SERVICE_ID=@nservid  and cl.MANAGEMENT_COMPANY_ID in (41,91))    
      print '   NOT exists SERV OA LS '+cast(@occ as varchar(15))+' srv '+cast(@nservid as varchar(5))+' sald '+cast(@saldo as varchar(15))
      else
         begin
        print 'SET SALDO RAZ LS '+cast(@occ as varchar(15))+' srv '+cast(@nservid as varchar(5))+' sald '+cast(@saldo as varchar(15))
    Begin TRY   
    Begin Transaction tran1 
       update  oa
         set oa.saldo=@saldo 
         from [it_gh].[dbo].OCC_ACCOUNTS oa
         where oa.OCC_ID=@occ and oa.SERVICE_ID=@nservid 
         
             update [it_gh].[dbo].occupations --Íåýôôåêòèâíî êîíå÷íî êàæäûé ðàç äåðãàòü
    set saldo=(select SUM(saldo) from OCC_ACCOUNTS where OCC_ID=@occ)
    where id=@occ;

     
   -- exec [it_gh].[dbo].ad_SetTechCorrectWitchDoc @occ,@nservid,45,@saldo      -- 15 - Íîìåð äîê ïîëó÷èòü ïî exec ad_GetDocsList 1
    Commit Transaction tran1
    End Try
     Begin Catch
	  Begin
	  Rollback Transaction tran1
	  print 'ERROR ADDED - LS '+cast(@occ as varchar(15))+' nsrv '+cast(@nservid as varchar(5))+' sald '+cast(@saldo as varchar(15))+ ' srv '+cast(@servid as varchar(5))
	  --print  '===ERROR_NUMBER '+ERROR_NUMBER()+' ERROR_SEVERITY '+ERROR_SEVERITY()+' ERROR_STATE '+ERROR_STATE()+' ERROR_PROCEDURE '+ERROR_PROCEDURE()+'ERROR_LINE'+ERROR_LINE()+' ERROR_MESSAGE '+ERROR_MESSAGE()
	  print ' ===ERROR_MESSAGE '+ERROR_MESSAGE()
      End
     End Catch
      
         end
  
    FETCH NEXT FROM cOcc INTO   @occ,@saldo,@servid
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  	--Ïîñëå âñåãî íàäî ïåðåðàñ÷åò çàïóñòèòü	
