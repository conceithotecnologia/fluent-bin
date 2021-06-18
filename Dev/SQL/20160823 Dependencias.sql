select * from ss002 limit 100

select * from ss009 where codtable = 'SS002'
select * from ss012 where codtable = 'SS002' order by order_

select * from ss018 limit 100


select sys_00026('00001002f')

select d.obj_id, o.*
  from ss122 d
       join ss018 o
         on o.obj_id = d.obj_dep
 where d.obj_id = '00001002f'
 order by o.type_, o.obj_id 

select * from ss018 where type_ = 'T' limit 100

select * from ss121 limit 100

 
select * from a000000001 
select obj_id from ss012 where codtable = 'A00' and columnname = 'F1_CODNAT' 