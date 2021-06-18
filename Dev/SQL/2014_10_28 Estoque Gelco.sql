select * from e020032001 
truncate table e020032001 

select * from e000032001 
select * from ss0270032000  

set session authorization "cb02ae1cc170a5468fd8008aae089868"

alter table e020032001 disable trigger all;

insert into e010032001 (b1_codpro, e00_data, e00_qtde_u1, e00_custoe_u1)
select a.b1_codpro, a.a3n_data, a.a3n_saldo, a.a3n_saldov
  from a3n0032001 a 
 where a.a3n_data = '2014-09-30'
   and a.a3n_saldo > 0


insert into e010032001 (b1_codpro, a2h_cod, e01_data, e01_qtde_u1, e01_custoe_u1)
select a.b1_codpro, b.a2h_cod, a.a3n_data, a.a3n_saldo, a.a3n_saldov
  from a3n0032001 a 
       join sb10032000 b
         on b.b1_codpro = a.b1_codpro
 where a.a3n_data = '2014-09-30'
   and a.a3n_saldo > 0


   
   
alter table e020032001 enable trigger all;

select * from a3n0032002  

select b1_codpro, to_char(a3n_data, 'yyyymm'), a3n_saldo, a3n_saldov, a3n_ssaldo, a3n_ssaldov
  from a3n0032001 
 where a3n_data = '2014-09-30'
   and a3n_ssaldo > 0
