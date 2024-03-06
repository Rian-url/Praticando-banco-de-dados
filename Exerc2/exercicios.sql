create database db_exerc2;
use db_exerc2;

create table tb_contas_a_receber(
cd_conta int not null primary key,
nm_cliente varchar(40),
vl_conta decimal(10,2),
dt_vencimento date,
nm_banco varchar(20)
);

insert into tb_contas_a_receber(cd_conta, nm_cliente, vl_conta, dt_vencimento, nm_banco) values 
(100100, "ABC PAPELARIA",      5000.00,   "2017-01-20", "ITAU"),
(100110, "LIVRARIA FERNANDES", 2500.00,   "2017-01-22", "ITAU"),
(100120, "LIVRARIA FERNANDES", 1500.00,   "2016-10-15", "BRADESCO"),
(100130, "ABC PAPELARIA",      8000.00,   "2016-10-15", "SANTANDER"),
(200120, "LER E SABER",        10500.00,  "2018-04-26", "BANCO DO BRASIL"),
(200125, "LIVROS E CIA",       2000.00,   "2018-04-26", "BANCO DO BRASIL"),
(200130, "LER E SABER",        11000.00,  "2018-09-26", "ITAU"),
(250350, "PAPELARIA SILVA",    1500.00,   "2018-01-26", "BRADESCO"),
(250360, "LIVROS MM",          500.00,    "2018-12-18", "SANTANDER"),
(250370, "LIVROS MM",          3400.00,   "2018-04-26", "SANTANDER"),
(250380, "PAPELARIA SILVA",    3500.00,   "2018-04-26", "BANCO DO BRASIL "),
(453360, "LIVROS E CIA",       1500.00,   "2018-06-15", "ITAU"),
(453365, "LIVROS MM ",         5400.00,   "2018-06-15", "BRADESCO"),
(453370, "PAPELARIA SILVA",    2350.00,   "2017-12-27", "ITAU"),
(453380, "LIVROS E CIA",       1550.00,   "2017-12-27", "BANCO DO BRASIL"),
(980130, "ABC PAPELARIA",      4000.00,   "2016-12-11", "ITAU"),
(770710, "LIVRARIA FERNANDES", 2500.00,   "2016-11-15", "SANTANDER"),
(985001, "ABC PAPELARIA",      3000.00,   "2016-11-09", "ITAU"),
(985002, "PAPEL E AFINS",       2500.00,    "2016-03-12", "SANTANDER"),
(888132, "LER E SABER",         2500.00 ,  "2017-03-05", "ITAU")
;

select nm_cliente,dt_vencimento, vl_conta from tb_contas_a_receber;

select cd_conta from tb_contas_a_receber where nm_banco = "ITAU";

select count(cd_conta) from tb_contas_a_receber where nm_banco = "ITAU";

select * from tb_contas_a_receber where dt_vencimento like "2017%";

select * from tb_contas_a_receber where nm_banco != "ITAU" and  nm_banco != "SANTANDER";

select cd_conta from tb_contas_a_receber where nm_cliente = "PAPELARIA SILVA";
select sum(vl_conta) as "VALOR TOTAL DAS DIVIDAS" from tb_contas_a_receber where nm_cliente = "PAPELARIA SILVA";

delete from tb_contas_a_receber where cd_conta = 770710;

select * from tb_contas_a_receber where cd_conta = 770710;

select * from tb_contas_a_receber order by nm_cliente;

select nm_cliente, nm_banco, vl_conta, dt_vencimento  from tb_contas_a_receber order by dt_vencimento;

set sql_safe_updates = 0;

update tb_contas_a_receber 
 set nm_banco = "SANTANDER"
 where nm_banco = "BANCO DO BRASIL";
 
 set sql_safe_updates = 1;
 
 select * from tb_contas_a_receber;

-- alter table tb_contas_a_receber change nm_conta  nm_cliente varchar(40); 	




