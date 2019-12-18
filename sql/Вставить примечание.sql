SELECT TOP 1000 [ID]
      ,[OCC_ID]
      ,[STR]
      ,[DATE]
      ,[TYPE]
  FROM [it_gh].[dbo].[OCC_ETC]
  
--delete from [it_gh].[dbo].[OCC_ETC] where [TYPE]='1000'
  
--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'�������� ��� � 1468 �� 29.10.2010 ������ ����� �� ��� ������������ ����� ����������� - 1.65 �. �� ��.�.' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where o.proptype_id='����' and t.IS_HISTORY=1  and t.ID<>98
  
  
  
  
 -- insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'�������� ��� � 1468 �� 29.10.2010 ������ ����� �� ��� ������������ ����� ����������� - 1.65 �. �� ��.�.  ���� �� ��� "������� �����" - www.uk9raion.ru' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where o.proptype_id='����' and t.IS_HISTORY=1 and t.ID=98
  
  --delete from [it_gh].[dbo].[OCC_ETC]
  from [it_gh].[dbo].[OCC_ETC] oe
  inner join occupations o on o.id=oe.OCC_ID
   inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where oe.TYPE='1000' and t.IS_HISTORY=1 and t.ID=98
  
  --insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'���� �� ��� "������� �����" - www.uk9raion.ru' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where o.proptype_id='����' and t.IS_H

 insert into [it_gh].[dbo].[OCC_ETC]
 (OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'��������! �� ��������� ����� ������� �������������� �������� ����� �������������, ������������ ���� �� ������������. ��� ����������� ������������� ������ �������� �����, ���������� ���������� �� �������.' tex
 , '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
  and exists(select 1 from COUNTER_LIST cl where cl.OCC_ID=o.id and cl.CNTR_TYPE_ID in (1,2) and cl.SERVICE_ID in ('1004','1020','����'))
  

--delete from [it_gh].[dbo].[OCC_ETC]
 --insert into [it_gh].[dbo].[OCC_ETC]
 (OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'��������! �������� ������ ������ ���� ���������  ���������� ������������ �������. ������ �������� ���� ������� �� ������� �������(��. 39 �� ��), �. 53-66-13 ��� �� "14 �����"' tex
 
 ,'1000' tip,CURRENT_TIMESTAMP dt 
 from --[it_gh].[dbo].[OCC_ETC] oe
 occupations o
 
  --inner join occupations o on o.id=oe.OCC_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 and ---oe.TYPE='1000' and
  ((b.STREET_ID=217 and b.BLDN_NO in('62','62�'))or(b.STREET_ID=72 and b.BLDN_NO in('5','9')))

---------------
-----------
--���������� �� ��������� �� ��
use it_gh;
DECLARE	
	@occ int;
	
DECLARE cOcc CURSOR FOR
select distinct occ_id from(
select oa.SALDO+pl.VALUE+pl.ADDED-pl.PAID pereplat--, oa.* 
--sum(oa.saldo)
,pl.*
from OCC_ACCOUNTS oa
  inner join occupations o on o.id=oa.OCC_ID
  inner join PAYM_LIST pl on pl.OCC_ID=o.ID and  pl.TYPE_ID=oa.SERVICE_ID
  inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=oa.SERVICE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1  and oa.SERVICE_ID='����'
   and oa.SALDO+pl.VALUE+pl.ADDED-pl.PAID<0 --and RIGHT(cl.SOURCE_ID,3)='000'
 )aa
--BEGIN TRANSACTION

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ

	WHILE @@FETCH_STATUS =0
		BEGIN
	    delete from [dbo].[OCC_ETC]
	    where TYPE='1000' and OCC_ID=@occ    
	    insert into [dbo].[OCC_ETC]
        (OCC_ID,[STR],[TYPE],[DATE])
         values(@occ,'��������! � ��� ������������ ��������� �� �������� ���� � ������������� �� ������ ����� �����.��������� �� ������ ���� ������ �� �������� ���������� ��� �� ���������� ���� � ������������ � �.14 ��.155 �� ��.','1000',CURRENT_TIMESTAMP );   
	   FETCH NEXT FROM cOcc INTO  @occ
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  


--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'�������������� ���� �� �������� ��� �. ������ www.055pskov.ru' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1
  

 update oe
  set [STR]='�������������� ���� �� �������� ��� �. ������ www.055pskov.ru. �� ��� ���������� �� ��������� �������  ����������� ������� ����� �� ������� ������������� � �. ������, ��������� ���������� �� �������'--, ���. 66-41-15
  from [it_gh].[dbo].[OCC_ETC] oe
  inner join [CONSMODES_LIST] cl on cl.OCC_ID=oe.OCC_ID
  inner join SUPPLIERS sp on sp.ID=cl.SOURCE_ID
  where TYPE='1000'  and sp.SUP_ACCEPT_ID=4 


----------
insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'c 01.07.12 �������� ���� �������� ���������� ��� �  "���������� �2"' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1
  and((b.STREET_ID= 239 and b.BLDN_NO in('18�','29/23'))
      or
      (b.STREET_ID= 255 and b.BLDN_NO in('28','30'))
     )


----------------------
--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'� 25.07.12 �������� ������ �� ��, ���. ��� �232 �� 17.07.12' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1

-----------
delete from oe
  from  [it_gh].[dbo].[OCC_ETC] oe
  inner join occupations o on o.id=oe.OCC_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 and oe.[TYPE]='1000' and b.TECHSUBDIV_ID in(34,70)

-------------------------------

--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,' ������  -  5% �� ������ (����������� ������) ������ ����' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=2120045


 --DELETE from oe
 --select oe.*,oa.SALDO+pl.ADDED-pl.PAID+pl.VALUE summa
 from  [OCC_ETC] oe
 inner join occupations o on oe.OCC_ID=o.ID
 inner join PAYM_LIST pl on pl.OCC_ID=oe.OCC_ID and pl.TYPE_ID='����'
 inner join OCC_ACCOUNTS oa  on oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=2120045
  and oe.TYPE='1000'
  and  oa.SALDO+pl.ADDED-pl.PAID+pl.VALUE=0

--------------------------------------------------------------------

use it_gh
--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'�������� ��� �� ���.���� � ����� �� ������� 2013�.' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=6211026

select x.ID street_id ,x.NAME street,b.BLDN_NO dom,b.ID bldn_id from BUILDINGS b
inner join XSTREETS x on x.ID=b.STREET_ID
where lower(x.NAME) like lower('%�����%') and lower(b.BLDN_NO)=lower('14')


--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,' ���������� �� ��������� � ����� � ���������� ��������' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=3901015

use it_gh
--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'�������� ��� �� ���.���� � 01.01.12 �� 01.11.14' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=2512044

use it_gh
 insert into [it_gh].[dbo].[OCC_ETC]
 (OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'����������� ������������ �� �� � ����� � ������������ ���������' tex
 , '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
  and exists(select 1 from [it_gh].[dbo].[ADDED_PAYMENTS] a where a.OCC_ID=o.id and a.SERVICE_ID in ('1004') and a.DOC_ID=22)


use it_gh
 insert into [it_gh].[dbo].[OCC_ETC]
 (OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'����������� �� ��/�� �� 2 ������' tex
 , '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
  and exists(select 1 from [it_gh].[dbo].[ADDED_PAYMENTS] a where a.OCC_ID=o.id and a.SERVICE_ID in ('1008','����') and a.DOC_ID=22)
 --exec ad_GetDocsList 1

--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,' ������  -  �� ���������� ������ ����' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=2170018

--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,' ������  -  �� ���������� ������ ����' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=761013

--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select distinct o.id,'� 01.04.15 �������� ������ 10% �� ������� ����' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt 
  FROM [CONSMODES_LIST] cl
    inner join occupations o on o.id=cl.OCC_ID
  inner join FLATS f on f.ID=o.flat_id  
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join STREETS s on s.ID=b.STREET_ID
  where cl.MODE_ID in (17010,17012,17013,23010,23012,23013)

--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,' ������������ �� ��������� �� ������� ������� �� 12.2015' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=3350005
  
--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,' ����� �� ������ ������' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=3881023

--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,' ����� �� ������ �����������������' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=2120005

--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,' ����� �� ������ �����������������' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=6211004


 --DELETE from oe
 --select oe.*,oa.SALDO+pl.ADDED-pl.PAID+pl.VALUE summa
 from  [OCC_ETC] oe
 inner join occupations o on oe.OCC_ID=o.ID
 inner join PAYM_LIST pl on pl.OCC_ID=oe.OCC_ID and pl.TYPE_ID='����'
 inner join OCC_ACCOUNTS oa  on oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=6211004
  and oe.TYPE='1000'
  and  oa.SALDO+pl.ADDED-pl.PAID+pl.VALUE=0


--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,' ������  -  �� ���������� ������ ����' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID= 1300017


 use it_gh
--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'���������� � ����� � ���������� ������� ������' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID= 6211080

--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'������������ �� ������� � ����� � �������� ����������������' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID= 2120005


use it_gh
--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'�������� ��� �� ���.���� �� 2015�.' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=2550012

use it_gh
--insert into [it_gh].[dbo].[OCC_ETC]
(OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'���������� �������� �� ��������� � ����� � ���������� ���� � 2013 ����' tex
 ,
 '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where f.BLDN_ID=5280003

use it_gh
 insert into [it_gh].[dbo].[OCC_ETC]
 (OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'����������� �� ���� � ������ 2016�.' tex
 , '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 and b.ID=2630026
  and exists(select 1 from [it_gh].[dbo].[ADDED_PAYMENTS] a where a.OCC_ID=o.id and a.SERVICE_ID in ('����') and a.DOC_ID in (27,26,25))
 --exec ad_GetDocsList 1


use it_gh
 insert into [it_gh].[dbo].[OCC_ETC]
 (OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'�������� ���� ������� ����� �� ��������' tex
 , '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
  and exists(select 1 from [it_gh].[dbo].[ADDED_PAYMENTS] a where a.OCC_ID=o.id and a.SERVICE_ID in ('1004') and a.DOC_ID in (37) and a.VALUE<>0)
 --exec ad_GetDocsList 1


use it_gh
 insert into [it_gh].[dbo].[OCC_ETC]
 (OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'�������� �� ��� ���� �� 2015�.' tex
 , '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
  and exists(select 1 from [it_gh].[dbo].[ADDED_PAYMENTS] a where a.OCC_ID=o.id and a.SERVICE_ID in ('1000') and a.DOC_ID in (55) and a.VALUE<>0)  --exec ad_GetDocsList 1
  
----------------

use it_gh
 insert into [it_gh].[dbo].[OCC_ETC]
 (OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'����� �� ������ ���������' tex
 , '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
  and b.ID in (4330071)
  and exists(select 1 from [it_gh].[dbo].[ADDED_PAYMENTS] a where a.OCC_ID=o.id  and a.DOC_ID in (29) and a.VALUE<>0)  --exec ad_GetDocsList 1

---------


 
 use it_gh
 insert into [it_gh].[dbo].[OCC_ETC]
 (OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'���������� �� ���������� ��������� �� ���� 2018' tex
 , '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
  and b.ID in (2170088)
  and exists(select 1 from [it_gh].[dbo].[ADDED_PAYMENTS] a where a.OCC_ID=o.id  and a.DOC_ID in (60) and a.VALUE<>0)  --exec ad_GetDocsList 1

-------------

 use it_gh
 insert into [it_gh].[dbo].[OCC_ETC]
 (OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'�������� ����� ������ �� ������� 2018' tex
 , '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID='1015'  
  where t.IS_HISTORY=1 
  and t.ID in (25) and cl.MODE_ID%1000<>0
  
-----------------
 use it_gh
 insert into [it_gh].[dbo].[OCC_ETC]
 (OCC_ID,[STR],[TYPE],[DATE])
 select o.id,'���������� ������ � ������� 18 �� ������ 19' tex
 , '1000' tip,CURRENT_TIMESTAMP dt from occupations o
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  where t.IS_HISTORY=1 
  and b.ID in (3901015)
  and exists(select 1 from [it_gh].[dbo].[ADDED_PAYMENTS] a where a.OCC_ID=o.id  and a.DOC_ID in (32) and a.VALUE<>0)  --exec ad_GetDocsList 1


--------------------