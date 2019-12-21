/*
Пересчет единиц для услуг ОДН по домовым счетчикам,
в случае если дельта положительная.

Не учитываются закрытые ЛС и без начислений. Надо проверить
*/
use it_gh
DECLARE	
	@occ int,
	@summa money,
	@servid char(4),
	@NewCnUnits decimal(16,6),
	@domschet decimal(16,6),
	@ODNdelta decimal(16,6),
	@Sob decimal(16,6);
	
set @domschet=643.012     --Домовое потребление по ОДН счетчику
select @ODNdelta=88.911   --Дельта ОДН уже посчитанная
select @Sob=6178.60       -- Площадь всех жилых и нежилых помещений
set @servid='хпод'	;     --По услуге ОДН      хпод  пдод


create table #lsper
(occ_id int,
Sunits decimal(16,6),
Cnunits decimal(16,6),
CnunitsNew decimal(16,6)
)


insert into #lsper
(occ_id ,
Sunits ,
Cnunits)
SELECT o.id,
  cl.UNITS,cl.CNTR_UNITS 
  FROM occupations o
inner join [CONSMODES_LIST] cl on cl.OCC_ID=o.id 
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID
where t.IS_HISTORY=1 
and cl.CNTR_BIT=4 and
cl.SERVICE_ID=@servid and
b.ID=761013 -- бастионная 13а

update #lsper
set CnunitsNew=@ODNdelta*Sunits/@Sob;

--select * from #lsper

DECLARE cOcc CURSOR FOR
SELECT l.occ_id,l.CnunitsNew
  FROM #lsper l  

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@NewCnUnits

	WHILE @@FETCH_STATUS =0
		BEGIN 
		print cast(@occ as varchar(12))+' - '+cast(@NewCnUnits as varchar(18))
        update [CONSMODES_LIST]
        set CNTR_UNITS=@NewCnUnits,
        NORMA=0,
        EX_NORMS=@NewCnUnits
        where OCC_ID=@occ and SERVICE_ID=@servid
        
	    FETCH NEXT FROM cOcc INTO  @occ,@NewCnUnits
        END;  
		
CLOSE cOcc
DEALLOCATE cOcc      



drop table  #lsper