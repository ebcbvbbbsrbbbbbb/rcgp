--����� ����� ���
select  --x.NAME,mp.SERVICE_ID,
'',85 tip,
mp.OCC_ID,
sum(mp.value) 
--mp.*
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where --mp.OCC_ID=26404957
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85  --=0
and mp.VALUE<>0
and mp.SERVICE_ID not in('1004','1014','1020','����','1023')-- '1023'- �1 �����
--group by x.NAME,mp.SERVICE_ID
group by mp.OCC_ID


-------------------------
------------------------- ������ ����������� ����� �� ������� ���� ������ ������
select  x.NAME,mp.SERVICE_ID,
sum(mp.value) 
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID not in('1004','1014','1020','����','1023')--
group by x.NAME,mp.SERVICE_ID

/*

����������� ������������        	1000	14208.82
������ �����������              	1006	30.43
���������                       	1008	775.49
������ ���� (������ �����)      	1009	7.86
��������������� �������� ����   	1012	3373.12
��������������� ������� ����    	1013	2111.73
����� ������                    	1015	1394.64
����������� ������ (���� ���)   	1016	0.28
��� �� ��� ���������            	1019	246.41
��� ��������������� ��          	1021	206.63
���� 1 ��                       	1022	341.18
���� 1 ���������                	1030	57.11
���� 1 ����� ������             	1037	35.83
����������� ������              	����	406.51
����                            	����	568.06
���� �����                      	����	357.54
���                             	����	20.84
�������� ����                   	����	4075.43
�������������� ��������� �� ��� 	����	163.21
�������������                   	����	127.97
*/

---�������������� ��������� �� ��� 	����
---�������������                   	����

select  --x.NAME,mp.SERVICE_ID,
'',127 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('����','����')
group by mp.OCC_ID

---���                             	����
select  --x.NAME,mp.SERVICE_ID,
'',25 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('����')
group by mp.OCC_ID

---���� �����                      	����
select  --x.NAME,mp.SERVICE_ID,
'',117 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('����')
group by mp.OCC_ID


---����                            	����
select  --x.NAME,mp.SERVICE_ID,
'',79 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('����')
group by mp.OCC_ID


---����������� ������              	����
select  --x.NAME,mp.SERVICE_ID,
'',111 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('����')
group by mp.OCC_ID

---���� 1 ����� ������             	1037
select  --x.NAME,mp.SERVICE_ID,
'',77 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1037')
group by mp.OCC_ID


---���� 1 ���������                	1030
select  --x.NAME,mp.SERVICE_ID,
'',49 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1030')
group by mp.OCC_ID

---���� 1 ��                       	1022
select  --x.NAME,mp.SERVICE_ID,
'',5 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1022')
group by mp.OCC_ID

---��� �� ��� ���������            	1019
---�������� ����                   	����
select  --x.NAME,mp.SERVICE_ID,
'',73 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1019','����')
group by mp.OCC_ID

---����������� ������ (���� ���)   	1016
select  --x.NAME,mp.SERVICE_ID,
'',99 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1016')
group by mp.OCC_ID


---����� ������                    	1015
select  --x.NAME,mp.SERVICE_ID,
'',75 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1015')
group by mp.OCC_ID


---��������������� �������� ����   	1012
--- ��������������� ������� ����  	1013
---��� ��������������� ��          	1021
select  --x.NAME,mp.SERVICE_ID,
'',71 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1012','1013','1021')
group by mp.OCC_ID

---������ ���� (������ �����)      	1009
select  --x.NAME,mp.SERVICE_ID,
'',55 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1009')
group by mp.OCC_ID

---���������                       	1008
select  --x.NAME,mp.SERVICE_ID,
'',125 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1008')
group by mp.OCC_ID

---������ �����������              	1006
select  --x.NAME,mp.SERVICE_ID,
'',39 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1006')
group by mp.OCC_ID

---����������� ������������        	1000
select  --x.NAME,mp.SERVICE_ID,
'',3 tip,
mp.OCC_ID,
-sum(mp.value) 
,''
from MONTHS_PAID mp
left join XSERVICES x on x.ID=mp.SERVICE_ID
where 
PAY_TYPE_ID='1003'and 
PLAT_TYPE_ID<>85 
and mp.VALUE<>0
and mp.SERVICE_ID in('1000')
group by mp.OCC_ID

