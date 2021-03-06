CREATE TABLE users(
	uid varchar(20) primary key,
    upw varchar(20) not null,
    uname varchar(10) not null,
	uemail varchar(45) not null,
    subject varchar(50),
    qcode integer DEFAULT 0,
    point integer DEFAULT 0,
    tier integer DEFAULT 0
    );

INSERT into users VALUES('test', '1234', 'user', 'user@test.com', 'html, java', 0, 0, 0, 0);

SELECT * from users;

DROP TABLE answer;
    
create table question(
    qcode integer primary key,
    question varchar(60),
    qtcount integer DEFAULT 0 
);

CREATE TABLE solve (
  auto_acode INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  qcode INT NOT NULL,
  answer VARCHAR(30) NULL,
  solvedate DATETIME NOT NULL
);

create table correct(
    ccode integer primary key,
    correct varchar(30)
);
    
CREATE TABLE answer (
  auto_acode INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  qcode INT NOT NULL,
  answer VARCHAR(30) NULL,
  solvedate DATETIME NOT NULL
  );

CREATE TABLE board (
	  no INT primary key not null AUTO_INCREMENT,
	  btype varchar(20) not null,
	  btitle varchar(45) not null,
	  bwriter varchar(10) not null,
	  bcontent varchar(2000) not null,
      bhit INT not null DEFAULT 0 
	  );
