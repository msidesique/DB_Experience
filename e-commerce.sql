create database ecommerce;
use ecommerce;

create table cliente(
	idCliente int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    address varchar(45),
    constraint unique_cpf_client unique (CPF)
);

create table product(
	idProduct int auto_increment primary key,
    Pname varchar(30) not null,
    classif_kids bool default false,
    category enum('Eletrônico','Vestuário','Brinquedos','Alimentos') not null,
    score float default 0,
    size varchar(10)
);

create table payment(
	idCliente int,
    id_payment int,
    typePayment enum('Boleto', 'Cartão', 'Pix', 'Misto'),
    limitAvailable float,
    primary key(idCliente, id_payment)
);

create table pedido(
	idPedido int auto_increment primary key,
    idPedidoCliente int,
    PedidoStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    pedidoDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_pedido_cliente foreign key (idPedidoCliente) references cliente(idCliente)
);

create table productStorage(
	idProdStorage int auto_increment primary key,
	storageLocation varchar(255),
	quantity int default 0
);

create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_seller unique (CNPJ)
);

create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Sem estoque') default ('Disponível'),
    primary key (idPOproduct, idPOorder),
    constraint fk_product_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_product_product foreign key (idPOorder) references pedido(idPedido)
);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_product_seller foreign key (idLproduct) references product(idProduct),
    constraint fk_product_product foreign key (idPOorder) references pedido(idPedido)
);
    