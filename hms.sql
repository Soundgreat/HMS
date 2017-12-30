create database hms;
use hms;

create table 员工
(
员工号 char(4) primary key,
姓名 varchar(10) not null,
职位 enum('经理', '前台') not null,
密码 varchar(16) not null,
性别 enum('男', '女'),
联系方式 char(11)
);

create table 用户
(
身份证号 char(18) primary key,
密码 varchar(16) not null,
姓名 varchar(20),
性别 enum('男', '女'),
年龄 int,
联系方式 char(11)
); 

create table  客房类型
(
类型 varchar(10) primary key,
容量 int not null,
余量 int not null,
价格 int not null,
描述 varchar(140)
);

create table 客房
(
房号 char(4) primary key,
类型 varchar(10) not null,
空置 bit,
朝向 varchar(10),
描述 varchar(140),
foreign key(类型) references 客房类型(类型) on update cascade
);

create table 客房_订单
(
编号 int auto_increment primary key,
房号 char(4),
订单号 char(20),
foreign key(房号) references 客房(房号) on update cascade,
foreign key(订单号) references 订单(订单号) on update cascade
) AUTO_INCREMENT = 1;

create table 订单
(
订单号 char(20) primary key,
入住人数 int,
入住日期 date,
离店日期 date,
价格 int,
联系方式 char(11),
服务评分 enum('1', '2', '3', '4', '5'),
服务评价 varchar(140),
订单状态 enum('预定中', '交易中', '已完成') not null
);

create table 住客_订单
(
编号 int auto_increment primary key,
身份证号 char(18),
订单号 char(20),
foreign key(身份证号) references 住客(身份证号) on update cascade,
foreign key(订单号) references 订单(订单号) on update cascade
) AUTO_INCREMENT = 1;

create table 住客
(
身份证号 char(18) primary key,
姓名 varchar(20) not null,
性别 enum('男', '女'),
年龄 int,
联系方式 char(11),
);

create table 预定中订单
(
订单号 char(20) primary key,
foreign key(订单号) references 订单(订单号) on update cascade
);

create table 交易中订单
(
订单号 char(20) primary key,
foreign key(订单号) references 订单(订单号) on update cascade
);

create table 团体订单
(
订单号 char(20) primary key,
foreign key(订单号) references 订单(订单号) on update cascade
);

create table 已完成订单
(
订单号 char(20) primary key,
foreign key(订单号) references 订单(订单号)
);