select * from ss012 where codtable = 'SB3'

update sb30007001 set b3_bloq = 0
select * from a4a0007001 

select * from ss0270007000 

set session authorization "b794727ba102ff01bfe410e209c14ce6"

insert into a4a0007001 (recno, a4a_nome) values (1, 'Local')

select * from sb30007001 where b3_area = 2
delete from sb30007001 where b3_area = 2
alter table sb30007001 alter b3_nome type varchar(45)

delete from ss1010007000 where codtable = 'SCM'
delete from a3l0007000   where codtable = 'SEN'

delete 
  from a3l0007000
where recno in (  
select a.recno 
  from a3l0007000 a
 where not exists (
       select 1
         from ss114 b
        where b.codtable = a.codtable))

select * from a3l0007000 