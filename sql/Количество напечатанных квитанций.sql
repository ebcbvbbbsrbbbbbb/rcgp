  use Stack
declare @rasch_date date
set @rasch_date = '20191101'
;
with temp as (
SELECT distinct 
ki.[���������������-����] as ls_id,
(select ����� from stack.[������� �����] where row_id = ki.[���������������-����]) as ��,
(select ����� from stack.[AddrLs_Table](ki.[���������������-����],0)) as �����,
(select ��� from stack.[AddrLs_Table](ki.[���������������-����],0)) as ���,
(select �������� from stack.[AddrLs_Table](ki.[���������������-����],0)) as ��������,
ki.[���������������-�����] as �����,
mk.�������� as ����_������,
org1.������� as ���,
count(*) over(partition by ki.[���������������-����], org1.������� ) as [���-�� ����.]
  FROM stack.����_����������� ki 
  left join stack.����_����������� org1 on ki.[���������������-������] = org1.ROW_ID
  left join stack.����_����������� org2 on ki.[���������������-��������] = org2.ROW_ID
  inner join stack.[������ ���������] mk on mk.ROW_ID = ki.[���������������-�����]
  where cast (ki.����� as date) = @rasch_date  and [���������������-������] <> 17
    )
 select distinct ��, �����,���,��������,/*����_������,*/���, [���-�� ����.],
   case when [���-�� ����.]%2>0
	then FLOOR([���-�� ����.]/2)+1
	else [���-�� ����.]/2
  end as [���-�� ������]  
  from temp
  order by ���, �����, ���,��������