alter table sb10032000 disable trigger all;
alter table sbf0032001 disable trigger all;
update sb10032000 set b1_estocavel = 1 where b1_codpro in ('A20020', 'A25030', 'A27540', 'CHP002');
update sbf0032001 set sbf_estocavel = 1 where b1_codpro in ('A20020', 'A25030', 'A27540', 'CHP002');
alter table sb10032000 enable trigger all;
alter table sbf0032001 enable trigger all;

select * from ss0270032000 where coduser = 'VOLIVEIRA'




select * from sag0032001 where saf_codped in (9121, 9123)
set session authorization "postgres"
alter table sag0032001 disable trigger all;
set session authorization "d8fbc267b744fe02667d93b0b9bd8b1b";
update sag0032001 
   set sag_qtdlib = sag_qtd, sag_qtdfat = sag_qtd, sag_qtdlibsld = 0, sag_estado = 3, 
       sag_estoque = 0
 where saf_codped in (9144 );
set session authorization "postgres";
alter table sag0032001 enable trigger all;

select * from ng40032001

select * from ss012 where codtable = 'NG4'

alter table ss012 disable trigger all;
update ss012 set size = 12 where recno = 33037;
alter table ss012 enable trigger all;
select * from e000032001