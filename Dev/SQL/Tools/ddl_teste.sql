select t.codtable, t.modo, f.columnname, dt.fb_datatype, dt.pg_datatype, dt.required_length, dt.required_precision, 
			          f.size, f.precision, f.allownull, f.default_		         
  from ss009 t
       join ss012 f
	     on f.codtable = t.codtable
	   join ss085 ct
	     on ct.recno = f.content_type
	   join ss086 dt
	     on dt.datatype = ct.datatype			    
 where t.export = 1
   and t.view = 0 
   and t.status = 0
 order by t.codtable, f.order_, f.recno
 
 
select ddl_create_table(t.codtable, '0000', 1, 'fb') 
  from ss009 t       
 where t.export = 1
   and t.view = 0 
   and t.status = 0
 order by t.codtable;
 
 
select to_char(10, '(FM9999999')

select ddl_create_table('ss001', '0000', 1, 'fb');
select dml_select('ss001', '0000', 1, 'pgsql');



select * from ss086


select json_agg(dicionario)::text as tables
  from (
select row_to_json(tabelas, false) as table
  from (
select t.codtable alias, t.modo "mode", t.descricao "label", t.table_sys issystem, 
	   -- lista de campos
	   (select json_agg(campos) fields
		 from (select f.columnname, dt.fb_datatype, dt.pg_datatype, dt.required_length, dt.required_precision, 
			          f.size, f.precision, f.allownull, f.default_
		         from ss012 f
			          join ss085 ct
	                    on ct.recno = f.content_type
	                  join ss086 dt
	                    on dt.datatype = ct.datatype
			    where f.codtable = t.codtable
			 order by f.order_, f.recno) as campos),
		-- lista de índices				
		(select json_agg(indices) "indexes"
		 from (select i.index_, i.descript, i.fields, i.tipo, i.where_, i.ordem
		         from ss013 i			          
			    where i.codtable = t.codtable
			 order by i.ordem) as indices)										
  from ss009 t     
 where t.export = 1
   and t.view = 0
   and t.status = 0
   and t.codtable = 'SS009'					
  order by t.codtable) as tabelas) dicionario
  
drop schema flt cascade;
drop schema tmp cascade;
drop schema u00 cascade;
drop schema u01 cascade;

create schema flt;
create schema tmp;
create schema u00;
create schema u01;
 
set search_path to u00;
 
create table empresas 
 	(codigo serial not null,
	 nome varchar not null,
	constraint pk_empresas primary key(codigo));
	 
set search_path to u01;

create table funcionarios
 	(empresa integer not null,
	 funcionario integer not null,
	 nome varchar not null,
	 constraint pk_funcionarios primary key(empresa, funcionario));

set search_path to u01, u00, flt;

alter table funcionarios
	add constraint fk_funcionarios1 foreign key(empresa)
		references empresas(codigo);
 
show search_path
 
 create or replace function teste() returns void as
 $$
 begin
 	if not exists(
		select 1
	      from empresas
	     where codigo = 1)
	then
 		raise notice 'ricardo';
	else
		raise notice 'outra coisa';
	end if;
	
	set search_path to u00;
 end;
 $$
 language plpgsql;
 
 select teste();
 
 show SEARCH_path
 set search_path to "$user",public;
 
 