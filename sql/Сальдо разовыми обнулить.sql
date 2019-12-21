----Сальдо ПТС другого месяца
use it_gh
DECLARE	
	@occ int,
	@summa money,
	@servid char(4);
	
DECLARE cOcc CURSOR FOR
SELECT o.id,oa.SERVICE_ID,-(oa.SALDO)sm
  FROM occupations o 
inner join pskovNN ..OCC_ACCOUNTS oa on oa.OCC_ID=o.id ---and oa.SALDO<>0
inner join PAYM_LIST pl on pl.OCC_ID=o.id and pl.TYPE_ID=oa.SERVICE_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join XSTREETS x on x.ID=b.STREET_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=oa.SERVICE_ID
inner join SUPPLIERS su on su.SERVICE_ID=cl.SERVICE_ID and su.ID=cl.source_id and su.SUP_ACCEPT_ID=4
where t.IS_HISTORY=1 --and b.TECHSUBDIV_ID in (81)
and cl.MANAGEMENT_COMPANY_ID=81
 and b.ID in (3900019,3900021,5640015)
--and oa.SERVICE_ID in('отоп')
and oa.saldo<0
/*and NOT exists(select 1 from CONSMODES_LIST cl2 
inner join SUPPLIERS su2 on su2.SERVICE_ID=cl2.SERVICE_ID and su2.ID=cl2.source_id and su2.SUP_ACCEPT_ID=4
inner join pskovNN..OCC_ACCOUNTS oa2 on oa2.OCC_ID=o.id and oa2.SERVICE_ID=cl2.SERVICE_ID
where cl2.OCC_ID=o.ID and oa2.saldo>0
)*/

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa

	WHILE @@FETCH_STATUS =0
		BEGIN 
        exec ad_SetTechCorrectWitchDoc @occ,@servid,19,@summa      -- 15 - Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc      

-----------------------------------
----------------------------
---По воде с учетом платежей и разовых по дату платежа
use it_gh
DECLARE	
	@occ int,
	@summa money,
	@servid char(4);
	
DECLARE cOcc CURSOR FOR
SELECT o.id,oa.SERVICE_ID,-(oa.saldo+pl.ADDED-ISNULL(ms.summa,0)+pl.value)sm
  FROM occupations o 
inner join pskovNN..OCC_ACCOUNTS oa on oa.OCC_ID=o.id ---and oa.SALDO<>0
inner join pskovNN..PAYM_LIST pl on pl.OCC_ID=o.id and pl.TYPE_ID=oa.SERVICE_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join XSTREETS x on x.ID=b.STREET_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
inner join CONSMODES_LIST cl on cl.OCC_ID=o.ID and cl.SERVICE_ID=oa.SERVICE_ID
inner join SUPPLIERS su on su.SERVICE_ID=cl.SERVICE_ID and su.ID=cl.source_id and su.SUP_ACCEPT_ID=9
left join (select mp.OCC_ID,mp.SERVICE_ID, SUM(mp.VALUE) summa from pskovNN..MONTHS_PAID mp 
                where mp.DAY<'2019-04-16' ---Указывать следующий день, т.к. тип данных вместе со временем 
                group by mp.OCC_ID,mp.SERVICE_ID ) ms on  ms.OCC_ID=o.ID and ms.SERVICE_ID=oa.SERVICE_ID
where t.IS_HISTORY=1 --and b.TECHSUBDIV_ID in (81)
and cl.MANAGEMENT_COMPANY_ID in (87,76)
 --and b.ID in (3700014,3700032)
--and oa.SERVICE_ID in('хвод','1012','1019','1021','1013','хво2','хво3','кхво','кхв2','кхв3','2013','2012','3012','2019','2021','китх','кит2')
and oa.saldo+pl.ADDED-ISNULL(ms.summa,0)+pl.value<0

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa

	WHILE @@FETCH_STATUS =0
		BEGIN 
        exec ad_SetTechCorrectWitchDoc @occ,@servid,15,@summa      -- 15 - Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc      







-------------------
use it_gh
DECLARE	
	@occ int,
	@summa money,
	@servid char(4);
	
DECLARE cOcc CURSOR FOR
SELECT o.id,oa.SERVICE_ID,-(oa.SALDO-pl.PAID+pl.ADDED)sm
  FROM occupations o 
inner join OCC_ACCOUNTS oa on oa.OCC_ID=o.id ---and oa.SALDO<>0
inner join PAYM_LIST pl on pl.OCC_ID=o.id and pl.TYPE_ID=oa.SERVICE_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join XSTREETS x on x.ID=b.STREET_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
--inner join [PRINTKVIT] pk on pk.H1=o.id
where t.IS_HISTORY=1  and b.TECHSUBDIV_ID in (24,28,38,21,22,54,51,77,71,85,6,67,98,46)
and oa.SERVICE_ID in('1000','1004','1006','1008','1009','1012','1013','1014','1015','1016','1017','1019','1020','1021',
    '2008','анте','вывм','капр','лифт','найм','освл','отоп','пгаз','хвод','элво','элек','элпл','кх54','хв54','взно')
and oa.saldo-pl.PAID+pl.ADDED<>0

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa

	WHILE @@FETCH_STATUS =0
		BEGIN 
        exec ad_SetTechCorrectWitchDoc @occ,@servid,15,@summa      -- 15 - Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc      


------------------
--НА долговые услуги 
use it_gh
DECLARE	
	@occ int,
	@summa money,
	@servid char(4);
	
DECLARE cOcc CURSOR FOR
SELECT o.id,oa.SERVICE_ID,-(oa.SALDO-pl.PAID+pl.ADDED)sm
  FROM occupations o 
inner join OCC_ACCOUNTS oa on oa.OCC_ID=o.id ---and oa.SALDO<>0
inner join consmodes_list cl on cl.occ_id=oa.occ_id and cl.service_id=oa.service_id
inner join PAYM_LIST pl on pl.OCC_ID=o.id and pl.TYPE_ID=oa.SERVICE_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join XSTREETS x on x.ID=b.STREET_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
--inner join [PRINTKVIT] pk on pk.H1=o.id
where t.IS_HISTORY=1  --and b.TECHSUBDIV_ID in (41,91,24,28,38,21,22,77,85)
 and cl.management_company_iD in (41,91,24,28,38,21,22,77,6,67,85,89,46,32)
and oa.SERVICE_ID in(--'1000','1004','1006','1008','1009','1012','1013','1014','1015','1016','1017','1019','1020','1021',
    --'2008','анте','вывм','капр','лифт','найм','освл','отоп','пгаз','хвод','элво','элек','элпл','кх54','хв54',
     --Долг1  1022 
 '1022','1023','1024','1025','1026','1027','1028','1029','1030','1031','1032','1033','1034','1035','1036',
  '1037','1038','1039','1040','1041','1042','1043',
  
-- Долг2 1044  
 '1044','1045','1046','1047','1048','1049','1050','1051','1052','1053','1054','1055','1056','1057','1058',
  '1059','1060','1061','1062','1063','1064','1065')
   
and oa.saldo-pl.PAID+pl.ADDED<>0

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa

	WHILE @@FETCH_STATUS =0
		BEGIN 
        exec ad_SetTechCorrectWitchDoc @occ,@servid,12,@summa      -- 15 - Номер док получить по exec ad_GetDocsList 1
	    FETCH NEXT FROM cOcc INTO  @occ,@servid,@summa
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc      