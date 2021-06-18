select  
       
       
       a12_aliqicms, a12_aliqpis, a12_aliqcofins, 
       a12_consumo, a12_aliqicms_red, 
       a12_aliqipi, 
       
       
 from a120032001 
where b1_codpro = 'MP0001' order by a12_data, recno limit 100

       -- Identificação 
select recno, b1_codpro, codtable, a12_recno, a3k_tipo, a12_historico, sfj_pessoa, a12_doc,
       a2h_cod,  a44_numser, b3_codlocal, sd3_lote, a5r_recno,
       -- Operação 1ª unidade
       a12_data, a12_tipo, a12_qtd, a12_valor, a12_valor_t, a12_custou, a12_custo_t,
       -- Saldos 1ª unidade
       a12_sdant, a12_saldo, a12_custo, a12_saldov,  
       -- Operação 2ª unidade
       a12_sqtd, a12_svalor, a12_svalor_t, a12_scustou, a12_scusto_t,
       -- Saldos 2ª unidade
       a12_ssdant, a12_ssaldo, a12_scusto, a12_ssaldov  
  from a120032001 
 where b1_codpro = 'MP0001' and a12_data < '2014-10-01'
 order by a12_data, recno


 