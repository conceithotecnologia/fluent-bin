select * from ss0270000000 

delete from ss0270000000 where coduser = 'MONITOR1'

select f.codtable, t.descricao, t.modo,   f.columnname, f.name,
       f.datatype, f.array_,    f.size,   f.precision,  f.allownull,  
       f.default_, t.view,      t.viewsql 
  from ss012 f
       join ss009 t
         on t.codtable = f.codtable
        and t.status = 0       
 where f.status = 0
   and f.codtable = 'SB1'
 order by f.codtable, f.order_
select * from sb10000000 
 select sys_00007('sb1', '0000', 1, null)
 select sys_00008('sao', '0000', 1, null)
 select sys_00009('0000', 1, null)

select * from ss012 
select * from pg_catalog.pg_constraint  where schemaname 

select * from pg_class where relname = 'pg_namespace'

select * from pg_catalog.pg_tables 

select c.codtable, c.constname, c.fields,     c.fktable, c.fkfields, 
       c.onupdate, c.ondelete,  c.check_stmt, c.tipo
  from ss032 c       
 where c.codtable = 'SB1'
   and not exists(
	select 1
          from pg_constraint con
               join pg_namespace nsp
                 on nsp.oid = con.connamespace
                and nsp.nspname  = 'tupi'
         where con.conname = lower(c.constname))
  order by c.tipo       

select nsp.nspname as schema, c.* 
  from pg_constraint c
       join pg_namespace nsp
         on nsp.oid = c.connamespace
        and nsp.nspname  = 'tupi';


select * from pg_indexes


select nsp.nspname as schema, c.* 
  from pg_class c
       join pg_namespace nsp
         on nsp.oid = c.relnamespace
 where nsp.nspname  = 'tupi_0000000';

show search_path