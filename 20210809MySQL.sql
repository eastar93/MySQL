CREATE TABLE jspboard(
	bid int(9) primary key auto_increment,
    bname varchar(16) not null,
    btitle varchar(40) not null,
	bcontent varchar(2000) not null,
    bdate timestamp not null,
    bhit int(6)
    );
    
    DROP TABLE jspboard;
    
    INSERT INTO jspboard(bname, btitle, bcontent, bdate, bhit) 
		VALUES("테스터", "테스트글", "테스트 내용", now(), 0);
        
