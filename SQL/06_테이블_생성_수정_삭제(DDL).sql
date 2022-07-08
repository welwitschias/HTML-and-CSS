-- ===========================================================================

-- 주의 : 테이블은 생성, 삭제하는 순간 바로 COMMIT됨, ROLLBACK 불가
-- 테이블 생성
CREATE TABLE 테스트 
( 숫자 NUMBER,
  문자열 VARCHAR2(100),
  날짜 DATE DEFAULT SYSDATE );  -- Column_Name Data_Type [DEFAULT Default_Value]

-- 테이블 이름 만들 때 주의사항
-- 1. 문자로 시작해야 함(숫자로 시작 불가)
-- 2. 테이블 이름은 30바이트 이하
-- 3. 사용가능한 문자는 A-Z, a-z, _, $, # (- 사용불가) / 한글 가능
-- 4. 기존의 다른 테이블과 이름이 같으면 안됨
-- 5. SQL 명령어를 사용하면 안됨(SELECT, FROM, WHERE, ...)

INSERT INTO 테스트 VALUES (1, '하나', SYSDATE);
INSERT INTO 테스트 VALUES (2, '두울', SYSDATE);
INSERT INTO 테스트 VALUES (3, '세엣', SYSDATE);
INSERT INTO 테스트 VALUES (4, '네엣', SYSDATE);
SELECT * FROM 테스트;

-- 테이블 삭제
DROP TABLE TEST;
DROP TABLE 테스트;

-- 예제 1-1
CREATE TABLE SAMPLE_PRODUCT
( PRODUCT_ID NUMBER,
  PRODUCT_NAME VARCHAR2(20),
  MENU_DATE DATE );
-- 예제 1-2
DROP TABLE SAMPLE_PRODUCT;
DESC SAMPLE_PRODUCT;

-- ===========================================================================

-- 제약조건 생성
-- 컬럼 레벨 정의 : 컬럼을 생성하면서 같이 정의
CREATE TABLE emp
( eno       NUMBER(3) CONSTRAINT emp_eno_pk PRIMARY KEY, 
  emp_name  VARCHAR2(20) );
-- 테이블 레벨 정의 : 테이블 생성 마지막에 정의, NOT NULL은 불가(컬럼 레벨만 가능)
CREATE TABLE emp
( eno       NUMBER(3),
  emp_name  VARCHAR2(20),
  CONSTRAINT emp_eno_pk PRIMARY KEY (eno) );
DESC emp;
DROP TABLE emp;

-- 제약조건 삭제
DROP TABLE emp CASCADE CONSTRAINT;

-- NOT NULL : NULL값 허용 안함, UNIQUE : 중복된 값 허용 안함(NULL값은 허용함)
CREATE TABLE emp1
( eno       NUMBER(3) CONSTRAINT emp1_eno_pk PRIMARY KEY,
  emp_name  VARCHAR2(20) CONSTRAINT emp1_ename_nn NOT NULL,
  email     varchar2(30),
  CONSTRAINT emp1_email_uk UNIQUE (email) );
DESC emp1;
INSERT INTO emp1 VALUES (100, '길동', 'hong@naver.com');
INSERT INTO emp1 VALUES (101, '펭수', 'peng@naver.com');
--INSERT INTO emp1 VALUES (101, NULL, 'peng@naver.com'); -- NULL값이 들어가서 오류
--INSERT INTO emp1 VALUES (101, '펭수', 'hong@naver.com'); -- 길동이의 이메일과 같아서 오류
SELECT * FROM emp1;
DROP TABLE emp1;

-- CHECK : 데이터의 조건을 정의(WHERE절과 동일하게 조건 지정함)
CREATE TABLE emp2
( eno       NUMBER(3),
  emp_name  VARCHAR2(20),
  sal       number(10),
  CONSTRAINT emp_sal_check CHECK (sal > 1000) ); -- sal열의 제약조건으로 1000보다 큰 수여야 함
DESC emp2;
INSERT INTO emp2 VALUES (200, '춘향', 1200);
INSERT INTO emp2 VALUES (201, '몽룡', 1500);
--INSERT INTO emp VALUES (201, '몽룡', 800); -- 1000 이하여서 오류
SELECT * FROM emp2;
DROP TABLE emp2;

-- 제약조건의 이름없이 테이블 생성
CREATE TABLE emp3
( eno      NUMBER(4) PRIMARY KEY,
  ename    VARCHAR2(20) NOT NULL,
  password VARCHAR2(13) UNIQUE CHECK (LENGTH(password) >= 8),
  gender   VARCHAR2(6) CHECK (gender IN ('남성', '여성')) );
DESC emp3;
INSERT INTO emp3 VALUES (1000, '왕건', '12345678', '남성');
INSERT INTO emp3 VALUES (1010, '장금', '789123456', '여성');
SELECT * FROM emp3;
DROP TABLE emp3;

-- 예제 2
CREATE TABLE members
( member_id  NUMBER(2) PRIMARY KEY,
  first_name VARCHAR2(50) NOT NULL,
  last_name  VARCHAR2(50) NOT NULL,
  gender     VARCHAR2(5) CHECK (gender IN ('Man', 'Woman')),
  birth_day  DATE DEFAULT SYSDATE,
  email      VARCHAR2(200) UNIQUE NOT NULL );
DESC members;
INSERT INTO members VALUES (01, '길동', '홍', 'Man', '1972-11-13', ' ');
INSERT INTO members VALUES (02, '춘향', '성', 'Woman', '1985-06-26', '  ');
SELECT * FROM members;
DROP TABLE members;

-- ===========================================================================

-- 기본키, 외래키 만들기
CREATE TABLE dept
( dno   NUMBER(4),
  dname VARCHAR2(20),
  CONSTRAINT dept_dno_pk PRIMARY KEY(dno) );

CREATE TABLE emp
( eno       NUMBER(4) PRIMARY KEY,
  emp_name  VARCHAR2(20),
  sal       NUMBER(10),
  dno       NUMBER(4),
  FOREIGN KEY (dno) REFERENCES dept (dno) ); -- 외래키는 테이블 레벨에서만 지정가능

INSERT INTO dept VALUES (10, '개발');
INSERT INTO dept VALUES (20, '영업');
INSERT INTO dept VALUES (30, '회계');
INSERT INTO dept VALUES (40, '관리');
INSERT INTO dept VALUES (50, '안전');
SELECT * FROM dept;
DROP TABLE dept;

INSERT INTO emp VALUES (1010, '철수', 100, 10);
INSERT INTO emp VALUES (1020, '훈이', 200, 20);
INSERT INTO emp VALUES (1030, '맹구', 250, 30);
INSERT INTO emp VALUES (1040, '유리', 350, 40);
INSERT INTO emp VALUES (1050, '짱구', 500, 50);
SELECT * FROM emp;
DROP TABLE emp;

-- 제약조건 조회하기
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'EMP'; -- 테이블명은 대문자로 적어야 함
-- CONSTRAINT_TYPE : P(기본키), R(외래키), U(유니크), C(NOT NULL, CHECK)
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'DEPT';

-- ===========================================================================