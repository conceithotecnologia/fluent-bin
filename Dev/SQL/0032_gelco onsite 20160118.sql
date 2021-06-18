set session authorization postgres;
alter table sb10032000 disable trigger all;
update sb10032000 set b1_estocavel = 0 where b4_codfam = 4;
alter table sb10032000 enable trigger all;



select * from sb40032000 

alter table sbf0032001 disable trigger all;
update sbf0032001 b 
   set sbf_estocavel = 0 
  from sb10032000 a
 where a.b1_codpro = b.b1_codpro
   and a.b4_codfam = 4;
alter table sbf0032001 enable trigger all;


alter table sbf0032002 disable trigger all;
update sbf0032002 b 
   set sbf_estocavel = 0 
  from sb10032000 a
 where a.b1_codpro = b.b1_codpro
   and a.b4_codfam = 4;
alter table sbf0032002 enable trigger all;


select sag_estoque from sag0032001 where recno = 3930


select * from ss0270032000 

set session authorization cb02ae1cc170a5468fd8008aae089868

select mc_setflag0032001('SAG', 3933);
select mc_setflag0032001('SAG', 3934);
update sag0032001 set sag_estoque = 0, sag_qtdlib = sag_qtd,  sag_qtdlibsld = 0, sag_estado = 3 where recno in (3933, 3934)
select mc_delflag0032001('SAG', 3930);
select mc_delflag0032001('SAG', 3933);
select mc_delflag0032001('SAG', 3934);


 new.sag_qtdlib := new.sag_qtd; -- disponibiliza toda quantidade para faturamento
               new.sag_qtdlibsld := 0; -- impede que o item gerar liberações de estoque
               new.sag_estado := 3;

select * from sam0032001 limit 100


select * from saj0032001 where recno in (5894, 5895)