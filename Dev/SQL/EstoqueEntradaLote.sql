select * from fpm0000001

select * from a2h0000000  
select * from sf80000000 where f8_descri ilike '%serviço%' order by 2
select * from sf80000000 where f8_descri ilike '%substituição%' order by 2
select * from sf80000000 where f8_descri ilike '%comercialização%' order by 1

update sf80000000 set f8_estoque = 0 where f8_descri ilike '%energia elétrica%'

update sf80000000 
   set f8_estoque = 1, f8_consumo = 1 
 where recno in (13, 111, 193, 464, 463, 462, 249, 251, 366, 98, 190, 214, 461, 440, 329, 115, 17)

drop table a4e0000001 cascade;
drop table a0l0000001 cascade;
drop table a470000001 cascade;

select * 
  from sam0000001 sam
       left join a4f0000001 a4f
         on a4f.al_serial = sam.al_serial
        and a4f.b1_codpro = sam.b1_codpro 
       left join a480000001 a48
         on a48.al_serial = sam.al_serial
        and a48.b1_codpro = sam.b1_codpro   
 where sam.al_serial = 1


select * from sam0000001 


select * from sam0000001 
select * from va4e0000001 
select * from a480000001 
select * from a4f0000001 
select * from a4e0000001 
truncate table a480000001 

select a4d.a4d_estado,    a4d.fpn_numero,    a4d.b1_codpro,     sb1.b1_nome,   sb1.b1_ref, 
       sb1.b1_ativo,      sb1.z2_coduni,     sb1.b1_coduni,     a4d.a4d_qtdu1, a4d.a4d_qtdu2,
       a4d.a4d_qtdloteu1, a4d.a4d_qtdloteu2, a4d.a4d_qtdnser, a4d.a4d_obs,   a4d.u_i,        
       a4d.d_i,           a4d.u_u,           a4d.d_u,           a4d.recno
  from [(a4d)] a4d
       join [(sb1)] sb1
         on sb1.b1_codpro = a4d.b1_codpro
        and sb1.b1_temp = 0

select a4d.a4d_estado,    a4d.fpn_numero,    a4d.b1_codpro,     sb1.b1_nome,   sb1.b1_ref, 
       sb1.b1_ativo,      sb1.z2_coduni,     sb1.b1_coduni,     a4d.a4d_qtdu1, a4d.a4d_qtdu2,
       a4d.a4d_qtdloteu1, a4d.a4d_qtdloteu2, a4d.a4d_qtdnser,   a4d.a4d_obs,   a4d.u_i,        
       a4d.d_i,           a4d.u_u,           a4d.d_u,           a4d.recno,     sbf.sbf_rastro,  
       sbf.sbf_numser
  from a4d0000001 a4d
       join sb10000000 sb1
         on sb1.b1_codpro = a4d.b1_codpro
        and sb1.b1_temp = 0
       join sbf0000001 sbf
         on sbf.b1_codpro = a4d.b1_codpro 

select a4e.a4e_estado,    a4e.al_serial,    a4e.b1_codpro,     sb1.b1_nome,   sb1.b1_ref, 
       sb1.b1_ativo,      sb1.z2_coduni,     sb1.b1_coduni,     a4e.a4e_qtdu1, a4e.a4e_qtdu2,
       a4e.a4e_qtdloteu1, a4e.a4e_qtdloteu2, a4e.a4e_qtdnser,   a4e.a4e_obs,   a4e.u_i,        
       a4e.d_i,           a4e.u_u,           a4e.d_u,           a4e.recno,     sbf.sbf_rastro,  
       sbf.sbf_numser
  from a4e0000001 a4e
       join sb10000000 sb1
         on sb1.b1_codpro = a4e.b1_codpro
        and sb1.b1_temp = 0
       join sbf0000001 sbf
         on sbf.b1_codpro = a4e.b1_codpro 
         
select * from fpm0000001 

select fpm.fpn_numero, fpm.fpc_pedido, fpm.fpc_ano,    fpm.b1_codpro,  sb1.b1_nome,     
       sb1.b1_ref,     sb1.b1_ativo,   sb1.z2_coduni,  sb1.b1_coduni,  fpm.fpm_qtdlote, 
       fpm.u_i,        fpm.d_i,        fpm.u_u,        fpm.d_u,        fpm.recno
  from fpm0000001 fpm
       join sb10000000 sb1
         on sb1.b1_codpro = fpm.b1_codpro
        and sb1.b1_temp = 0        


select * from ss0420000001 

select * from va4d0000001 where sbf_numser = 1

select * from a470000001
select * from a0l0000001  

select pnser(10, '004', '126', 13)
select pnser(10, '006', null, 100)

create or replace function pnser(
   in in_prenota integer,
   in in_produto varchar(25),
   in in_lote varchar(50),
   in in_quantos integer)
returns void as
$$
declare
   i            integer;
   v44numser	a440000001.a44_numser%type;
Begin
  for i in 1..in_quantos
  loop
     v44numser := in_prenota ||'_'||in_produto|| '_' || trim(to_char(i, '0000'));
  
     insert into a470000001(fpn_numero, b1_codpro, a44_numser, a0l_loteforn)
          values           (in_prenota, in_produto, v44numser, in_lote);
  end loop;
end;
$$
language plpgsql;   

insert into a2h0000000 (a2h_cod, a2h_descri, u_i, u_u, d_i, d_u)
select a2h_cod, a2h_descri, u_i, u_u, d_i, d_u from a2h 

drop table a2h 

select a2h_cod, a2h_descri, u_i, u_u, d_i, d_u from a2h0000000  


   
delete from a4g0000000 where a2h_cod = '03'

insert into a4g0000000 (f8_cfop, a2h_cod) 
select f8_cfop, '07', *
  from sf80000000 
 where f8_estoque = 1
   and f8_descri ~ '(C|c)onsumo'
order by 1

select * from sam0000001 

select * from sb10000000 where b1_codpro = '005' and b8_codtipo = 5

select * from sb80000000 where b8_codtipo = 5

select * from a4g0000000 where f8_cfop = '1101' and a2h_cod = '01' 

select * from shi0000000 
truncate table ss0270000000 cascade
select * from sf80000000 where f8_cfop = '1101' and f8_estoque = 1
