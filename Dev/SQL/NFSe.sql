select * from nfk0000001 order by recno desc
delete from ss0270000000 where coduser = 'MONITOR1'
select * from ss0270000000 
set session authorization "52a7d18e4f6c5626c083bbcc173b8947"

update nfk0000001 set nfk_status_fat = 0 where recno = 273;
update nfk0000001 set nfk_status_fat = 1 where recno = 273;


select * from ss012 where codtable = 'NFK'

select * from ss034 where combo = 199

select * from nfb0000001 order by nfa_serial desc