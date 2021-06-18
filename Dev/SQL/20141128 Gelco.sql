select sum(custo)
  from (
select sum(i.sam_custo) as  custo
  from sam0032001 i
       join sal0032001 n
         on n.al_serial = i.al_serial
        and n.al_dtentrada between '2014-10-01' and '2014-10-31'
       join sb10032000 p
         on p.b1_codpro = i.b1_codpro
        and (p.a2h_cod in ('06', '07', '99'))
       --join sbf0032001 pc
       --  on pc.b1_codpro = i.b1_codpro
       -- and pc.sbf_inventario = 1  
       join sf40032001 f4
         on f4.f4_tes = i.f4_tes
        and f4.f4_atuestoque = 1  
union all        
select sum(mi.a1b_custo)
  from a1b0032001 mi 
       join sb10032000 p
         on p.b1_codpro = mi.b1_codpro
        and (p.a2h_cod in ('06', '07', '99'))
 where mi.a1b_tipo = 1
   and mi.a1b_data between '2014-10-01' and '2014-10-31') cc


select sum(mi.a1b_custo)
  from a1b0032001 mi 
       join sb10032000 p
         on p.b1_codpro = mi.b1_codpro
        and (p.a2h_cod in ('06', '07', '99'))
 where mi.a1b_tipo = 2
   and mi.a1b_data between '2014-10-01' and '2014-10-31'


   select sum(o.a49_custot_u1)
     from a490032001 o
          join sb10032000 p
         on p.b1_codpro = o.b1_codpro
        and (p.a2h_cod in ('06', '07', '99'))
    where o.a49_estado = 2
      and o.a49_tipo = 2 
      and o.a49_data between '2014-10-01' and '2014-10-31'


123546.0396
121779.4159

select * from a120032001 where b1_codpro = '500958' order by a12_data, recno   


        alter table sb10032000 disable trigger all;
        update sb10032000 set a2h_cod = '07' where a2h_cod = '06';
        alter table sb10032000 enable trigger all;