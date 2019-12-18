use it_gh
--ЛС, где не совпадает начисление по ХВП и подогреву
SELECT TOP 1000 cl.*
  FROM [CONSMODES_LIST] cl
  where cl.SERVICE_ID='1014' 
  and cl.CNTR_BIT>0
  and not exists(select 1 from .[CONSMODES_LIST] cl2 
                   inner join  [COUNTER_LIST] cnl on cnl.OCC_ID=cl2.OCC_ID and cnl.SERVICE_ID=cl2.SERVICE_ID
                   inner join [COUNTERS] c on c.COUNTER_ID=cnl.COUNTER_ID  
                  where --and cnl.CNTR_TYPE_ID in (1,2) and
                  cl2.SERVICE_ID='1004' and cl2.OCC_ID=cl.OCC_ID and abs(cl2.CNTR_UNITS-cl.CNTR_UNITS*c.SCALE)<0.01 )


select cn.* ,c2.GROUP_VOLUME from 
[COUNTER_LIST] cn
inner join COUNTERS c2 on c2.COUNTER_ID=cn.COUNTER_ID 
where NOT exists(select 1 from COUNTERS c where c.COUNTER_ID=cn.COUNTER_ID and c.GROUP_VOLUME=cn.ACTUAL_UNITS )	
and cn.CNTR_TYPE_ID in (1,2)
and c2.last_set  in (2, 10, 12) -- Кроме новых счетчиков, счетчиков на поверке и счетчиков поставленных обратно после поверки
and cn.ACTUAL_UNITS>0
order by cn.OCC_ID


------------
exec pAdmRepairCountersVolume;
---------

use it_gh
declare 
@counter_id int,
@gvolume decimal(16,6),
@occ int,
@servid char(4),
@res int;

DECLARE cOcc CURSOR FOR

select cn.occ_id,cn.service_id,cn.counter_id ,c2.GROUP_VOLUME from 
[COUNTER_LIST] cn
inner join COUNTERS c2 on c2.COUNTER_ID=cn.COUNTER_ID 
where NOT exists(select 1 from COUNTERS c where c.COUNTER_ID=cn.COUNTER_ID and c.GROUP_VOLUME=cn.ACTUAL_UNITS )	
and cn.CNTR_TYPE_ID in (1,2)
and c2.last_set  in (2, 10, 12) -- для новых счетчиков, счетчиков на поверке и счетчиков поставленных обратно после поверки
and cn.ACTUAL_UNITS>0
order by cn.OCC_ID

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid,@counter_id,@gvolume
	WHILE @@FETCH_STATUS =0
	   BEGIN   	 
           print 'LS= '+cast(@occ as varchar(10))+' serv= '+@servid	  
	   update cn
	   set CN.ACTUAL_UNITS=@gvolume
	   from [COUNTER_LIST] cn
	   where cn.COUNTER_ID=@counter_id and cn.OCC_ID=@occ and cn.SERVICE_ID=@servid
      
       update CL
       set cl.CNTR_UNITS=(select SUM(c2.GROUP_VOLUME) from [COUNTER_LIST] cn 
                          inner join COUNTERS c2 on c2.COUNTER_ID=cn.COUNTER_ID 
                          where cn.OCC_ID=@occ and cn.SERVICE_ID=@servid
                          and cn.CNTR_TYPE_ID in (1,2)
                          )
       from CONSMODES_LIST CL 
       where cl.OCC_ID=@occ and cl.SERVICE_ID=@servid
       and cl.CNTR_BIT>0
       	            
       exec @res=[pSetCalcByOcc]  @occ;
	   FETCH NEXT FROM cOcc INTO  @occ,@servid,@counter_id,@gvolume
 	   END;
		
CLOSE cOcc
DEALLOCATE cOcc

---------------

go

use it_gh
declare 
@occ int,
@servid char(4),
@res int;

DECLARE cOcc CURSOR FOR

SELECT cl.occ_id,cl.service_id
  FROM [CONSMODES_LIST] cl
  where cl.SERVICE_ID='1014' 
  and cl.CNTR_BIT>0
  and not exists(select 1 from .[CONSMODES_LIST] cl2 
                   inner join  [COUNTER_LIST] cnl on cnl.OCC_ID=cl2.OCC_ID and cnl.SERVICE_ID=cl2.SERVICE_ID
                   inner join [COUNTERS] c on c.COUNTER_ID=cnl.COUNTER_ID  
                  where  cl2.SERVICE_ID='1004' and cl2.OCC_ID=cl.OCC_ID and abs(cl2.CNTR_UNITS-cl.CNTR_UNITS*c.SCALE)<0.001 )
order by cl.OCC_ID

OPEN cOcc
	FETCH NEXT FROM cOcc INTO  @occ,@servid
	WHILE @@FETCH_STATUS =0
	   BEGIN   
	   if @servid='1014' set @servid='1004' 
	   print 'LS= '+cast(@occ as varchar(10))+' serv= '+@servid
	   update cn
	   set CN.ACTUAL_UNITS=(select c2.GROUP_VOLUME_10 from COUNTERS c2 where c2.COUNTER_ID=cn.COUNTER_ID )
	   from [COUNTER_LIST] cn	   
	   where cn.OCC_ID=@occ and cn.SERVICE_ID=@servid
       and cn.CNTR_TYPE_ID in (1,2)
       
       update CL
       set cl.CNTR_UNITS=(select SUM(c2.GROUP_VOLUME) from [COUNTER_LIST] cn 
                          inner join COUNTERS c2 on c2.COUNTER_ID=cn.COUNTER_ID 
                          where cn.OCC_ID=@occ and cn.SERVICE_ID=@servid
                          and cn.CNTR_TYPE_ID in (1,2)
                          )
       from CONSMODES_LIST CL 
       where cl.OCC_ID=@occ and cl.SERVICE_ID=@servid
       and cl.CNTR_BIT>0
       	            
       exec @res=[pSetCalcByOcc]  @occ;
	   FETCH NEXT FROM cOcc INTO  @occ,@servid
 	   END;
		
CLOSE cOcc
DEALLOCATE cOcc
