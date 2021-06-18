set session authorization "cb02ae1cc170a5468fd8008aae089868"
Insert Into a490032001  
         (codtable,    a49_recno,    b1_codpro,   a49_qtd,
          z2_coduni,   a49_custo,    a49_tipo,    a49_data,          
          f8_cfop,     a49_historico)          
select 'SAM', am.recno, am.b1_codpro, am.sam_qtd, 
       p.z2_coduni, am.sam_custou, 1, al.al_dtentrada,
       am.f8_cfop,   format('NFE nº %s série %s de %s', al.al_coddoc, al.al_serie, sfj.sfj_nome)
  from sam0032001 am
       join sal0032001 al
         on al.al_serial = am.al_serial
        and al.al_dtentrada >= '2014-10-01' 
       join sf40032001 f4
         on f4.f4_tes = am.f4_tes
        and f4.f4_atuestoque = 1	
       join sfj0032000 sfj
         on sfj.sfj_pessoa = al.ac_codforn
       join sb10032000 p
         on p.b1_codpro = am.b1_codpro  
 order by al.al_dtentrada, am.al_serial, am.recno


delete from a120032001 where a12_data >= '2014-10-01'

set session authorization postgres;
alter table a490032001 disable trigger all;
delete  from a490032001 where codtable = 'SAM' and a49_data >= '2014-10-01';
alter table a490032001 enable trigger all;
set session authorization "cb02ae1cc170a5468fd8008aae089868";


select * from a120032001 

-- Saldo incial
   select 0 as tipo,                 0 as qtd,            0 as custo, 0 as sqtd,       
          0 as scusto,  e00_qtdf_u1 as saldo,          e00_qtdf_u2 as ssaldo,   0 as sdant,     
          0 as ssdant,     null::varchar(30) as codtable, 0 as recno_tb,              0 as valor,                    0 as svalor,             
          recno,                     0 as doc,                      0 as pessoa,             
          0 as custo_t,              0 as scusto_t,                 0 as valor_t,            0 as svalor_t,              
          e00_custof_u1 as saldov,   e00_custof_u2 as ssaldov,      e00_data as data     
     from e000032001 
    where b1_codpro = 'MP0001'
      and e00_data < '2014-10-01'
    order by e00_data desc, e00_tipo desc
    limit 1;   



for r in (
-- Gera registro (kardex)
            insert into a120032001  (b1_codpro,     a12_data,          a12_tipo,     a3k_tipo, 
                                 a12_qtd,       a12_custo,         a12_sqtd,     a12_scusto,    
                                 a44_numser,    b3_codlocal,       sd3_lote,     a12_historico,     
                                 codtable,      a12_recno,         a5r_recno)                                
            select b.b1_codpro, b.a49_data,      b.a49_tipo, b.a3k_tipo, 
                                 r.a5r_qtdu1,   b.a49_custou_u1, r.a5r_qtdu2,  b.a49_custou_u1, 
                                 r.a44_numser,  r.b3_codlocal,     r.sd3_lote,   b.a49_historico,
                                 b.codtable,  b.a49_recno,     r.recno
              from a5r0032001 r
                   join a490032001 b
                     on b.recno = r.a49_recno
                    and b.codtable <> 'SAM'
                    and b.a49_data > '2014-09-30'
                    and a49_estado = 2
              order by a49_data, a49_tipo
         loop            
            
                         values (new.b1_codpro, new.a49_data,      new.a49_tipo, new.a3k_tipo, 
                                 r.a5r_qtdu1,   new.a49_custou_u1, r.a5r_qtdu2,  new.a49_custou_u1, 
                                 r.a44_numser,  r.b3_codlocal,     r.sd3_lote,   new.a49_historico,
                                 new.codtable,  new.a49_recno,     r.recno);
         end loop;

    

select a12_tipo as tipo,       a12_qtd as qtd,           a12_custo as custo,     a12_sqtd as sqtd,       
             a12_scusto as scusto,   a12_saldo as saldo,       a12_ssaldo as ssaldo,   a12_sdant as sdant,     
             a12_ssdant as ssdant,   codtable,                 a12_recno as recno_tb,  a12_aliqpis as aliqpis, 
             a12_consumo as consumo, a12_valor as valor,       a12_svalor as svalor,   a12_aliqicms as aliqicms,    
             recno,                  a12_doc as doc,           sfj_pessoa as pessoa,   a12_aliqcofins as aliqcofins,
             a12_custo_t as custo_t, a12_scusto_t as scusto_t, a12_valor_t as valor_t, a12_svalor_t as svalor_t,
             a12_aliqipi as aliqipi, a12_aliqicms_red as aliqicms_red,
             a12_custou as custou,  a12_scustou as scustou,    a12_saldov as saldov,   a12_ssaldov as ssaldov,
             a12_data as data
        from a120032001
       where b1_codpro = 'MP0001'
         and a12_data >= '2014-10-01'
       order by b1_codpro, a12_data, recno;   


       select b1_codpro, a12_sdant, 0 as "Custo Ant", a12_tipo, a12_qtd, a12_custo, a12_custo_t, a12_saldo, a12_custou, a12_saldov
         from a120032001 where b1_codpro = 'MP0001' order by b1_codpro, a12_data, recno;   



         select * from a5r0032001 


       select a12_tipo,   a12_qtd,     a12_custo,   a12_sqtd,       
             a12_scusto, a12_saldo,   a12_ssaldo,  a12_sdant,     
             a12_ssdant, recno,       a12_custo_t, a12_scusto_t, 
             a12_saldov, a12_ssaldov, a12_custou,  a12_scustou,
             a12_data                
        from a120032001 
       where b1_codpro = 'MP0001'
         and a12_data < '2014-11-10'
       order by b1_codpro, a12_data desc, recno desc
       limit 1;   