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

select s_name,s_address from students where s_address in(select s_address from students group by s_address having count(*)>1);

--第二題--

select sum(case when s.s_sex like 'M' then 1 else 0 end)as '男生人數',sum(case when s.s_sex like 'F' then 1 else 0 end)as '女生人數' from (select * from students where s_name like '陳%') as  s ;

--第三題--

select r.s_no , s.s_name,r.r_result from(select s_no,r_result from results where c_no like 'C0004' AND r_result<90) as r,students as s  where r.s_no=s.s_no ;

--第四題--

select r.s_no,s.s_name,c.c_name from results as r ,students as s, classes as c where r.c_no=c.c_no and r.s_no=s.s_no order by s_no;

--第五題--

select * from (select s_no,c_no,r_result,ROW_NUMBER()over(partition by c_no order by r_result desc)as 'rank' from results )as t where t.rank<=3
--第六題--

select distinct r.s_no ,s.s_name from (select c_no from results where s_no like 'S080400011') as rr,results as r,students as s where rr.c_no=r.c_no and s.s_no = r.s_no and s.s_no<>'S080400011';
