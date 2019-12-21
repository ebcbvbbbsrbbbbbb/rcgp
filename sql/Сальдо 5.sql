
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
SELECT --TOP 1000 
    --  s.usl,
      l.occ,
      s.[SALDO],
  --    s.[LS],
      CASE s.usl 
  when 'ХВ на подогрев' then '1014'
  when 'Холодная вода' then 'хвод'
  when 'Канализ. ХВ' then '1012'
  when 'Отопление' then 'отоп'
  when 'Содерж.ремонт' then '1000'
  when 'ХВна подИТП' then '1019'
  when 'КапРемМаш9' then 'капр'
  when 'Подогрев ХВ' then '1004'
  when 'Канализ. ГВ' then '1013'
  when 'Освещ.л/ клет' then '1008'
  when 'Капитал.ремонт' then 'капр'
  when 'Хол.вода на ОДН' then 'одхв'
  when 'Вывоз мусора' then '1015'
  else null 
  end NUSL
  
  FROM [it_gh].[dbo].[saldo5] s
  inner join ls25 l on l.LS8=s.ls
  inner join OCCUPATIONS  o on o.id=l.occ
  inner join FLATS f on f.ID=o.flat_id
 -- inner join BUILDINGS b on b.ID=f.BLDN_ID and b.TECHSUBDIV_ID=25 
  where s.saldo<>0
  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@saldo,@servid
		WHILE @@FETCH_STATUS =0
	BEGIN 
	--print 'LS '+cast(@occ as varchar(15))+' srv '+cast(@servid as varchar(5))+' sald '+cast(@saldo as varchar(15))
	
	set @nservid=@servid 
	
	if @servid in ('1004','1020')
   	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1004' and  cl.MANAGEMENT_COMPANY_ID in (25))
	    set @nservid='1004'
	    else
	   if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1020' and cl.MANAGEMENT_COMPANY_ID in (25))--ИТП
	   set @nservid='1020'
	   
	   
	if @servid in ('1013','1021')
	
  	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1013' and  cl.MANAGEMENT_COMPANY_ID in (25))
	    set @nservid='1013'
	   else
	   if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1021' and cl.MANAGEMENT_COMPANY_ID in (25))--ИТП
	   set @nservid='1021'
	      
	   
	if @servid in ('1014','1019')
  	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1014' and  cl.MANAGEMENT_COMPANY_ID in (25))
	    set @nservid='1014'
	    else
	   if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1019' and cl.MANAGEMENT_COMPANY_ID in (25))--ИТП
	   set @nservid='1019'
	     
	   	   
	   
	if @servid in ('элек','элво','элпл')
	begin
	   if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='элек' and  cl.MANAGEMENT_COMPANY_ID in (25))
	    set @nservid='элек'
	   else 
	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='элво' and cl.MANAGEMENT_COMPANY_ID in (25))--
	   set @nservid='элво'
	   else
	    if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='элпл' and  cl.MANAGEMENT_COMPANY_ID in (25))--
	   set @nservid='элпл'
	   else 	
	   if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1008'  and cl.MANAGEMENT_COMPANY_ID in (25))
	    set @nservid='1008'	
	    else
    if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='2008' and cl.MANAGEMENT_COMPANY_ID in (25))--
	   set @nservid='2008'	   
	   else
    if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='освл' and cl.MANAGEMENT_COMPANY_ID in (25))--
	   set @nservid='освл'	
	end   
	--   else
	  --  if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1029' and  cl.MANAGEMENT_COMPANY_ID in (25))--D1
	  -- set @nservid='1029'
	      
	   
	if @servid='1000'
	  if not exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1000'  and cl.MANAGEMENT_COMPANY_ID in (25))
	  begin
	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1022' and cl.MANAGEMENT_COMPANY_ID in (25))--D1
	   set @nservid='1022'	   
	   end  
	   
	if @servid='хвод'
	  if not exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='хвод'  and cl.MANAGEMENT_COMPANY_ID in (25))
	  begin
	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1024' and cl.MANAGEMENT_COMPANY_ID in (25))--D1
	   set @nservid='1024'	   
	   end  

	if @servid='1012'
	  if not exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1012'  and cl.MANAGEMENT_COMPANY_ID in (25))
	  begin
	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1034' and cl.MANAGEMENT_COMPANY_ID in (25))--D1
	   set @nservid='1034'	   
	   end  

	if @servid='отоп'
	  if not exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='отоп'  and cl.MANAGEMENT_COMPANY_ID in (25))
	  begin
	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1023' and cl.MANAGEMENT_COMPANY_ID in (25))--D1
	   set @nservid='1023'	   
	   end  
	   
	if @servid='1014'
	  if not exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1014'  and cl.MANAGEMENT_COMPANY_ID in (25))
	  begin
	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1036' and cl.MANAGEMENT_COMPANY_ID in (25))--D1
	   set @nservid='1036'	   
	   end  


	   
	if @servid='1015'
	   if not exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1015'  and cl.MANAGEMENT_COMPANY_ID in (25))
	   begin
	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='вывм' and cl.MANAGEMENT_COMPANY_ID in (25))--
	   set @nservid='вывм'	 
	  else 	    
	   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1037' and cl.MANAGEMENT_COMPANY_ID in (25))--D1
	   set @nservid='1037'	   
	   end  
	   
	--if @servid='1006'
	 --  if not exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1006'  and cl.MANAGEMENT_COMPANY_ID in (25))
	 --  begin
	 --  if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1028' and cl.MANAGEMENT_COMPANY_ID in (25))--D1
	 --  set @nservid='1028'	   
	 --  end 	   
	   
	   	   
	if @servid='капр'
	if not exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='капр'  and cl.MANAGEMENT_COMPANY_ID in (25))
	begin
	if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1033' and cl.MANAGEMENT_COMPANY_ID in (25))--D1
	set @nservid='1033'	   
	end 	   
	   
	if @servid in ('1008','2008','освл')
	begin
	 if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1008'  and cl.MANAGEMENT_COMPANY_ID in (25))
	    set @nservid='1008'	
	    else
    if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='2008' and cl.MANAGEMENT_COMPANY_ID in (25))--
	   set @nservid='2008'	   
	   else
    if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='освл' and cl.MANAGEMENT_COMPANY_ID in (25))--
	   set @nservid='освл'	
       else
    if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='элек' and  cl.MANAGEMENT_COMPANY_ID in (25))
      set @nservid='элек'
      else
    if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='элво' and cl.MANAGEMENT_COMPANY_ID in (25))--
	   set @nservid='элво'
	   else
    if exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='элпл' and  cl.MANAGEMENT_COMPANY_ID in (25))--
	   set @nservid='элпл'	      
	if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1030' and cl.MANAGEMENT_COMPANY_ID in (25))--D1
	 set @nservid='1030'	   
    end
	        
	 
	--if @servid='1016'
	--   if not exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1016'  and cl.MANAGEMENT_COMPANY_ID in (25))
	--   begin
	--   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1038' and cl.MANAGEMENT_COMPANY_ID in (25))--D1
	--   set @nservid='1038'	   
	--   end 	  
	   
	--if @servid='1017'
	--   if not exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1017'  and cl.MANAGEMENT_COMPANY_ID in (25))
	--   begin
	--   if  exists(select 1 from [it_gh].[dbo].CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1039' and cl.MANAGEMENT_COMPANY_ID in (25))--D1
	--   set @nservid='1039'	   
	--   end 		   
	   
   ----------
      if not exists(select 1 from [it_gh].[dbo].OCC_ACCOUNTS oa inner join [it_gh].[dbo].CONSMODES_LIST cl on cl.OCC_ID=oa.OCC_ID and cl.SERVICE_ID=oa.SERVICE_ID where oa.OCC_ID=@occ and oa.SERVICE_ID=@nservid  and cl.MANAGEMENT_COMPANY_ID in (25))    
      print 'NOT exists SERV OA LS '+cast(@occ as varchar(15))+' srv '+cast(@nservid as varchar(5))+' sald '+cast(@saldo as varchar(15))
        else
         begin
        
        --print 'SET SALDO RAZ LS '+cast(@occ as varchar(15))+' srv '+cast(@nservid as varchar(5))+' sald '+cast(@saldo as varchar(15))
  Begin TRY   
    Begin Transaction tran1
         update OCC_ACCOUNTS
      set SALDO=@saldo
      where OCC_ID=@occ and SERVICE_ID=@nservid;
    
    update occupations --Неэффективно конечно каждый раз дергать
    set saldo=(select SUM(saldo) from OCC_ACCOUNTS where OCC_ID=@occ)
    where id=@occ;
   
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
DEALLOCATE cOcc  	--После всего надо перерасчет запустить	