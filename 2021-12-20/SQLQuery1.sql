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

select s.s_name,c.c_name,r.r_result from results as r ,classes as c,students as s where r_result <=70 and r.c_no=c.c_no and s.s_no=r.s_no;

--第二題--

select r.s_no,s.s_name, avg(r_result)as 'average' from results as r ,students as s where  s.s_no=r.s_no group by r.s_no,s.s_name having AVG(r_result)>85;

--第三題--

select r.s_no,s.s_name,r.c_no,r.r_result  from results as r,students as s 
where r.s_no=s.s_no and r.r_result>(select avg(r_result) as average
from results) group by  r.s_no,s.s_name,r.c_no,r.r_result ;

--第四題--

select r.s_no,s.s_name,AVG(r.r_result),RANK() OVER (order by AVG(r.r_result) desc ) AS Rank 
FROM results as r inner join students as s on r.s_no =s.s_no 
group by r.s_no,s.s_name;

--第五題--

select s_no as '學號',SUBSTRING(s_name,1,1)as '姓氏',SUBSTRING(s_name,2,2)as '名字' from students;

