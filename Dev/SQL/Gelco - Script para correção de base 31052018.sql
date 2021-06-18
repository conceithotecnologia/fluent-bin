-- Atualização das do kardex para produtos com 2°unidade de medida desabilitada
update sbf0032001 set 
SBF_SQTD= 0,SBF_SQTDL= 0,SBF_SQTDE= 0,SBF_SQTDLBLOQ= 0,
SBF_SQTDEBLOQ= 0,SBF_SQTDBLOQ= 0,SBF_SQTDRES= 0,SBF_SEMP= 0,
SBF_SQTDDISP= 0,SBF_SCUSTO = 0
where b1_coduni is null and SBF_SQTD <> 0;

update a120032001 a12
   set a12_sqtd = 0, A12_SVALOR = 0, A12_SVALOR_T = 0, A12_SCUSTOU = 0, A12_SCUSTO_T = 0, A12_SSDANT = 0, A12_SSALDO = 0, A12_SCUSTO = 0, A12_SSALDOV = 0
  from sbf0032001 sbf
  where sbf.b1_codpro = a12.b1_codpro
    and (a12_sqtd <> 0 or A12_SSDANT <> 0 or A12_SVALOR <> 0 or A12_SCUSTOU <> 0 or A12_SCUSTO <> 0 or A12_SSALDOV <> 0)
    and b1_coduni is null;

update e000032001 e00
   set e00_qtde_u2 = 0, E00_VLRE_U2 =0, E00_QTDS_U2 =0, E00_VLRS_U2=0, E00_SALDO_U2=0, E00_SALDOR_U2 =0, E00_SALDOD_U2=0, E00_CUSTO_U2=0
  from sbf0032001 sbf
  where sbf.b1_codpro = e00.b1_codpro
    and (e00_qtde_u2 <> 0 or E00_SALDOD_U2 <> 0 or e00_saldo_u2 <> 0)
    and b1_coduni is null;

update e250032001 e25
   set e25_saldo_u2 = 0, e25_sdant_u2 = 0, E25_QTD_U2 = 0
  from sbf0032001 sbf
  where sbf.b1_codpro = e25.b1_codpro
    and E25_QTD_U2 <> 0
    and b1_coduni is null;

set session authorization "0b51abb416036cd807ec7e82a751f301";

update e110032001 e11
   set E11_QTD_U2= 0 , E11_CUSTOU_U2 = 0, E11_CUSTO_U2 = 0, E11_QTDR_U2 = 0, E11_QTDD_U2 = 0, E11_QTDP_U2 = 0, E11_QTDF_U2 = 0
  from sbf0032001 sbf
  where sbf.b1_codpro = e11.b1_codpro
    and (E11_QTD_U2 <> 0 or E11_QTDR_U2 <> 0 or E11_CUSTO_U2 <> 0)
    and b1_coduni is null;

-- select * from e110032001 e11 join sbf0032001 sbf on sbf.b1_codpro = e11.b1_codpro where E11_QTD_U2 <> 0 and b1_coduni is null;

update e120032001 e12
   set E12_QTD_U2= 0 , E12_QTDB_U2 = 0, E12_QTDR_U2 = 0, E12_QTDD_U2 = 0, E12_QTDP_U2 = 0, E12_QTDF_U2 = 0
  from sbf0032001 sbf
  where sbf.b1_codpro = e12.b1_codpro
    and E12_QTD_U2 <> 0
    and b1_coduni is null;

update e140032001 e14
   set e14_qtde_u2 = 0 , e14_qtds_u2 = 0, e14_saldo_u2 = 0, e14_saldor_u2 = 0, e14_saldod_u2 = 0
  from sbf0032001 sbf
  where sbf.b1_codpro = e14.b1_codpro
    and e14_saldo_u2 <> 0
    and b1_coduni is null;

set session authorization postgres;

-- Finalização de reservas abertas
alter table sdf0032001 disable trigger all;
alter table e020032001 disable trigger all;
alter table e030032001 disable trigger all;
alter table e040032001 disable trigger all;

update sdf0032001 set sdf_estado = 2 where sdf_estado = 1;
update e020032001 set e02_estado = 2 where e02_estado = 1;
update e030032001 set e03_estado = 2 where e03_estado = 1;
update e040032001 set e04_estado = 2 where e04_estado = 1;

alter table sdf0032001 enable trigger all;
alter table e020032001 enable trigger all;
alter table e030032001 enable trigger all;
alter table e040032001 enable trigger all;

-- Finalização de movimentações internas em aberto
alter table a1b0032001 disable trigger all;

update a1b0032001 set a1b_estado = 1 where a1b_estado = 0;

alter table a1b0032001 enable trigger all;

-- Finalização de registros de movimentação abertos
alter table a5r0032001 disable trigger all;

update a5r0032001 set a5r_estado = 2 where a5r_estado = 1;

alter table a5r0032001 enable trigger all;

-- Finalização de ordens de movimentação em aberto
alter table a490032001 disable trigger all;

update a490032001 set a49_estado = 2 where a49_estado in (0,1);

alter table a490032001 enable trigger all;

-- Correção de status de notas já transmitidas

alter table sai0032001 disable trigger all;

update sai0032001 set SAI_STATUS = 1 where SAI_STATUS = 0;

alter table sai0032001 enable trigger all;

-- Recomposição do kardex
--select mc_000200032001('2018-05-01',null,null);
--select mc_011220032001('2018-05-01',null,null);
--select mc_011260032001('2018-05-01',null,null);
--select mc_001750032001('2018-05-01',null,null,null);
--nselect mc_008520032001('2018-05-01',null);

-- Reprocessamento de saldo diário
--select mc_008930032001('2018-05-01',null,null);

-- Finalização de pedidos já faturados
alter table saf0032001 disable trigger all;
alter table sag0032001 disable trigger all;

update saf0032001 set saf_etapas = 3 where recno in (9806,9895);
update sag0032001 set sag_qtdlibsld = 0, sag_qtdlibproc = 0 where recno IN(
10018,10015,10030,10032,10039,10040,10066,10079,10086,10088,10140,
10141,10149,10160,10195,10198,10202,10283,10302,10410,10535);
update sag0032001 set sag_qtdlib = 0 where recno in (
9794,10239,10242,10243,10253,10267,10398,10522,10595,10738,10739,10743,10747);

alter table saf0032001 enable trigger all;
alter table sag0032001 enable trigger all;

--
update a2h0032000 set f1_codnat = null;

alter table ss1130032001 disable trigger all;
delete 
  from ss1130032001
where recno in ( 
select a.recno from ss1130032001 a where not exists(select 1 from ss1080032001 b where b.recno = a.ss108_recno));
alter table ss1130032001 enable trigger all;

alter table ss1090032001 disable trigger all;
delete 
  from ss1090032001
where recno in ( 
select a.recno from ss1090032001 a where not exists(select 1 from ss1080032001 b where b.recno = a.ss108_recno));
alter table ss1090032001 enable trigger all;

alter table ss1100032001 disable trigger all;
delete 
  from ss1100032001
where recno in ( 
select a.recno from ss1100032001 a where not exists(select 1 from ss1080032001 b where b.recno = a.ss108_recno));
alter table ss1100032001 enable trigger all;
