delete 
  from ss036 
 where recno in (
   select recno 
     from ss036 
    where codtable in ('SCP', 'SCS', 'SCR', 'SCO', 'SB2', 'SBE', 'SCQ', 'SCN')
   union
   select recno 
     from ss036 
    where rotina in ('MC_00051', 'MC_00006', 'MC_00007', 'MC_00011'));
 
drop table scp0000001 cascade;
drop table scs0000001 cascade;
drop table scr0000001 cascade;
drop table sco0000001 cascade;
drop table sb20000001 cascade;
drop table sbe0000001 cascade;
drop table scq0000001 cascade;
drop table scn0000001 cascade;
drop table sb80000000 cascade;
drop table sbb0000000 cascade;
drop table sze0000000 cascade;
drop table se80000000 cascade;
drop table se90000000 cascade;
drop table sea0000000 cascade;
drop table seb0000000 cascade;


select * from sco0000001 