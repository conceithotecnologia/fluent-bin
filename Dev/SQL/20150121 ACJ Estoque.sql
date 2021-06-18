
-- =================================================================================================================
-- Procedimentos antes da troca do dicionário
-- =================================================================================================================

-- Destruindo tabelas de saldo
drop table f000013001 cascade;
drop table e000013001 cascade;
drop table e010013001 cascade; 
drop table e020013001 cascade; 
drop table e030013001 cascade; 
drop table e040013001 cascade; 
drop table e050013001 cascade; 
drop table e060013001 cascade; 
drop table e070013001 cascade; 
drop table e080013001 cascade; 
drop table e090013001 cascade; 
drop table e100013001 cascade; 
drop table e110013001 cascade; 
drop table e120013001 cascade; 
--drop table e130013001 cascade; 
--drop table e140013001 cascade; 
--drop table e150013001 cascade; 
drop table sf80013000 cascade;
drop table a490013001 cascade;
drop table a5r0013001 cascade;
drop table a120013001 cascade;
drop table f150013000 cascade;
drop table f210013001 cascade;
drop table sd10013001 cascade;
drop table sdl0013001 cascade;
drop table a3k0013000 cascade;

delete 
  from a4g0013000 a
 where a2h_cod not in (
       select a2h_cod
         from a2h0013000);

alter table a1b0013001 disable trigger all;
update a1b0013001 set a49_recno = null, a1b_estado = 0; 
update a1b0013001 a 
   set a2h_cod = b.a2h_cod
  from sb10013000 b
 where b.b1_codpro = a.b1_codpro; 
alter table a1b0013001 enable trigger all;

alter table tle0013001 disable trigger all;
update tle0013001 set a2h_cod = '05' where a2h_cod = '12'; 
alter table tle0013001 enable trigger all;

alter table sb10013000 disable trigger all;
update sb10013000 set a2h_cod = '05' where a2h_cod = '12'; 
alter table sb10013000 enable trigger all;

delete 
  from ss0410013000 
 where rotina = 'MC_01048' 
   and ctrl = 10;

-- =================================================================================================================
-- Procedimentos após a troca do dicionário
-- =================================================================================================================
set session authorization "7034d479f0f236d5c7a16a915de3583a";
select mc_008430013001();
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
          n.al_coddoc, n.al_serie, f.sfj_nome, i.f8_cfop,
          n.ac_codforn
        from sam0013001 i
             join sal0013001 n
               on n.al_serial = i.al_serial
             join sfj0013000 f
               on f.sfj_pessoa = n.ac_codforn
             join sbf0013001 p
               on p.b1_codpro = i.b1_codpro
              and p.sbf_inventario = 1)
	loop	
	text_var1 := null;
	begin
	i49recno := nextval('a490013001_recno_seq'::regclass);
	
		Insert Into a490013001 
         (codtable,      a49_recno,      b1_codpro,   a49_qtd,
          z2_coduni,     a49_custo,      a49_tipo,    a49_data,          
          a49_historico, f8_cfop, recno, a49_custou,  sfj_pessoa,
          a49_doc)
          values (
          'SAM',  r.recno,        r.b1_codpro, r.sam_qtd,
          r.z2_coduni, r.sam_custou,   1,           r.al_dtentrada,  
          format('NFE nº %s série %s de %s', r.al_coddoc, r.al_serie, r.sfj_nome), r.f8_cfop, i49recno, 
          r.sam_custou, r.ac_codforn, r.al_coddoc);

          insert into a5r0013001 (a49_recno, a5r_qtd,   codtable,  a5r_recno)
                 values      (i49recno,  r.sam_qtd, 'SAM',     r.recno);
	exception
				when raise_exception then	
					GET STACKED DIAGNOSTICS text_var1 = MESSAGE_TEXT;
			end;
			
			if text_var1 is not null then
			   raise notice '[[Não conseguir processa o item %. Erro: %]]', r, text_var1;
			end if;
			
	end loop;
end;             
$$  
language plpgsql;

select sys_000120013000('est_criticar', 'false');
select AjustaEntradas();
select sys_000120013000('est_criticar', 'true');

create or replace function AjustaMVI()
returns void as 
$$
declare
   r record;
   i49recno integer;
   text_var1	text;
   va1b_historico text;
begin
   for r in (    
      select x.codtable, x.a1b_recno, x.b1_codpro, x.a1b_qtd,
             x.z2_coduni, x.a1b_custo, x.a1b_data, x.recno
        from a1b0013001 x
             join sbf0013001 p
               on p.b1_codpro = x.b1_codpro
              and p.sbf_inventario = 1 
       where x.a1b_tipo = 1
         and x.a1b_estado = 0)
	loop	
      text_var1 := null;
      begin
         va1b_historico := 'MVI n° ' || mask_00009(r.recno);

         i49recno := nextval('a490013001_recno_seq'::regclass);
	
         Insert Into a490013001 
            (codtable,       a49_recno,      b1_codpro,   a49_qtd,
             z2_coduni,      a49_custou,     a49_tipo,    a49_data,          
             a49_historico,  recno,          a49_notificar)
         values 
            (r.codtable,     r.a1b_recno,    r.b1_codpro, r.a1b_qtd,
             r.z2_coduni,    r.a1b_custo,    1,           r.a1b_data,
             va1b_historico, i49recno,       1);

         --insert into a5r0013001 (a49_recno, a5r_qtd,   codtable,   a5r_recno)
         --           values      (i49recno,  r.a1b_qtd, r.codtable, r.a1b_recno);
      exception
         when raise_exception then	
            GET STACKED DIAGNOSTICS text_var1 = MESSAGE_TEXT;
      end;
			
		if text_var1 is not null then
         raise notice '>>Não consegui processar o item %. Erro: %<<', r, text_var1;
      end if;			
	end loop;
end;             
$$  
language plpgsql;

select sys_000120013000('est_criticar', 'false');
select AjustaMVI();
select sys_000120013000('est_criticar', 'true');

alter table a1b0013001 add processado boolean default false;

create or replace function AjustaMVI_S()
returns void as 
$$
declare
   r 	record;   
   i49recno integer;
   text_var1	text;
   va1b_historico text;
   isfj_pessoa    sfj0013000.sfj_pessoa%type;
   ia49_doc       a490013001.a49_doc%type;
   iCount         integer;
begin
   iCount := 0;
   for r in (    
      select *
        from (
      select x.codtable, x.a1b_recno, x.b1_codpro, x.a1b_qtd,
             x.z2_coduni, x.a1b_data, x.recno, x.tlc_recno,
             sfj.sfj_pessoa, tlc.tlc_nota, 
             'MVI n° ' || mask_00009(x.recno)||'. NFS n° ' || tlc.tlc_nota || ' série ' || tlc.tlc_serie || ' de ' || sfj.sfj_nome as a1b_historico
        from a1b0013001 x
             join sbf0013001 p
               on p.b1_codpro = x.b1_codpro
              and p.sbf_inventario = 1
             join tlc0013001 tlc
               on tlc.recno = x.tlc_recno
             join sfj0013000 sfj
	       on sfj.sfj_pessoa = tlc.sfj_pessoa
       where x.a1b_tipo = 2
         and x.a1b_estado = 0
         and x.codtable = 'TLC'         
      union all   
      select x.codtable, x.a1b_recno, x.b1_codpro, x.a1b_qtd,
             x.z2_coduni, x.a1b_data, x.recno, x.tlc_recno,
             null, null, 'MVI n° ' || mask_00009(x.recno)
        from a1b0013001 x
             join sbf0013001 p
               on p.b1_codpro = x.b1_codpro
              and p.sbf_inventario = 1
       where x.a1b_tipo = 2
         and x.a1b_estado = 0
         and x.codtable <> 'TLC') as tb order by b1_codpro, a1b_data limit 1000)
	loop	
      text_var1 := null;
      iCount := iCount + 1;
      begin
         i49recno := nextval('a490013001_recno_seq'::regclass);         
          
         Insert Into a490013001 
            (codtable,       a49_recno,      b1_codpro,   a49_qtd,
             z2_coduni,      a49_tipo,    a49_data, sfj_pessoa, a49_doc,
             a49_historico,  recno,          a49_notificar)
         values 
            ('A1B',     r.recno,    r.b1_codpro, r.a1b_qtd,
             r.z2_coduni,    2,     r.a1b_data, r.sfj_pessoa, r.tlc_nota, 
             r.a1b_historico, i49recno,       1);

         --insert into a5r0013001 (a49_recno, a5r_qtd,   codtable,   a5r_recno)
         --           values      (i49recno,  r.a1b_qtd, r.codtable, r.a1b_recno);
      exception
         when raise_exception then	         
            GET STACKED DIAGNOSTICS text_var1 = MESSAGE_TEXT;
      end;
			
	if text_var1 is not null then
		raise notice '>>Não consegui processar o item %. Erro: %<<', r, text_var1;
		/*perform mc_setflag0013001('A1B', r.recno);
		update a1b0013001 set processado = true where recno = r.recno;
		perform mc_delflag0013001('A1B', r.recno);*/
	end if;		
      
     if iCount % 100 = 0 then
        raise notice '>>Registros processados %<<', iCount;
     end if;  
      	
     end loop;
end;             
$$  
language plpgsql;

select sys_000120013000('est_criticar', 'false');
select AjustaMVI_S();
select sys_000120013000('est_criticar', 'true');


set session authorization "postgres";

select count(*) from a1b0013001 where a1b_estado = 0 and a1b_tipo = 2 and not processado