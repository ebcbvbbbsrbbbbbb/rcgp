 use Stack
 IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME='PTS_dolg' AND xtype='U')   
   
    create table Stack.PTS_dolg
(
  LS NUMERIC(10,0),
  FIO char(33),
  ULICA char(51),
  DOM char(16),
  KV char(11),
  KOD_UO numeric(5,0),
  NAME_UO char (50),
  DATE_NACH date,
  DOLG_GV numeric(15,2),
  DOLG_OTOP numeric(15,2),
  DOLG numeric (10,2),
  KOL_CHEL numeric(10,0),
  KOL_M2 numeric(10,2)
)

ELSE DELETE FROM stack.PTS_dolg

 declare @rasch_date date
 set @rasch_date = '2019-11-01'

create table #occ 
(
 occ_id int,
 ls varchar(255),
 service int,
 service_group int,
 uk_dog int,
 rasch_date date,
 isITP int,
)
	 --drop table #occ
----------- �������� ������
insert into #occ
select distinct ns.���� occ_id, (select ����� from stack.[������� �����] where row_id = ns.����) ls, ns.[����� ������] service, 
tui.������������� service_group, ns.��������� uk_dog, @rasch_date as rasch_date, 
case when(select count(*) from stack.[������ �����] su inner join stack.[���� �����] tu on tu.ROW_ID=su.[���-������] 
where su.[����-������]=ns.���� and tu.[������� ��� 1]=28)	> 0
then 1 
else 0
end as isitp
from stack.������� ns inner join stack.[���� ����� ��������] tui on tui.������������ = ns.[����� ������] 
where (CAST([����� �������]	as date) = DATEADD(MONTH,-2,@rasch_date) and ��������� = 1305 and tui.�����������=2 and ns.����� <> 0)
or (CAST([����� �������]	as date) = DATEADD(MONTH,-2,@rasch_date) and ��������� = 765 and tui.�����������=2 and ns.����� <> 0 and tui.������������� in (400,2000,2100,4700))
or (CAST([����� �������]	as date) = DATEADD(MONTH,-2,@rasch_date) and ��������� = 972 and tui.�����������=2 and ns.����� <> 0 and tui.������������� in (400,2000,2100,4700) and exists(select 1 from stack.[������� ��������] where �������=ns.���� and ��������=943))

------------- ����������
union	
select distinct ns.���� occ_id, (select ����� from stack.[������� �����] where row_id = ns.����) ls, ns.[����� ������] service,
 tui.������������� service_group, ns.��������� uk_dog, @rasch_date rasch_date, 
case when(select count(*) from stack.[������ �����] su inner join stack.[���� �����] tu on tu.ROW_ID=su.[���-������] 
where su.[����-������]=ns.���� and tu.[������� ��� 1]=28)	> 0
then 1 
else 0
end  as itp
from stack.������ ns inner join stack.[���� ����� ��������] tui on tui.������������ = ns.[����� ������] 
where (CAST([����� �������]	as date) = DATEADD(MONTH,-1,@rasch_date) and ��������� = 1305 and tui.�����������=2 and ns.����� <> 0)
or ((CAST([����� �������]	as date) = DATEADD(MONTH,-1,@rasch_date) and ��������� = 765 and tui.�����������=2 and ns.����� <> 0 and tui.������������� in (400,2000,2100,4700)))
or ((CAST([����� �������]	as date) = DATEADD(MONTH,-1,@rasch_date) and ��������� = 972 and tui.�����������=2 and ns.����� <> 0 and tui.������������� in (400,2000,2100,4700) and exists(select 1 from stack.[������� ��������] where �������=ns.���� and ��������=943)))

------------ �������
union 		
select distinct ns.���� occ_id, (select ����� from stack.[������� �����] where row_id = ns.����) ls, ns.[����� ������] as service,
 tui.������������� service_group,  ns.��������� uk_dog,  @rasch_date rasch_date, 
case when(select count(*) from stack.[������ �����] su inner join stack.[���� �����] tu on tu.ROW_ID=su.[���-������] 
where su.[����-������]=ns.���� and tu.[������� ��� 1]=28)	> 0
then 1 
else 0
end  as itp 
from stack.[�� ������] ns inner join stack.[���� ����� ��������] tui on tui.������������ = ns.[����� ������] 
where CAST([����� �������]	as date) = DATEADD(MONTH,-1,@rasch_date) and ��������� = 1305 and tui.�����������=2 and ns.����� <> 0
or (CAST([����� �������]	as date) = DATEADD(MONTH,-1,@rasch_date) and ��������� = 765 and tui.�����������=2 and ns.����� <> 0 and tui.������������� in (400,2000,2100,4700))
or (CAST([����� �������] 	as date) = DATEADD(MONTH,-1,@rasch_date) and ��������� = 972 and tui.�����������=2 and ns.����� <> 0 and tui.������������� in (400,2000,2100,4700) and exists(select 1 from stack.[������� ��������] where �������=ns.���� and ��������=943))

----------- �������
union 	
 select distinct so.[����-������] as occ_id, (select ����� from stack.[������� �����] where row_id = so.[����-������]) as ls,
 tu.[����� ������] as service, tui.������������� as service_group, ukd.ROW_ID as uk_dog, @rasch_date rasch_date,
 case when(select count(*) from stack.[������ �����] su inner join stack.[���� �����] tu on tu.ROW_ID=su.[���-������] 
where su.[����-������]=so.[����-������] and tu.[������� ��� 1]=28)	> 0
then 1 
else 0
end  as itp
 from stack.[������ �� �����] opv left join stack.[������ ������] so on so.ROW_ID = opv.[�������������-������]
 left join stack.[���� �����] tu on tu.ROW_ID = opv.[�������������-������]
 left join stack.[���� ����� ��������] tui  on tui.������������ = tu.[����� ������]
 left join stack.����������� org on opv.[�������������-��] =  org.ROW_ID
 left join stack.[�� ��������] ukd on ukd.[�����������-���������] = org.ROW_ID
 where 
 (opv.��� <> 2 and cast (so.���� as date) between DATEADD(month,-1,@rasch_date) and EOMONTH(@rasch_date) and tui.����������� = 2 and opv.[�������������-����] = 1305 and ukd.�����<>0) or 
 ((opv.��� <> 2 and cast (so.���� as date) between DATEADD(month,-1,@rasch_date) and EOMONTH(@rasch_date) and tui.����������� = 2 and opv.[�������������-����] = 765) and tui.������������� in (400,2000,2100,4700) and ukd.�����<>0) or
 ((opv.��� <> 2 and cast (so.���� as date) between DATEADD(month,-1,@rasch_date) and EOMONTH(@rasch_date) and tui.����������� = 2 and opv.[�������������-����] = 972) and tui.������������� in (400,2000,2100,4700) 
 and exists(select 1 from stack.[������� ��������] where �������=so.[����-������] and ��������=943) and ukd.�����<>0) 
 ;


 with temp as (																  
select #occ.occ_id as ��, ls as �����_��,
cast ((select ���  from stack.[�������� �����������] where [����-����������] = #occ.occ_id) as char(33)) as ���, 
(select ����� from stack.[AddrLs_Table](#occ.occ_id,0)) as �����,
(select ��� from stack.[AddrLs_Table](#occ.occ_id,0)) as ���,
(select �������� from stack.[AddrLs_Table](#occ.occ_id,0)) as ��������,
 stack.AddrLs(#occ.occ_id,1) �����, ukd.�����, org.�������� as ��,  #occ.rasch_date as �����, 
#occ.service as ���_���, #occ.service_group as ��_���, #occ.uk_dog,
isnull(nt.������_�����,0) as ������_�����, 
isnull(rn.�����_�������,0) as �������, 
isnull(perer.������_�����,0) as ����������,
isnull(opl.�����,0) as �����_��������,
isnull(ns.�����,0) as ��_������, 
isnull(ls.�������,0) as �������, 
isnull(ppl.total_ppl,0) as ���������, 
#occ.isITP as ITP

from #occ 
-- ����������� ��������
left join stack.[�� ��������] ukd on #occ.uk_dog=ukd.ROW_ID
left join stack.����������� org on org.ROW_ID = ukd.[�����������-���������]
-- �������� ������
left join (select sum(�����) as �����, [����� ������], ���������, ���� from stack.������� where CAST([����� �������] as date) = DATEADD(MONTH,-2,@rasch_date)  
 group by [����� ������], ���������, ����)
as ns on ns.���������=#occ.uk_dog and ns.[����� ������] = #occ.service and #occ.occ_id = ns.���� 
-- ����������
left join (select sum(�����) as ������_�����, [����� ������], ���������, ����, ���������������� 
from stack.[���������� �������] nl where cast([����� �������] as date)=DATEADD(MONTH,-1,@rasch_date) and ����� <> 0 and 
��������� = 
	case when exists (select 1 from stack.[������� ��������] where ������� = ���� and �������� = 943 and �����������=3)
	then 972
	else 1305
	end 
and ���������2<>777 and ��� <> '������'   group by [����� ������], ���������, ����, ����������������)
as nt on nt.[����� ������] = #occ.service and #occ.occ_id = nt.���� and	nt.���������= #occ.uk_dog
-- �����������
left join (select sum(�����) as ������_�����, sum(�����) as ������_�����, [����� ������], ���������, ����
from stack.[���������� �������] nl where cast([����� �������] as date)=DATEADD(MONTH,-1,@rasch_date) and ����� <> 0 and ��������� = 1305 and ���='������'   group by [����� ������], ���������, ����)
as perer on perer.���������=#occ.uk_dog and perer.[����� ������] = #occ.service and #occ.occ_id = perer.���� 
-- �������
left join (select sum(rns.�����) as �����_�������, rns.[����� ������], rns.���������, rns.���� 
from stack.[�� ������] rns inner join stack.[�� ��������] rnd on rns.[��-������] = rnd.ROW_ID where cast(rns.[����� �������] as date)=DATEADD(MONTH,-1,@rasch_date)
group by  rns.[����� ������], rns.���������, rns.����) as rn
on rn.[����� ������]  = #occ.service and rn.���� = #occ.occ_id and rn.���������=#occ.uk_dog 
-- �������
 left join 
(
select sum(opv.�����) �����, tu.[����� ������], ukd.ROW_ID, so.[����-������] from stack.[������ �� �����] opv 
 left join stack.[������ ������] so on so.ROW_ID = opv.[�������������-������]
 left join stack.[���� �����] tu on tu.ROW_ID = opv.[�������������-������]
 left join stack.[���� ����� ��������] tui  on tui.������������ = tu.[����� ������]
 left join stack.����������� org on opv.[�������������-��] =  org.ROW_ID
 left join stack.[�� ��������] ukd on ukd.[�����������-���������] = org.ROW_ID
  where 
 (opv.��� <> 2 and cast (so.���� as date) between DATEADD(month,-1,@rasch_date) and EOMONTH(@rasch_date) and tui.����������� = 2 and opv.[�������������-����] = 1305 and ukd.�����<>0) or 
 ((opv.��� <> 2 and cast (so.���� as date) between DATEADD(month,-1,@rasch_date) and EOMONTH(@rasch_date) and tui.����������� = 2 and opv.[�������������-����] = 765) and tui.������������� in (400,2000,2100,4700) and ukd.�����<>0) or
 ((opv.��� <> 2 and cast (so.���� as date) between DATEADD(month,-1,@rasch_date) and EOMONTH(@rasch_date) and tui.����������� = 2 and opv.[�������������-����] = 972) and tui.������������� in (400,2000,2100,4700) 
 and exists(select 1 from stack.[������� ��������] where �������=so.[����-������] and ��������=943) and ukd.�����<>0) 
 group by tu.[����� ������], ukd.ROW_ID, so.[����-������]
) as opl on opl.[����-������] = #occ.occ_id and opl.[����� ������] = #occ.service and opl.ROW_ID = #occ.uk_dog
-- ������� ������� 
left join (select s.�������� as �������, s.[����-���������] as ����  from stack.�������� s  
where s.[����-���������]=5 and @rasch_date BETWEEN cast(s.������ as date) and cast(s.������ as date)) as ls on
ls.����=#occ.occ_id
-- ���-�� ����������� � ������ ���������� ��������
left join
( select (isnull(total_ppl,0)-isnull(total_dv,0)) as total_ppl, prop.������� ���_��  
  from (SELECT [�������-�������] as �������, count(*) as total_ppl
  FROM [Stack].[stack].[�������� �����������]  
  where (CAST([���� ��������] as date) <= EOMONTH(@rasch_date) and (CAST([���� �������] as date) > EOMONTH(@rasch_date) or [���� �������] is null) )
  group by [�������-�������]) as prop
  left join 
  (select count(*) as total_dv, [����-��������] as ������� from stack.[��������� ��������] where cast(������ as date) < @rasch_date 
  and (cast(������ as date) > EOMONTH(@rasch_date) or ������ is null)
  and ���=0
  group by [����-��������]) as dv
  on dv.������� = prop.�������) as ppl on ppl.���_�� = #occ.occ_id
)
 
--select * from temp where �����_��=25001407

insert into stack.pts_dolg	
	select �����_��, ���, �����, ���, ��������, �����, ��, @rasch_date,
	sum(case when ��_��� in (2000,2100) 
		then ��_������ + ������_����� + ������� + ���������� - �����_��������
		else 0
	end),
		sum(case when ��_��� in (400) 
		then ��_������ + ������_����� + ������� + ���������� - �����_��������
		else 0
	end),
		sum(��_������ + ������_����� + ������� + ���������� - �����_��������
	),
	 ���������, �������	
	 from temp 
 	 group by �����_��, �����, ���, ��������, �����, ��, �������, ���������, ���

 
  select 
  LS,
  FIO,
  ULICA,
  DOM,
  KV,
  KOD_UO,
  NAME_UO,
  DATE_NACH,
  case when DOLG_GV<0 or DOLG_OTOP <0
  then
	  case when DOLG_GV+DOLG_OTOP<=0
		then 0
		else 
			case when DOLG_GV>DOLG_OTOP
			then DOLG_GV-DOLG_OTOP
			else 0
		end
	  end
  else DOLG_GV
  end as DOLG_GV,
  case when DOLG_GV<0 or DOLG_OTOP <0
   then
    case when DOLG_GV+DOLG_OTOP<=0
	then 0
	else 
		case when DOLG_OTOP>DOLG_GV
		then DOLG_OTOP-DOLG_GV
		else 0
	end
  end 
  else DOLG_OTOP
  end as DOLG_OTOP,
  DOLG,
	KOL_CHEL,
	KOL_M2  
   from stack.PTS_dolg where DOLG>0
  order by KOD_UO ,ULICA,DOM,KV,LS
 
  --drop table #occ

 
 
 
 
   select * from #occ


 
