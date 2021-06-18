-- Movimentos de entrada
-- ======================================================================================================================
select * from ss0270001000

set session authorization "8d643775836a127b5f77977ceee5817e"

alter table a120001001
	add b3_codlocal integer,
	add scm_ender varchar(15),
	add sd3_lote integer;

alter table a490001001 
	add f4_tes integer;

--alter table saj0001001 
--	add baixado boolean default false;
	
update a120001001 set a12_data = cast(to_char(a12_data, 'yyyy-mm-')||'01' as date) where a12_tipo = 1;

-- Apagar movimentações inválidas          
DROP TRIGGER a490001001_logtg ON a490001001;
DROP TRIGGER mc_005020001001tg ON a490001001;
DROP TRIGGER mc_005120001001tg ON a490001001;
DROP TRIGGER a5r0001001_logtg ON a5r0001001;
DROP TRIGGER mc_005040001001tg ON a5r0001001;
DROP TRIGGER mc_005100001001tg ON a5r0001001;
DROP TRIGGER mc_002640001001tg ON a1b0001001;
DROP TRIGGER mc_002800001001tg ON a1b0001001;

delete from a270001001 where recno < 31;
delete from a490001001 where u_i = 'ITAMAR';

alter table a490001001 add bug boolean default false;
delete from a490001001 where a49_estado between 0 and 1 or recno = 42085;

update a490001001 set a49_data = '2014-01-10' where recno in (16842, 16843);

update a440001001 
   set a44_estado = 2, b3_codlocal = 1
 where a44_numser in (
select a44_numser from a5r0001001 where a49_recno in (16842, 16843));

update a490001001 o
   set bug = true
  from a280001001 p
 where p.a27_recno in (75,76,77)
   and p.a49_recno = o.recno;


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
CREATE TRIGGER a5r0001001_logtg
  BEFORE INSERT OR UPDATE OR DELETE
  ON a5r0001001
  FOR EACH ROW
  EXECUTE PROCEDURE a5r0001001_log('A5R');
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
CREATE TRIGGER a490001001_logtg
  BEFORE INSERT OR UPDATE OR DELETE
  ON a490001001
  FOR EACH ROW
  EXECUTE PROCEDURE a490001001_log('A49');
	
delete from a1b0001001 where a1b_estado = 0;

truncate table a120001001;

insert into sb00001001 (b1_codpro,       b3_codlocal,   sd3_lote,  scm_ender,      sb0_data,
                              sb0_tipo,        z2_coduni,     sb0_qtd,   sb0_custo,      codtable,
                              sb0_recno,       sb0_historico, sb0_local, sb0_lote,       sb0_ender,
                              sb0_lote_ender,  sb0_filial,    sb0_atucusto, f4_tes )

select b.b1_codpro,   a.b3_codlocal,  a.sd3_lote,  a.scm_ender,    b.scf_data,
                              1,               sys_iif(ck_000010001000(b.b1_codpro, b.z2_coduni) = 1,b.z2_coduni, c.z2_coduni), a.scg_qtd,   b.scf_custo, 'SCG',
                              a.recno,      'Documento de classificação n° ' || mask_00009(b.recno) ||
            ' com origem em ' || b.codtable || ' - ' || mask_00009(b.scf_recno),    1, 1,     1,
                              1, 1,   b.scf_atucusto, b.f4_tes
           from scg0001001 a
                join scf0001001 b
                  on a.scf_recno = b.recno
                join sb10001000 c
                  on c.b1_codpro = b.b1_codpro  
                 and c.b1_codpro <> '000000000000831'
          order by b.recno, scg_loteforn;

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
       and sf4.f4_atuestoque = 1;

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
   and not a.bug
   and a.b1_codpro not in ('000000000000837')
 order by a.recno;

select processar_vendas();
