select * 
  from scp0032001 scp
       join scf0032001 scf
         on scf.recno =
       join scg0032001 scg
         on scg.scf_recno = scf.recno
 where scp.codtable = 'SCG'

select * from scf0032001 
select * from ss0270032000 
set session authorization "cb02ae1cc170a5468fd8008aae089868"
delete from sco0032001 where recno in (
select scp.recno
  from sco0032001 scp
       left join scg0032001 scg
         on scg.recno = scp.sco_recno
 where scp.codtable = 'SCG'
   and scg.recno is null)

delete from scp0032001 where recno in (
select scp.recno
  from scp0032001 scp
       left join scg0032001 scg
         on scg.recno = scp.scp_recno
 where scp.codtable = 'SCG'
   and scg.recno is null)

delete from a120032001 where recno in (
select scp.recno
  from a120032001 scp
       left join scg0032001 scg
         on scg.recno = scp.a12_recno
 where scp.codtable = 'SCG'
   and scg.recno is null)



DROP TRIGGER mc_000300032001tg ON sam0032001;
DROP TRIGGER mc_000580032001tg ON sam0032001;
DROP TRIGGER mc_000850032001tg ON sal0032001;
DROP TRIGGER mc_000920032001tg ON sal0032001;
DROP TRIGGER mc_000250032001tg ON scf0032001;
DROP TRIGGER mc_000290032001tg ON scf0032001;
DROP TRIGGER mc_000310032001tg ON scg0032001;
DROP TRIGGER mc_000330032001tg ON scg0032001;
delete from scf0032001 where recno in (
select scf.recno as scf_recno
  from sam0032001 sam
       join sal0032001 sal
         on sal.al_serial = sam.al_serial         
        and sal.ac_codforn = 0 
       join scf0032001 scf
         on scf.scf_recno = sam.recno
        and scf.codtable = 'SAM' 
       join scg0032001 scg
         on scg.scf_recno = scf.recno 
 order by sam.b1_codpro)

delete from sal0032001 where ac_codforn = 0;

CREATE TRIGGER mc_000330032001tg
  BEFORE INSERT OR UPDATE OR DELETE
  ON scg0032001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_000330032001();
CREATE TRIGGER mc_000310032001tg
  AFTER INSERT OR UPDATE OR DELETE
  ON scg0032001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_000310032001();
CREATE TRIGGER mc_000290032001tg
  AFTER INSERT OR UPDATE OR DELETE
  ON scf0032001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_000290032001();
CREATE TRIGGER mc_000250032001tg
  BEFORE INSERT OR UPDATE OR DELETE
  ON scf0032001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_000250032001();
CREATE TRIGGER mc_000920032001tg
  BEFORE INSERT OR UPDATE OR DELETE
  ON sal0032001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_000920032001();
CREATE TRIGGER mc_000850032001tg
  AFTER INSERT OR UPDATE OR DELETE
  ON sal0032001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_000850032001();
CREATE TRIGGER mc_000580032001tg
  BEFORE INSERT OR UPDATE OR DELETE
  ON sam0032001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_000580032001();
CREATE TRIGGER mc_000300032001tg
  AFTER INSERT OR UPDATE OR DELETE
  ON sam0032001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_000300032001();


insert into  a1b0032001 (b1_codpro, b3_codlocal, z2_coduni, a1b_qtd, a1b_custo, a1b_tipo, a1b_data)
select sam.recno as sam_recno, scf.recno as scf_recno
  from sam0032001 sam
       join sal0032001 sal
         on sal.al_serial = sam.al_serial         
        and sal.ac_codforn = 0 
       join scf0032001 scf
         on scf.scf_recno = sam.recno
        and scf.codtable = 'SAM' 
       join scg0032001 scg
         on scg.scf_recno = scf.recno 
 order by sam.b1_codpro




select * from a1b0032001 


update scp0032001 scp
   set a3k_tipo = mc_004790032001(scp.codtable, scp_recno, b.f4_tes)
  from (select sam.f4_tes, scg.recno
          from sam0032001 sam
               join scf0032001 scf
                 on scf.scf_recno = sam.recno
                and scf.codtable = 'SAM' 
               join scg0032001 scg
                 on scg.scf_recno = scf.recno) b
 where scp.scp_recno = b.recno
   and scp.codtable = 'SCG'                      

update a120032001 scp
   set a3k_tipo = mc_004790032001(scp.codtable, a12_recno, b.f4_tes)
  from (select sam.f4_tes, scg.recno
          from sam0032001 sam
               join scf0032001 scf
                 on scf.scf_recno = sam.recno
                and scf.codtable = 'SAM' 
               join scg0032001 scg
                 on scg.scf_recno = scf.recno) b
 where scp.a12_recno = b.recno
   and scp.codtable = 'SCG'                      

update sco0032001 scp
   set a3k_tipo = mc_004790032001(scp.codtable, sco_recno, b.f4_tes)
  from (select sam.f4_tes, scg.recno
          from sam0032001 sam
               join scf0032001 scf
                 on scf.scf_recno = sam.recno
                and scf.codtable = 'SAM' 
               join scg0032001 scg
                 on scg.scf_recno = scf.recno) b
 where scp.sco_recno = b.recno
   and scp.codtable = 'SCG'                      
   
select mc_000180032001(a.b1_codpro, 1, null, null, null, '1900-01-01'::date)
   from (select b1_codpro 
           from a120032001 
          group by b1_codpro) a

select mc_000180032001(a.b1_codpro, 2, a.b3_codlocal, null, null, '1900-01-01'::date)
   from (select b1_codpro, b3_codlocal
           from scp0032001 
          group by b1_codpro, b3_codlocal) a          

select mc_000180032001(a.b1_codpro, 4, b3_codlocal, null, scm_ender, '1900-01-01'::date)
   from (select b1_codpro, b3_codlocal, scm_ender
           from sco0032001 
          group by b1_codpro, b3_codlocal, scm_ender) a 


select * from a120032001 where codtable = 'SAJ' 
         select * from a1b0032001 where codtable = 'SAJ' 

select a3k_tipo from a120032001 group by a3k_tipo        
select * from a120032001 where b1_codpro = 'A00001'
select * from a1b0032001 where b1_codpro = 'A00001'

-- Baixa estoque
                        Insert Into sb00032001 
                           (b1_codpro,     b3_codlocal,       sb0_tipo,   sb0_qtd,
                            codtable,      sb0_custo,         sb0_recno,  sb0_historico,
                            z2_coduni,     sb0_data,          sb0_emp,    sb0_ender,
                            sb0_lote,      sb0_lote_ender,    f4_tes )
select saj.b1_codpro,     sbf.b3_codlocal,       2,          saj.saj_quantos, 
                            'SAJ',         saj.saj_unitario,      saj.recno,      'Referente a nota '|| sai.sai_serial,
                            saj.z2_coduni,     sai.sai_dtemissao, 0,          0,
                            0,             0,                 saj.f4_tes
  from saj0032001 saj
       join sf40032001 sf4
         on sf4.f4_tes = saj.f4_tes
        and sf4.f4_atuestoque = 1 
       join sai0032001 sai
         on sai.sai_serial = saj.sai_serial 
        and sai.sai_avulso = 0
       join sbf0032001 sbf
         on sbf.b1_codpro = saj.b1_codpro
        and sbf.b1_codpro <> 'T2039'

        select * from sb20032001 