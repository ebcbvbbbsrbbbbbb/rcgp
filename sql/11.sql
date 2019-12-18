--������ �� � ���

select o.id LS, o.INITIALS,o.TOTAL_SQ,o.SALDO, o.ADDRESS from it_gh.dbo.OCCUPATIONS o 
inner join it_gh.dbo.FLATS f on f.ID=o.FLAT_ID
inner join BUILDINGS b on b.ID=f.BLDN_ID  
 where not exists(select 1 from [it_gh].[dbo].[LS11] l where l.occ=o.id )
 and b.TECHSUBDIV_ID in (41,91)
 
-- �� ���������� ��������
use it_gh
select l.* , o.ADDRESS,o11.ADDRESS  from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
and f11.FLAT_NO<>f.FLAT_NO


-- �� ���������� �������
use it_gh
select l.occ11 LS11,l.occ LS , o.ADDRESS ADRES,o11.ADDRESS ADRES11 ,o.TOTAL_SQ OB_PL ,o11.TOTAL_SQ OB_PL11, o.COMBINED_SQ sov_pl ,o11.COMBINED_SQ sov_pl11 from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
and (--abs(o11.TOTAL_SQ-o.TOTAL_SQ)>0.01
--or  
 abs(o11.COMBINED_SQ-o.COMBINED_SQ)>0.001
--abs(o11.LIVING_SQ-o.LIVING_SQ)>0.001
     )
     and f.[ROOMTYPE_ID]='����'
order by 3     
---------------------

------ ���������� �������
use it_gh
select l.occ11 LS11,l.occ LS , o.ADDRESS ADRES,o11.ADDRESS ADRES11 ,o.TOTAL_PEOPLE chel,o11.TOTAL_PEOPLE chel11
 from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
and (o11.TOTAL_PEOPLE<>o.TOTAL_PEOPLE
     )
   order by 3


------ ��� �������
use it_gh
select l.occ11 LS11,l.occ LS , o.ADDRESS ADRES,o11.ADDRESS ADRES11 ,o.initials,o11.initials--o.TOTAL_PEOPLE chel,o11.TOTAL_PEOPLE chel11
 from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
 left join [it_gh].[dbo].[PEOPLE] p on p.occ_id=o.id and p.[WHO_ID]='����'
 left join mr11.[dbo].[PEOPLE] p11 on p11.occ_id=o11.id  and p11.[WHO_ID]='����'
  where b.TECHSUBDIV_ID in (91,41)
and (--o11.TOTAL_PEOPLE<>o.TOTAL_PEOPLE
p.[LAST_NAME]<>p11.[LAST_NAME]
or p.[FIRST_NAME]<>p11.[FIRST_NAME]
or p.[SECOND_NAME]<>p11.[SECOND_NAME]
     )
   order by 3


---------
------ ��� ������������� ��������
use it_gh
update p
set p.[LAST_NAME]=p11.[LAST_NAME]
,p.[FIRST_NAME]=p11.[FIRST_NAME]
,p.[SECOND_NAME]=p11.[SECOND_NAME]
,p.[STATUS_ID]=p11.[STATUS_ID]
,p.[BIRTHDATE]=p11.[BIRTHDATE]
,p.[REG_DATE]=p11.[REG_DATE]

--select p.* 
from [it_gh].[dbo].[PEOPLE] p 
  inner join OCCUPATIONS  o on  p.occ_id=o.id
   inner join  [it_gh].[dbo].[LS11] l on o.ID=l.OCC
   inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID   
  inner join  mr11.[dbo].[PEOPLE] p11  on p11.occ_id=o11.id  and p11.[WHO_ID]='����'
where p.[WHO_ID]='����' and  b.TECHSUBDIV_ID in (91,41) and
(
p.[LAST_NAME]<>p11.[LAST_NAME]
or p.[FIRST_NAME]<>p11.[FIRST_NAME]
or p.[SECOND_NAME]<>p11.[SECOND_NAME]
     )
     
--------------------------------

--������� ����� � ��������� ����� �������������, ��� ���������� ���������� �������
delete from pd
--select p.* 
from 
[it_gh].[dbo].[PEOPLE] p 
inner join [it_gh].[dbo].[people_documents] pd on pd.[people_id]=p.id
  inner join OCCUPATIONS  o on  p.occ_id=o.id
   inner join  [it_gh].[dbo].[LS11] l on o.ID=l.OCC
   inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID   
  --inner join  mr11.[dbo].[PEOPLE] p11  on p11.occ_id=o11.id  and p11.[WHO_ID]='����'
where p.[WHO_ID]<>'����' and  b.TECHSUBDIV_ID in (91,41) and
(o11.TOTAL_PEOPLE<>o.TOTAL_PEOPLE
     )


delete from p
--select p.* 
from [it_gh].[dbo].[PEOPLE] p 
  inner join OCCUPATIONS  o on  p.occ_id=o.id
   inner join  [it_gh].[dbo].[LS11] l on o.ID=l.OCC
   inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID   
  --inner join  mr11.[dbo].[PEOPLE] p11  on p11.occ_id=o11.id  and p11.[WHO_ID]='����'
where p.[WHO_ID]<>'����' and  b.TECHSUBDIV_ID in (91,41) and
(o11.TOTAL_PEOPLE<>o.TOTAL_PEOPLE
     )

--����������� ����� ����� �������������
insert into [it_gh].[dbo].[PEOPLE] ([FLAT_ID]
      ,[OCC_ID]
      ,[LAST_NAME]
      ,[FIRST_NAME]
      ,[SECOND_NAME]
      ,[WHO_ID]
      ,[STATUS_ID]
      ,[BIRTHDATE]
      ,[DOCTYPE_ID]
      ,[DOC_NO]
      ,[PASSSER_NO]
      ,[ISSUED]
      ,[DOCORG],
      [FINTERM_ID],
      [SOC_STATUS_ID],
      [PEOPLE_EARN]
      ,[SEX]
      ,[REG_DATE]
      ,[IS_PROFIT])
select o.[FLAT_ID]
      ,o.id
      ,p.[LAST_NAME]
      ,p.[FIRST_NAME]
      ,p.[SECOND_NAME]
      ,p.[WHO_ID]
      ,p.[STATUS_ID]
      ,p.[BIRTHDATE]
      ,'????' as DOCTYPE_ID
      ,null as [DOC_NO]
      ,null as [PASSSER_NO]
      ,null as [ISSUED]
      ,null as [DOCORG],
      p.[FINTERM_ID]+7,
      p.[SOC_STATUS_ID],
      p.[PEOPLE_EARN]
      ,p.[SEX]
      ,p.[REG_DATE]
      ,p.[IS_PROFIT] 
from 
  [it_gh].[dbo].[LS11] l 
   inner join mr11.[dbo].[PEOPLE] p on p.occ_id=l.OCC11
   inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join OCCUPATIONS  o on  o.id=l.occ
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID   
  
where p.[WHO_ID]<>'����' and  b.TECHSUBDIV_ID in (91,41) and
(o11.TOTAL_PEOPLE<>o.TOTAL_PEOPLE
     )






------------------------------------
 select l.occ,count(*) from  [it_gh].[dbo].[LS11] l 
 group by occ
having count(*)>1
 
 
 
 select * from 
  [it_gh].[dbo].[LS11] l 
  where  --l.occ= 9127791
  l.occ11=417728
 
--update l 
--set l.occ=null --'41022'+RIGHT(l.occ11,3)  --null --
 select * 
 from [it_gh].[dbo].[LS11] l
 where NOT exists(select 1 from it_gh.dbo.OCCUPATIONS o where  l.occ=o.id  )
 --and NOT exists(select 1 from [it_gh].[dbo].[LS11] l2 where l2.occ=l.occ)
 and l.occ is null
 
 
  update l 
 set l.occ=91103837 
 --select * 
 from [it_gh].[dbo].[LS11] l
 where l.occ11=918837
---------------------

--���������� ������������� ����� �������

DECLARE	
	@occ int,
	@plos decimal(16,6),
	@fl_id int;
DECLARE cOcc CURSOR FOR
select o.id, f11.TOTAL_SQ ,o.flat_id
 from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
and (--abs(o11.TOTAL_SQ-o.TOTAL_SQ)>0.001
abs(f11.TOTAL_SQ-f.TOTAL_SQ)>0.001
    )


OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@plos,@fl_id

	WHILE @@FETCH_STATUS =0
		BEGIN
		print 'ls= '+cast(@occ as varchar(10))+ ' plos= '+cast(@plos as varchar(16))
	    exec CliSquareTotalSet @fl_id,@plos
	   	   
	FETCH NEXT FROM cOcc INTO  @occ,@plos,@fl_id
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  



------ ������������
use it_gh
update o
set o.[PROPTYPE_ID]=o11.[PROPTYPE_ID]
--select l.occ11 LS11,l.occ LS , o.ADDRESS ADRES,o11.ADDRESS ADRES11 ,o.[PROPTYPE_ID] priv,o11.[PROPTYPE_ID] priv11
 from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
and (o11.[PROPTYPE_ID]<>o.[PROPTYPE_ID]
     )
   order by 3

-------------
------ ����� ����������� ��������
use it_gh
update cl
set cl.[MODE_ID]=(select case cl2.[MODE_ID] when 28002 then 17001 when 28004 then 17002 when 28008 then 17007 else 17000 end
                 from [mr11].[dbo].[CONSMODES_LIST] cl2 where  cl2.occ_id=l.occ11 and cl2.service_id='��  '
                 )
--select l.occ11 LS11,l.occ LS , o.ADDRESS ADRES,o11.ADDRESS ADRES11 ,o.[PROPTYPE_ID] priv,o11.[PROPTYPE_ID] priv11
 from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  inner join OCCUPATIONS  o on o.ID=l.OCC
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
  and cl.service_id='1004'
and exists (select 1 from [mr11].[dbo].[CONSMODES_LIST] cl11 where cl11.occ_id=l.occ11 and cl11.service_id='��  ' and cl11.[MODE_ID] %1000<>0)

------ ����� ����������� ��� ��������
use it_gh
update cl
set cl.[MODE_ID]=(select case cl2.[MODE_ID] when 29000 then 28000  else 28001 end
                 from [mr11].[dbo].[CONSMODES_LIST] cl2 where  cl2.occ_id=l.occ11 and cl2.service_id='��_�'
                 )
--select l.occ11 LS11,l.occ LS , o.ADDRESS ADRES,o11.ADDRESS ADRES11 ,o.[PROPTYPE_ID] priv,o11.[PROPTYPE_ID] priv11
 from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  inner join OCCUPATIONS  o on o.ID=l.OCC
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
  and cl.service_id='1020'
and exists (select 1 from [mr11].[dbo].[CONSMODES_LIST] cl11 where cl11.occ_id=l.occ11 and cl11.service_id='��_�' and cl11.[MODE_ID] %1000<>0)

----

------ ����� ����������� ��� �� ���������
use it_gh
update cl
set cl.[MODE_ID]=(select case cl2.[MODE_ID] when 17001 then 23001 when 17002 then 23002 when 23007 then 17007  else 23001 end
                 from it_gh.[dbo].[CONSMODES_LIST] cl2 where  cl2.occ_id=o.id and cl2.service_id='1004'
                 )
--select l.occ11 LS11,l.occ LS , o.ADDRESS ADRES,o11.ADDRESS ADRES11 ,o.[PROPTYPE_ID] priv,o11.[PROPTYPE_ID] priv11
 from  OCCUPATIONS  o 
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
  and cl.service_id='1014'
and exists (select 1 from it_gh.[dbo].[CONSMODES_LIST] cl3 where cl3.occ_id=o.id and cl3.service_id='1004' and cl3.[MODE_ID] %1000<>0)
------ ����� ����������� ��� ����
use it_gh
update cl
set cl.[MODE_ID]=(select case cl2.[MODE_ID] when 36000 then  153000  else  153001 end
                 from [mr11].[dbo].[CONSMODES_LIST] cl2 where  cl2.occ_id=l.occ11 and cl2.service_id='��_�'
                 )
--select l.occ11 LS11,l.occ LS , o.ADDRESS ADRES,o11.ADDRESS ADRES11 ,o.[PROPTYPE_ID] priv,o11.[PROPTYPE_ID] priv11
 from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  inner join OCCUPATIONS  o on o.ID=l.OCC
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
  and cl.service_id='����'
and exists (select 1 from [mr11].[dbo].[CONSMODES_LIST] cl11 where cl11.occ_id=l.occ11 and cl11.service_id='��_�' and cl11.[MODE_ID] %1000<>0)


------ ����� ����������� ����-����
use it_gh
update cl
set cl.[MODE_ID]=(select case cl2.[MODE_ID] when 37000 then  154000  else  154001 end
                 from [mr11].[dbo].[CONSMODES_LIST] cl2 where  cl2.occ_id=l.occ11 and cl2.service_id='��_�'
                 )
--select l.occ11 LS11,l.occ LS , o.ADDRESS ADRES,o11.ADDRESS ADRES11 ,o.[PROPTYPE_ID] priv,o11.[PROPTYPE_ID] priv11
 from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  inner join OCCUPATIONS  o on o.ID=l.OCC
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
  and cl.service_id='����'
and exists (select 1 from [mr11].[dbo].[CONSMODES_LIST] cl11 where cl11.occ_id=l.occ11 and cl11.service_id='��_�' and cl11.[MODE_ID] %1000<>0)

------ ����� ����������� ����
use it_gh
update cl
set cl.[MODE_ID]=(select case cl2.[MODE_ID] when 35001 then  19002  else  19000 end
                 from [mr11].[dbo].[CONSMODES_LIST] cl2 where  cl2.occ_id=l.occ11 and cl2.service_id='��� '
                 )
--select l.occ11 LS11,l.occ LS , o.ADDRESS ADRES,o11.ADDRESS ADRES11 ,o.[PROPTYPE_ID] priv,o11.[PROPTYPE_ID] priv11
 from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  inner join OCCUPATIONS  o on o.ID=l.OCC
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
  and cl.service_id='1008'
and exists (select 1 from [mr11].[dbo].[CONSMODES_LIST] cl11 where cl11.occ_id=l.occ11 and cl11.service_id='��� ' and cl11.[MODE_ID] %1000<>0)


------ ����� ����������� ����
use it_gh
update cl
set cl.[MODE_ID]=(select case cl2.[MODE_ID] when 20001 then  10001  else  10000 end
                 from [mr11].[dbo].[CONSMODES_LIST] cl2 where  cl2.occ_id=l.occ11 and cl2.service_id='�   '
                 )
--select l.occ11 LS11,l.occ LS , o.ADDRESS ADRES,o11.ADDRESS ADRES11 ,o.[PROPTYPE_ID] priv,o11.[PROPTYPE_ID] priv11
 from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  inner join OCCUPATIONS  o on o.ID=l.OCC
 inner join [CONSMODES_LIST] cl on  cl.occ_id=o.id
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
  and cl.service_id='����'
and exists (select 1 from [mr11].[dbo].[CONSMODES_LIST] cl11 where cl11.occ_id=l.occ11 and cl11.service_id='�   ' and cl11.[MODE_ID] %1000<>0)


------- 
 select l.occ,count(*) from  [it_gh].[dbo].[LS11] l 
 group by occ
having count(*)>1

-- �� ���������� ���� �������
use it_gh
select l.occ11 LS11,l.occ LS , o.ADDRESS ADRES,o11.ADDRESS ADRES11 ,f.[ROOMTYPE_ID] tip ,f11.[ROOMTYPE_ID] tip11
 from
[it_gh].[dbo].[LS11] l 
 inner join mr11.[dbo].OCCUPATIONS o11 on o11.ID=l.occ11  
 inner join mr11.[dbo].FLATS f11 on f11.ID=o11.FLAT_ID  
  
  inner join OCCUPATIONS  o on o.ID=l.OCC
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (91,41)
and (f.[ROOMTYPE_ID]<>f11.[ROOMTYPE_ID]
     )
   order by 3


--------------------
--������� 
use it_gh
select '', aa.tip,aa.occ ,sum(aa.summa),''
from (select
case mp.service_id
	when '��� ' then 47
	when '�/� ' then 47
	when '����' then 47
	when '��_�' then 209
	when '��_�' then 207
	when '��  ' then 75
	when '�   ' then 79
	when '��  ' then 33
	when '��_�' then 33
	when '��_�' then 33
	when '��  ' then 11
	end tip,
	ml.occ,(mp.VALUE) summa
from 
  mr11.dbo.occupations mo
  inner join mr11.dbo.months_paid mp on mp.occ_id=mo.id 
  inner join [it_gh].[dbo].[LS11] ml on ml.occ11=mo.id 
  inner join [it_gh].dbo.occupations o on o.id=ml.occ
  inner join [it_gh].dbo.FLATS f on f.ID=o.flat_id
  inner join [it_gh].dbo.BUILDINGS b on b.ID=f.BLDN_ID
  inner join [it_gh].dbo.TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID    
  where t.IS_HISTORY=1 
 and b.TECHSUBDIV_ID in (41,91) 
 and mp.service_id in ('��_�','��_�','��  ','�   ','����','��� ','��  ','��  ','��_�','��_�','�/� ')
  and mp.VALUE<>0 
 ) aa
group by occ,tip
  order by occ,tip
  