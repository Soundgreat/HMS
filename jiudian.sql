use �Ƶ�;
create table �û�
(
rname char(10),
npassword char(16),
age int,
phone int,
IDcard char(18) primary key
); 
create table  ��������
(
rtype char(10) primary key,
surplus int,
price int,
);
create table Ա��
(
cname char(10),
position char(10),
cpassword char(10),
);
create table ����
(
room int,
rtype char(10),
describe char(100),
turn char(15),
free bit,
PRIMARY KEY(rtype),
FOREIGN KEY(rtype)REFERENCES ��������(rtype),
);
create table ����
(
rtype char(10),
IDcard char(18),
Checkout date,
Checkin date,
phone int,
price int,
orderNum int,
PRIMARY KEY(rtype,IDcard),
FOREIGN KEY(rtype)REFERENCES ��������(rtype),
FOREIGN KEY(IDcard)REFERENCES �û�(IDcard),
);
create table ������ϸ
(
orderNUm int,
sump int,
);