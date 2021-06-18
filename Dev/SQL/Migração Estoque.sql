select * from shi0001000 

update shi0001000 set a2h_cod = '99' where a2h_cod is null

select * from sb30001001 
select * from a4a0001001 

alter table sb30001001 drop b3_area 

select * from ng00001001 

select * from a470001001 

select * from ss012 where codtable = 'A47' order by order_

select * from ss0270001000 
set session authorization "8d643775836a127b5f77977ceee5817e"
select mc_setflag0001001('FPM', recno) from fpm0001001 

truncate table a490001001 cascade;

select fpn_numero, b1_codpro, count(*)
  from fpm0001001 a
 where not exists(
	select 1
	  from a4d0001001 b
	 where b.fpn_numero = a.fpn_numero
	   and b.b1_codpro = a.b1_codpro)
 group by fpn_numero, b1_codpro

insert into a4g0001000 (f8_cfop, a2h_cod) values ('1403','01')
insert into a4g0001000 (f8_cfop, a2h_cod) values ('1102','01')

select AjusteRecebimento()
select AjusteEntrada()

update sb10001000 a
   set a2h_cod = '01'
  from (select a.b1_codpro
	  from sam0001001 a
	       join sf40001001 b
		 on b.f4_tes = a.f4_tes
		and b.f8_cfop_de in ('1101', '1401', '1902')
	       join sb10001000 p
		 on p.b1_codpro = a.b1_codpro
		and p.a2h_cod <> '01'
	  group by a.b1_codpro) n
 where n.b1_codpro = a.b1_codpro

update sb10001000 a
   set a2h_cod = '00'
  from (select a.b1_codpro
	  from sam0001001 a
	       join sf40001001 b
		 on b.f4_tes = a.f4_tes
		and b.f8_cfop_de in ('1102')
	       join sb10001000 p
		 on p.b1_codpro = a.b1_codpro
		and p.a2h_cod <> '00'
	  group by a.b1_codpro) n
 where n.b1_codpro = a.b1_codpro
 
update sb10001000 a
   set a2h_cod = '07'
  from (select a.b1_codpro
	  from sam0001001 a
	       join sf40001001 b
		 on b.f4_tes = a.f4_tes
		and b.f8_cfop_de in ('1407', '1556')
	       join sb10001000 p
		 on p.b1_codpro = a.b1_codpro
		and p.a2h_cod <> '07'
	  group by a.b1_codpro) n
 where n.b1_codpro = a.b1_codpro;

update sb10001000 a
   set a2h_cod = '08'
  from (select a.b1_codpro
	  from sam0001001 a
	       join sf40001001 b
		 on b.f4_tes = a.f4_tes
		and b.f8_cfop_de in ('1551')
	       join sb10001000 p
		 on p.b1_codpro = a.b1_codpro
		and p.a2h_cod <> '08'
	  group by a.b1_codpro) n
 where n.b1_codpro = a.b1_codpro
 

select * from a2h0001000 
select * from ss040 

delete from ss040 where columnname = 'B8_CODTIPO'

select * from sam0001001 
update sam0001001 set recno = recno
update fpm0001001 set recno = recno
select mc_delflag0001001('SAM', recno) from sam0001001 


select * from a2h0001000 

select a.b1_codpro as "Material", a.b1_nome as "Nome", a.a2h_cod as "Tipo", b.a2h_descri as "Descrição", 
       sys_iif(b.a2h_natureza = 1, 'Material', sys_iif(b.a2h_natureza = 2,'Serviço','Transitoria')) as "Tipo", 
       sys_iif(b.a2h_venda = 1, 'Sim', 'Não') as "Venda"
  from sb10001000 a
       join a2h0001000 b
         on b.a2h_cod = a.a2h_cod
 where a.a2h_cod in ('03', '05', '09', '99')
order by a.b1_nome;




select * from sb30001001 