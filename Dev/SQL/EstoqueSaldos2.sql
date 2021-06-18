select * from ss0270000000 

select '201412' ~ '^2{1}[0-9]{3}(0{1}[1-9]{1}|1{1}[0-2]{1})$'

drop table e030000001 
drop table e020000001 

alter table a490000001 add a49_competencia varchar(6)

alter table ss032 enable trigger all

select * from ss0270000000 

set session authorization "52a7d18e4f6c5626c083bbcc173b8947"
set session authorization "postgres"
alter table a490000001 disable trigger all
update a490000001 set a49_competencia = to_char(a49_data, 'yyyymm')
alter table a490000001  enable trigger all

select * from e030000001 
truncate table e030000001;

select mc_008460000001()

select a49_competencia, a2h_cod, sum(sys_iif(a49_tipo = 1, a49_custot_u1, 0)) as a49_custoe_u1, sum(sys_iif(a49_tipo = 2, a49_custot_u1, 0)) as a49_custos_u1,
       sum(sys_iif(a49_tipo = 1, a49_custot_u2, 0)) as a49_custoe_u2, sum(sys_iif(a49_tipo = 2, a49_custot_u2, 0)) as a49_custos_u2
  from a490000001 
 where a49_estado = 2 
 group by a49_competencia, a2h_cod
 order by a49_competencia, a2h_cod
 
select * from a490000001
select b1_codpro, a49_data, a2h_cod, a49_tipo, a49_competencia,
           a49_qtdu1, a49_custot_u1, a49_qtdu2, a49_custot_u2, a49_estado 
      from a490000001 
     order by a49_data, b1_codpro, a2h_cod, a49_tipo;



select a49_competencia, a2h_cod, sum(sys_iif(a49_tipo = 1, a49_custot_u1, 0)) as a49_custoe_u1, 
             sum(sys_iif(a49_tipo = 2, a49_custot_u1, 0)) as a49_custos_u1,
             sum(sys_iif(a49_tipo = 1, a49_custot_u2, 0)) as a49_custoe_u2, 
             sum(sys_iif(a49_tipo = 2, a49_custot_u2, 0)) as a49_custos_u2
        from a490000001
       where a49_estado = 2 
       group by a49_competencia, a2h_cod
       order by a49_competencia, a2h_cod



select a49_competencia, sum(sys_iif(a49_tipo = 1, a49_custot_u1, 0)) as a49_custoe_u1, 
             sum(sys_iif(a49_tipo = 2, a49_custot_u1, 0)) as a49_custos_u1,
             sum(sys_iif(a49_tipo = 1, a49_custot_u2, 0)) as a49_custoe_u2, 
             sum(sys_iif(a49_tipo = 2, a49_custot_u2, 0)) as a49_custos_u2
        from a490000001
       where a49_estado = 2 
       group by a49_competencia
       order by a49_competencia