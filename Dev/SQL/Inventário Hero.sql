select a2h_cod as "Tipo", a2h_descri as "Nome", sbm_clf as "Class. Fiscal", b1_codpro as "Código", b1_nome as "Material", 
       al_dtentrada as "Data", z2_coduni as "Unidade", sam_qtd as "Qtd", sam_custou as "Unitário", sam_custo as "Parcial",
       sys_iif(tipo = 1, 'Entrada', 'Saída') as "Tipo Movto", historico as "Histórico"
  from (
select b1.a2h_cod, a2.a2h_descri, b1.sbm_clf, am.b1_codpro, b1.b1_nome, 1 as tipo, al.al_dtentrada, b1.z2_coduni, am.sam_qtd, am.sam_custou, am.sam_custo, 
       'Nota Fiscal nº '||al.al_coddoc||' série '||al_serie||' do fornecedor '||fj.sfj_nome as historico
  from sam0001001 am
       join sal0001001 al
	 on al.al_serial = am.al_serial
        and (al.ac_codforn <> 0 or (al.ac_codforn = 0 and al.al_serial < 390))
	and al.al_status = 2
	and al.al_dtentrada <= '2014-09-30'
       join sfj0001000 fj
         on fj.sfj_pessoa = al.ac_codforn	
       join sb10001000 b1
         on b1.b1_codpro = am.b1_codpro
       join a2h0001000 a2
         on a2.a2h_cod = b1.a2h_cod
union all
select b1.a2h_cod, a2.a2h_descri, b1.sbm_clf, aj.b1_codpro, b1.b1_nome, 1, ai.sai_dtsaida, b1.z2_coduni, aj.saj_qtdu1, aj.saj_custou, aj.saj_custo, 
       'Nota Fiscal nº '||ai.sai_nf||' série '||at_serie||' do fornecedor '||fj.sfj_nome as historico
  from saj0001001 aj
       join sai0001001 ai
	 on ai.sai_serial = aj.sai_serial     
	and ai.sai_tipo = 1
	and ai.nf0_cod = 100
	and ai.sai_dtsaida <= '2014-09-30'
       join sfj0001000 fj
         on fj.sfj_pessoa = ai.a1_codcli
       join sb10001000 b1
         on b1.b1_codpro = aj.b1_codpro
       join a2h0001000 a2
         on a2.a2h_cod = b1.a2h_cod 
union all
select b1.a2h_cod, a2.a2h_descri, b1.sbm_clf, aj.b1_codpro, b1.b1_nome, 2, ai.sai_dtsaida, b1.z2_coduni, aj.saj_qtdu1, aj.saj_custou, aj.saj_custo, 
       'Nota Fiscal nº '||ai.sai_nf||' série '||at_serie||' do fornecedor '||fj.sfj_nome as historico
  from saj0001001 aj
       join sai0001001 ai
	 on ai.sai_serial = aj.sai_serial     
	and ai.sai_tipo = 0
	and ai.nf0_cod = 100
	and ai.sai_dtsaida <= '2014-09-30'
       join sfj0001000 fj
         on fj.sfj_pessoa = ai.a1_codcli	
       join sb10001000 b1
         on b1.b1_codpro = aj.b1_codpro
       join a2h0001000 a2
         on a2.a2h_cod = b1.a2h_cod 
 ) movimento         
 order by a2h_cod, b1_codpro, tipo, al_dtentrada
 