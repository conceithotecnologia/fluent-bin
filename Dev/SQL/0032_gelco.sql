delete from ss0270032000;
update ss0470032000 set session_recno = null where session_recno is not null;
update ss0630032000 set sfj_pessoa = 0 where cnpj = '10681186000145';
update ss0630032000 set sfj_pessoa = 1607 where cnpj = '10681186000226';

--alter table a1b0032001 disable trigger all;
--alter table a1b0032001 add a4i_tipo integer;
--alter table a1b0032001 enable trigger all;

--alter table a1b0032002 disable trigger all;
--alter table a1b0032002 add a4i_tipo integer;
--alter table a1b0032002 enable trigger all;

drop table f100032001 cascade;
drop table f100032002 cascade;
drop table f730032001 cascade;
drop table f730032002 cascade;
drop table f880032001 cascade;
drop table f880032002 cascade;
drop table sdy0032001 cascade;
drop table sdy0032002 cascade;


alter table sag0032001 alter f8_cfop type varchar(4);
alter table sag0032002 alter f8_cfop type varchar(4);

alter table a1b0032001 disable trigger all;
update a1b0032001 a
   set a4i_tipo = b.a4i_tipo
  from a4i0032000 b
 where b.a2h_cod = a.a2h_cod; 
alter table a1b0032001 enable trigger all;


alter table a1b0032002 disable trigger all;
update a1b0032002 a
   set a4i_tipo = b.a4i_tipo
  from a4i0032000 b
 where b.a2h_cod = a.a2h_cod; 
alter table a1b0032002 enable trigger all;

delete from a3l0032000 where codtable = 'SDY';

alter table a120032001 disable trigger all;
update a120032001 k
   set a4i_tipo = p.a4i_tipo_s
  from sbf0032001 p
 where p.b1_codpro = k.b1_codpro;
alter table a120032001 enable trigger all; 


alter table a120032002 disable trigger all;
update a120032002 k
   set a4i_tipo = p.a4i_tipo_s
  from sbf0032002 p
 where p.b1_codpro = k.b1_codpro;
alter table a120032002 enable trigger all; 

alter table sbf0032002 disable trigger all;
update sbf0032002 a 
            set a4i_tipo_s = b.a4i_tipo 
           from (select p.b1_codpro, te.a4i_tipo  
                   from sb10032000 p 
               join (select min(a4i_tipo) a4i_tipo, a2h_cod 
                        from  a4i0032000  
                      group by a2h_cod) te 
                 on te.a2h_cod = p.a2h_cod) b 
          where b.b1_codpro = a.b1_codpro 
            and a.sbf_estocavel = 1 
            and a.a4i_tipo_s is null; 
            
update sbf0032002 a 
   set a4i_tipo_e = b.a4i_tipo 
  from (select p.b1_codpro, te.a4i_tipo  
          from sb10032000 p 
               join (select min(a4i_tipo) a4i_tipo, a2h_cod 
                        from  a4i0032000  
                      group by a2h_cod) te 
                 on te.a2h_cod = p.a2h_cod) b 
          where b.b1_codpro = a.b1_codpro 
            and a.sbf_estocavel = 1;   
            
alter table sbf0032002 enable trigger all;

alter table a1b0032001 disable trigger all;
update a1b0032001 set a4i_tipo = 130 where a4i_tipo is null;
alter table a1b0032001 enable trigger all;

delete 
  from ss0410032000 
 where recno in ( 
	select a.recno
	  from ss0410032000 a
	 where not exists(
	    select 1
	      from ss054 b
	     where b.rotina = a.rotina
	       and b.ctrl = a.ctrl));

alter table ss1090032001  disable trigger all;
delete from ss1090032001 where not (to_ ~ E'^[a-zA-Z0-9][a-zA-Z0-9\\._-]+@([a-zA-Z0-9\\._-]+\\.)[a-zA-Z0-9]{2}');
alter table ss1090032001  enable trigger all;

alter table a120032001 disable trigger all;
update a120032001 k
   set sfj_pessoa = u.sfj_pessoa
  from a4i0032000 f, ss0630032000 u
 where f.a4i_tipo = k.a4i_tipo
   and f.a4i_tipoest = 0
   and u.filial = 1;
alter table a120032001 enable trigger all;   

alter table a120032002 disable trigger all;
update a120032002 k
   set sfj_pessoa = u.sfj_pessoa
  from a4i0032000 f, ss0630032000 u
 where f.a4i_tipo = k.a4i_tipo
   and f.a4i_tipoest = 0
   and u.filial = 2;
alter table a120032002 enable trigger all;

---------------------------------------------------------------------------------------------------------------------------
/*
         
select * from sbf0032001 where sbf_estocavel = 1 and (a4i_tipo_e is null or a4i_tipo_s is null)

select * from ss1090032001 where not (to_ ~ E'^[a-zA-Z0-9][a-zA-Z0-9\\._-]+@([a-zA-Z0-9\\._-]+\\.)[a-zA-Z0-9]{2}')

select sfj_pessoa, * from ss0630032000 

select * from sa40032000

select * from sfh0032000 where sfh_cnpj = '10681186000145'
select * from sfh0032000 where sfh_cnpj = '10681186000226'

select * from sbf0032001 where a4i_tipo_e is null
select * from a1b0032001 where a4i_tipo is null

select p.b1_codpro, te.a4i_tipo  
  from sb10032000 p
       join a4i0032000 te
         on te.a2h_cod = p.a2h_cod

select * from sdy0032001 

         select min(a.a4i_tipo) a4i_tipo, a.a2h_cod 
           from a4i0032000 a 
          group by a.a2h_cod*/


select * from a490032001 where recno = 30950          