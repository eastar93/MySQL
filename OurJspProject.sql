CREATE TABLE users(
	uid varchar(20) primary key,
    upw varchar(20) not null,
    uname varchar(10) not null,
	uemail varchar(45) not null,
    subject varchar(50)
    );
    
create table question(
    qcode integer auto_increment primary key,
    question varchar(60)
);

alter table question auto_increment=1000;

create table correct(
    ccode integer auto_increment primary key,
    correct varchar(30)
);
alter table correct auto_increment=1000;
    
create table answer(
    acode integer auto_increment primary key,
    answer varchar(30)
);
alter table answer auto_increment=1000;
    
    
CREATE TABLE board (
	  no INT primary key not null AUTO_INCREMENT,
	  btype varchar(20) not null,
	  btitle varchar(45) not null,
	  bwriter varchar(10) not null,
	  bcontent varchar(2000) not null,
      bhit INT not null DEFAULT 0 
	  );
      