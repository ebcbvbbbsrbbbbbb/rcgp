use it_gh
  go 
   DECLARE		
	@name varchar(64)
	
DECLARE cBldn CURSOR FOR
SELECT mc.name
FROM [MANAGEMENT_COMPANIES] mc
  where mc.MANAGEMENT_COMPANY_ID>24 and mc.NAME not like '-%'
  and mc.MANAGEMENT_COMPANY_ID not in (64,63,101,104)

OPEN cBldn
	FETCH NEXT FROM cBldn INTO @name
	   WHILE @@FETCH_STATUS =0
	   BEGIN   	   	
	  exec AdmInsertNewPartner @name;
	   FETCH NEXT FROM cBldn INTO  @name
       END;  		
CLOSE cBldn
DEALLOCATE cBldn  		


insert into partner_property_sets 
(partner_id,partner_property_id,property_value)
select p.partner_id,'account',mc.ACCOUNTING from PARTNERS p
inner join MANAGEMENT_COMPANIES mc on mc.NAME=p.name
where NOT exists(select 1 from partner_property_sets ps where ps.partner_id=p.partner_id and ps.partner_property_id='account')


insert into partner_property_sets 
(partner_id,partner_property_id,property_value)
select p.partner_id,'bank',mc.BANK from PARTNERS p
inner join MANAGEMENT_COMPANIES mc on mc.NAME=p.name
where NOT exists(select 1 from partner_property_sets ps where ps.partner_id=p.partner_id and ps.partner_property_id='bank')

insert into partner_property_sets 
(partner_id,partner_property_id,property_value)
select p.partner_id,'bik',mc.BIK from PARTNERS p
inner join MANAGEMENT_COMPANIES mc on mc.NAME=p.name
where NOT exists(select 1 from partner_property_sets ps where ps.partner_id=p.partner_id and ps.partner_property_id='bik')

insert into partner_property_sets 
(partner_id,partner_property_id,property_value)
select p.partner_id,'fullname',mc.NAME from PARTNERS p
inner join MANAGEMENT_COMPANIES mc on mc.NAME=p.name
where NOT exists(select 1 from partner_property_sets ps where ps.partner_id=p.partner_id and ps.partner_property_id='fullname')

insert into partner_property_sets 
(partner_id,partner_property_id,property_value)
select p.partner_id,'inn',mc.INN from PARTNERS p
inner join MANAGEMENT_COMPANIES mc on mc.NAME=p.name
where NOT exists(select 1 from partner_property_sets ps where ps.partner_id=p.partner_id and ps.partner_property_id='inn')

insert into partner_property_sets 
(partner_id,partner_property_id,property_value)
select p.partner_id,'kpp',mc.KPP from PARTNERS p
inner join MANAGEMENT_COMPANIES mc on mc.NAME=p.name
where NOT exists(select 1 from partner_property_sets ps where ps.partner_id=p.partner_id and ps.partner_property_id='kpp')
insert into partner_property_sets 
(partner_id,partner_property_id,property_value)
select p.partner_id,'shortname',mc.NAME from PARTNERS p
inner join MANAGEMENT_COMPANIES mc on mc.NAME=p.name
where NOT exists(select 1 from partner_property_sets ps where ps.partner_id=p.partner_id and ps.partner_property_id='shortname')

insert into partner_property_sets 
(partner_id,partner_property_id,property_value)
select p.partner_id,'uadrress',mc.ADDRESS from partner_property_sets  p
inner join MANAGEMENT_COMPANIES mc on mc.NAME=p.property_value
where p.partner_property_id='shortname' and
NOT exists(select 1 from partner_property_sets ps where ps.partner_id=p.partner_id and ps.partner_property_id='uadrress')

  use it_gh
  update mc
  set mc.PARTNER_ID=p.partner_id
from  MANAGEMENT_COMPANIES mc 
  inner join partner_property_sets  p
 on mc.NAME=p.property_value
where p.partner_property_id='shortname' and mc.NAME=p.property_value
