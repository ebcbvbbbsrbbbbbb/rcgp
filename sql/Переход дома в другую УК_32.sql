
--------��-----
---���������� ����� �� �� ������������ ������ �� ���������

update cl 
 set MANAGEMENT_COMPANY_ID=117
 --
 --select *
  from [CONSMODES_LIST]cl
  inner join occupations o on o.id=cl.OCC_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  --left join STREETS s on s.ID=b.STREET_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  ---inner join umr_sup u  on u.sdivid=t.ID
  where coalesce(cl.MANAGEMENT_COMPANY_ID,0)=32
  and cl.mode_id %1000 <>0
  and b.TECHSUBDIV_ID=117
  and t.IS_HISTORY=1
  and cl.SERVICE_ID in('1004','1012','1013','1014','1019','1020','1021','����')
  and cl.CNTR_BIT=0

-----------------------
/*
������
*/
use it_gh
DECLARE	
	@occ int,
	@bldn int
	
DECLARE cOcc CURSOR FOR
select o.id,b.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 --and b. id in (   )
  and b.TECHSUBDIV_ID in (117 )

  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@bldn

	WHILE @@FETCH_STATUS =0
		BEGIN   ---������ ������ �-� ��������� ������ �� ���� 1
-----��------------------------------------------------		
	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='9999'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1022'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1022'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1000'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1000'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'	
		

		
----------------------------------------------------------

-------����� ������---------------------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1037'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1037'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1015'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1015'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
	--	
		
--------------------------------------------------------------------

--------------����------------------------------------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1040'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1040'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
		--	
		
---------------------------------------------------------	

-----------���������------------------------------------
if (not @bldn in (1300009,4250049,4900030))
   begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1033'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1033'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
	end

-------------------------------------------------------------

-----------��� ���������------------------------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='�1��'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='�1��'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
	

-------------------------------------------------------------
	
--------------��� ����---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='����'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1024'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1024'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------	    	   


--------------����� ��� ����---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1012'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1034'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1034'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1012'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1012'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------	

--------------�����---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1023'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1023'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
            
---------------------------------------------

---------------------------------------------

--------------��������---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1004'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1026'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1026'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1004'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1004'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------
----
            
---------------------------------------------

--------------�� ��� ���������---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1014'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1036'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1036'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1014'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1014'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------
---
---------------------------------------------

--------------����� ��---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1013'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1035'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1035'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1013'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1013'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------

--------------��� ����� ��---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1021'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1043'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1043'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1021'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1021'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 end           
---------------------------------------------

--------------��� ��������---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1020'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1042'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1042'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1020'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1020'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------

--------------��� �� ���---------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1019'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1041'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1041'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1019'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1019'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------

--------------��� ��� �� ���---------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='�1��'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='�1��'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 ----    
--------------��� ��� ���---------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='�1��'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='�1��'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 ---- 

  --------------��� ���---------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='�1��'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='�1��'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 ----     
  --------------��� ���---------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='�1��'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='�1��'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 ----     

   --------------��� ��---------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='�1��'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='�1��'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 ----        

    --------------��� ��---------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='�1��'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='�1��'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 ----        
---------------------------------------------
---------------------------------------------
	    	   
	   FETCH NEXT FROM cOcc INTO  @occ,@bldn
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  

-----------------
------------------
---------------


-----����-------------

 use it_gh
  update op
  set op.SERVICE_ID=
  case op.SERVICE_ID
  when '1000' then '1022'
  when '1015' then '1037'
  when '����' then '1023'
  when '1004' then '1026'
  when '1014' then '1036'
  when '����' then '1040'
  else 
  op.SERVICE_ID
  end
 --select   op.*
  from [OCC_PENYA_HISTORY] op
  inner join occupations o on o.ID=op.OCC_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 --and b. id in (   )
  and b.TECHSUBDIV_ID in (117 )
  and NOT exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=o.ID and cl.SERVICE_ID=op.SERVICE_ID and cl.MANAGEMENT_COMPANY_ID=32 )
  and op.FINTERM_ID=70
 -- and o.ID=32004389



--------�������-----------

use it_gh
DECLARE	
	@occ int,
	@bldn int;
DECLARE cOcc CURSOR FOR
select o.id,b.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and b.TECHSUBDIV_ID=117

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@bldn

	WHILE @@FETCH_STATUS =0
		BEGIN   ---������ ������ �-� ����4 �� ����1


/*
-------------------
-------------------
--------------------
----------------------
-----------------------
*/

------


----------���������---------
if (not @bldn in (1300009,4250049,4900030))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1033'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='����'
and VALUE<>0
end
--------����-----------
update [MONTHS_PAID]
set 
SERVICE_ID='1040'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='����'
and VALUE<>0

------------�����----------
update [MONTHS_PAID]
set 
SERVICE_ID='1037'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1015'
and VALUE<>0

----��---------------
update [MONTHS_PAID]
set 
SERVICE_ID='1022'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1000'
and VALUE<>0

-------------��� ����--------------------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='����'and cl.MANAGEMENT_COMPANY_ID=32))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1024'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='����'
and VALUE<>0
end
-------------����� ��� ���--------------------------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1012'and cl.MANAGEMENT_COMPANY_ID=32))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1034'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1012'
and VALUE<>0
end
----------�����----------------
update [MONTHS_PAID]
set 
SERVICE_ID='1023'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='����'
and VALUE<>0


----------��������----------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1004'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1026'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1004'
and VALUE<>0
end
----------���------------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1014'and cl.MANAGEMENT_COMPANY_ID=32))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1036'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1014'
and VALUE<>0
end
----------����� ��-----------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1013'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1035'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1013'
and VALUE<>0
end


----��� �����--------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1021'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1043'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1021'
and VALUE<>0
end
----��� ��������--------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1020'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1042'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1020'
and VALUE<>0
end
----��� ���--------
if (not exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1019'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1041'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1019'
and VALUE<>0
end

----------��� ���������---------

update [MONTHS_PAID]
set 
SERVICE_ID='�1��'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='����'
and VALUE<>0

-------------
update pl
set PAID=isnull((select SUM(mp.VALUE) from MONTHS_PAID mp where mp.OCC_ID=pl.OCC_ID and mp.SERVICE_ID=pl.TYPE_ID),0)
from PAYM_LIST pl
where OCC_ID=@occ
--------------
-------------------	    	   
	   FETCH NEXT FROM cOcc INTO  @occ,@bldn
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  



----------------------
--������� ������ �� ��������� ����� �����

use it_gh
DECLARE	
	@occ int,
	@bldn int
	
DECLARE cOcc CURSOR FOR
select o.id,b.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 --and b. id in (   )
  and b.TECHSUBDIV_ID in (117 )

  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@bldn

	WHILE @@FETCH_STATUS =0
		BEGIN   ---������ ������ �-� ��������� ������ �� ���� 1

	
--------------��� ����---------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='����'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1024'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1024'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------	    	   


--------------����� ��� ����---------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1012'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1034'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1034'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1012'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1012'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------	


---------------------------------------------

--------------��������---------------------
if (exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1004'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1026'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1026'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1004'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1004'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------
----
            
---------------------------------------------

--------------�� ��� ���������---------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1014'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1036'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1036'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1014'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1014'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------
---
---------------------------------------------

--------------����� ��---------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1013'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1035'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1035'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1013'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1013'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------

--------------��� ����� ��---------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1021'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1043'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1043'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1021'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1021'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
 end           
---------------------------------------------

--------------��� ��������---------------------
if (exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1020'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1042'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1042'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1020'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1020'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------

--------------��� �� ���---------------------
if (exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1019'and cl.MANAGEMENT_COMPANY_ID=32))
begin
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1041'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1041'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1019'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1019'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
end            
---------------------------------------------
---�������� ���

	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='9999'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='�1��'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='�1��'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'	
		
---��� ���

	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='9999'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='�1��'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='�1��'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'	
		
---�������� ���� ���

	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='9999'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='�1��'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='�1��'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='����'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'	
		
---------------------------------------------

-----------���������------------------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1030'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1030'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1008'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1008'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
      ---
       

	    	   
	   FETCH NEXT FROM cOcc INTO  @occ,@bldn
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  


---------------
--������� �� �������� �� ��������� �����


use it_gh
DECLARE	
	@occ int,
	@bldn int;
DECLARE cOcc CURSOR FOR
select o.id,b.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and b.TECHSUBDIV_ID=117

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@bldn

	WHILE @@FETCH_STATUS =0
		BEGIN   ---������ ������ �-� ����4 �� ����1


/*
-------------------
-------------------
--------------------
----------------------
-----------------------
*/

------


-------------��� ����--------------------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='����'and cl.MANAGEMENT_COMPANY_ID=32))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1024'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='����'
and VALUE<>0
end
-------------����� ��� ���--------------------------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1012'and cl.MANAGEMENT_COMPANY_ID=32))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1034'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1012'
and VALUE<>0
end


----------��������----------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1004'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1026'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1004'
and VALUE<>0
end
----------���------------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1014'and cl.MANAGEMENT_COMPANY_ID=32))
begin
update [MONTHS_PAID]
set 
SERVICE_ID='1036'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1014'
and VALUE<>0
end
----------����� ��-----------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1013'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1035'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1013'
and VALUE<>0
end


----��� �����--------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1021'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1043'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1021'
and VALUE<>0
end
----��� ��������--------
if ( exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1020'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1042'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1020'
and VALUE<>0
end
----��� ���--------
if (exists(select 1 from CONSMODES_LIST cl where cl.OCC_ID=@occ and cl.SERVICE_ID='1019'and cl.MANAGEMENT_COMPANY_ID=32))
begin

update [MONTHS_PAID]
set 
SERVICE_ID='1041'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1019'
and VALUE<>0
end

----------����---------

update [MONTHS_PAID]
set 
SERVICE_ID='1030'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='1008'
and VALUE<>0

-------------

----------�� ���---------

update [MONTHS_PAID]
set 
SERVICE_ID='�1��'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='����'
and VALUE<>0
-------------

----------������� ���---------

update [MONTHS_PAID]
set 
SERVICE_ID='�1��'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='����'
and VALUE<>0
-------------

----------������� ���---------

update [MONTHS_PAID]
set 
SERVICE_ID='�1��'
FROM [it_gh].[dbo].[MONTHS_PAID] mp
  inner join occupations o on o.id=mp.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where o.id=@occ
and SERVICE_ID='����'
and VALUE<>0
-------------

update pl
set PAID=isnull((select SUM(mp.VALUE) from MONTHS_PAID mp where mp.OCC_ID=pl.OCC_ID and mp.SERVICE_ID=pl.TYPE_ID),0)
from PAYM_LIST pl
where OCC_ID=@occ
--------------
-------------------	    	   
	   FETCH NEXT FROM cOcc INTO  @occ,@bldn
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  


--------��������� ����������

 use it_gh
  update cl
  set cl.source_id=
  case cl.SERVICE_ID
  when '����' then '4021'
  when '1012' then '21017'
  when '1013' then '22013'
  when '1019' then '27011'
  when '1021' then '29008'
  when '1008' then '19059'
  when '����' then '141013'
  else 
  cl.source_id
  end
 --select   op.*
  from consmodes_list cl
  inner join occupations o on o.ID=cl.OCC_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 --and b. id in (   )
  and b.TECHSUBDIV_ID in (117 )
  and cl.SERVICE_ID in ('����','1012','1013','1019','1021','1008','����')


