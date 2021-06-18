--TRUNCATE table a490001001 cascade
select mc_008460001001();

select * from a490001001 where a49_qtd > 10000

select AjustaEntradas();

create or replace function AjustaEntradas()
returns void as 
$$
declare
  r record;
  i49recno integer;
  text_var1	text;
begin

      for r in (    
      select i.recno,        i.b1_codpro, i.sam_qtd,
          i.z2_coduni, i.sam_custou,   n.al_dtentrada,  
          n.al_coddoc, n.al_serie, f.sfj_nome, i.f8_cfop
        from sam0001001 i
             join sal0001001 n
               on n.al_serial = i.al_serial
             join sfj0001000 f
               on f.sfj_pessoa = n.ac_codforn)
	loop
		if r.b1_codpro = '000000000000610' then
			continue;
		end if;
	text_var1 := null;
	begin
	i49recno := nextval('a490001001_recno_seq'::regclass);
	
		Insert Into a490001001 
         (codtable,    a49_recno,    b1_codpro,   a49_qtd,
          z2_coduni,   a49_custo,    a49_tipo,    a49_data,          
          a49_historico, f8_cfop, recno)
          values (
          'SAM',  r.recno,        r.b1_codpro, r.sam_qtd,
          r.z2_coduni, r.sam_custou,   1,           r.al_dtentrada,  
          format('NFE nº %s série %s de %s', r.al_coddoc, r.al_serie, r.sfj_nome), r.f8_cfop, i49recno);

          insert into a5r0001001 (a49_recno, a5r_qtd,   codtable,  a5r_recno)
                 values      (i49recno,  r.sam_qtd, 'SAM',     r.recno);
	exception
				when raise_exception then	
					GET STACKED DIAGNOSTICS text_var1 = MESSAGE_TEXT;
			end;
			
			if text_var1 is not null then
			   raise notice '[[Não conseguir processar o item %. Erro: %]]', r, text_var1;
			end if;
			
	end loop;
end;             
$$  
language plpgsql;

insert into a5r0001001 (a49_recno, a5r_qtd,   codtable,  a5r_recno)
select recno, a49_qtd, codtable, a49_recno from a490001001 where a49_estado < 2




set session authorization postgres
alter table sam0001001 disable trigger all
set session authorization "8d643775836a127b5f77977ceee5817e"
update sam0001001 i 
   set z2_coduni = coalesce(p.b1_coduni, p.z2_coduni)
  from sb10001000 p   
 where p.b1_codpro = i.b1_codpro
   and ck_000010001000(i.b1_codpro, i.z2_coduni) = 0 
set session authorization postgres
alter table sam0001001 enable trigger all
set session authorization "8d643775836a127b5f77977ceee5817e"


select *
  from sam0001001 a
       join sbf0001001 b
         on b.b1_codpro = a.b1_codpro
        and b.sbf_numser = 1 
 group by a.f8_cfop
 order by 1

select * from e000001001 
select * from e010001001 
select * from e020001001 

truncate e000001001; 
truncate e010001001; 
truncate e020001001; 
truncate e030001001; 
truncate e040001001; 
truncate e050001001; 
truncate e060001001; 
truncate e070001001; 
drop table f020001000 

alter table a490001001 add a49_competencia varchar(6)

select * from ss0270001000 

set session authorization "8d643775836a127b5f77977ceee5817e"
update a490001001 set a49_competencia = to_char(a49_data, 'yyyymm')


select * from a4d0001001 
select * from a480001001 

set session authorization postgres
alter table sam0001001 disable trigger all
set session authorization "8d643775836a127b5f77977ceee5817e"
update sam0001001 i
   set sam_estado = 1
  from sbf0001001 p
 where p.b1_codpro = i.b1_codpro
   and p.sbf_numser = 0 
   and p.sbf_rastro = 0 
set session authorization postgres
alter table sam0001001 enable trigger all
new.f8_cfop := (mc_00040####???(xCursor.ac_codforn, mc_00205####???(xCursor.ac_codforn), new.f4_tes))[1];



select mc_008430001001()

select * from sam0001001 
select * from sf80001000  
select * from ss0270001000 
