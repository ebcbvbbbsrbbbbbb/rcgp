/****** Сценарий для команды SelectTopNRows среды SSMS  ******/
 /*SELECT TOP 1000 *
  FROM [it_gh].[dbo].consmodes_list f
  where f.OCC_ID=36002701 and f.service_id='1020'*/
  
 use it_gh

DECLARE	
	@occ int,
	@unitsumma numeric(18,4),
	@servid char(4),
	@totalunitsum numeric(18,4),
	@corrsumma numeric(18,2),
	@sumper numeric(18,2),
	@tosumper numeric(18,2);
	
set @corrsumma=84095.4 ---306253.77;

create table #occper(occ_id int,cntsum numeric(18,4),sumper numeric(18,2))	;

set @servid='1020';


 
 insert into #occper(occ_id,cntsum)
 SELECT cml.OCC_ID, sum(cml.[cntr_units])   
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
  where  f.BLDN_ID=6211026
  and fi.ID >=24 and fi.id<=42
 and cml.SERVICE_ID =@servid
 and cl.mode_id=28013 --kv 28013=101-200 28014=201-300
 group by cml.OCC_ID;
 
 set @totalunitsum=(SELECT  sum(cntsum)  FROM #occper );

print @totalunitsum
--select @totalunitsum;
/*select * from #occper;
drop table #occper;
return ;*/

 update #occper
 set sumper=(cntsum/@totalunitsum)*@corrsumma; 
 
set @tosumper=(select SUM(sumper) from #occper)

if @tosumper<>@corrsumma
   begin
   update #occper
   set sumper=sumper+(@corrsumma-@tosumper)
   where occ_id=(select top 1 occ_id from #occper order by sumper desc)
   end

	
DECLARE cOcc CURSOR FOR
select occ_id,cntsum,sumper from #occper
where sumper<>0

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@unitsumma,@sumper
	WHILE @@FETCH_STATUS =0
		BEGIN 
		
		print 'occ= '+cast(@occ as varchar(10))+' cntsum= '+cast(@unitsumma as varchar(18))+' sumper= '+cast(@sumper as varchar(18));
       -- exec ad_SetTechCorrectWitchDoc @occ,@servid,44,@sumper      -- 15 - Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@unitsumma,@sumper
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc   
drop table #occper;