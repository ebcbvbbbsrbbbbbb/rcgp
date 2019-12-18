SELECT TOP 1000 [LS]
      ,[ADRES]
      ,[FIO]
      ,[PROP]
      ,[JIV]
      ,[SALL]
      ,[SOTOP]
      ,[SJIL]
      ,[KV]
  FROM [it_gh].[dbo].[ALEXINA30]


--Установить  общие площади
use it_gh
DECLARE		
	@plos decimal(16,6),
	@fl_id int;
DECLARE cOcc CURSOR FOR
select distinct a.sall ,f.id
 from  FLATS f 
inner join  [it_gh].[dbo].[ALEXINA30] a on a.kv=f.flat_no 
  inner join BUILDINGS b on b.ID=f.BLDN_ID 
  inner join xSTREETS s on s.ID=b.STREET_ID  
  where b.TECHSUBDIV_ID in (36)
  and b.id=6211077
 OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @plos,@fl_id

	WHILE @@FETCH_STATUS =0
		BEGIN
		
	    exec CliSquareTotalSet @fl_id,@plos
	   	   
	FETCH NEXT FROM cOcc INTO  @plos,@fl_id
    END;  
		
CLOSE cOcc
DEALLOCATE cOcc  
-------------
--------Вставить ЛС

   DECLARE			
	@occ int,
	@pl numeric(18,2),
	@flid int
	;	
DECLARE cBldn CURSOR FOR
SELECT a.occ,f.ID,a.sall 
  from FLATS f 
  inner join  [it_gh].[dbo].[ALEXINA30] a on a.kv=f.flat_no  
  where  f.BLDN_ID=6211077 
OPEN cBldn
	FETCH NEXT FROM cBldn INTO  @occ,@flid,@pl
	   WHILE @@FETCH_STATUS =0
	   BEGIN   	   
	  print  @occ;
	  exec CliOccNewIns @flid,@occ,'муни','отдк','прив',@pl,null, 0, 0, 0
	   FETCH NEXT FROM cBldn INTO  @occ,@flid,@pl
       END;  		
CLOSE cBldn
DEALLOCATE cBldn
  	
----------------

go
--Прописать людей
   DECLARE			
	@occ int,
	@vidprop char(4),
	@kolch int,
	@flid int,
	@fam varchar(32),
	@im varchar(32),
	@ot varchar(32),
	@fio varchar(50),
	@kolprop int,	
	@curpos int	,
	@tmpfio varchar(50)
	;
	
DECLARE cBldn CURSOR FOR
SELECT a.occ,f.ID,a.fio,isnull(a.jiv,0 )chel 
  from FLATS f 
  inner join occupations o on o.flat_id=f.id
  inner join  [it_gh].[dbo].[ALEXINA30] a on a.occ=o.id
  where  f.BLDN_ID=6211077 

OPEN cBldn
	FETCH NEXT FROM cBldn INTO  @occ,@flid,@fio,@kolch
	   WHILE @@FETCH_STATUS =0
	   BEGIN 
	   set @tmpfio=@fio
	   set @curpos = CHARINDEX(' ',@fio,1);
	   set @fam=LEFT(@fio,@curpos);
	   set @fio=ltrim(SUBSTRING(@fio,@curpos,LEN(@fio)));
	   
	   set @curpos = CHARINDEX(' ',@fio,1);
	   if @curpos=0 set @curpos=LEN(@fio);
	   set @im=LEFT(@fio,@curpos);
	   set @ot=ltrim(SUBSTRING(@fio,@curpos,LEN(@fio)));
	   
	   print  'FIO= '+@tmpfio+'  FAM= '+@fam+'   IM= '+@im+'  OT= '+@ot;	   
	   if (@kolch=0) set @vidprop='влад' 
	      else set @vidprop='пост' 
	  -- exec CliPeopleIns @flid,@occ,@fam,@im,@ot,null,@vidprop,'отвл', null, 0, NULL, NULL, NULL, 0, '01/10/2014'
	   set @kolprop=1
	   if (@kolch>1)
	   while (@kolprop<@kolch)
	    begin
	    print @kolch
	   -- exec CliPeopleIns @flid,@occ,@fam,@im,@ot,null,@vidprop,'????', null, 0, NULL, NULL, NULL, 0, '01/10/2014'
	    set @kolprop=@kolprop+1
	    end
	 
	   FETCH NEXT FROM cBldn INTO  @occ,@flid,@fio,@kolch
       END;  		
CLOSE cBldn
DEALLOCATE cBldn  
-----------

---ФИО
  update l
set fam= case when b.fam_last > a.fam_first then substring(n.fio, a.fam_first, b.fam_last - a.fam_first + 1) else '' end ,
im=case when c.im_first <n.len_fio then substring(n.fio, c.im_first,  d.im_last  - c.im_first  + 1) else '' end,
otch=right(rtrim(ltrim(n.fio)) , n.len_fio - d.im_last)
 --select *
 from     
    [it_gh].[dbo].[ALEX30FIO] l
    inner join 
      (select kv, fio, len(fio) as len_fio from [it_gh].[dbo].[ALEX30FIO]) n on n.kv=l.kv
     cross apply (select patindex('%[^ ]%', n.fio) as fam_first) a
     cross apply (select isnull(nullif(charindex(' ', n.fio, a.fam_first), 0) - 1, n.len_fio) as fam_last) b
     cross apply (select patindex('%[^ ]%', substring(n.fio, b.fam_last + 1, n.len_fio)) + b.fam_last as im_first) c
     cross apply (select isnull(nullif(charindex(' ', n.fio, c.im_first), 0) - 1, n.len_fio) as im_last) d;  


update af
set af.occ=a.occ
from
[it_gh].[dbo].[ALEX30FIO] af
inner join [it_gh].[dbo].[ALEXINA30] a on a.KV=af.kv

------ ФИО ответственных обновить
use it_gh
update p
set p.[LAST_NAME]=l.FAM
,p.[FIRST_NAME]=l.im
,p.[SECOND_NAME]=l.OTCH

--select l.fam,l.im,l.otch, p.* 
from [it_gh].[dbo].[PEOPLE] p 
  inner join OCCUPATIONS  o on  p.occ_id=o.id
   inner join  [it_gh].[dbo].[ALEX30FIO] l on o.ID=l.OCC   
  inner join FLATS f on f.ID=o.flat_id
  inner join BUILDINGS b on b.ID=f.BLDN_ID     
where p.[WHO_ID]='отвл' and  b.TECHSUBDIV_ID in (36) and
(
 p.[LAST_NAME]<>l.FAM
or p.[FIRST_NAME]<>l.IM
or p.[SECOND_NAME]<>l.OTCH
   )  

