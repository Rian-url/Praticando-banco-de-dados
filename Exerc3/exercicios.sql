create database db_LongLife;
use db_LongLife;


create table tb_plan(
cd_plan char(2) not null primary key,
ds_plan longtext not null,
vl_plan decimal(10,2) not null
);

insert into tb_plan values
("B1", "BASICO 1", 200.00),
("B2", "BASICO 2", 150.00),
("B3", "BASICO 3", 100.00),
("E1", "EXECUTIVO 1", 350.00),
("E2", "EXECUTIVO 2", 300.00),
("E3", "EXECUTIVO 3", 250.00),
("M1", "MASTER 1", 500.00),
("M2", "MASTER 2", 450.00),
("M3", "MASTER 3", 400.00);

select * from tb_plan;

create table tb_client(
cd_client int auto_increment primary key,
fk_cd_plan char(2) not null,
nm_client varchar(50) not null,
nm_addres varchar(40) not null, 
nm_city varchar(30) not null,
nm_uf char(2) not null, 
CEP char(9) not null,
foreign key (fk_cd_plan) references tb_plan (cd_plan)
);

insert into tb_client values
(null, "B1", "JOSE ANTONIO DA SILVA", "TR. FELIPE DO AMARAL, 3450", "COTIA", "SP", "06700-000");

insert into tb_client values
(null, "B1", "MARIA DA SILVA SOBRINHO", "R. FELIPE DE JESUS, 1245", "DIADEMA", "SP", "09960-170"),
(null, "B1", "PEDRO JOSE DE OLIVEIRA", "R. AGREPINO DIAS, 155", "COTIA", "SP", "06700-011"),
(null, "B2", "ANTONIO DE FERNANDES", "R. PE EZEQUEL, 567 ", "DIADEMA", "SP", "09960-175"),
(null, "B2", "ANTONIO DO PRADO", "R. INDIO TABAJARA, 55", "GUARULHOS", "SP", "07132-999"),
(null, "B3", "WILSON DE SENA", "R. ARAPIRACA, 1234", "OSASCO", "SP", "06293-001"),
(null, "B3", "SILVIA DE ABREU", "R. DR.JOAO DA SILVA, 5", "SANTO ANDRE", "SP", "09172-112"),
(null, "E1", "ODETE DA CONCEICAO DA SILVA", "R. VOLUNTARIOS DA PATRIA, 10", "SAO PAULO", "SP", "02010-550"),
(null, "E2", "JAO CARLOS MACEDO", "R. VISTA ALEGRE, 500", "SAO PAULO", "SP", "04343-990"),
(null, "E3", "CONCEICAO DA SILVA", "AV. VITORIO DO AMPARO, 11", "MAUA", "SP", "09312-988"),
(null, "E3", "PAULO BRUNO AMARAL", "R. ARGENZIO BRILHANTE, 88", "BARUERI", "SP", "06460-999"),
(null, "E3", "WALDENICE", "R. OURO VELHO, 12", "BARUERI", "SP", "06460-998"),
(null, "E3", "MARCOS DO AMARAL", "R. DO OUVIDOR, 67", "GUARULHOS", "SP", "07031-555"),
(null, "M1", "MURILO DE SANTANA", "R. PRATA DA CASA", "BARUERI", "SP", "06455-111"),
(null, "M1", "LUIZA ONOFRE FREITAS", "R. VICENTE DE ABREU, 55", "SANTO ANDRE", "SP", "09060-667"),
(null, "M2", "MELISSA DE ALMEIDA", "R. FERNANDO ANTONIO, 2345", "SAO PAULO", "SP", "04842-987"),
(null, "M2", "JOAO INACIO DA CONCEICAO", "R. PENELOPE CHARMOSA, 34", "SUZANO", "SP", "08670-888"),
(null, "B3", "AUGUSTO DE ABREU", "AV. RIO DA SERRA, 909", "SANTO ANDRE", "SP", "09061-333"),
(null, "M3", "ILDA DE MELO DA CUNHA", "AV. POR DO SOL, 546", "SANTO ANDRE", "SP", "09199-444"),
(null, "M3", "MARCOS DA CUNHA", "AV. PEDROSO DE MORAES", "SAO PAULO", "SP", "04040-444");


select * from tb_client;

-- 2. Extrair uma relação geral de todos os associados e os planos que eles possuem.
 select nm_client, fk_cd_plan
 from tb_client C
 inner join tb_plan P
 on C.fk_cd_plan = P.cd_plan;
 
 -- 3. Quantos associados possuem o plano B1?
 select count(cd_client)
 from tb_client
 where fk_cd_plan = "B1";
 
 -- 4. Apresente uma relação com todos os nomes, planos e valores de todos os registros de associados
 select nm_client as "NOME",
 fk_cd_plan as "PLANO",
 vl_plan as "VALOR"
 from tb_client C
 inner join tb_plan P
 on C.fk_cd_plan = P.cd_plan;
 
-- 5. Quais são os associados que moram em COTIA ou em DIADEMA?
 select nm_client, nm_city 
 from tb_client where nm_city = "COTIA" or nm_city = "DIADEMA";

-- 6. Apresente o nome, plano e valor dos associados que moram em BARUERI e possuem o plano M1
 select nm_client as "NOME",
 fk_cd_plan as "PLANO",
 vl_plan as "VALOR"
 from tb_client C
 inner join tb_plan P
 on C.fk_cd_plan = P.cd_plan
 where C.nm_city = "BARUERI" 
 and C.fk_cd_plan = "M1";
 
 -- 7. Apresente uma relação com nome, plano e valor de todos os associados residentes em SÃO PAULO
 select nm_client as "NOME",
 fk_cd_plan as "PLANO",
 vl_plan as "VALOR"
 from tb_client C
 inner join tb_plan P
 on C.fk_cd_plan = P.cd_plan
 where C.nm_city = "SAO PAULO";
 
 -- 8. Apresente uma relação completa de todos os campos de ambas as tabelas em que o associado possua SILVA no nome.
 select *
 from tb_client C
 inner join tb_plan P
 on C.fk_cd_plan = P.cd_plan
 where nm_client like "%SILVA%";
  
-- 9. Devido ao aumento do índice IGPM, a empresa reajustou os valores dos planos básicos em 10%, 
-- dos planos executivos em 5% e dos planos Máster em 3 %. Atualize os valores na tabela planos.

 update tb_plan
 set vl_plan = vl_plan + (vl_plan * 0.10)
 where cd_plan like "B%";
 
 update tb_plan
 set vl_plan = vl_plan + (vl_plan * 0.05)
 where cd_plan like "M%";
 
 update tb_plan
 set vl_plan = vl_plan + (vl_plan * 0.03)
 where cd_plan like "E%";
 
 select * from tb_plan;
 
-- 10. O associado PEDRO JOSE DE OLIVEIRA alterou seu plano de B1 para E3. Faça a devida atualização.

 update tb_client
 set fk_cd_plan = "E3"
 where nm_client = "PEDRO JOSE DE OLIVEIRA";

 select * from tb_client;
 
-- 11. Quantos associados possuem o plano E3?
 select count(nm_client) from tb_client where fk_cd_plan = "E3";  
 
-- 12.Liste o nome e o valor de todos os associados que possuem os planos B1, E1 e M1.
 select nm_client, vl_plan
 from tb_client C
 inner join tb_plan P
 on C.fk_cd_plan = P.cd_plan
 where C.fk_cd_plan like "%1";

-- 13. Quais são os associados que possuem plano do tipo EXECUTIVO, independentemente da categoria ser 1, 2 ou 3?
 select nm_client, fk_cd_plan
 from tb_client
 where fk_cd_plan like "E%";
 
 -- 14. Quais são os associados que possuem plano dos tipos Básico e Máster?
 select nm_client, fk_cd_plan
 from tb_client
 where fk_cd_plan not like "E%";
 
 -- 15. A empresa fechou seu escritório na cidade de SANTO ANDRE e transferiu os cliente para um terceirizado.
 -- Remova da tabela associados todos os registros existentes de associados da cidade de SANTO ANDRE
  delete from tb_client 
  where nm_city = "SANTO ANDRE";
  
-- 16. Apresente o nome, plano e valor dos associados que moram em SÃO PAULO e 
-- possuem os planos M2 e M3. A listagem deve estar ordenada pelo campo nome.

select nm_client as "NOME",
cd_plan as "PLANO",
vl_plan as "VALOR"
from tb_client C
inner join tb_plan P
on C.fk_cd_plan = P.cd_plan
where nm_city = "SAO PAULO"
order by nm_client;

-- 17. Apresente uma listagem completa de todos os campos de ambas as tabelas ordenados por tipo de plano.
 select * from tb_client C 
 inner join tb_plan P 
 on C.fk_cd_plan = P.cd_plan
 order by cd_plan;
 
-- 18. Faça uma relação geral de todos os associados e planos que eles possuem. A relação deve ser apresentada em ordem 
-- ascendente pelo campo tipo de plano e descendente pelo campo de identificação do nome do associado.
 select * from tb_client C 
 inner join tb_plan P 
 on C.fk_cd_plan = P.cd_plan
 order by cd_plan asc, nm_client desc;
 
-- 19. Apresentar uma relação de todos os associados que não possuem o plano Máster.
 select nm_client, fk_cd_plan
 from tb_client
 where fk_cd_plan not like "M%";
 
-- 20. Apresentar uma listagem em ordem crescente pelo campo nome do associado. Essa listagem deve ser formada pelos 
-- campos Nome da tabela associado e Descrição da tabela Planos
 select nm_client, ds_plan
 from tb_client C
 inner join tb_plan P 
 on C.fk_cd_plan = P.cd_plan
 order by nm_client asc;
 
-- 21. Apresentar uma listagem dos planos que estão situados na faixa de valores de 300 até 500
 select * from tb_plan
 where vl_plan > 300 and vl_plan < 500;

-- 22. Apresentar uma relação contendo: nome,plano, descrição do plano e valor de todos os associados que tenham em 
-- seu nome, seja na posição que for, a seqüência AMARAL.
 select nm_client as "NOME",
 cd_plan as "PLANO",
 ds_plan as "DESCRICAO",
 vl_plan as "VALOR"
 from tb_client C 
 inner join tb_plan P 
 on C.fk_cd_plan = P.cd_plan
 where nm_client like "%AMARAL%";
 
-- 23. Quais associados residem na cidade de DIADEMA?
 select nm_client from tb_client 
 where nm_city = "DIADEMA";
 
-- 24. O plano do tipo MASTER teve um reajuste de 6%. Atualize na tabela planos os valores das categorias 1, 2 e 3.
 update tb_plan
 set vl_plan = vl_plan + (vl_plan * 0.06)
 where cd_plan like "M%";
 
 select * from tb_plan;
 
-- 25. Quais são os clientes cujo CEP é iniciado com os valores 09?
 select nm_client, CEP from tb_client
 where CEP like "09%";
 
 