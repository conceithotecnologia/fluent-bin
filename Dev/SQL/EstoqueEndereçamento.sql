/*
-- Tabelas excluídas
sb2
sbe
scm
scn
sco
scp
scq
scr
scs
sde

-- Rotina excluídas
mc_00052
mc_00072
mc_00002
mc_00004
ck_00002
*/

drop table a4a0000001;
drop table sb20000001 cascade;
drop table sbe0000001 cascade;
drop table scm0000001 cascade;
drop table scn0000001 cascade;
drop table sco0000001 cascade;
drop table scp0000001 cascade;
drop table scq0000001 cascade;
drop table scr0000001 cascade;
drop table scs0000001 cascade;
drop table sde0000001 cascade;
drop table a270000001 cascade;
drop table a280000001 cascade;
drop table a5v0000001 cascade;

select 'alter table ' || lower(f.codtable) || '0000' || sys_iif(t.modo = 1, '000', '001') || ' alter ' || lower(f.columnname) || ' drop not null;'
  from ss012 f
       join ss009 t
         on t.codtable = f.codtable
        and t.view = 0
 where f.columnname ~ 'CODLOCAL'
   and f.primarykey = 0
 order by f.codtable, f.order_;

DROP VIEW a1d0000001;
DROP VIEW vsa3_10000001;

alter table sb30000001  alter b3_nome type varchar(45);

alter table a490000001 add a49_recno_item integer;

select * from a490000001 

DROP TRIGGER mc_005020000001tg ON a490000001;
DROP TRIGGER mc_005120000001tg ON a490000001;
update a490000001 set codtable_item = codtable, a49_recno_item = a49_recno;
CREATE TRIGGER mc_005120000001tg
  AFTER INSERT OR UPDATE OR DELETE
  ON a490000001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_005120000001();

CREATE TRIGGER mc_005020000001tg
  BEFORE INSERT OR UPDATE OR DELETE
  ON a490000001
  FOR EACH ROW
  EXECUTE PROCEDURE mc_005020000001();


  select * from a490000001 order by recno desc limit 1

  select 'NF: ' || c.al_coddoc || ' Série: ' || c.al_serie || ' Tipo: Compra Fornecedor: '|| f.sfj_nome
    from sam0000001 i
         join sal0000001 c
           on c.al_serial = i.al_serial
         join sfj0000000 f
           on f.sfj_pessoa = c.ac_codforn
   where i.recno = 126

   