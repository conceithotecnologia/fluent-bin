select * 
  from sam0000001 i
       left join a4f0000001 l
         on l.al_serial = i.al_serial
        and l.b1_codpro = i.b1_codpro         
 where i.al_serial = 29
select * from sf80000000

select i.b1_codpro, p.z2_coduni, i.sam_qtd, i.sam_custou, cast('SAM' as varchar(20)) as codtable, i.recno, p.sbf_rastro, p.sbf_numser, b1.a2h_cod
  from sam0000001 i
       join sb10000000 b1
         on b1.b1_codpro = i.b1_codpro
       join sbf0000001 p
         on p.b1_codpro = i.b1_codpro
        and p.sbf_rastro = 0
        and p.sbf_numser = 0
       join sf80000000 o
         on o.f8_cfop = i.f8_cfop  
        and o.f8_estoque = 1 
 where i.al_serial = 29
union
select s.b1_codpro, p.z2_coduni, s.a4e_qtdu1, s.a4e_custouu1, cast('A4E' as varchar(20)), s.recno, p.sbf_rastro, p.sbf_numser, b1.a2h_cod
  from a4e0000001 s              
       join sb10000000 b1
         on b1.b1_codpro = s.b1_codpro 
       join sbf0000001 p
         on p.b1_codpro = s.b1_codpro        
 where s.al_serial = 29

select l.b1_codpro, p.z2_coduni, l.a4f_qtdu1, s.a4e_custouu1, cast('A4F' as varchar(20)), l.recno, a4f_loteforn
  from a480000001 l       
       join a4e0000001 s
         on s.al_serial = l.al_serial
        and s.b1_codpro = l.b1_codpro 
       join sbf0000001 p
         on p.b1_codpro = l.b1_codpro
        and p.sbf_rastro = 1
        and p.sbf_numser = 0        
 where l.al_serial = 29


select * from a4e0000001 



select round(round(sum(sam_custo),4) / sum(sam_qtd), 4), round(round(sum(sam_scusto),4) / sum(sam_sqtd), 4)
  from sam0000001 
 where al_serial = 29
   and b1_codpro = '004'

select * from a4e0000001 where al_serial = 29

drop table a4e0000001 cascade;
drop table a4f0000001 cascade;
drop table a480000001 cascade;
 


select * from a4e0000001 

select * from ss012 where codtable = 'SAM'

select * from a4f0000001 

select * from a4e0000001 

select * from fpc0000001 
select * from a2h0000000  
select * from a0l0000001   
select * from sf80000000 
select * from sd30000001 

select * 
  from sam0000001 a
       join sb10000000 b
         on b.b1_codpro = a.b1_codpro
       join sf80000000 c
         on c.f8_cfop = a.f8_cfop
        and c.f8_estoque = 1
 where a.al_serial = 32 
         


select  fpn_numero, b1_codpro, a0l_loteforn, a0l_qtd, z2_coduni 
                        from a0l0000001 
                       where fpn_numero = 11;


select * from a480000001 
select  b1_codpro, a44_numser, recno, a0l_loteforn
                        from a470000001 
                       where fpn_numero = 11; 