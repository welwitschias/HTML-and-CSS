-- ===========================================================================

-- 뷰(view) : 가상의 테이블
-- 간단한 뷰 만들기
CREATE VIEW EMP_V1
AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id
FROM employees;
SELECT * FROM emp_v1;

-- 뷰에 데이터 입력 시 실제로는 뷰를 만들 때 사용한 테이블에 입력됨
INSERT INTO EMP_V1
VALUES(33, '펭수', '김', 'Peng', SYSDATE, 'IT_PROG');
SELECT * FROM employees WHERE employee_id = 33;

-- 복잡한 뷰 만들기
-- 그룹함수를 사용한 뷰는 DML(데이터의 입력, 수정, 삭제) 사용 불가
CREATE OR REPLACE VIEW 부서별_직원_보고서 -- OR REPLACE : 뷰를 삭제하지 않고 수정할 수 있음
AS
SELECT department_id 부서번호, count(*) 직원수, MAX(salary) 최고급여, MIN(salary) 최저급여, ROUND(AVG(salary)) 평균급여
FROM employees
GROUP BY department_id
ORDER BY department_id;
SELECT * FROM 부서별_직원_보고서;

-- 읽기만 가능한 뷰 (90번 부서 직원들의 읽기 전용 뷰)
CREATE OR REPLACE VIEW emp90_read
AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id
FROM employees
WHERE department_id = 90
WITH READ ONLY;
SELECT * FROM emp90_read;
-- 읽기 전용이므로 DML 사용 안됨
DELETE FROM emp90_read; -- 삭제 불가
INSERT INTO emp90_read VALUES (777, '몽룡', '이', 'Mong', '22/05/07', 'IT_PROG'); -- 입력 불가

-- ===========================================================================

-- 인덱스 조회하기 : 기본키 열은 자동으로 인덱스가 생성됨
SELECT * FROM all_ind_columns WHERE table_name = 'DEPARTMENTS';
SELECT * FROM all_ind_columns WHERE table_name = 'MEMBERS';

-- 인덱스 실습용 테이블 만들기
CREATE TABLE members
( member_id INT,
  first_name VARCHAR2(100) NOT NULL,
  last_name VARCHAR2(100) NOT NULL,
  gender CHAR(1) NOT NULL,
  dob DATE NOT NULL,
  email VARCHAR2(255) NOT NULL,
  PRIMARY KEY(member_id) );
SELECT * FROM members ORDER BY member_id;

-- full_name으로 검색
EXPLAIN PLAN FOR
SELECT * FROM members
WHERE last_name LIKE 'A%' AND first_name LIKE 'M%';
-- SQL 실행 보고서 확인
SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

-- 인덱스 만들기
CREATE INDEX members_last_name_i ON members(last_name);

-- 인덱스 삭제하기
DROP INDEX members_last_name_i;

-- 멀티 인덱스 (여러 개의 열을 같이 인덱스)
CREATE INDEX members_name_i ON members(last_name, first_name);

-- ===========================================================================

-- 시퀀스 : 유일한(UNIQUE) 값을 생성해주는 오라클 객체, 보통 기본키 생성에 사용
-- 시퀀스 만들기
CREATE SEQUENCE 시퀀스1; -- 기본 : 1로 시작, 1씩 증가

-- 시퀀스 삭제하기
DROP SEQUENCE 시퀀스1;

-- 시퀀스 정보 확인
SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME = '시퀀스1';

-- 시퀀스 사용법
SELECT 시퀀스1.NEXTVAL FROM DUAL; -- .NEXTVAL : 다음 시퀀스 값이 실행됨(1씩 증가)
SELECT 시퀀스1.CURRVAL FROM DUAL; -- .CURRVAL : 현재 시퀀스 값이 실행됨

-- 시퀀스를 이용해서 직원의 id를 입력해보자
CREATE TABLE 직원
( emp_id NUMBER(6) PRIMARY KEY,
  emp_name VARCHAR2(50) NOT NULL );

CREATE SEQUENCE 시퀀스2
START WITH 100000 -- 100000으로 시작
INCREMENT BY 10; -- 10씩 증가

INSERT INTO 직원 VALUES (시퀀스2.NEXTVAL, '태종');
INSERT INTO 직원 VALUES (시퀀스2.NEXTVAL, '세종');
INSERT INTO 직원 VALUES (시퀀스2.NEXTVAL, '세조');
INSERT INTO 직원 VALUES (시퀀스2.NEXTVAL, '영조');
INSERT INTO 직원 VALUES (시퀀스2.NEXTVAL, '정조');
SELECT * FROM 직원;

-- 직원의 id를 시퀀스1로 업데이트 해보자
UPDATE 직원 SET emp_id = 시퀀스1.NEXTVAL;

-- ===========================================================================

-- ROWNUM : SELECT한 데이터에 일련번호를 붙이는 것
-- 상위 n행만 출력하기
SELECT ROWNUM, employees.* FROM employees WHERE ROWNUM <= 7;

-- 중간의 n행만 출력하기 - 서브쿼리 이용
SELECT E.* FROM (SELECT ROWNUM RN, employees.* FROM employees) E
WHERE RN BETWEEN 5 AND 10; -- ROWNUM을 RN으로 별칭을 줘야 결과 출력됨

-- 정렬 후 순서매겨서 중간행만 출력하기
SELECT ROWNUM, A.*
FROM (SELECT employee_id, last_name, salary FROM employees ORDER BY salary DESC) A
WHERE ROWNUM <= 10;

-- ===========================================================================