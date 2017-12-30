use 酒店;
create table 用户
(
rname char(10),
npassword char(16),
age int,
phone int,
IDcard char(18) primary key
); 
create table  房间类型
(
rtype char(10) primary key,
surplus int,
price int,
);
create table 员工
(
cname char(10),
position char(10),
cpassword char(10),
);
create table 房间
(
room int,
rtype char(10),
describe char(100),
turn char(15),
free bit,
PRIMARY KEY(rtype),
FOREIGN KEY(rtype)REFERENCES 房间类型(rtype),
);
create table 订单
(
rtype char(10),
IDcard char(18),
Checkout date,
Checkin date,
phone int,
price int,
orderNum int,
PRIMARY KEY(rtype,IDcard),
FOREIGN KEY(rtype)REFERENCES 房间类型(rtype),
FOREIGN KEY(IDcard)REFERENCES 用户(IDcard),
);
create table 订单明细
(
orderNUm int,
sump int,
);