use Stack
----  ����� ���
SELECT doc.���� as [����], ist.������������ as ��������, isp.������������ as �����������, sum(opv.�����) as ����� 
 from Stack.�������� doc  inner join stack.����������� ist on ist.ROW_ID = doc.[��������-�������]		-- �������� ��������
inner join stack.[������ ������] so on so.[������-������] = doc.ROW_ID	                                 -- ������
inner join stack.[������ �� �����] opv on opv.[�������������-������]=so.ROW_ID
left join stack.[���� �����] tu on tu.ROW_ID = opv.[�������������-������]
left join stack.����������� isp on isp.ROW_ID = opv.[�������������-��]	   
where doc.[��� ���������]=67 and cast(doc.����	as date) = '2019-11-05' and doc.[��� �/�-�������] = -1	and ist.ROW_ID=500
group by  doc.����, ist.������������, isp.������������

----  ����� ��
SELECT doc.���� as [����], ist.������������ as ��������, isp.������������ as �����������, sum(opv.�����) as ����� 
 from Stack.�������� doc  inner join stack.����������� ist on ist.ROW_ID = doc.[��������-�������]		-- �������� ��������
inner join stack.[������ ������] so on so.[������-������] = doc.ROW_ID	                                 -- ������
inner join stack.[������ �� �����] opv on opv.[�������������-������]=so.ROW_ID
left join stack.[���� �����] tu on tu.ROW_ID = opv.[�������������-������]
left join stack.����������� isp on isp.ROW_ID = opv.[�������������-��]	   
where doc.[��� ���������]=67 and cast(doc.����	as date) = '2019-11-06' and doc.[��� �/�-�������] = -1	and ist.ROW_ID=451
group by  doc.����, ist.������������, isp.������������