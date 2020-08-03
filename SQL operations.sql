-- create database Books;



-- create user 
grant INSERT, UPDATE,select,delete
ON books
to worker;
grant INSERT, UPDATE,select,delete
ON book_authers
to worker;
grant INSERT, UPDATE,select,delete
ON books_condition
to worker;
grant INSERT, UPDATE,select,delete
ON customer
to worker;
grant INSERT, UPDATE,select,delete
ON deal
to worker;
grant INSERT, UPDATE,select,delete
ON deal_book
to worker;

grant INSERT, UPDATE,select,delete
ON delivery
to worker;
grant INSERT, UPDATE,select,delete
ON delivery_address
to worker;
grant INSERT, UPDATE,select,delete
ON delivery_book
to worker;
grant INSERT, UPDATE,select,delete
ON delivery_edition
to worker;
grant INSERT, UPDATE,select,delete
ON delivery_type
to worker;
grant INSERT, UPDATE,select,delete
ON edition
to worker;
grant INSERT, UPDATE,select,delete
ON edition_translating
to worker;
grant INSERT, UPDATE,select,delete
ON edition_translating
to worker;
grant INSERT, UPDATE,select,delete
ON members
to worker;
grant INSERT, UPDATE,select,delete
ON order_book
to worker;
grant INSERT, UPDATE,select,delete
ON supplies
to worker;
grant INSERT, UPDATE,select,delete
ON supplies_book
to worker;
grant INSERT, UPDATE,select,delete
ON ordervbook
to worker;
grant INSERT, UPDATE,select,delete
ON vendor
to worker;
grant INSERT, UPDATE,select,delete
ON worker
to worker;
grant INSERT, UPDATE,select,delete
ON worker_address
to worker;
grant INSERT, UPDATE,select,delete
ON worker_salary
to worker;

-- create tables
create table members(
id varchar(45) NOT NULL,
type_member varchar(45) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE customer (
id varchar(45) NOT NULL ,
first_name varchar(45) NOT NULL ,
last_name varchar(45),
cellular_num varchar(45) NOT NULL ,
phone_num varchar(45),
join_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (id) REFERENCES members (id),
 PRIMARY KEY (id)
);

CREATE TABLE all_payment_store (
month_year timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
electricity int DEFAULT 0,
rant int DEFAULT 0,
property_tex int DEFAULT 0,
water int DEFAULT 0,
cellular_num int DEFAULT 0,
phone_num int DEFAULT 0,
delivery int DEFAULT 0,
salaries int DEFAULT 0,
various int DEFAULT 0,
total int DEFAULT 0,
PRIMARY KEY (month_year)

);

create table vendor(
id varchar(45) NOT NULL,
vendor_name varchar(45) NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES members (id)
);
create table supplies(
supply_id smallint unsigned NOT NULL AUTO_INCREMENT,
id varchar(45) NOT NULL,
month_year timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
full_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (supply_id),
FOREIGN KEY (id) REFERENCES members (id),
FOREIGN KEY (month_year) REFERENCES all_payment_store (month_year)
);

CREATE TABLE books (
title varchar(45) NOT NULL ,
price int,
price_store int,
num_page int ,
weight float,
current_inventory int , 
location varchar(100) ,
PRIMARY KEY (title)
);
create table supplies_book(
supply_id smallint unsigned NOT NULL AUTO_INCREMENT,
title varchar(45) NOT NULL ,
_sum int DEFAULT 1,
PRIMARY KEY (supply_id,title),
FOREIGN KEY (supply_id) REFERENCES supplies (supply_id),
FOREIGN KEY (title) REFERENCES books(title)
);


CREATE TABLE worker (
num_worker smallint unsigned NOT NULL AUTO_INCREMENT,
first_name varchar(45) NOT NULL ,
last_name varchar(45),
cellular_num varchar(45) NOT NULL ,
start_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
end_date timestamp DEFAULT NULL,
still_work BOOLEAN,
PRIMARY KEY (num_worker)
);

CREATE TABLE worker_salary (
num_worker smallint unsigned NOT NULL,
month_year timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
hours int default 0,
PRIMARY KEY (num_worker,month_year),
FOREIGN KEY (num_worker) REFERENCES worker (num_worker),
FOREIGN KEY (month_year) REFERENCES all_payment_store (month_year)
);

CREATE TABLE worker_address (
num_worker smallint unsigned NOT NULL,
city  varchar(45) NOT NULL ,
street  varchar(45) NOT NULL ,
_num int DEFAULT 0,
 FOREIGN KEY (num_worker ) REFERENCES worker (num_worker)
);



CREATE TABLE deal (
num_deal smallint unsigned NOT NULL AUTO_INCREMENT,
num_worker smallint unsigned NOT NULL,
id varchar(45) NOT NULL ,
payment_sum int NOT NULL,
payment_way varchar(45) NOT NULL ,
date_deal timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (num_deal),
FOREIGN KEY (num_worker) REFERENCES worker (num_worker),
FOREIGN KEY (id) REFERENCES customer(id)
);

CREATE TABLE deal_book (
num_deal smallint unsigned NOT NULL,
title varchar(45) NOT NULL ,
_sum int DEFAULT 1,
PRIMARY KEY (num_deal,title),
FOREIGN KEY (num_deal) REFERENCES deal (num_deal),
FOREIGN KEY (title) REFERENCES books(title)
);

CREATE TABLE order_book (
order_id smallint unsigned NOT NULL AUTO_INCREMENT,
id varchar(45) NOT NULL ,
_status varchar(45) NOT NULL ,
order_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
closed_date timestamp  DEFAULT NULL,
FOREIGN KEY (id) REFERENCES customer (id),
PRIMARY KEY (order_id)
);

CREATE TABLE orderVbook (
order_id smallint unsigned NOT NULL,
title varchar(45) NOT NULL ,
_sum int default 1,
primary key(order_id,title ),
FOREIGN KEY (order_id ) REFERENCES order_book (order_id),
FOREIGN KEY (title ) REFERENCES books (title)
);

-- -----------------------------------
CREATE TABLE books_condition (
title varchar(45) NOT NULL ,
book_condition varchar(100), 
current_inventory int ,
primary key (title,book_condition),
FOREIGN KEY (title) REFERENCES books (title)
);

CREATE TABLE book_authers (
_name varchar(45)  ,
title varchar(45) NOT NULL ,
 PRIMARY KEY (_name),
 FOREIGN KEY (title) REFERENCES books (title)
);

CREATE TABLE edition (
edition_id smallint unsigned NOT NULL AUTO_INCREMENT,
title varchar(45) NOT NULL ,
_year varchar(45) NOT NULL ,
publisher varchar(45) NOT NULL ,
PRIMARY KEY (edition_id),
FOREIGN KEY (title) REFERENCES books (title)
);
CREATE TABLE delivery_type (
type_delivery smallint unsigned NOT NULL AUTO_INCREMENT,
name_company varchar(45) NOT NULL ,
_type varchar(45) NOT NULL ,
PRIMARY KEY (type_delivery)
);

CREATE TABLE delivery (
delivery_id  smallint unsigned NOT NULL AUTO_INCREMENT,
num_deal smallint unsigned,
_status varchar(45) NOT NULL ,
type_delivery smallint unsigned NOT NULL,
PRIMARY KEY (delivery_id),
FOREIGN KEY (type_delivery) REFERENCES delivery_type (type_delivery),
FOREIGN KEY (num_deal) REFERENCES deal (num_deal)
);
CREATE TABLE delivery_address (
delivery_id  smallint unsigned NOT NULL,
city  varchar(45) NOT NULL ,
street  varchar(45) NOT NULL ,
_num int DEFAULT 0,
primary key (delivery_id,city, street,_num),
FOREIGN KEY (delivery_id ) REFERENCES delivery (delivery_id)
);
CREATE TABLE delivery_edition (
delivery_id  smallint unsigned NOT NULL,
edition_id smallint unsigned NOT NULL,
primary key (delivery_id,edition_id),
FOREIGN KEY (delivery_id ) REFERENCES delivery (delivery_id),
FOREIGN KEY (edition_id) REFERENCES edition (edition_id)
);
CREATE TABLE delivery_book (
delivery_id  smallint unsigned NOT NULL,
title varchar(45) NOT NULL ,
_sum int DEFAULT 1,
PRIMARY KEY (delivery_id,title),
FOREIGN KEY (delivery_id) REFERENCES delivery (delivery_id),
FOREIGN KEY (title) REFERENCES books(title)
);

CREATE TABLE edition_translating (
edition_id smallint unsigned NOT NULL,
language_edition varchar(45) DEFAULT 'English' ,
FOREIGN KEY (edition_id) REFERENCES edition (edition_id)
);



 -- insert member

INSERT INTO members(id,type_member)
   VALUES ('101010101','customer');
INSERT INTO members(id,type_member)
  VALUES ('203123456','customer');
INSERT INTO members(id,type_member)
  VALUES ('203123999','customer');
INSERT INTO members(id,type_member)
  VALUES ('203111111','customer');
 INSERT INTO members(id,type_member)
  VALUES ('111212121','customer');
 INSERT INTO members(id,type_member)
  VALUES ('909876541','customer');
  INSERT INTO members(id,type_member)
  VALUES ('123454321','customer');
   INSERT INTO members(id,type_member)
  VALUES ('234567890','customer');
 INSERT INTO members(id,type_member)
  VALUES ('209876789','customer');
 INSERT INTO members(id,type_member)
  VALUES ('202121234','customer');
  INSERT INTO members(id,type_member)
  VALUES ('200000000','external');
  INSERT INTO members(id,type_member)
  VALUES ('300000000','external');
  INSERT INTO members(id,type_member)
  VALUES ('400000000','external');



-- insert customer

INSERT INTO customer(id,first_name,last_name,cellular_num ,phone_num,join_date)
  VALUES ('101010101','aviv','cohen','054-3423123','03-3399912','2020-11-02');
INSERT INTO customer(id,first_name,last_name,cellular_num ,phone_num,join_date)
  VALUES ('203123456','david','levy','054-3323129','03-3449912','2019-08-02');
INSERT INTO customer(id,first_name,last_name,cellular_num ,phone_num,join_date)
  VALUES ('203123999','dan','shalom','050-5553129','03-8989912','2019-01-02');
INSERT INTO customer(id,first_name,last_name,cellular_num ,phone_num,join_date)
  VALUES ('203111111','niv','assaf','050-6667129','03-8989000','2020-01-02');
  INSERT INTO customer(id,first_name,last_name,cellular_num ,phone_num,join_date)
  VALUES ('111212121','norit','ben','050-0007129','03-1122000','2020-01-014');
  INSERT INTO customer(id,first_name,last_name,cellular_num ,phone_num,join_date)
  VALUES ('909876541','yossi','cohen','050-3427129','03-6767000','2020-03-02');
   INSERT INTO customer(id,first_name,last_name,cellular_num ,phone_num,join_date)
  VALUES ('123454321','maya','daniel','050-9090909','03-6114400','2020-01-02');
   INSERT INTO customer(id,first_name,last_name,cellular_num ,phone_num,join_date)
  VALUES ('234567890','omer','adam','052-8765456','03-9871256','2019-02-02');
   INSERT INTO customer(id,first_name,last_name,cellular_num ,phone_num,join_date)
  VALUES ('209876789','dor','mosh','052-0005456','03-9871000','2020-01-02');
  INSERT INTO customer(id,first_name,last_name,cellular_num ,phone_num,join_date)
  VALUES ('202121234','dana','or','052-2222496','03-2221340','2020-03-02');
 --  select *from vendor;
   INSERT INTO vendor (id,vendor_name)
   VALUES ('200000000','doron');
   INSERT INTO vendor (id,vendor_name)
   VALUES ('300000000','labery shalom');

select *from all_payment_store;
INSERT INTO all_payment_store(month_year ,electricity,rant,property_tex,water,cellular_num,phone_num ,delivery,salaries,various,total)
  VALUES ('2019-07-01','350','2500','450','210','230','135','390','1500','340','6105');
   INSERT INTO all_payment_store(month_year ,electricity,rant,property_tex,water,cellular_num,phone_num ,delivery,salaries,various,total)
   VALUES ('2019-08-01','420','2500','450','190','210','110','420','980','205','5485');
    INSERT INTO  all_payment_store(month_year ,electricity,rant,property_tex,water,cellular_num,phone_num ,delivery,salaries,various,total)
   VALUES ('2019-09-01','300','2500','450','230','200','150','290','570','150','4740');
    INSERT INTO  all_payment_store(month_year ,electricity,rant,property_tex,water,cellular_num,phone_num ,delivery,salaries,various,total)
   VALUES ('2019-010-01','320','2500','450','220','100','330','300','800','100','5120');
    INSERT INTO  all_payment_store(month_year ,electricity,rant,property_tex,water,cellular_num,phone_num ,delivery,salaries,various,total)
   VALUES ('2019-11-01','400','2500','450','250','150','310','290','290','200','4840');
   INSERT INTO  all_payment_store(month_year ,electricity,rant,property_tex,water,cellular_num,phone_num ,delivery,salaries,various,total)
   VALUES ('2019-12-01','420','2500','450','200','210','250','260','1040','90','5420');
   INSERT INTO  all_payment_store(month_year ,electricity,rant,property_tex,water,cellular_num,phone_num ,delivery,salaries,various,total)
   VALUES ('2020-01-01','440','2500','450','290','310','350','330','850','120','5640');
  INSERT INTO  all_payment_store(month_year ,electricity,rant,property_tex,water,cellular_num,phone_num ,delivery,salaries,various,total)
   VALUES ('2020-02-01','410','2500','450','300','350','295','270','1010','220','5805');
   INSERT INTO  all_payment_store(month_year ,electricity,rant,property_tex,water,cellular_num,phone_num ,delivery,salaries,various,total)
   VALUES ('2020-03-01','390','2500','450','330','400','430','420','1830','200','6950');
     INSERT INTO  all_payment_store(month_year ,electricity,rant,property_tex,water,cellular_num,phone_num ,delivery,salaries,various,total)
   VALUES ('2020-04-01','390','2500','450','330','400','430','420','1830','200','6950');
    
  select * from worker;
   INSERT INTO worker(first_name,last_name,cellular_num,start_date,end_date,still_work)
  VALUES ('ben', 'ram','050-4488987','2018-01-02','2018-09-02',0);
  INSERT INTO worker(first_name,last_name,cellular_num,start_date,still_work)
  VALUES ('josh', 'jame','052-4123657','2019-01-03',1);
INSERT INTO worker(first_name,last_name,cellular_num,start_date,end_date,still_work)
  VALUES ('miki', 'shay','053-4336235','2017-01-05','2018-10-02',0);
INSERT INTO worker(first_name,last_name,cellular_num,start_date,still_work)
  VALUES ('maya', 'shame','052-0650300','2020-01-03',1);
INSERT INTO worker(first_name,last_name,cellular_num,start_date,end_date,still_work)
  VALUES ('kim', 'einat','054-112345','2016-01-07','2019-10-02',0);
INSERT INTO worker(first_name,last_name,cellular_num,start_date,end_date,still_work)
  VALUES ('shimi', 'kor','058-119087','2018-08-05','2019-01-06',0);
INSERT INTO worker(first_name,last_name,cellular_num,start_date,end_date,still_work)
  VALUES ('yaron', 'fridman','052-889874','2014-05-03','2018-10-03',0);
INSERT INTO worker(first_name,last_name,cellular_num,start_date,still_work)
  VALUES ('rona','bay','053-563728','2017-01-07',1);
INSERT INTO worker(first_name,last_name,cellular_num,start_date,still_work)
  VALUES ('josi', 'nike','052-336349','2017-01-06',1);
INSERT INTO worker(first_name,last_name,cellular_num,start_date,still_work)
  VALUES ('mor', 'rik','052-299807','2018-06-03',1);
 
INSERT INTO worker_address(num_worker,city,street,_num)
  VALUES ('1', 'Ramat-Gan','Zahal' ,9);
  INSERT INTO worker_address(num_worker,city,street,_num)
  VALUES ('2', 'Tel-Aviv','shalom' ,13);
INSERT INTO worker_address(num_worker,city,street,_num)
  VALUES ('3', 'Ramat-Gan','Tel-hay' ,15);
INSERT INTO worker_address(num_worker,city,street,_num)
  VALUES ('4', 'Lod','Yerdan' ,58);
INSERT INTO worker_address(num_worker,city,street,_num)
  VALUES ('5', 'Ramat-Gan','Negba' ,91);
INSERT INTO worker_address(num_worker,city,street,_num)
  VALUES ('6', 'Givataaim','Toval' ,1);
INSERT INTO worker_address(num_worker,city,street,_num)
  VALUES ('7', 'Tel-Aviv','Arlozorov' ,101);
INSERT INTO worker_address(num_worker,city,street,_num)
  VALUES ('8', 'Rehovot','macabim' ,3);
INSERT INTO worker_address(num_worker,city,street,_num)
  VALUES ('9', 'Ramat-Gan','Zahal' ,81);
INSERT INTO worker_address(num_worker,city,street,_num)
  VALUES ('10', 'Yehud','hassid' ,3);
select * from supplies;

INSERT INTO supplies(supply_id,month_year ,id ,full_date)
  VALUES (1,'2019-07-01','200000000','2019-07-010');
  INSERT INTO supplies(supply_id,month_year ,id ,full_date)
  VALUES (4,'2019-08-01','200000000','2019-08-011');
 INSERT INTO supplies(supply_id,month_year ,id ,full_date)
  VALUES (5,'2019-09-01','200000000','2019-09-012');
 INSERT INTO supplies(supply_id,month_year ,id ,full_date)
  VALUES (6,'2019-010-01','300000000','2019-010-010');
INSERT INTO supplies(supply_id,month_year ,id ,full_date)
  VALUES (7,'2019-011-01','300000000','2019-011-09');
 INSERT INTO supplies(supply_id,month_year ,id ,full_date)
  VALUES (8,'2019-011-01','300000000','2019-012-09');
 INSERT INTO supplies(supply_id,month_year ,id ,full_date)
  VALUES (9,'2020-01-01','203123999','2020-01-010');
INSERT INTO supplies(supply_id,month_year ,id ,full_date)
  VALUES (10,'2020-02-01','203123999','2020-02-010');
  INSERT INTO supplies(supply_id,month_year ,id ,full_date)
  VALUES (12,'2019-07-01','909876541','2019-07-010');
  INSERT INTO supplies(supply_id,month_year ,id ,full_date)
  VALUES (13,'2019-07-01','111212121','2019-07-010');
  INSERT INTO supplies(supply_id,month_year ,id ,full_date)
  VALUES (15,'2019-07-01','111212121','2019-07-012');
  INSERT INTO supplies(supply_id,month_year ,id ,full_date)
  VALUES (16,'2020-02-01','203123999','2020-02-010');
  

select * from books;
INSERT INTO books (title,price,price_store,num_page,weight,current_inventory,location)
 VALUES ('Lolita',40,20,500,2.2,20,'store');
INSERT INTO books (title,price,price_store,num_page,weight,current_inventory,location)
 VALUES ('The Hobbit',55,22,384,1.3,13,'Storage');
 INSERT INTO books (title,price,price_store,num_page,weight,current_inventory,location)
 VALUES ('Little Women',35,19,298,1.7,9,'store');
 INSERT INTO books (title,price,price_store,num_page,weight,current_inventory,location)
 VALUES ('Animal Farm',71,56,213,2.0,19,'Storage');
 INSERT INTO books (title,price,price_store,num_page,weight,current_inventory,location)
 VALUES ('Gone with the Wind',43,29,321,1.5,10,'store');
 INSERT INTO books (title,price,price_store,num_page,weight,current_inventory,location)
 VALUES ('Charlotte’s Web',52,27,245,1.3,15,'store');
 INSERT INTO books (title,price,price_store,num_page,weight,current_inventory,location)
 VALUES ('Lord of the Flies',60,34,242,1.4,6,'storage');
INSERT INTO books (title,price,price_store,num_page,weight,current_inventory,location)
 VALUES ('The Kite Runner',72,54,145,1.9,2,'storage');
 INSERT INTO books (title,price,price_store,num_page,weight,current_inventory,location)
 VALUES ('Romeo and Juliet',81,62,491,2.3,10,'store');
 INSERT INTO books (title,price,price_store,num_page,weight,current_inventory,location)
 VALUES ('Wuthering Heights',57,33,324,1.9,8,'store');
SELECT *FROM books;

select * from delivery_type;
 INSERT INTO delivery_type(name_company,_type)
 VALUES ('Israel Post', 'EXPRESS');
 INSERT INTO delivery_type(name_company,_type)
 VALUES ('Xpress', 'EXPRESS');
 INSERT INTO delivery_type(name_company,_type)
 VALUES ('Israel Post', 'Rgular');
 INSERT INTO delivery_type(name_company,_type)
 VALUES ('Xpress', 'Rgular');
INSERT INTO deal(num_worker,id,payment_sum,payment_way,date_deal)
  VALUES ('1', '101010101',95,'Bit','2018-05-20');
  INSERT INTO deal(num_worker,id,payment_sum,payment_way,date_deal)
  VALUES ('1', '203123456',145,'credit','2018-04-20');
INSERT INTO deal(num_worker,id,payment_sum,payment_way,date_deal)
  VALUES ('2', '909876541',146,'Bank transfer','2020-07-20');
INSERT INTO deal(num_worker,id,payment_sum,payment_way,date_deal)
  VALUES ('2', '909876541',200,'Bit','2020-06-15');
INSERT INTO deal(num_worker,id,payment_sum,payment_way,date_deal)
  VALUES ('3', '203111111',85,'credit','2018-09-15');
INSERT INTO deal(num_worker,id,payment_sum,payment_way,date_deal)
  VALUES ('8', '111212121',105,'Bank transfer','2020-02-05');
INSERT INTO deal(num_worker,id,payment_sum,payment_way,date_deal)
  VALUES ('4', '111212121',63,'Bit','2020-03-20');
INSERT INTO deal(num_worker,id,payment_sum,payment_way,date_deal)
  VALUES ('7', '203111111',185,'credit','2018-06-23');
INSERT INTO deal(num_worker,id,payment_sum,payment_way,date_deal)
  VALUES ('8', '209876789',90,'credit','2019-05-20');
INSERT INTO deal(num_worker,id,payment_sum,payment_way,date_deal)
  VALUES ('8', '209876789',155,'Bit','2019-07-20');
INSERT INTO delivery(delivery_id ,num_deal,_status,type_delivery)
  VALUES (1,3, 'send',1);
 iNSERT INTO delivery(delivery_id ,num_deal,_status,type_delivery)
  VALUES (2,3, 'In preparation',1);
iNSERT INTO delivery(delivery_id ,num_deal,_status,type_delivery)
  VALUES (3,5, 'Arrived and waiting for collection',1);
iNSERT INTO delivery(delivery_id ,num_deal,_status,type_delivery)
  VALUES (4,5, 'Delivered',1);
iNSERT INTO delivery(delivery_id ,num_deal,_status,type_delivery)
  VALUES (5,1, 'send',1);
iNSERT INTO delivery(delivery_id ,num_deal,_status,type_delivery)
  VALUES (6,2, 'In preparation',1);
iNSERT INTO delivery(delivery_id ,num_deal,_status,type_delivery)
  VALUES (7,4, 'Arrived and waiting for collection',2);
iNSERT INTO delivery(delivery_id ,num_deal,_status,type_delivery)
  VALUES (8,6, 'Delivered',2);
iNSERT INTO delivery(delivery_id ,num_deal,_status,type_delivery)
  VALUES (9,7, 'send',2);
iNSERT INTO delivery(delivery_id ,num_deal,_status,type_delivery)
  VALUES (10,9, 'send',3);
  iNSERT INTO delivery(delivery_id ,num_deal,_status,type_delivery)
  VALUES (11,10, 'send',3);

select * from deal_book;

INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('1','The hobbit',1 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('1','Lolita',1 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('2','The hobbit',2 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('2','Little Women', 1 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('3', 'Little Women',1 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('3', 'Charlotte’s Web',1 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('4','Animal Farm',3 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('5', 'Little Women',1 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('5','Gone with the wind',1 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('6','Romeo and Juliet',1 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('7','The kite Runner',1 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('9', 'Charlotte’s Web',2 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('10','Lolita',3 );
INSERT INTO deal_book(num_deal,title,_sum)
  VALUES ('8', 'Romeo and Juliet',2 );
select * from delivery;
iNSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('1','Charlotte’s Web','1');
INSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('2','Little Women','1');
INSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('3','Gone with the wind','1');
INSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('4','Little Women','1');
INSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('5','Lolita','1');
INSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('5','The hobbit','1');
INSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('6','The hobbit','2');
INSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('6','Little Women','1');
INSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('7','Animal Farm','3');
INSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('8','Romeo and Juliet','1');
INSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('10','Romeo and Juliet','2');
INSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('9','The Kite Runner','1');
  INSERT INTO delivery_book(delivery_id ,title,_sum)
  VALUES ('11','Lolita','3');
  
  
  
  
select * from delivery_book;
select * from deal_book;

INSERT INTO delivery_address(delivery_id ,city,street,_num)
  VALUES ('1','Ramat Gan','Hayrden','31');
INSERT INTO delivery_address(delivery_id ,city,street,_num)
  VALUES ('2','Tel Aviv','bograshov','15');
INSERT INTO delivery_address(delivery_id ,city,street,_num)
  VALUES ('3','Yehud','Shalom','101');
INSERT INTO delivery_address(delivery_id ,city,street,_num)
  VALUES ('4','Ramat Gan','Tel Hay','53');
INSERT INTO delivery_address(delivery_id ,city,street,_num)
  VALUES ('5','Lod','Shabazi','24');
INSERT INTO delivery_address(delivery_id ,city,street,_num)
  VALUES ('6','Tel Aviv','Gat','123');
INSERT INTO delivery_address(delivery_id ,city,street,_num)
  VALUES ('7','Givataaim','borohov','41');
INSERT INTO delivery_address(delivery_id ,city,street,_num)
  VALUES ('8','Lod','Mishel','13');
INSERT INTO delivery_address(delivery_id ,city,street,_num)
  VALUES ('9','Ramat Gan','Negba','55');
INSERT INTO delivery_address(delivery_id ,city,street,_num)
  VALUES ('10','Yehud','Kiron','100');
  INSERT INTO delivery_address(delivery_id ,city,street,_num)
  VALUES ('11','Yehud','Kiron','13');
select * from edition;
INSERT INTO edition(title,_year,publisher)
  VALUES ('Lolita','2003','Matar');
INSERT INTO edition(title,_year,publisher)
  VALUES ('Lolita','2005','Matar');
  
  
  
  INSERT INTO edition(title,_year,publisher)
  VALUES ('The Hobbit','2008','Modan');
INSERT INTO edition(title,_year,publisher)
  VALUES ('The Hobbit','2010','Yedioth');
INSERT INTO edition(title,_year,publisher)
  VALUES ('Little Women','2012','Korna');
INSERT INTO edition(title,_year,publisher)
  VALUES ('Animal Farm','2015', 'Matar');
INSERT INTO edition(title,_year,publisher)
  VALUES ('Gone with the Wind','2017', 'Yedioth');
INSERT INTO edition(title,_year,publisher)
  VALUES ('Charlotte’s Web','2011', 'Korna');
INSERT INTO edition(title,_year,publisher)
  VALUES ('Lord of the Flies','2018', 'Modan');
INSERT INTO edition(title,_year,publisher)
  VALUES ('The Kite Runner',2003, 'Modan');
INSERT INTO edition(title,_year,publisher)
  VALUES ('The Kite Runner',2008, 'Yedioth');
INSERT INTO edition(title,_year,publisher)
  VALUES ('Romeo and Juliet',2000, 'Yedioth');
INSERT INTO edition(title,_year,publisher)
  VALUES ('Romeo and Juliet',2010, 'Korna');
INSERT INTO edition(title,_year,publisher)
  VALUES ('Romeo and Juliet',2005, 'Matar');
INSERT INTO edition(title,_year,publisher)
  VALUES ('Wuthering Heights',2019, 'Yaso');
select * from edition;
  INSERT INTO edition_translating(edition_id ,language_edition)
  VALUES ('1','Spanish');
  INSERT INTO edition_translating(edition_id,language_edition )
  VALUES ('1','English');
 INSERT INTO edition_translating(edition_id ,language_edition)
  VALUES ('2','English');
  INSERT INTO edition_translating(edition_id,language_edition )
  VALUES ('6','English');
 INSERT INTO edition_translating(edition_id ,language_edition)
 VALUES ('6','Spanish');
  INSERT INTO edition_translating(edition_id ,language_edition)
  VALUES ('6','Italian');
 INSERT INTO edition_translating(edition_id ,language_edition)
  VALUES ('8','Italian');
 INSERT INTO edition_translating(edition_id ,language_edition)
  VALUES ('9','Spanish');
  INSERT INTO edition_translating(edition_id )
 VALUES ('10');
 INSERT INTO edition_translating(edition_id )
 VALUES ('11');
INSERT INTO edition_translating(edition_id )
VALUES ('12');
 INSERT INTO edition_translating(edition_id )
VALUES ('13');
 INSERT INTO edition_translating(edition_id ,language_edition)
	VALUES ('14','Spanish');
  INSERT INTO edition_translating(edition_id ,language_edition)
  VALUES ('15','Spanish');
  
select *from delivery_book;
select *from delivery_edition;
select *from edition;
iNSERT INTO delivery_edition(delivery_id ,edition_id)
  VALUES ('11','1');
  iNSERT INTO delivery_edition(delivery_id ,edition_id)
  VALUES ('11','2');
  iNSERT INTO delivery_edition(delivery_id ,edition_id)
  VALUES ('10','13');
  iNSERT INTO delivery_edition(delivery_id ,edition_id)
  VALUES ('10','14');
  iNSERT INTO delivery_edition(delivery_id ,edition_id)
  VALUES ('6','4');
  iNSERT INTO delivery_edition(delivery_id ,edition_id)
 VALUES ('11','5');

iNSERT INTO delivery_edition(delivery_id ,edition_id)
  VALUES ('1','9');
  iNSERT INTO delivery_edition(delivery_id ,edition_id)
  VALUES ('2','1');
   iNSERT INTO delivery_edition(delivery_id ,edition_id)
   VALUES ('3','8');
   iNSERT INTO delivery_edition(delivery_id ,edition_id)
   VALUES ('4','1');
    iNSERT INTO delivery_edition(delivery_id ,edition_id)
   VALUES ('5','4');
    iNSERT INTO delivery_edition(delivery_id ,edition_id)
   VALUES ('7','7');
   iNSERT INTO delivery_edition(delivery_id ,edition_id)
   VALUES ('8','14');
   iNSERT INTO delivery_edition(delivery_id ,edition_id)
   VALUES ('9','1');
   
  select* from supplies_book;
  select* from supplies;
INSERT INTO supplies_book (supply_id, title, _sum)
VALUES (10,'Lolita',2);
   INSERT INTO supplies_book( supply_id,title,_sum)
  VALUES ('1','Lolita','3');
 INSERT INTO supplies_book(supply_id,title,_sum)
  VALUES ('1','The Hobbit','4');
 INSERT INTO supplies_book( supply_id,title,_sum)
  VALUES ('1','Little Women','3');
   INSERT INTO supplies_book( supply_id,title,_sum)
  VALUES ('4','Animal Farm','3');
 INSERT INTO supplies_book(supply_id,title,_sum)
  VALUES ('5','Gone with the Wind','3');
   INSERT INTO supplies_book( supply_id,title,_sum)
  VALUES ('4','Charlotte’s Web','3');
   INSERT INTO supplies_book( supply_id,title,_sum)
  VALUES ('5','Lord of the Flies','5');
   INSERT INTO supplies_book( supply_id,title,_sum)
 VALUES ('6','The Kite Runner','6');
  



   INSERT INTO book_authers( _name,title)
  VALUES ('Vladimir Nabokov','Lolita');
INSERT INTO book_authers( _name,title)
  VALUES ('J.R.R. Tolkien','The Hobbit');
INSERT INTO book_authers( _name,title)
  VALUES ('Jason Ker','The Hobbit');
  INSERT INTO book_authers( _name,title)
  VALUES ('Louisa May Alcott','Little Women');
  INSERT INTO book_authers( _name,title)
  VALUES ('George Orwell','Animal Farm');
  INSERT INTO book_authers( _name,title)
  VALUES ('Margaret Mitchell','Gone with the Wind');
  INSERT INTO book_authers( _name,title)
  VALUES ('E.B. White','Charlotte’s Web');
  INSERT INTO book_authers( _name,title)
  VALUES ('William Golding','Lord of the Flies');
  INSERT INTO book_authers( _name,title)
  VALUES ('Khaled Hosseini','The Kite Runner');
  INSERT INTO book_authers( _name,title)
  VALUES ('William Shakespeare','Romeo and Juliet');
  INSERT INTO book_authers( _name,title)
  VALUES ('Emily Bronte','Wuthering Heights');

  INSERT INTO order_book(id,_status,order_date,closed_date)
  VALUES ('203111111', 'send message','2020-01-014','2020-01-020');
INSERT INTO order_book(id,_status,order_date)
  VALUES ('123454321', 'Arrived','2020-02-014');
INSERT INTO order_book(id,_status,order_date,closed_date)
  VALUES ('203123456', 'send message','2020-03-014','2020-04-020');
INSERT INTO order_book(id,_status,order_date,closed_date)
  VALUES ('111212121', 'closed','2020-06-010','2020-06-025');
INSERT INTO order_book(id,_status,order_date)
  VALUES ('123454321', 'in proccess','2020-07-010');
  INSERT INTO order_book(id,_status,order_date)
  VALUES ('123454321', 'Arrived','2020-02-014');
INSERT INTO order_book(id,_status,order_date,closed_date)
  VALUES ('203123456', 'send message','2020-03-014','2020-05-020');
INSERT INTO order_book(id,_status,order_date,closed_date)
  VALUES ('203123456', 'closed','2020-02-010','2020-03-020');
INSERT INTO order_book(id,_status,order_date)
  VALUES ('123454321', 'in proccess','2019-07-010');
  
  
  select* from ordervbook;
   
 INSERT INTO orderVbook(order_id,title,_sum)
  VALUES ('2', 'Lolita',3);
INSERT INTO orderVbook(order_id,title,_sum)
  VALUES ('1', 'Lolita',1);
INSERT INTO orderVbook(order_id,title,_sum)
  VALUES (2, 'Little Women',2);
INSERT INTO orderVbook(order_id,title,_sum)
  VALUES ('2', 'Animal Farm',4);
INSERT INTO orderVbook(order_id,title,_sum)
  VALUES (6,'Romeo and Juliet',1);
INSERT INTO orderVbook(order_id,title,_sum)
  VALUES ('6', 'Charlotte’s Web',2);
INSERT INTO orderVbook(order_id,title,_sum)
  VALUES ('6', 'Lord of the Flies',4);
INSERT INTO orderVbook(order_id,title,_sum)
  VALUES ('4', 'The Kite Runner',5);
INSERT INTO orderVbook(order_id,title,_sum)
  VALUES ('4', 'Romeo and Juliet',3);
INSERT INTO orderVbook(order_id,title,_sum)
  VALUES ('4', 'Wuthering Heights',1);
  INSERT INTO orderVbook(order_id,title,_sum)
  VALUES ('7', 'Romeo and Juliet',1);
   INSERT INTO orderVbook(order_id,title,_sum)
  VALUES ('8', 'Romeo and Juliet',1);
   INSERT INTO orderVbook(order_id,title,_sum)
  VALUES ('9', 'Romeo and Juliet',1);
   
   
select * from worker;
select * from worker_salary;
 INSERT INTO worker_salary(month_year ,num_worker, hours)
   VALUES ('2019-07-01','10','34');
   INSERT INTO worker_salary(month_year ,num_worker, hours)
   VALUES ('2019-08-01','10','30');
  INSERT INTO worker_salary(month_year ,num_worker, hours)
  VALUES ('2019-09-01','9','130');
  INSERT INTO worker_salary(month_year ,num_worker, hours)
  VALUES ('2019-010-01','8','100');
  INSERT INTO worker_salary(month_year ,num_worker, hours)
  VALUES ('2019-011-01','10','50');
  INSERT INTO worker_salary(month_year ,num_worker, hours)
  VALUES ('2019-012-01','8','30');
  INSERT INTO worker_salary(month_year ,num_worker, hours)
  VALUES ('2020-01-01','4','100');
 INSERT INTO worker_salary(month_year ,num_worker, hours)
  VALUES ('2020-02-01','4','60');

 INSERT INTO worker_salary(month_year ,num_worker, hours)
  VALUES ('2019-07-01','8','40');
 INSERT INTO worker_salary(month_year ,num_worker, hours)
  VALUES ('2019-09-01','10','30');
select * from books;
select * from books_condition;
INSERT INTO books_condition(title,book_condition,current_inventory)
 VALUES ('Animal Farm','medium',10);
INSERT INTO books_condition(title,book_condition,current_inventory)
 VALUES ('Animal Farm','good',9);
 INSERT INTO books_condition(title,book_condition,current_inventory)
 VALUES ('Charlotte’s Web','medium',15);
INSERT INTO books_condition(title,book_condition,current_inventory)
 VALUES ('Gone with the Wind','good',10);
 INSERT INTO books_condition(title,book_condition,current_inventory)
 VALUES ('Little Women','good',9);
 INSERT INTO books_condition(title,book_condition,current_inventory)
 VALUES ('Lolita','medium',10);
  INSERT INTO books_condition(title,book_condition,current_inventory)
 VALUES ('Lolita','good',10);
  INSERT INTO books_condition(title,book_condition,current_inventory)
 VALUES ('Lord of the Flies','rickety',6);
  INSERT INTO books_condition(title,book_condition,current_inventory)
 VALUES ('Romeo and juliet','As new',10);
  INSERT INTO books_condition(title,book_condition,current_inventory)
 VALUES ('The Hobbit','rickety',10);
  INSERT INTO books_condition(title,book_condition,current_inventory)
VALUES ('The Hobbit','good',3);
INSERT INTO books_condition(title,book_condition,current_inventory)
VALUES ('The Kite Runner','Brand new',2);
INSERT INTO books_condition(title,book_condition,current_inventory)
VALUES ('Wuthering Heights','Brand new',8);
