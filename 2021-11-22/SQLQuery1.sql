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
select * from students;
select * from classes;
select * from results;
--�Ĥ@�D--
 select s.s_no,s.s_name from students as s where s_no not in(select s_no from results where c_no in(select c_no from classes where c_name='�����H�춥'))

--�ĤG�D--

 select s_no,r_result from results where c_no='C0006'and r_result<80 order by r_result desc; 

--�ĤT�D--
 
 select s_no,s_name,s_address from students where s_address like '%������%';

--�ĥ|�D--

select r.c_no as'�ҵ{�s��',c.c_name as '�ҵ{�W��',max(r.r_result) as '�̰���' ,min(r.r_result)as '�̧C��',avg(r.r_result) as '������'from classes as c,results as r where r.c_no=c.c_no group by  r.c_no,c.c_name;
--�Ĥ��D--

select c_no,count(s_no)as '�ǥͼ�'from results group by c_no order by '�ǥͼ�';

--�Ĥ��D--

select r.c_no,avg(r.r_result)as '�������Z' from (select s_no from students where s_address like'�x�_��%') as s,results as r where s.s_no=r.s_no group by r.c_no;

--�ĤC�D--

select s_no,s_name,s_address from students;
update students set s_address = REPLACE(s_address,'�x�_��%','�s�_��%') where s_address like '�x�_��%';
select * from students;

--�ĤK�D--

 select * from results where s_no ='S080400001' and c_no = 'C0001';
 delete  from results where s_no ='S080400001' and c_no = 'C0001';
 select* from results where s_no ='S080400001' ;