alter table saf0014001 disable trigger all;
update saf0014001 set saf_dtentrega = d_i where saf_dtentrega is null;
alter table saf0014001 enable trigger all;

alter table saf0014002 disable trigger all;
update saf0014002 set saf_dtentrega = d_i where saf_dtentrega is null;
alter table saf0014002 enable trigger all;

alter table saf0014003 disable trigger all;
update saf0014003 set saf_dtentrega = d_i where saf_dtentrega is null;
alter table saf0014003 enable trigger all;

alter table saf0014004 disable trigger all;
update saf0014004 set saf_dtentrega = d_i where saf_dtentrega is null;
alter table saf0014004 enable trigger all;

alter table saf0014006 disable trigger all;
update saf0014006 set saf_dtentrega = d_i where saf_dtentrega is null;
alter table saf0014006 enable trigger all;

alter table saf0014005 disable trigger all;
update saf0014005 set saf_dtentrega = d_i where saf_dtentrega is null;
alter table saf0014005 enable trigger all;


alter table saf0014007 disable trigger all;
update saf0014007 set saf_dtentrega = d_i where saf_dtentrega is null;
alter table saf0014007 enable trigger all;

drop table f000014001 cascade;
drop table f000014002 cascade;
drop table f000014003 cascade;
drop table f000014004 cascade;
drop table f000014005 cascade;
drop table f000014006 cascade;

alter table a050014001 disable trigger all;
update a050014001 a
   set f8_cfop = (mc_000400014001(b.a1_codcli, mc_002050014000(b.a1_codcli), a.f4_tes))[1]
  from a030014001 b
 where b.a03_os = a.a03_os
   and a.f8_cfop is null;
alter table a050014001 enable trigger all;   

alter table a050014002 disable trigger all;
update a050014002 a
   set f8_cfop = (mc_000400014002(b.a1_codcli, mc_002050014000(b.a1_codcli), a.f4_tes))[1]
  from a030014002 b
 where b.a03_os = a.a03_os
   and a.f8_cfop is null;
alter table a050014002 enable trigger all;   

alter table a050014003 disable trigger all;
update a050014003 a
   set f8_cfop = (mc_000400014003(b.a1_codcli, mc_002050014000(b.a1_codcli), a.f4_tes))[1]
  from a030014003 b
 where b.a03_os = a.a03_os
   and a.f8_cfop is null;
alter table a050014003 enable trigger all;   

alter table a050014004 disable trigger all;
update a050014004 a
   set f8_cfop = (mc_000400014004(b.a1_codcli, mc_002050014000(b.a1_codcli), a.f4_tes))[1]
  from a030014004 b
 where b.a03_os = a.a03_os
   and a.f8_cfop is null;
alter table a050014004 enable trigger all;   

alter table a050014006 disable trigger all;
update a050014006 a
   set f8_cfop = (mc_000400014006(b.a1_codcli, mc_002050014000(b.a1_codcli), a.f4_tes))[1]
  from a030014006 b
 where b.a03_os = a.a03_os
   and a.f8_cfop is null;
alter table a050014006 enable trigger all;   

alter table a050014007 disable trigger all;
update a050014007 a
   set f8_cfop = (mc_000400014007(b.a1_codcli, mc_002050014000(b.a1_codcli), a.f4_tes))[1]
  from a030014007 b
 where b.a03_os = a.a03_os
   and a.f8_cfop is null;
alter table a050014007 enable trigger all;   

update a4a0014001 set a4a_bloq = 0;
update a4a0014002 set a4a_bloq = 0;
update a4a0014003 set a4a_bloq = 0;
update a4a0014004 set a4a_bloq = 0;
update a4a0014005 set a4a_bloq = 0;
update a4a0014006 set a4a_bloq = 0;
update a4a0014007 set a4a_bloq = 0;

alter table sam0014001 disable trigger all;
update sam0014001 a
   set f8_cfop = (mc_000400014001(b.ac_codforn, mc_002050014000(b.ac_codforn), a.f4_tes))[1]
  from sal0014001 b
 where b.al_serial = a.al_serial
   and a.f8_cfop is null
   and b.ac_codforn <> 383;
alter table sam0014001 enable trigger all;

alter table sam0014002 disable trigger all;
update sam0014002 a
   set f8_cfop = (mc_000400014002(b.ac_codforn, mc_002050014000(b.ac_codforn), a.f4_tes))[1]
  from sal0014002 b
 where b.al_serial = a.al_serial
   and a.f8_cfop is null;
alter table sam0014002 enable trigger all;

alter table sam0014003 disable trigger all;
update sam0014003 a
   set f8_cfop = (mc_000400014003(b.ac_codforn, mc_002050014000(b.ac_codforn), a.f4_tes))[1]
  from sal0014003 b
 where b.al_serial = a.al_serial
   and a.f8_cfop is null;
alter table sam0014003 enable trigger all;

alter table sam0014004 disable trigger all;
update sam0014004 a
   set f8_cfop = (mc_000400014004(b.ac_codforn, mc_002050014000(b.ac_codforn), a.f4_tes))[1]
  from sal0014004 b
 where b.al_serial = a.al_serial
   and a.f8_cfop is null;
alter table sam0014004 enable trigger all;

alter table sam0014005 disable trigger all;
update sam0014005 a
   set f8_cfop = (mc_000400014005(b.ac_codforn, mc_002050014000(b.ac_codforn), a.f4_tes))[1]
  from sal0014005 b
 where b.al_serial = a.al_serial
   and a.f8_cfop is null;
alter table sam0014005 enable trigger all;

alter table sam0014006 disable trigger all;
update sam0014006 a
   set f8_cfop = (mc_000400014006(b.ac_codforn, mc_002050014000(b.ac_codforn), a.f4_tes))[1]
  from sal0014006 b
 where b.al_serial = a.al_serial
   and a.f8_cfop is null;
alter table sam0014006 enable trigger all;

alter table sam0014007 disable trigger all;
update sam0014007 a
   set f8_cfop = (mc_000400014007(b.ac_codforn, mc_002050014000(b.ac_codforn), a.f4_tes))[1]
  from sal0014007 b
 where b.al_serial = a.al_serial
   and a.f8_cfop is null;
alter table sam0014007 enable trigger all;

update sb30014001 set b3_bloqtxt = 'Revisar área';
update sb30014002 set b3_bloqtxt = 'Revisar área';
update sb30014003 set b3_bloqtxt = 'Revisar área';
update sb30014004 set b3_bloqtxt = 'Revisar área';
update sb30014005 set b3_bloqtxt = 'Revisar área';
update sb30014006 set b3_bloqtxt = 'Revisar área';
update sb30014007 set b3_bloqtxt = 'Revisar área';

drop table a0f0014000 cascade;

alter table saj0014001 disable trigger all;
delete
  from saj0014001 
 where sai_serial not in(
   select sai_serial
     from sai0014001);
alter table saj0014001 enable trigger all;

alter table saj0014002 disable trigger all;
delete
  from saj0014002 
 where sai_serial not in(
   select sai_serial
     from sai0014002);
alter table saj0014002 enable trigger all;

alter table saj0014003 disable trigger all;
delete
  from saj0014003 
 where sai_serial not in(
   select sai_serial
     from sai0014003);
alter table saj0014003 enable trigger all;

alter table saj0014004 disable trigger all;
delete
  from saj0014004 
 where sai_serial not in(
   select sai_serial
     from sai0014004);
alter table saj0014004 enable trigger all;

alter table saj0014005 disable trigger all;
delete
  from saj0014005 
 where sai_serial not in(
   select sai_serial
     from sai0014005);
alter table saj0014005 enable trigger all;

alter table saj0014006 disable trigger all;
delete
  from saj0014006 
 where sai_serial not in(
   select sai_serial
     from sai0014006);
alter table saj0014006 enable trigger all;

alter table saj0014007 disable trigger all;
delete
  from saj0014007 
 where sai_serial not in(
   select sai_serial
     from sai0014007);
alter table saj0014007 enable trigger all;