Освещение в самом КОНЦЕ!!!!! финпериода, с учётом начислений,поступлений и разовых
select * from
(
select '',47 tp,pl.OCC_ID,(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=217
and b.BLDN_NO='78'
--and oa.saldo=0
and pl.TYPE_ID='1008'
) qq
where newsaldo<>0

select * from
(
select '',49 tp,pl.OCC_ID,-(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=217
and b.BLDN_NO='78'
--and oa.saldo=0
and pl.TYPE_ID='1008'
) qq
where newsaldo<>0



--ТО
select * from
(
select '',3 tp,pl.OCC_ID,(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=107
and b.BLDN_NO='46'

and pl.TYPE_ID='1000'
) qq
where newsaldo<>0

--Д1 ТО
select * from
(
select '',5 tp,pl.OCC_ID,-(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=107
and b.BLDN_NO='46'

and pl.TYPE_ID='1000'
) qq
where newsaldo<>0

----
--мус
select * from
(
select ''q,75 tp,pl.OCC_ID,(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=107
and b.BLDN_NO='46'

and pl.TYPE_ID='1015'
) qq
where newsaldo<>0

--Д1  мус
select * from
(
select '',77 tp,pl.OCC_ID,-(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=107
and b.BLDN_NO='46'

and pl.TYPE_ID='1015'
) qq
where newsaldo<>0



-------
-- стар мусор
select * from
(
select ''q,39 tp,pl.OCC_ID,(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=107
and b.BLDN_NO='46'

and pl.TYPE_ID='1006'
) qq
where newsaldo<>0

--Д1  стар мусор
select * from
(
select ''q,41 tp,pl.OCC_ID,-(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=107
and b.BLDN_NO='46'

and pl.TYPE_ID='1006'
) qq
where newsaldo<>0



--------------
--капрем
 
select * from
(
select ''q,111 tp,pl.OCC_ID,(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID

where b.STREET_ID=107
and b.BLDN_NO='46'

--where b.STREET_ID=131
--and b.BLDN_NO='11Б'

and pl.TYPE_ID='капр'
) qq
where newsaldo<>0

---д1 капрем
select * from
(
select ''q, 113 tp,pl.OCC_ID,-(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID

where b.STREET_ID=107
and b.BLDN_NO='46'

--and oa.saldo=0
and pl.TYPE_ID='капр'
) qq
where newsaldo<>0




--капрем фжкх
 
select * from
(
select ''q,99 tp,pl.OCC_ID,(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID

where ((b.STREET_ID=368
and b.BLDN_NO in ('83А','65А'))
or(b.STREET_ID=311
and b.BLDN_NO in ('1А','6')))

--where b.STREET_ID=131
--and b.BLDN_NO='11Б'

and pl.TYPE_ID='1016'
) qq
where newsaldo<>0

---д1 капрем фжкх
select * from
(
select ''q, 133 tp,pl.OCC_ID,-(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID

where ((b.STREET_ID=368
and b.BLDN_NO in ('83А','65А'))
or(b.STREET_ID=311
and b.BLDN_NO in ('1А','6')))

--and oa.saldo=0
and pl.TYPE_ID='1016'
) qq
where newsaldo<>0

------------
-----------

--смета фжкх
 
select * from
(
select ''q,101 tp,pl.OCC_ID,(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID

where ((b.STREET_ID=368
and b.BLDN_NO in ('83А','65А'))
or(b.STREET_ID=311
and b.BLDN_NO in ('1А','6')))

--where b.STREET_ID=131
--and b.BLDN_NO='11Б'

and pl.TYPE_ID='1017'
) qq
where newsaldo<>0

---д1 смета фжкх
select * from
(
select ''q, 135 tp,pl.OCC_ID,-(pl.VALUE-pl.PAID+pl.ADDED+(select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID

where ((b.STREET_ID=368
and b.BLDN_NO in ('83А','65А'))
or(b.STREET_ID=311
and b.BLDN_NO in ('1А','6')))

--and oa.saldo=0
and pl.TYPE_ID='1017'
) qq
where newsaldo<>0










----------------
-----*********************
-----------------
----------------------------------------------------

В середине периода лучше до печати квитанций

use it_gh
--TO
select * from
(
select ';3' tp,pl.OCC_ID,((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=388
and b.BLDN_NO='31'
--and oa.saldo=0
and pl.TYPE_ID='1000'
) qq
where newsaldo<>0

--Д1 TO
select * from
(
select ';5' tp,pl.OCC_ID,-((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=388
and b.BLDN_NO='31'
--and oa.saldo=0
and pl.TYPE_ID='1000'
) qq
where newsaldo<>0

------------------
--ВМ
select * from
(
select ';75' tp,pl.OCC_ID,((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=388
and b.BLDN_NO='31'
--and oa.saldo=0
and pl.TYPE_ID='1015'
) qq
where newsaldo<>0

--Д1 ВМ
select * from
(
select ';77' tp,pl.OCC_ID,-((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=388
and b.BLDN_NO='31'
--and oa.saldo=0
and pl.TYPE_ID='1015'
) qq
where newsaldo<>0

---------------*************

--Капрем
select * from
(
select ';111' tp,pl.OCC_ID,((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=388
and b.BLDN_NO='31'
--and oa.saldo=0
and pl.TYPE_ID='капр'
) qq
where newsaldo<>0

--Д1 Капрем
select * from
(
select ';113' tp,pl.OCC_ID,-((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=388
and b.BLDN_NO='31'
--and oa.saldo=0
and pl.TYPE_ID='капр'
) qq
where newsaldo<>0
-------------


------------------
--Старый ВМ
select * from
(
select ';39' tp,pl.OCC_ID,((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=388
and b.BLDN_NO='31'
--and oa.saldo=0
and pl.TYPE_ID='1006'
) qq
where newsaldo<>0

--Д1 СтарыйВМ
select * from
(
select ';41' tp,pl.OCC_ID,-((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=388
and b.BLDN_NO='31'
--and oa.saldo=0
and pl.TYPE_ID='1006'
) qq
where newsaldo<>0

---------------*************
-------------
--Старый лифт
select * from
(
select ';55' tp,pl.OCC_ID,((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=487
and b.BLDN_NO='76/2'
--and oa.saldo=0
and pl.TYPE_ID='1009'
) qq
where newsaldo<>0

--Д1 Старый лифт
select * from
(
select ';57' tp,pl.OCC_ID,-((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=487
and b.BLDN_NO='76/2'
--and oa.saldo=0
and pl.TYPE_ID='1009'
) qq
where newsaldo<>0


--------------------
-------------------
-- лифт
select * from
(
select ';79' tp,pl.OCC_ID,((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=487
and b.BLDN_NO='76/2'
--and oa.saldo=0
and pl.TYPE_ID='лифт'
) qq
where newsaldo<>0

--Д1 лифт
select * from
(
select ';107' tp,pl.OCC_ID,-((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=487
and b.BLDN_NO='76/2'
--and oa.saldo=0
and pl.TYPE_ID='лифт'
) qq
where newsaldo<>0


-- свет
select * from
(
select ';47' tp,pl.OCC_ID,((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=487
and b.BLDN_NO='76/2'
--and oa.saldo=0
and pl.TYPE_ID='1008'
) qq
where newsaldo<>0

--Д1 свет
select * from
(
select ';49' tp,pl.OCC_ID,-((select oa.SALDO from OCC_ACCOUNTS oa where oa.OCC_ID=pl.OCC_ID and oa.SERVICE_ID=pl.TYPE_ID)-pl.PAID) newsaldo,' ' aa
from  [PAYM_LIST] pl
inner join occupations o on o.id=pl.OCC_ID
inner join FLATS f on f.ID=o.flat_id
inner join BUILDINGS b on b.ID=f.BLDN_ID
where b.STREET_ID=487
and b.BLDN_NO='76/2'
--and oa.saldo=0
and pl.TYPE_ID='1008'
) qq
where newsaldo<>0

