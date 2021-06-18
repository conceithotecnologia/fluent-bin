select * from a120032001 where a12_data <= '2014-09-30' and a5r_recno is null


update a120032001 k
   set a5r_recno = o.a5r_recno
 from (  
select k.recno, m.recno as a5r_recno
  from a120032001 k
       join a490032001 o
         on o.codtable = k.codtable
	and o.a49_recno = k.a12_recno
       join a5r0032001 m
         on m.a49_recno = o.recno
 where k.codtable = 'A1B' 
--   and k.a12_data between '2014-05-27' and '2014-09-30'
   and k.a5r_recno is null ) o
where k.recno = o.recno


select k.*
  from a120032001 k
       join a490032001 o
         on o.codtable = k.codtable
	and o.a49_recno = k.a12_recno       
 where k.codtable = 'A1B' 
   and k.a12_data between '2014-05-27' and '2014-09-30'
   and k.a5r_recno is null



select * 
  from a120032001 k
  where k.codtable = 'A1B' 
    and k.a12_data between '2014-05-27' and '2014-09-30'
    and k.a5r_recno is null
    and not exists(
	select 1 
	  from a490032001 o
	 where o.codtable = 'A1B' 
	   and o.a49_data <= '2014-09-30'
	   and o.a49_recno = k.a12_recno)



	 select a49_data, *
	  from a490032001 o
	 where o.codtable = 'A1B' 
	   and o.a49_data <= '2014-09-30'
	 order by a49_emissao desc 

