create database assgn2;
use assgn2;

create table R2(K int, D int, E int, primary key(K));
create table R3(A int, A1 int, A2 int, A3 int, primary key(A));
create table R4(B int, B1 int, B2 int, primary key(B));
create table R5(C int, C1 int, C2 int, C3 int, C4 int, C5 int, primary key(C));
create table R1(K int, A int, B int, C int, primary key(K), 
foreign key(K) references R2(K), foreign key(A) references R3(A), 
foreign key(B) references R4(B), foreign key(C) references R5(C));

insert into R2 values(4,1,6),(5,1,5),(1,1,8),(2,1,7),(3,1,3);
insert into R3 values(1,2,3,4),(2,4,6,8);
insert into R4 values(0,0,0),(3,9,27);
insert into R5 values(4,2,0,6,1,6),(5,2,0,5,1,5),(1,1,3,8,1,8),(2,1,3,7,1,7),(3,2,3,3,1,3);
insert into R1 values(4,2,0,4),(5,2,0,5),(1,1,3,1),(2,1,3,2),(3,2,3,3);


select * from R1;
select * from R2;
select * from R3;
select * from R4;
select * from R5;

select R1.K as K, R1.A as A, R1.B as B, R1.C as C, D, E,
 A1, A2, A3, B1, B2, C1, C2, C3, C4, C5 
from R1, R2, R3, R4, R5 where R1.K=R2.K and R1.A=R3.A and R1.B=R4.B and R1.C=R5.C;