-- Reprocessamento de custo médio por local
select mc_000180000001('001', 2, 1, null, null, '1200-01-01'::date)
select mc_000180000001('001', 1, null, null, null, '1200-01-01'::date)
select mc_000180000001('LOTE', 3, 1, 1, null, '1200-01-01'::date)
select mc_000180000001('001', 4, 1, null, 'ENDER1', '1200-01-01'::date)

select * from sco0000001 

update a120000001 a12
      set codtable = 'SAJ'
     from a1b0000001 a1b
    where a1b.recno = a12.a12_recno
      and a1b.codtable = 'SAJ' 
      and a12.codtable = 'A1B';