create database s1311034021;
use s1311034021;

create table students
( s_no char(10)  ,
  s_name varchar(10) ,
  s_sex char(1),
  s_birthday date,
  s_phone char(10),
  s_address varchar(100)
  primary key(s_no),
  index s_name(s_name)
);

create table classes
(
c_no char(5),
c_name varchar(24),
c_points int,
c_time int,
c_cost int,
c_bdate date,

primary key(c_no),
index c_name(c_name)
);

create table results
(s_no char(10),
c_no char(5),
r_result float,
r_date date,
foreign key (s_no) references students(s_no),
foreign key (c_no) references classes(c_no),
index k1(s_no,c_no)
)

create table Tmpdata
( s_no char(10) not null,
  s_name varchar(10) not null ,
  s_sex char(1) not null,
  s_birthday date not null,
  s_phone char(10) not null,
  s_address varchar(100) not null,
  c_no char(5) not null,
  c_name varchar(24) not null,
  c_points int not null,
c_time int not null,
c_cost int not null,
c_bdate date not null,
r_result float not null,
r_date date not null,
);
bulk insert Tmpdata from 'C:/Users/User/Desktop/data.txt'
with
(
fieldterminator ='\t',
rowterminator ='\n'
);
insert into students(s_no,s_name,s_sex,s_birthday,s_phone,s_address)
select distinct s_no,s_name,s_sex,s_birthday,s_phone,s_address from Tmpdata;
select * from students

insert into classes
select distinct c_no,c_name,c_points,c_time,c_cost,c_bdate from Tmpdata;
select * from classes;

insert into results(s_no,c_no,r_result,r_date) select distinct s_no,c_no,r_result,r_date from Tmpdata;
select * from results;

drop table Tmpdata;

--第一題--

select * from students where s_name like '林%' or s_name like '李%';

--第二題--

select distinct r1.c_no,r1.s_no,r1.r_result from results  r1,results  r2
 where r1.c_no=r2.c_no and r1.s_no != r2.s_no and r1.r_result=r2.r_result;

--第三題--

select r.c_no,c.c_name ,
sum(case when r_result >= 86 then 1 else 0 end)  '100-86',
sum(case when r_result >= 70 and r_result <86 then  1 else 0 end)  '100-86',
sum(case when r_result >= 60 and r_result <70 then 1 else 0 end)  '100-86',
sum(case when r_result <  60 then 1 else 0 end)  '<60'
from results  r, classes  c where c.c_no=r.c_no group by c.c_name,r.c_no order by r.c_no;

--第四題--

select r.s_no,s.s_name,sum(c.c_points)'學分數' 
from students s, (select s_no,c_no from results where r_result >=60) r,classes  c 
where s.s_no=r.s_no and c.c_no = r.c_no group by r.s_no ,s.s_name;

--第五題--

select s.s_sex '性別',avg(r.r_result) '平均' from students s, (select s_no,r_result from results where c_no like 'C0001') r where s.s_no=r.s_no group by s.s_sex;

--第六題--

BACKUP DATABASE s1311034021 TO DISK ='D:\BACKUP\s131034021.bak' with INIT;


