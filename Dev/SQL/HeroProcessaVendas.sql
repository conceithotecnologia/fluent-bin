create or replace function processar_vendas()
returns void as
$$
Declare
	r		record;
	rk		record;
	vhist		a490001001.a49_historico%type;
	bErro		boolean;
	i		numeric(18, 4);
	saldo		numeric(18, 4);
	bnumser		boolean;
	vnumser 	a440001001.a44_numser%type;
	fsb0_custo	sb00001001.sb0_custo%type;
	text_var1	text;
Begin
	truncate table resultados;
	
	for r in (
		select saj.b1_codpro, saj.z2_coduni, sai.sai_dtsaida, saj.saj_quantos, 
		       saj.saj_unitario, sai.sai_nf, saj.recno, saj.f4_tes
		 from saj0001001 saj
		       join sai0001001 sai
			 on sai.sai_serial = saj.sai_serial
			and sai.nf0_cod = 100        
			and sai.sai_tipo = 0		
			--and sai.sai_dtsaida <= '2014-03-31'::date
		       join sf40001001 b
			 on b.f4_tes = saj.f4_tes
			and b.f4_atuestoque = 1 
			and b.f4_tes not in (566)
			and (b.f8_cfop_de ~ '10(1|2)$')
		       left join a120001001 k
			 on k.a12_recno = saj.recno
			and k.codtable = 'SAJ'
			and k.a12_tipo = 2
		 where saj.saj_quantos > 0
		   and saj.saj_unitario > 0		   		   
		   and k.recno is null
		   order by sai.sai_dtsaida, saj.b1_codpro)
	loop
		bErro := False;				
		bnumser := ck_000110001001(r.b1_codpro) != 0;
		i := r.saj_quantos;
		vnumser := null;
		
		while (i != 0) 
		loop
			vhist := format('Nota fiscal (NFe) n° %s.', r.sai_nf);
			text_var1 := null;
			begin		
				if bnumser then
					r.saj_quantos := 1;
					select a44_numser
					  into vnumser
					  from a440001001
					 where a44_estado = 2
					 order by a44_numser
					 limit 1;
				end if;
				

				-- Gerando requisições para notas de venda
				/*insert into a490001001 
					(b1_codpro,     z2_coduni,     a49_data,  a49_qtd, 
					 a49_custo,     a49_historico,  codtable,  a49_recno,
					 a49_tipo,      f4_tes)
				values
					(r.b1_codpro,  r.z2_coduni, r.sai_dtsaida, r.saj_quantos,
					 r.saj_unitario, vhist, 'SAJ', r.recno,
					 2, r.f4_tes);*/
				fsb0_custo := mc_005500001001(r.b1_codpro, r.z2_coduni, r.sai_dtsaida);         

				if fsb0_custo = 0 then
					fsb0_custo := r.saj_unitario;
				end if;
					 
				Insert Into sb00001001 (
					b1_codpro,    b3_codlocal,     sb0_tipo,
					sb0_qtd,      codtable,        sb0_custo,    sb0_recno,     sb0_historico,
					z2_coduni,    sb0_data,        sb0_emp,      sb0_filial,    a44_numser,
					sb0_atucusto, f4_tes)
				   values 
					(r.b1_codpro,  1, 2,
					 r.saj_quantos, 'SAJ',      fsb0_custo,  r.recno,   vhist,
					 r.z2_coduni,  r.sai_dtsaida,      0,            1,             vnumser,
					 1,            r.f4_tes);

				if bnumser then
					update a440001001
					   set a44_estado = 3, a44_historico = 'Baixado pela ' || vhist
					 where a44_numser = vnumser;
				end if;
					 
				--update saj0001001 
				--   set baixado = true 
				-- where recno = r.recno;
			exception
				when raise_exception then	
					GET STACKED DIAGNOSTICS text_var1 = MESSAGE_TEXT;
			end;
			
			if text_var1 is not null then
								
				text_var1 := substr(text_var1, strpos(text_var1, 'Saldo:') + 7, strpos(text_var1, ')]]') - (strpos(text_var1, 'Saldo:') + 7));
				
				insert into resultados values (r.sai_nf, r.sai_dtsaida, r.b1_codpro, r.saj_quantos, vnumser, text_var1);
				
				saldo := cast(text_var1 as numeric(18,4)) * -1;
				vhist := format('Fechamento 31/03/2014. Complementando saldo para nota fiscal (NFe) n° %s.', r.sai_nf);
				/*Insert Into sb00001001 (
					b1_codpro,    b3_codlocal,     sb0_tipo,
					sb0_qtd,      codtable,        sb0_custo,    sb0_recno,     sb0_historico,
					z2_coduni,    sb0_data,        sb0_emp,      sb0_filial,    a44_numser,
					sb0_atucusto, f4_tes)
				   values 
					(r.b1_codpro,  1, 1,
					 100000, 'SAJ',      fsb0_custo,  r.recno,   vhist,
					 r.z2_coduni,  '2014-04-01'::date,      0,            1,             vnumser,
					 1,            r.f4_tes);*/
			
				raise notice 'Não consegui registrar a saída do nota fiscal % item % quantidade % série % data %. Mensagem: %', 
						r.sai_nf, r.b1_codpro, r.saj_quantos, vnumser, r.sai_dtsaida, text_var1;														  
			end if;

			i := i - r.saj_quantos;
		end loop;

		/*
		-- Se houve erro verifica se exite saldo em algum momento.
		if bErro then
			select recno
			  into rk
			 from a120001001 
			where b1_codpro = r.b1_codpro
			  and a12_tipo = 1
			limit 1;

			-- cria um registro de entrada caso não haja registro de entrada no kardex
			--if not Found then			
				-- gera saldo para o próximo processamento
				insert into a1b0001001 (
					b1_codpro, b3_codlocal, z2_coduni, a1b_qtd, 
					a1b_custo, a1b_descri, a1b_data, a1b_tipo)
				values (
					r.b1_codpro, 1, r.z2_coduni, r.saj_quantos,
					r.saj_unitario, 'Entrada automática', r.sai_dtsaida, 1);
			else
				raise notice 'Movendo lançamento % do produto % para data %', rk.recno, r.b1_codpro, r.sai_dtsaida;
				update a120001001
				   set a12_data = r.sai_dtsaida
				 where recno = rk.recno;

				perform mc_000180001001(r.b1_codpro, 1, null, null, null, r.sai_dtsaida);
			end if; 
		--end if;*/ 

	end loop;
end;
$$
language plpgsql;