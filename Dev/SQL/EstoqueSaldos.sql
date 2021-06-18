select sum(e02_custoe_u1) as e02_custoe_u1, sum(e02_custos_u1) as e02_custos_u1, 
       sum(e02_custoe_u2) as e02_custoe_u2, sum(e02_custos_u2) as e02_custos_u2
  from e020000001 
 where e02_competencia = '2014-10-01' 


 select * from e000000001 
 select * from e010000001 
 select * from e020000001 
 select * from e030000001 
 

 select * from e000000001 where b1_codpro = '004' order by b1_codpro , e00_data

 update e000000001 set recno = recno

 select b1_codpro, a49_data, a2h_cod, a49_tipo, a49_competencia,
        a49_qtdu1, a49_custot_u1, a49_qtdu2, a49_custot_u2 
   from a490000001 
  order by b1_codpro, a49_data, a2h_cod, a49_tipo


select mc_008460000001()