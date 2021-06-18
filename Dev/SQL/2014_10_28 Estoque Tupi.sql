set session authorization "52a7d18e4f6c5626c083bbcc173b8947"
insert into e050000001 (b1_codpro, b3_codlocal, e05_data, e05_qtde_u1, e05_custoe_u1, e05_qtds_u1)
values ('001', 1, '2014-08-03', 15, 46.570, 0)
insert into e010000001 (b1_codpro, a2h_cod, e01_data, e01_qtde_u1, e01_custoe_u1, e01_qtds_u1)
values ('001', '00', '2014-08-13', 25, 41.4, 0)
insert into e010000001 (b1_codpro, a2h_cod, e01_data, e01_qtde_u1, e01_custoe_u1, e01_qtds_u1)
values ('001', '00', '2014-08-01', 22, 36.80, 0)
insert into e010000001 (b1_codpro, a2h_cod, e01_data, e01_qtde_u1, e01_custoe_u1, e01_qtds_u1)
values ('001', '00', '2014-07-01', 22, 34.80, 0)
insert into e010000001 (b1_codpro, a2h_cod, e01_data, e01_qtde_u1, e01_custoe_u1, e01_qtds_u1)
values ('001', '00', '2014-07-02', 12, 34.80, 0)



delete from e000000001 where b1_codpro = '001' and e00_data = '2014-09-25';

truncate table e000000001;
truncate table e010000001;
truncate table e050000001;
truncate table e040000001;

select * from e050000001 
select * from e110000001 

select * from a490000001 


select * from e010000001 

truncate table e020000001
truncate table e030000001;

select * from e000000001 order by b1_codpro, e00_data
select * from e020000001 

update e000000001 set recno = recno where recno = 795



select * from ss0270000000 