/****** Сценарий для команды SelectTopNRows среды SSMS  ******/
use it_gh
SELECT TOP 1000 ci.CNTR_MODELS_ID,cl.*
  FROM [it_gh].[dbo].[COUNTER_LIST] cl
  inner join COUNTERS_INFO ci on ci.COUNTER_ID=cl.COUNTER_ID
  where cl.SERVICE_ID='1020'

use it_gh
DECLARE	
	@occ int,
	@servid char(4),
	@nservid char(4),
	@cntrid int,
	@modelid int,
	@newmodelid int,
	@scale decimal(16,6),
	@cmode int
	;
DECLARE cOcc CURSOR FOR
select --top 10 
o.id,cl.service_id,cl.[COUNTER_ID],ci.[CNTR_MODELS_ID],c.scale,cml.mode_id
from [it_gh].dbo.counter_list cl 
  inner join counters c on c.[COUNTER_ID]=cl.[COUNTER_ID] --and c.[MASTER_ID]=0
  inner join occupations o on o.id=cl.occ_id
  inner join consmodes_list cml on cml.occ_id=o.id and cml.service_id=cl.service_id
  inner join [COUNTERS_INFO] ci on ci.[COUNTER_ID]=c.[COUNTER_ID]
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and cl.[CNTR_TYPE_ID] in (1,2) and 
   cl.service_id in('1004','1020')
 -- and c.SCALE=1
  order by o.id,cl.service_id
  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid,@cntrid,@modelid,@scale,@cmode
		WHILE @@FETCH_STATUS =0
	BEGIN  
  
/*  
ID	CNTR_GROUPS_ID	NAME
9	2	НЕ Изол  С Полотенц. 0,0674     
10	2	Изол. без Полотенц. 0,0574      
11	2	НЕ Изол Без Полотенц.     0,0624
12	2	Общий тип 999999.99999          
13	2	Общий тип 999999.999            
14	2	Изол С Полотенц. 0,0624         
15	2	ИТП Изол С Полотенц. 0,0599     
16	2	ИТП Изол БЕЗ Полотенц. 0,0549   
17	2	ИТП НЕ Изол Без Полотенц. 0,0599
18	2	ИТП НЕ Изол С Полотенц. 0,0649   
*/
/*
17001	Подогрев 2.1 ПТС Не Изол. с Полотенцесуш.
17000	Нет                             
17007	Подогрев 2.8 ПТС Не Изол. с Полотенцесуш.
17025	Подогрев 2.1 ПТС Не Изол. БЕЗ Полотенцесуш.
17018	ЖД с вдпр, кан, 2.1  Не Изол. с Полотенцесуш.
17004	Подогрев 2.5 ПТС Не Изол. с Полотенцесуш.
17006	Подогрев 2.7 ПТС Не Изол. с Полотенцесуш.
17010	Подогрев  2.1 СОВ ПТС Изол. с Полотенцесуш.
17024	Подогрев 2.1 ПТС Изол. с Полотенцесуш.
17013	Подогрев  2.8 СОВ ПТС Не Изол. с Полотенцесуш.
17031	ЖД с вдпр, кан, 2.1  Не Изол. БЕЗ Полотенцесуш.
17028	Подогрев  2.1 СОВ ПТС Изол. БЕЗ Полотенцесуш.
17019	Зональное ш. 32 (2.8) станция №8 Не Изол. БЕЗ Полотенцесуш.
17029	Подогрев  2.1 СОВ ПТС Не Изол. с Полотенцесуш.
17003	Подогрев 2.4 ПТС Не Изол. с Полотенцесуш.
17012	Подогрев  2.5 СОВ ПТС Не Изол. с Полотенцесуш.
17032	ЖД с вдпр, кан 2.5  Не Изол. БЕЗ Полотенцесуш. ,общ. душ.
17030	Подогрев  2.1 СОВ ПТС Не Изол. БЕЗ Полотенцесуш.
17022	Подогрев 2.2 ПТС Не Изол. с Полотенцесуш.
17002	Подогрев 2.3 ПТС Не Изол. с Полотенцесуш.
17026	Подогрев 2.3 ПТС Не Изол. БЕЗ Полотенцесуш.
28001	ИТП Подогрев 2.1 ПТС Не Изол. с Полотенцесуш.
28000	Нет                             
28004	ИТП Подогрев 2.5 ПТС Не Изол. с Полотенцесуш.
28007	ИТП Подогрев 2.8 ПТС Не Изол. с Полотенцесуш.
28003	ИТП Подогрев 2.4 ПТС Не Изол. с Полотенцесуш.
28021	ИТП Подогрев 2.1 ПТС Изол. с Полотенцесуш. */

set @newmodelid=0;
set @newmodelid=
case @cmode 
when 17001 then 9	--Подогрев 2.1 ПТС Не Изол. с Полотенцесуш.
--when 17000 then 9                            
when 17007	then 9--Подогрев 2.8 ПТС Не Изол. с Полотенцесуш.
when 17025	then 11 --Подогрев 2.1 ПТС Не Изол. БЕЗ Полотенцесуш.
when 17018	then 9--ЖД с вдпр, кан, 2.1  Не Изол. с Полотенцесуш.
when 17004	then 9--Подогрев 2.5 ПТС Не Изол. с Полотенцесуш.
when 17006	then 9--Подогрев 2.7 ПТС Не Изол. с Полотенцесуш.
when 17010	then 14--Подогрев  2.1 СОВ ПТС Изол. с Полотенцесуш.
when 17024	then 14--Подогрев 2.1 ПТС Изол. с Полотенцесуш.
when 17013	then 9--Подогрев  2.8 СОВ ПТС Не Изол. с Полотенцесуш.
when 17031	then 11--ЖД с вдпр, кан, 2.1  Не Изол. БЕЗ Полотенцесуш.
when 17028	then 10--Подогрев  2.1 СОВ ПТС Изол. БЕЗ Полотенцесуш.
when 17019	then 11--Зональное ш. 32 (2.8) станция №8 Не Изол. БЕЗ Полотенцесуш.
when 17029	then 9--Подогрев  2.1 СОВ ПТС Не Изол. с Полотенцесуш.
when 17003	then 9--Подогрев 2.4 ПТС Не Изол. с Полотенцесуш.
when 17012	then 9--Подогрев  2.5 СОВ ПТС Не Изол. с Полотенцесуш.
when 17032	then 11--ЖД с вдпр, кан 2.5  Не Изол. БЕЗ Полотенцесуш. ,общ. душ.
when 17030	then 11--Подогрев  2.1 СОВ ПТС Не Изол. БЕЗ Полотенцесуш.
when 17022	then 9--Подогрев 2.2 ПТС Не Изол. с Полотенцесуш.
when 17002	then 9--Подогрев 2.3 ПТС Не Изол. с Полотенцесуш.
when 17026	then 11--Подогрев 2.3 ПТС Не Изол. БЕЗ Полотенцесуш.
when 28001	then 9--ИТП Подогрев 2.1 ПТС Не Изол. с Полотенцесуш.
--when 28000	Нет                             
when 28004	then 18--ИТП Подогрев 2.5 ПТС Не Изол. с Полотенцесуш.
when 28007	then 18--ИТП Подогрев 2.8 ПТС Не Изол. с Полотенцесуш.
when 28003	then 18--ИТП Подогрев 2.4 ПТС Не Изол. с Полотенцесуш.
when 28021	then 15--ИТП Подогрев 2.1 ПТС Изол. с Полотенцесуш.
end

 if @newmodelid>0 
   exec [it_gh].dbo.NewCNTRChangeModel @cntrid,@newmodelid ---10
   
  
   
    FETCH NEXT FROM cOcc INTO   @occ,@servid,@cntrid,@modelid,@scale,@cmode
    END  
		
CLOSE cOcc
DEALLOCATE cOcc  		
