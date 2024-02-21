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
 
 select c.c_name,avg(r.r_result)as '平均分',convert(decimal(3,2),count(case when r.r_result >=60 then 1.0 else null end)*1.0/count(r.r_result)*1.0) as '及格率' from results as r,classes as c where c.c_no=r.c_no group by c.c_name order by '平均分'desc ; 

--第二題--

select s.s_no,s.s_name from (select a.s_no from (select * from results where c_no like'c0001') as a,
(select * from results where c_no like 'c0003')as b where b.s_no=a.s_no and b.r_result>a.r_result)as r, students as s where s.s_no = r.s_no;

--第三題--

select s_no ,AVG(r_result)as 'average' from results group by s_no having avg(r_result)>60 ;

--第四題--

select s.s_no ,s.s_name ,count(r.c_no) as '選課數' ,sum(r_result)as '總成績' from students  as s ,results as r where r.s_no=s.s_no group by s.s_no,s_name;

--第五題--

select s.s_no ,s.s_name,count(r.c_no) as '選課數' from students  as s ,results as r  where r.s_no=s.s_no group by s.s_no,s_name having count(r.c_no)< (select count(c_no)from classes) ;

--第六題--

select c.c_no as '課程編號',c.c_name as'課程名稱',count(r.s_no)as '選課人數' from classes as c,results as r where r.c_no=c.c_no  group by c.c_no,c.c_name having count(r.s_no)<10;