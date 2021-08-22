-- <제약조건>
-- 컬럼에 붙는 조건으로, 데이터의 무결성을 보장하기 위해
-- 추가적으로 붙이는 제한을 의미합니다.
-- 제약조건이 붙은 컬럼에는 제약조건을 만족시키는 데이터만
-- 집어넣을 수 있기 때문에 개발자가 의도한 데이터만
-- 들어오는 장점이 있습니다.

-- 제약조건 확인testtbl5testtbl5
-- DESC DB명.테이블명;
DESC employees.employees;

-- 제약조건 추가하기
-- primary key
-- ALTER TABLE 테이블이름 ADD CONSTRAINT 제약조건 명칭
-- PRIMARY KEY(컬럼이름);
CREATE TABLE testtbl5 (
	num int,
    name varchar(5)
);
ALTER TABLE testtbl5 ADD CONSTRAINT pk_tbl5num 
PRIMARY KEY(num);

DESC sqldb.testtbl5;

-- 제약조건 삭제(PRIMARY KEY)
-- ALTER TABLE 테이블명 DROP PRIMARY KEYtesttbl5testtbl5;
ALTER TABLE testtbl5 DROP PRIMARY KEY; 



-- 제약조건 추가하기
-- FOREIGN KEY
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명
-- FOREIGN KEY(컬럼명) REFERENCES 연결테이블(PK컬럼);
CREATE TABLE testtbl6 (
	fnum int not null,
    num int primary key,
    id varchar(5)
);

ALTER TABLE testtbl6 ADD CONSTRAINT fk_fnum
FOREIGN KEY(fnum) REFERENCES testtbl5(num);

DESC sqldb.testtbl6;

-- FOREIGN KEY 삭제
-- ALTER TABLE 테이블명 DROP FOREIGN KEY 제약조건명;
ALTER TABLE testtbl6 DROP FOREIGN KEY fk_fnum;

-- 특정 DB의 제약조건 전체 조회
SELECT * FROM information_schema.table_constraints
WHERE constraint_schema = 'sqldb';

-- 프로시저는 그냥 호출할 수도 있지만, 파라미터를 입력받게 
-- 처리해야 훨씬 사용성이 높아집니다.
-- 따라서 프로시저의 성질에 따라 파라미터를 활용할 수 있도록
-- 파라미터를 추가한 프로시저를 정의해보겠습니다.
-- 파라미터 지정은 
-- CREATE PROCEDURE 프로시저명(
-- 				IN 파라미터명 자료형(크기)
-- )
-- 와 같은 형식으로 지정할 수 있습니다.
-- 예시 프로시저

DELIMITER $$
CREATE PROCEDURE singerAge(
			IN userName VARCHAR(10)
)
BEGIN 
	DECLARE bYear INT;
    SELECT birthYear into bYear FROM userTbl
		WHERE name = username;
	IF (bYear >= 1980) THEN
		SELECT '젊은 편입니다.' as '결과';
	ELSE
		SELECT '나이가 좀 있습니다.' as '결과';
	END IF;
END $$
DELIMITER ;
CALL singerAge('이승기');
DROP PROCEDURE sqldb.singerAge;


-- 어제 작성한 employees.getFive() 프로시저를 
-- 사원번호를 입력받아서 입력받은 사원의 근속년수가 
-- 5년이 넘는지 안 넘는지 판단하는 프로시저로 고쳐서
-- getFive2()로 만들어주시고 호출도 해주세요.
DELIMITER $$
CREATE PROCEDURE getFive2(
					In empNo INT 
) 
BEGIN
	DECLARE hireDATE DATE; # 입사일을 받아옴
    DECLARE todayDATE DATE; #오늘날짜를 받아옴
    DECLARE days INT; # 오늘날짜 - 입사일 해서 경과일수
    
    SELECT hire_date INTO hireDATE
		FROM employees WHERE emp_no = empNo;
	# hire_date INTO hireDATE는 
    # 쿼리문의 결과로 나온 값을 hireDATE 변수에 대입함
	
    SET todayDATE = CURRENT_DATE(); # 오늘날짜 함수
    SET days = DATEDIFF(todayDATE, hireDATE);
    # 경과일수 구하는 함수

	IF (days/365) >= 5 THEN # 입사한지 5년여부 체크
		SELECT CONCAT('입사한지', days, '일이 경과했습니다.');
	ELSE
		SELECT CONCAT('5년미만이고, ', days, '일째 근무중.');
	END IF;
END $$
DELIMITER ;

CALL getFive2(50000);


-- <트리거>
-- 트리거는 특정 테이블에 명령이 내려지면 자동으로 
-- 연동된 명령을 수행하도록 구문을 걸어주는 것입니다.
-- 예를들어 회원이 탈퇴를 했다고 가정했을때
-- 탈퇴한 회원을 DB에서 바로 삭제하는게 아니라
-- 탈퇴보류회원 테이블에 INSERT를 해둔다던지
-- 수정이 일어났을때 수정 전 내역을 따로 다른 테이블에
-- 저장해 둔다던지 특정 테이블을 대상으로 실행되는 구문 이전이나
-- 혹은 이후에 추가로 실행 할 명령어를 지정해두는 것입니다.

-- 문법은 프로시저와 유사하나, 차이점이 조금 있습니다.
-- 문법)
-- DELIMITER //
-- CREATE TRIGGER 트리거명 
-- 		 실행시점 실행로직
-- 		 ON 트리거부착테이블
-- 		 FOR EACH ROW
-- BEGIN
-- 	  트리거 실행시 작동코드
-- END //
-- DELIMITER ;

-- 트리거 테스트용 테이블을 하나 추가하겠습니다.
CREATE TABLE gameList (
	id int,
    gamename varchar(10)
);

INSERT INTO gameList VALUES(1, '바람의나라');
INSERT INTO gameList VALUES(2, '스타크래프트');
INSERT INTO gameList VALUES(3, '롤');
SELECT * FROM gameList;

-- 트리거를 gameList테이블에 부착합니다.
DELIMITER //
CREATE TRIGGER testTrg
	AFTER DELETE
    ON gameList
    FOR EACH ROW
BEGIN
	SET @msg = '게임이 삭제되었습니다.';
END //
DELIMITER ;

SELECT @msg = '';
INSERT INTO gameList VALUES(4, '배틀그라운드');
SELECT @msg;
UPDATE gameList SET gamename = '리그오브레전드'
	WHERE id = 3;
SELECT @msg;
DELETE FROM gameList WHERE id = 4;
SELECT @msg;

set sql_safe_updates = 0;



