select * from a490001001 order by recno desc
select * from saj0001001 where b1_codpro = '000000000001189'
select AjustaSaidas2()
select * from sai0001001 
set session authorization "8d643775836a127b5f77977ceee5817e"
set session authorization "postgres"

select mc_008460001001()


create or replace function AjustaSaidas2()
returns void as 
$$
declare
  r record;
  i49recno integer;
  text_var1	text;
begin

      for r in (    
      select i.recno,        i.b1_codpro, i.saj_quantos,
          i.z2_coduni, sys_iif(i.z2_coduni = p.z2_coduni, i.saj_custou, i.saj_scustou) as saj_custou,  n.sai_dtsaida,  
          n.sai_nf, n.at_serie, f.sfj_nome, i.f8_cfop
        from saj0001001 i
             join sai0001001 n
               on n.sai_serial = i.sai_serial
             join sb10001000 p
               on p.b1_codpro = i.b1_codpro  
             join sfj0001000 f
               on f.sfj_pessoa = n.a1_codcli
       where n.sai_tipo = 0
         and n.nf0_cod = 100
         and i.saj_quantos > 0)
	loop		
	text_var1 := null;
	begin
	i49recno := nextval('a490001001_recno_seq'::regclass);
	
		Insert Into a490001001 
         (codtable,    a49_recno,    b1_codpro,   a49_qtd,
          z2_coduni,   a49_custo,    a49_tipo,    a49_data,          
          a49_historico, f8_cfop, recno)
          values (
          'SAJ',  r.recno,        r.b1_codpro, r.saj_quantos,
          r.z2_coduni, r.saj_custou,   2,           r.sai_dtsaida,  
          format('NFS nº %s série %s de %s', r.sai_nf, r.at_serie, r.sfj_nome), r.f8_cfop, i49recno);

          insert into a5r0001001 (a49_recno, a5r_qtd,   codtable,  a5r_recno)
                 values      (i49recno,  r.saj_quantos, 'SAJ',     r.recno);
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