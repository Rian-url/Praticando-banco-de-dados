create database  bd_vendas;
use bd_vendas;


create table tb_produto (
cd_produto int auto_increment primary key,
ds_produto varchar(30) not null,
vl_preco float not null
);

create table tb_nota_fiscal(
 cd_nota_fiscal int auto_increment primary key,
 dt_data date not null,
 vl_nota_fiscal float not null
);


create table tb_items(
 cd_item int auto_increment primary key,
 fk_cd_produto int not null,
 fk_cd_nota_fiscal int not null,
 qt_item int not null,
 foreign key (fk_cd_produto) references tb_produto(cd_produto),
 foreign key (fk_cd_nota_fiscal) references tb_nota_fiscal(cd_nota_fiscal)
);

alter table tb_produto modify ds_produto varchar(50) ;

alter table tb_nota_fiscal add nr_ICSM float after cd_nota_fiscal;

alter table tb_produto add vl_peso float;

describe tb_produto;

describe tb_nota_fiscal;

alter table tb_nota_fiscal change vl_nota_fiscal vl_total_nf float not null;

alter table tb_nota_fiscal drop dt_data;

drop table tb_items;

rename table tb_nota_fiscal to tb_venda;

describe tb_venda;