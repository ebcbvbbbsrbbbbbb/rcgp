/*
�������� � ����� ������ ����������� �������
*/
use it_gh
DECLARE	
	@occ int;
DECLARE cOcc CURSOR FOR
select o.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and b. id in (   )
  and b.TECHSUBDIV_ID in (  )

  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

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

--------------����---------------------
/*		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1032'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1032'
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
*/            
---------------------------------------------
-------------------������ �����------------------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1028'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1028'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1006'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1006'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
              --	
		
---------------------------------------    

--------------������ ����---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1031'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1031'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1009'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1009'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
     ---
        
---------------------------------------------

-----------���������------------------------------
/*  
--- ����� ����� ����� ��������� ��������
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
       
*/


------------------------------------

--------------������---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1027'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1027'
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

--------------���---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1025'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1025'
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

--------------������������---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1029'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1029'
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
	
--------------��� ����---------------------
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
            
---------------------------------------------	    	   


--------------����� ��� ����---------------------
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
------------------
--------------���� �����---------------------
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
            
---------------------------------------------

--------------��������---------------------
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
            
---------------------------------------------
----
--------------���� ��������---------------------
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
            
---------------------------------------------

--------------�� ��� ���������---------------------
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
            
---------------------------------------------
---
--------------���� �� ��� ���������---------------------
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
            
---------------------------------------------

--------------����� ��---------------------
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
            
---------------------------------------------

--------------��� ����� ��---------------------
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
            
---------------------------------------------

--------------��� ��������---------------------
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
            
---------------------------------------------

--------------��� �� ���---------------------
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
            
---------------------------------------------

--------------�� ��� ���---------------------
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
            
---------------------------------------------

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
            
---------------------------------------------

--------------�� ���---------------------
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
            
---------------------------------------------
	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  


----------------
----------------
-------------

���� 2

/*
�������� � ����� ������ ����������� �������
*/
use it_gh
DECLARE	
	@occ int;
DECLARE cOcc CURSOR FOR
select o.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and (
  (b.STREET_ID=388 and b.BLDN_NO='19�')) 

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN   ---������ ������ �-� ����4 �� ����2
-----��------------------------------------------------		
	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='1088'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1044'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1044'
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
		and oa.SERVICE_ID='1088'	
		

		
----------------------------------------------------------

-------����� ������---------------------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1103'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1059'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1059'
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
		and oa.SERVICE_ID='1103'
	--	
		
--------------------------------------------------------------------

-----------���������------------------------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1099'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1055'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1055'
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
		and oa.SERVICE_ID='1099'
	


-----------���������------------------------------
  
--- ����� ����� ����� ��������� ��������
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1096'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1052'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1052'
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
		and oa.SERVICE_ID='1096'
      ---
       



------------------------------------



	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  

-------����� ��������� ������ � [OCC_PENYA_HISTORY] ���� � ������ [FINTERM_ID]=��������

--select id from fin_terms where closed = 0  -- ������� ������

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

-----------------------
----------------------
-------------------
--������ �������������  � �1 �� ��������

/*
�������� � ����� ������ ����������� �������
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
  (b.STREET_ID=370 and b.BLDN_NO='32')  
  )

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN   ---������ ������ �-� ����4 �� ����1

---------------------------------------------------------	

-----------�����------------------------------------------		
set @saldo=0

	    select @saldo=saldo 	    
	    from
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1037'

if @saldo is null set @saldo=0

       update OCC_ACCOUNTS
		set 
		saldo=saldo+@saldo
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1015'

		update OCC_ACCOUNTS
		set 
		saldo=0
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1037'
		
		

		
----------------------------------------------------------

	
	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  


----------------
----------------
-------------




----------------------------

/*
�������� � ����� ������ ����������� �������
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
  (b.STREET_ID=239 and b.BLDN_NO='18�')or
  (b.STREET_ID=239 and b.BLDN_NO in ('29/23'))or
  (b.STREET_ID=255 and b.BLDN_NO='28')or
  (b.STREET_ID=255 and b.BLDN_NO='30')  
  )

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN   

        
---------------------------------------------
           
-----��������� �� ���� 1 ������������� �� ������. �� �����

--------------������������---------------------
set @saldo=0

	    select @saldo=saldo 	    
	    from
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='����'

if @saldo is null set @saldo=0

if @saldo<>0 
 begin
print '--'+cast(@OCC as varchar(12))+'=='+cast(@saldo as varchar(12))

       update OCC_ACCOUNTS
		set 
		saldo=saldo+@saldo
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1029'

		update OCC_ACCOUNTS
		set 
		saldo=0
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='����';
		
 end		
-------------------------------
	
---------------------------------------------
	
	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  


--------------------------
----------------------------
---=========================================================

--- ���� 3 ----------------------

-----------------------------------------------------------------
-----------------------------------------------------------------
	  -----��------------------------------------------------		
	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='1088'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1066'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1066'
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
		and oa.SERVICE_ID='1088'	
		

		
----------------------------------------------------------

-------����� ������---------------------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1103'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1081'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1081'
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
		and oa.SERVICE_ID='1103'
	--	
		
--------------------------------------------------------------------
-----------���������------------------------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1099'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1077'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1077'
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
		and oa.SERVICE_ID='1099'
	

-------------------------------------------------------------
--------------����---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1098'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1076'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1076'
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
		and oa.SERVICE_ID='1098'
            
---------------------------------------------

	  
	-----------���������------------------------------

--- ����� ����� ����� ��������� ��������
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1096'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1074'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1074'
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
		and oa.SERVICE_ID='1096'
      ---
       

--------------��� ����---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1090'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1068'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1068'
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
		and oa.SERVICE_ID='1090'
            
---------------------------------------------	    	   


--------------����� ��� ����---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1100'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1078'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1078'
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
		and oa.SERVICE_ID='1100'
            
---------------------------------------------	

--------------�����---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1089'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1067'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1067'
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
		and oa.SERVICE_ID='1089'
            
---------------------------------------------

--------------��������---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1092'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1070'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1070'
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
		and oa.SERVICE_ID='1092'
            
---------------------------------------------

--------------�� ��� ���������---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1102'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1080'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1080'
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
		and oa.SERVICE_ID='1102'
            
---------------------------------------------

--------------����� ��---------------------
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1101'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1079'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1079'
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
		and oa.SERVICE_ID='1101'
            
---------------------------------------------
---===========================================

-- ����1 -> ���� 2


use it_gh
DECLARE	
	@occ int;
DECLARE cOcc CURSOR FOR
select o.id from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 and (b.id=3881019) 

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN   ---������ ������ �-� 9999 �� ����2
-----��------------------------------------------------		
	    update OCC_ACCOUNTS  
		SET 
		SERVICE_ID='9999'
		FROM 
		OCC_ACCOUNTS OA
		WHERE OA.OCC_ID=@OCC
		AND OA.SERVICE_ID='1044'


		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1044'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1022'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1022'
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
		and oa.SERVICE_ID='1059'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1059'
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
		and oa.SERVICE_ID='9999'
	--	
		
--------------------------------------------------------------------



-----------���������------------------------------
  
		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1052'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1052'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='1030'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1030'
		from 
		OCC_ACCOUNTS oa
		where  oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
      ---
       
-------������ ����� ������---------------------------------

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='9999'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1050'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1050'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='1028'

		update OCC_ACCOUNTS
		set 
		SERVICE_ID='1028'
		from 
		OCC_ACCOUNTS oa
		where oa.OCC_ID=@occ
		and oa.SERVICE_ID='9999'
	--	
		
--------------------------------------------------------------------


------------------------------------



	    	   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  
