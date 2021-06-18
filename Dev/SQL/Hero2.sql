-- Movimentos de entrada
-- ======================================================================================================================
select * from ss0270001000

set session authorization "8d643775836a127b5f77977ceee5817e"

truncate table a120001001 cascade;
truncate table a270001001 cascade;
truncate table a490001001 cascade;
truncate table a1b0001001 cascade;
truncate table scp0001001;
delete from a440001001;

select * from a120001001 where codtable = 'A1B' and a12_tipo = 1

delete from a120001001 where codtable = 'A1B' and a12_tipo = 1 


insert into sb00001001 (b1_codpro,       b3_codlocal,   sd3_lote,  sb0_data,
                              sb0_tipo,        z2_coduni,     sb0_qtd,   sb0_custo,      codtable,
                              sb0_recno,       sb0_historico, sb0_local, sb0_lote,
                              sb0_filial,    sb0_atucusto, f4_tes )
select ni.b1_codpro, 1, ni.sd3_lote,  nf.al_dtentrada,
       1, sys_iif(ck_000010001000(ni.b1_codpro, ni.z2_coduni) = 1,ni.z2_coduni, p.z2_coduni), ni.am_qtd, ni.am_vlunit, 'SAM',
       ni.recno, 'Documento de entrada '||nf.al_coddoc||' série '||nf.al_serie, 1, 1, 
       1, tes.f4_atucusto, ni.f4_tes
  from sam0001001 ni
       join sal0001001 nf
         on nf.al_serial = ni.al_serial
        and (nf.ac_codforn <> 0 or al_dtentrada < '2014-01-01')       
       join sf40001001 tes
         on tes.f4_tes = ni.f4_tes
        and (tes.f8_cfop_de ~ '(1|9)0(1|2)$' or tes.f8_cfop_de ~ '(124|949)$' or tes.f8_cfop_de ~ '40(1|3)$')
       join sb10001000 p
         on p.b1_codpro = ni.b1_codpro
        --and p.b1_codpro = '000000000000877'
      order by nf.al_dtentrada, ni.recno, ni.sd3_lote;

-- Processamento de entradas em formulário próprio
insert into sb00001001 (
  b1_codpro,       b3_codlocal,      sb0_data,        sb0_tipo,       z2_coduni,     
  sb0_qtd,         sb0_custo,        codtable,        sb0_recno,      sb0_historico,    
  sb0_local,       sb0_lote,         sb0_ender,       sb0_lote_ender, sb0_filial,       
  sb0_atucusto,    f4_tes)
select 
  saj.b1_codpro,   saj.b3_codlocal,  sai.sai_dtsaida, 1,              saj.z2_coduni, 
  saj.saj_quantos, saj.saj_unitario, 'SAJ',           saj.recno,      format('Nota fiscal de entrada n° %s emitida pela própira empresa.', sai.sai_nf),
  1,               0,                0,               0,              1,
  sf4.f4_atucusto, saj.f4_tes
from saj0001001 saj
      join sai0001001 sai
	on sai.sai_serial = saj.sai_serial
       and sai.sai_tipo = 1
       and sai.nf0_cod = 100
      join sf40001001 sf4
	on sf4.f4_tes = saj.f4_tes
       and (sf4.f8_cfop_de ~ '(1|9)0(1|2)$' or sf4.f8_cfop_de ~ '(124|949)$' or sf4.f8_cfop_de ~ '40(1|3)$');

-- Move todas as entradas para o início do mês
update a120001001 set a12_data = (to_char(a12_data, 'YYYY-MM-')||'01')::date  where a12_tipo = 1 and a12_data > '2013-12-31';

-- Atualiza o kardex
select mc_000200001001(null, cast('2013-01-01' as date));


-- processamento de movimentações internas
Insert Into sb00001001  (b1_codpro,   b3_codlocal,     sd3_lote,     scm_ender,     sb0_tipo,
                           sb0_qtd,     codtable,        sb0_custo,    sb0_recno,     sb0_historico,
                           z2_coduni,   sb0_data,        sb0_emp,      sb0_filial,    a44_numser,
                           sb0_atucusto)
                     
select a.b1_codpro, b.b3_codlocal, b.sd3_lote, b.scm_ender, a.a49_tipo,
                           b.a5r_qtd, a.codtable,      a.a49_custo,  a.a49_recno,   format('Ordem de movimentação %s.', b.a49_recno),
                           sys_iif(ck_000010001000(a.b1_codpro, a.z2_coduni) = 1,a.z2_coduni, c.z2_coduni), a.a49_data,      0,            1,             b.a44_numser,
                           1
  from a490001001 a
       join a5r0001001 b
         on b.a49_recno = a.recno
       join sb10001000 c
         on c.b1_codpro = a.b1_codpro    
 where a.a49_estado = 2
   --and not a.bug
   --and a.b1_codpro not in ('000000000000837')
 order by a.a49_tipo, a.recno;

select * from a120001001 where b1_codpro = '000000000000515' order by b1_codpro, a12_data
select * from a120001001 where a12_valor = 0

select * from sam0001001 where b1_codpro = '000000000000604'
select * from scy0001001 where scy_codpro = '000000000000398'
delete from scy0001001 where recno = 116

Insert Into sb00001001 (b1_codpro,     b3_codlocal,     sb0_tipo,
                        sb0_qtd,       codtable,        sb0_recno,    sb0_data,      sb0_historico,
                        z2_coduni,     sb0_custo )
                select b1_codpro, b3_codlocal, 2,
                        scy_qtd,   'SCY',           recno,    scy_data,  'Transferência '||mask_00009(recno),
                        z2_coduni, scy_custo
                   from scy0001001;      
   Insert Into sb00001001 (b1_codpro,      b3_codlocal,      sb0_tipo,
                        sb0_qtd,        codtable,         sb0_recno,    sb0_data,      sb0_historico,
                        z2_coduni,      sb0_custo )
                select scy_codpro, scy_codlocal, 1,
                        scy_qtd,    'SCY',            recno,    scy_data,  'Transferência '||mask_00009(recno),
                        z2_coduni,  scy_custo
                   from scy0001001;     
                        

-- Move todas as entradas para o início do mês
update a120001001 set a12_data = (to_char(a12_data, 'YYYY-MM-')||'01')::date  where a12_tipo = 1 and a12_data > '2013-12-31';

-- Atualiza o kardex
select mc_000200001001(null, cast('2013-01-01' as date));

select processar_vendas();

select * from a490001001 where codtable = 'A1B' and a49_recno > 139 and a49_tipo = 2
select * from a1b0001001 where recno > 139 and a1b_tipo = 2


DROP TRIGGER mc_002640001001tg ON a1b0001001;
DROP TRIGGER mc_002800001001tg ON a1b0001001;
DROP TRIGGER mc_005020001001tg ON a490001001;
DROP TRIGGER mc_005120001001tg ON a490001001;
DROP TRIGGER a490001001_logtg ON a490001001;
DROP TRIGGER a1b0001001_logtg ON a1b0001001;
DROP TRIGGER mc_005040001001tg ON a5r0001001;
DROP TRIGGER mc_005100001001tg ON a5r0001001;

delete from a490001001 where codtable = 'A1B' and a49_recno > 139 and a49_tipo = 2;
delete from a1b0001001 where recno > 139 and a1b_tipo = 2;

CREATE TRIGGER mc_005100001001tg
  AFTER INSERT OR UPDATE OR DELETE
  ON a5r0001001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_005100001001();
CREATE TRIGGER mc_005040001001tg
  BEFORE INSERT OR UPDATE OR DELETE
  ON a5r0001001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_005040001001();
CREATE TRIGGER a1b0001001_logtg
  BEFORE INSERT OR UPDATE OR DELETE
  ON a1b0001001
  FOR EACH ROW
  EXECUTE PROCEDURE a1b0001001_log('A1B');
CREATE TRIGGER a490001001_logtg
  BEFORE INSERT OR UPDATE OR DELETE
  ON a490001001
  FOR EACH ROW
  EXECUTE PROCEDURE a490001001_log('A49');
CREATE TRIGGER mc_005120001001tg
  AFTER INSERT OR UPDATE OR DELETE
  ON a490001001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_005120001001();
CREATE TRIGGER mc_005020001001tg
  BEFORE INSERT OR UPDATE OR DELETE
  ON a490001001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_005020001001();
CREATE TRIGGER mc_002800001001tg
  AFTER INSERT OR UPDATE OR DELETE
  ON a1b0001001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_002800001001();
CREATE TRIGGER mc_002640001001tg
  BEFORE INSERT OR UPDATE OR DELETE
  ON a1b0001001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_002640001001();


insert into scy0001001 (scy_data, b1_codpro, b3_codlocal, scy_codpro, scy_codlocal, z2_coduni, scy_qtd) 
   values              ('2014-01-09', '000000000001032', 1, '000000000000398', 1,  'PC', 5);
insert into scy0001001 (scy_data, b1_codpro, b3_codlocal, scy_codpro, scy_codlocal, z2_coduni, scy_qtd) 
   values              ('2014-02-11', '000000000000077', 1, '000000000000078', 1,  'PC', 4);   
insert into scy0001001 (scy_data, b1_codpro, b3_codlocal, scy_codpro, scy_codlocal, z2_coduni, scy_qtd) 
   values              ('2014-02-11', '000000000000477', 1, '000000000000162', 1,  'PC', 1);   
insert into scy0001001 (scy_data, b1_codpro, b3_codlocal, scy_codpro, scy_codlocal, z2_coduni, scy_qtd) 
   values              ('2014-01-18', '000000000000624', 1, '000000000000182', 1,  'PC', 1);   
insert into scy0001001 (scy_data, b1_codpro, b3_codlocal, scy_codpro, scy_codlocal, z2_coduni, scy_qtd) 
   values              ('2014-03-25', '000000000000408', 1, '000000000000329', 1,  'PC', 1);   
insert into scy0001001 (scy_data, b1_codpro, b3_codlocal, scy_codpro, scy_codlocal, z2_coduni, scy_qtd) 
   values              ('2014-03-25', '000000000000382', 1, '000000000000341', 1,  'PC', 1);    
insert into scy0001001 (scy_data, b1_codpro, b3_codlocal, scy_codpro, scy_codlocal, z2_coduni, scy_qtd) 
   values              ('2014-01-13', '000000000000874', 1, '000000000000489', 1,  'PC', 1);    
insert into scy0001001 (scy_data, b1_codpro, b3_codlocal, scy_codpro, scy_codlocal, z2_coduni, scy_qtd) 
   values              ('2014-02-11', '000000000000036', 1, '000000000000904', 1,  'PC', 3);    
insert into a1b0001001 (b1_codpro, f1_codnat, b3_codlocal, z2_coduni, a1b_qtd, a1b_tipo, a1b_data, a1b_custo)
select r.produto, p.f1_codnat, 1, p.z2_coduni, cast(r.mensagem as numeric) * - 1, 1, r.data, 10
  from resultados r 
       join sb10001000 p
         on r.produto = p.b1_codpro
 order by produto, data, nota

   
select * from sam0001001 where b1_codpro = '000000000000877' order by 1
select * from sf40001001 where f4_tes = 132
            select f1_codnat, z2_coduni from sb10001000 where b1_codpro in ('000000000000251','000000000000287', '000000000000331', '000000000000916'

 select * from a1b0001001 

drop table resultados
create table resultados(nota integer, data date, produto varchar(25), qtd numeric(18,4), nserie varchar(30), mensagem text);
alter table ss079 add where_ text;

select * from scy0001001 
						   
--
select processar_vendas();

select * from a120001001 where b1_codpro = '000000000001069'
select * from sam0001001 where b1_codpro = '000000000001069'

select produto, count(*) from resultados group by produto order by 2 desc

select r.produto as "Material", p.b1_nome as "Nome", r.data as "Data", r.nota as "NF", r.nserie as "Nº de série", r.qtd as "Qtd", r.mensagem as "Erro"
  from resultados r 
       join sb10001000 p
         on r.produto = p.b1_codpro
 order by produto, data, nota

select * from a120001001 where a12_historico ~ 'Fechamento 31/03/2014'

delete from a120001001 where a12_historico ~ 'Fechamento 31/03/2014';


select * from a120001001 where a12_historico ~ 'Fechamento'
select * from a120001001 where b1_codpro = '000000000000002'
select sum(a12_custou * a12_qtd) from a120001001 where a12_tipo = 1 and a12_data between '2014-01-01' and '2014-03-31' 

select sum(am_qtd * am_vlunit) from (--nf.al_serial, sum(am_qtd * am_vlunit) from (
select ni.b1_codpro, 1, ni.sd3_lote,  nf.al_dtentrada, nf.al_serial,
       1, sys_iif(ck_000010001000(ni.b1_codpro, ni.z2_coduni) = 1,ni.z2_coduni, p.z2_coduni), ni.am_qtd, ni.am_vlunit, 'SAM',
       ni.recno, 'Documento de entrada '||nf.al_coddoc||' série '||nf.al_serie, 1, 1, 
       1, tes.f4_atucusto, ni.f4_tes
  from sam0001001 ni
       join sal0001001 nf
         on nf.al_serial = ni.al_serial
        --and nf.ac_codforn <> 0
        and (nf.ac_codforn <> 0 or al_dtentrada < '2014-01-01')
        --and al_dtentrada < '2014-01-01'
       join sf40001001 tes
         on tes.f4_tes = ni.f4_tes
        and (tes.f8_cfop_de ~ '(1|9)0(1|2)$' or tes.f8_cfop_de ~ '(124|949)$' or tes.f8_cfop_de ~ '40(1|3)$')
       join sb10001000 p
         on p.b1_codpro = ni.b1_codpro
        --and p.b1_codpro = '000000000000877'
      order by nf.al_dtentrada, ni.recno, ni.sd3_lote) nf
   where al_dtentrada between '2001-01-01' and '2013-12-31'
   group by al_serial
   order by 2 desc

select sum(saj_unitario * saj_quantos)
  from (
select 
  saj.b1_codpro,   saj.b3_codlocal,  sai.sai_dtsaida, 1,              saj.z2_coduni, 
  saj.saj_quantos, saj.saj_unitario, 'SAJ',           saj.recno,      format('Nota fiscal de entrada n° %s emitida pela própira empresa.', sai.sai_nf),
  1,               0,                0,               0,              1,
  sf4.f4_atucusto, saj.f4_tes
from saj0001001 saj
      join sai0001001 sai
	on sai.sai_serial = saj.sai_serial
       and sai.sai_tipo = 1
       and sai.nf0_cod = 100
      join sf40001001 sf4
	on sf4.f4_tes = saj.f4_tes
       and (sf4.f8_cfop_de ~ '(1|9)0(1|2)$' or sf4.f8_cfop_de ~ '(124|949)$' or sf4.f8_cfop_de ~ '40(1|3)$')) nf
 where nf.sai_dtsaida between '2001-01-01' and '2013-12-31'      
