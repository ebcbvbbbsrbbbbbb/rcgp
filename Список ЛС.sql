use it_gh
select --SUM(aa.KOLLS)
aa.* 
from
(select top 100000000 x.NAME ULICA, b.BLDN_NO DOM,f.FLAT_NO --,round(f.TOTAL_SQ,2)tottalsq,round(o.COMBINED_SQ,2)combsq
,o.REALLY_LIVE,o.ID LS
,b.FIAS_GUID
--rtrim(t.NAME) UCHASTOK
 from BUILDINGS b 
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  inner join FLATS f on f.BLDN_ID=b.ID
  inner join occupations o  on f.ID=o.flat_id
  inner join XSTREETS x on  x.ID=b.STREET_ID  
  where t.IS_HISTORY=1 and t.ID not in (54,24,100,28,38,22,21,77,46,71,85,98,67,6,101,109,108,64,112) 
  and b.TECHSUBDIV_ID=50
  and exists (select 1 from CONSMODES_LIST cl 
              inner join PAYM_LIST pl on pl.OCC_ID=o.ID and pl.TYPE_ID=cl.SERVICE_ID
             where cl.OCC_ID=o.ID and cl.MODE_ID % 1000<>0 
             and pl.VALUE<>0 
              and o.COMBINED_SQ>0.0001
             )
 )aa 

  order by 1,
	CASE
          WHEN PATINDEX ( '%[^0-9]%' , DOM ) = 0
	  THEN REPLICATE ( '0' , 7 - DATALENGTH ( DOM ) ) + DOM
          ELSE REPLICATE ( '0' , 8 - PATINDEX ( '%[^0-9]%' , DOM ) ) + DOM
	END,
		CASE
          WHEN PATINDEX ( '%[^0-9]%' , FLAT_NO ) = 0
	  THEN REPLICATE ( '0' , 7 - DATALENGTH ( FLAT_NO ) ) + FLAT_NO
          ELSE REPLICATE ( '0' , 8 - PATINDEX ( '%[^0-9]%' , FLAT_NO ) ) + FLAT_NO
	END


-------------------------
use it_gh
select --SUM(aa.KOLLS)
aa.* 
from
(select top 100000 x.NAME ULICA, b.BLDN_NO DOM,f.FLAT_NO,round(f.TOTAL_SQ,2)tottalsq,round(o.COMBINED_SQ,2)combsq,o.REALLY_LIVE,o.ID LS
--rtrim(t.NAME) UCHASTOK
 from BUILDINGS b 
  inner join TECH_SUBDIVISIONS t on t.ID=b.TECHSUBDIV_ID  
  inner join FLATS f on f.BLDN_ID=b.ID
  inner join occupations o  on f.ID=o.flat_id
  inner join XSTREETS x on  x.ID=b.STREET_ID  
  where t.IS_HISTORY=1 and t.ID not in (54,24,100,28,38,22,21,77,46,71,85,98,67,6,101,109,108,64,112) 
  and exists (select 1 from CONSMODES_LIST cl 
              inner join PAYM_LIST pl on pl.OCC_ID=o.ID and pl.TYPE_ID=cl.SERVICE_ID
             where cl.OCC_ID=o.ID and cl.MODE_ID % 1000<>0 
             and pl.VALUE<>0 
              and o.COMBINED_SQ>0.0001
             )
 )aa 

  order by 1,
	CASE
          WHEN PATINDEX ( '%[^0-9]%' , DOM ) = 0
	  THEN REPLICATE ( '0' , 7 - DATALENGTH ( DOM ) ) + DOM
          ELSE REPLICATE ( '0' , 8 - PATINDEX ( '%[^0-9]%' , DOM ) ) + DOM
	END,
		CASE
          WHEN PATINDEX ( '%[^0-9]%' , FLAT_NO ) = 0
	  THEN REPLICATE ( '0' , 7 - DATALENGTH ( FLAT_NO ) ) + FLAT_NO
          ELSE REPLICATE ( '0' , 8 - PATINDEX ( '%[^0-9]%' , FLAT_NO ) ) + FLAT_NO
	END
