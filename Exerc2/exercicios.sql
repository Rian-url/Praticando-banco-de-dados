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

-- 1. Listar nome,vencimento e valor de cada duplicata da tabela. 

select nm_cliente,dt_vencimento, vl_conta from tb_contas_a_receber;

-- 2. Apresentar o número das duplicatas depositadas no banco Itaú

select cd_conta from tb_contas_a_receber where nm_banco = "ITAU";

-- 3. Apresentar o número de duplicatas depositadas no banco Itaú 

select count(cd_conta) from tb_contas_a_receber where nm_banco = "ITAU";

-- 4. Quais são as duplicatas (número, vencimento, valor e nome) que vencem no ano de 2017. 

select * from tb_contas_a_receber where dt_vencimento like "2017%";

-- 5. Apresentar as duplicatas (número, vencimento, valor e nome) que não estão depositadas nos bancos Itaú e Santander. 

select * from tb_contas_a_receber where nm_banco != "ITAU" and  nm_banco != "SANTANDER";

-- 6. Quanto é o valor da divida o cliente PAPELARIA SILVA, e quais são as duplicatas? 

select cd_conta from tb_contas_a_receber where nm_cliente = "PAPELARIA SILVA";
select sum(vl_conta) as "VALOR TOTAL DAS DIVIDAS" from tb_contas_a_receber where nm_cliente = "PAPELARIA SILVA";

-- 7. Retirar da tabela a duplicata 770710 do cliente LIVRARIA FERNANDES, por ter sido devidamente quitada. 

delete from tb_contas_a_receber where cd_conta = 770710;
select * from tb_contas_a_receber where cd_conta = 770710;

-- 8. Apresentar uma listagem em ordem alfabética por nome do cliente de todos os campos da tabela. 

select * from tb_contas_a_receber order by nm_cliente;

-- 9. Apresentar uma listagem em ordem de data de vencimento com o nome do cliente, banco, valor e vencimento. 

select nm_cliente, nm_banco, vl_conta, dt_vencimento  from tb_contas_a_receber order by dt_vencimento;

-- 10. As duplicatas do Banco do Brasil foram transferidas para o Santander. Proceder o ajuste dos registros.

set sql_safe_updates = 0;

update tb_contas_a_receber 
 set nm_banco = "SANTANDER"
 where nm_banco = "BANCO DO BRASIL";
 
 set sql_safe_updates = 1;
 
 -- 11. Quais são os clientes que possuem suas duplicatas depositadas no Banco Bradesco?
 
 select nm_cliente from tb_contas_a_receber where nm_banco = "BRADESCO";
 
 -- 12. Qual é a previsão de recebimento no período de 01/01/2016 até 31/12/2016? 
 
 select dt_vencimento from tb_contas_a_receber where dt_vencimento < "2016-12-31" and dt_vencimento > "2016-01-01";
 
 -- 13. Quanto a empresa tem para receber no período de 01/05/2016 até 30/12/2016? 
 
select sum(vl_conta) as "VALOR A SER RECEBIDO" from tb_contas_a_receber where dt_vencimento < "2016-12-30" and dt_vencimento > "2016-05-01";

-- 15. Acrescentar uma multa de 15% para todos os títulos que se encontram vencidos no período de 01/01/2016 até 31/12/2016.  
 
set sql_safe_updates = 0;
 
update tb_contas_a_receber
set vl_conta = vl_conta + (vl_conta * 0.15)
where dt_vencimento < "2016-12-31" and dt_vencimento > "2016-01-01";

set sql_safe_updates = 1;

select * from tb_contas_a_receber;

-- 16. Acrescentar uma multa de 5% para todos os títulos vencidos entre 01/01/2017 e 31/05/2017 que sejam do cliente LER E SABER.

set sql_safe_updates = 0;
 
update tb_contas_a_receber
set vl_conta = vl_conta + (vl_conta * 0.05)
where dt_vencimento < "2017-05-31" and dt_vencimento > "2017-01-01";

set sql_safe_updates = 1;

select * from tb_contas_a_receber;

-- 17. Qual é a média aritmética dos valores das duplicatas do ano de 2016?

select sum(vl_conta)/count(vl_conta) as "MÉDIA ARITMÉTICA" from tb_contas_a_receber where dt_vencimento > "2016-01-01" and dt_vencimento < "2016-12-31";

-- 18. Exiba as duplicatas e nome dos respectivos clientes que possuem duplicatas com valor superior a 10000,00? 

select nm_cliente, vl_conta from tb_contas_a_receber where vl_conta > 1000;

-- 19. Qual o valor total das duplicatas lançadas para o banco Santander? 

select sum(vl_conta) as "VALOR TOTAL" from tb_contas_a_receber where nm_banco = "SANTANDER";

-- 20. Quais são os clientes que possuem suas duplicatas depositadas nos Bancos Bradesco ou Itaú? 

Select nm_cliente, nm_banco from tb_contas_a_receber where nm_banco = "BRADESCO" or nm_banco = "ITAU";
 
-- alter table tb_contas_a_receber change nm_conta  nm_cliente varchar(40); 	




