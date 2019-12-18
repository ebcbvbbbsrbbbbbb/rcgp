/****** �������� ��� ������� SelectTopNRows ����� SSMS  ******/
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
9	2	�� ����  � ��������. 0,0674     
10	2	����. ��� ��������. 0,0574      
11	2	�� ���� ��� ��������.     0,0624
12	2	����� ��� 999999.99999          
13	2	����� ��� 999999.999            
14	2	���� � ��������. 0,0624         
15	2	��� ���� � ��������. 0,0599     
16	2	��� ���� ��� ��������. 0,0549   
17	2	��� �� ���� ��� ��������. 0,0599
18	2	��� �� ���� � ��������. 0,0649   
*/
/*
17001	�������� 2.1 ��� �� ����. � ������������.
17000	���                             
17007	�������� 2.8 ��� �� ����. � ������������.
17025	�������� 2.1 ��� �� ����. ��� ������������.
17018	�� � ����, ���, 2.1  �� ����. � ������������.
17004	�������� 2.5 ��� �� ����. � ������������.
17006	�������� 2.7 ��� �� ����. � ������������.
17010	��������  2.1 ��� ��� ����. � ������������.
17024	�������� 2.1 ��� ����. � ������������.
17013	��������  2.8 ��� ��� �� ����. � ������������.
17031	�� � ����, ���, 2.1  �� ����. ��� ������������.
17028	��������  2.1 ��� ��� ����. ��� ������������.
17019	��������� �. 32 (2.8) ������� �8 �� ����. ��� ������������.
17029	��������  2.1 ��� ��� �� ����. � ������������.
17003	�������� 2.4 ��� �� ����. � ������������.
17012	��������  2.5 ��� ��� �� ����. � ������������.
17032	�� � ����, ��� 2.5  �� ����. ��� ������������. ,���. ���.
17030	��������  2.1 ��� ��� �� ����. ��� ������������.
17022	�������� 2.2 ��� �� ����. � ������������.
17002	�������� 2.3 ��� �� ����. � ������������.
17026	�������� 2.3 ��� �� ����. ��� ������������.
28001	��� �������� 2.1 ��� �� ����. � ������������.
28000	���                             
28004	��� �������� 2.5 ��� �� ����. � ������������.
28007	��� �������� 2.8 ��� �� ����. � ������������.
28003	��� �������� 2.4 ��� �� ����. � ������������.
28021	��� �������� 2.1 ��� ����. � ������������. */

set @newmodelid=0;
set @newmodelid=
case @cmode 
when 17001 then 9	--�������� 2.1 ��� �� ����. � ������������.
--when 17000 then 9                            
when 17007	then 9--�������� 2.8 ��� �� ����. � ������������.
when 17025	then 11 --�������� 2.1 ��� �� ����. ��� ������������.
when 17018	then 9--�� � ����, ���, 2.1  �� ����. � ������������.
when 17004	then 9--�������� 2.5 ��� �� ����. � ������������.
when 17006	then 9--�������� 2.7 ��� �� ����. � ������������.
when 17010	then 14--��������  2.1 ��� ��� ����. � ������������.
when 17024	then 14--�������� 2.1 ��� ����. � ������������.
when 17013	then 9--��������  2.8 ��� ��� �� ����. � ������������.
when 17031	then 11--�� � ����, ���, 2.1  �� ����. ��� ������������.
when 17028	then 10--��������  2.1 ��� ��� ����. ��� ������������.
when 17019	then 11--��������� �. 32 (2.8) ������� �8 �� ����. ��� ������������.
when 17029	then 9--��������  2.1 ��� ��� �� ����. � ������������.
when 17003	then 9--�������� 2.4 ��� �� ����. � ������������.
when 17012	then 9--��������  2.5 ��� ��� �� ����. � ������������.
when 17032	then 11--�� � ����, ��� 2.5  �� ����. ��� ������������. ,���. ���.
when 17030	then 11--��������  2.1 ��� ��� �� ����. ��� ������������.
when 17022	then 9--�������� 2.2 ��� �� ����. � ������������.
when 17002	then 9--�������� 2.3 ��� �� ����. � ������������.
when 17026	then 11--�������� 2.3 ��� �� ����. ��� ������������.
when 28001	then 9--��� �������� 2.1 ��� �� ����. � ������������.
--when 28000	���                             
when 28004	then 18--��� �������� 2.5 ��� �� ����. � ������������.
when 28007	then 18--��� �������� 2.8 ��� �� ����. � ������������.
when 28003	then 18--��� �������� 2.4 ��� �� ����. � ������������.
when 28021	then 15--��� �������� 2.1 ��� ����. � ������������.
end

 if @newmodelid>0 
   exec [it_gh].dbo.NewCNTRChangeModel @cntrid,@newmodelid ---10
   
  
   
    FETCH NEXT FROM cOcc INTO   @occ,@servid,@cntrid,@modelid,@scale,@cmode
    END  
		
CLOSE cOcc
DEALLOCATE cOcc  		
