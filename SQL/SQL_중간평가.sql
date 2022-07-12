--1
CREATE INDEX emp_ename_idx ON emp (ename);

--2
CREATE USER john IDENTIFIED BY 12345;

--3
GRANT CREATE TABLE FROM john;

--4
ALTER USER john IDENTIFIED BY oracle;

--5
CREATE TABLE EMP
( ENO NUMBER,
  ENAME VARCHAR2(20),
  HIRE_DATE DATE );
  
--6
CREATE OR REPLACE VIEW ... AS SELECT ...;

--7


--8
CREATE TABLE temp
( id NUMBER PRIMARY KEY,
  name VARCHAR2(50) UNIQUE );
  
--9
CREATE VIEW emp_dno
AS
SELECT eno, ename, dno
FROM EMP
WHERE dno = 30;

--10
CREATE SEQUENCE emp_seq
START WITH 10
INCREMENT BY 10;


--1 EMP 테이블의 구성(열의 이름, 널 사용가능 및 데이터 타입)을 확인하는
--  명령문을 작성하세요.
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'EMP';


--2 EMP 테이블에서 부서번호(DEPTNO) 열 값이 30이고 직업(JOB) 열 값이 SALESMAN인
--  데이터만 출력되도록 조회하는 문장을 작성하세요.
SELECT * FROM EMP
WHERE deptno = 30 AND job = 'SALESMAN';


--3 EMP 테이블에서 급여(SAL) 열 값이 2000 이상 3000 이하인 사원 데이터를
--  조회하는 SQL문을 작성하세요.
SELECT * FROM EMP
WHERE sal BETWEEN 2000 AND 3000;


--4 EMP 테이블의 열 구조만 같고 데이터는 없는 빈 EMP_TEMP 테이블을 생성하는
--  SQL문을 작성하세요.
CREATE TABLE emp_temp
AS
SELECT * FROM emp WHERE 1 != 1;
SELECT * FROM emp_temp;


--5 EMP_TEMP 테이블에 홍길동 사원을 추가 합니다.
--  사원번호(EMPNO)는 9999, 사원이름(ENAME)은 홍길동, 직책(JOB)은 PRESIDENT,
--  직속상관(MGR)은 NULL값, 고용일자(HIREDATE)는 2001년 1월 1일, 급여(SAL)는 5000,
--  추가 수당(COMM)은 1000, 부서 번호(DEPTNO)는 10으로 데이터를 추가하는
--  SQL문을 작성하여 입력하세요.
INSERT INTO emp_temp
VALUES (9999, '홍길동', 'PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10);
SELECT * FROM emp_temp;


--6 DEPT 테이블을 복사해서 DEPT_TEMP2 테이블을 생성하는 SQL문을 작성하세요.
CREATE TABLE dept_temp2
AS
SELECT * FROM dept;
SELECT * FROM dept_temp2;


--7 DEPT_TEMP2 테이블에서 40번 부서(DEPTNO)의 부서이름(DNAME)을 DATABASE로 수정하고
--  지역(LOC)을 SEOUL로 수정하는 SQL문을 작성하세요. (결과를 캡쳐하여 붙여 넣습니다.)
UPDATE dept_temp2
SET dname = 'DATABASE', loc = 'SEOUL'
WHERE deptno = 40;
SELECT * FROM dept_temp2;


--8 테이블에 한 행만 삭제해야 하는데 잘못해서 전체 행을 삭제해 버렸다.
--  이때 트랜잭션을 취소하는 명령어를 작성하세요.
ROLLBACK;


--9 EMP 테이블에서 사원이름(ENAME)열에 데이터가 대문자이든 소문자이든 상관없이
--  SMITH인 사원 정보를 조회하는 SQL문을 작성하세요.
-- (힌트: UPPER 함수로 WHERE 절에 사원 이름을 대문자로 만들어서 조건 검색)
SELECT *
FROM emp
WHERE UPPER(ename) = 'SMITH';


--10 EMP 테이블에서 사원 이름이 4글자 이하인 사원 정보를 조회하는 SQL문을 작성하세요.
SELECT * FROM emp
WHERE LENGTH(ename) <= 4;


--11 EMP 테이블에서 직책 이름을 첫글자부터 세 개만 출력하는 SQL문을 작성하세요.
SELECT SUBSTR(job, 1, 3) FROM emp;


--12 EMP 테이블에서 1981년 6월 1일 이후에 입사한 사원 정보를 출력하는 SQL문을 작성하세요.
SELECT * FROM emp
WHERE hiredate >= '1981/06/01';


--13. EMP 테이블에서 NVL 함수를 사용하여 사원별 사원번호(EMPNO), 사원이름(ENAME),
--    월급(SAL), 추가수당(COMM), 그리고 1년치 연봉을 구해서 ANNSAL 열로 출력하는 SQL문을
--    작성하세요. (힌트 : 1년 연봉은 월급*12 + 추가수당 이다. )
SELECT empno, ename, sal, comm, sal*12+NVL(comm,0) ANNSAL FROM emp;


-- 14. EMP 테이블에서 중복을 제외한 직책(JOB)의 개수를 출력하는 SQL문을 작성하세요.
--     (힌트 : DISTINCT 와 COUNT 함수를 이용하여 중복안된 열의 행의 개수를 카운트 )
SELECT COUNT(DISTINCT job) FROM emp;


--15. EMP와 DEPT 테이블에서 월급(SAL)을 3000 이상 받는 사원들의 사원이름과
--    소속 부서이름을 출력하는 SQL문을 작성하세요. (결과를 캡쳐하여 붙여 넣습니다.)
SELECT ename, dname
FROM emp e
JOIN dept d ON d.deptno = e.deptno
WHERE sal >= 3000;


--16 EMP 테이블에서 MARTIN보다 급여가 낮은 사원정보를 출력하는 SQL문을 작성하세요.
--   (서브쿼리 사용)
SELECT * FROM emp
WHERE sal < (SELECT sal FROM emp WHERE ename = 'MARTIN');


--17 EMP 테이블에서 30번 부서 사원들의 최대 급여보다 많은 급여를 받는 사원정보를
--   출력하는 SQL문을 작성하세요. (서브쿼리에서 단일행 연산자 방식과 다중행 연산자
--   방식으로 문장 2개를 모두 작성하세요)
-- 단일행 연산자 방식
SELECT * FROM emp
WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno = 30);

-- 다중행 연산자 방식
SELECT * FROM emp
WHERE sal > ALL (SELECT sal FROM emp WHERE deptno = 30);


--18 EMP, SALGRADE 테이블을 비동등 조인하여 사원의 급여등급이 3등급이고
--   30번 부서 소속인 사원들의 모든 정보를 출력하는 SQL문을 작성하세요.
SELECT * FROM emp
JOIN salgrade ON sal BETWEEN losal AND hisal
WHERE grade = 3 AND deptno = 30;


--19 CREATE 명령어를 사용하여 다음 열 구조를 가지는 EMP_DDL 테이블을 생성하는
--   SQL문을 작성하고 실행하세요. 그리고 DESC 명령어로 생성된 테이블의 열 구조를 확인하세요.
CREATE TABLE EMP_DDL
( EMPNO NUMBER(4),
  ENAME VARCHAR2(10),
  JOB VARCHAR2(9),
  MGR NUMBER(4),
  HIREDATE DATE,
  SAL NUMBER(7, 2),
  COMM NUMBER(7, 2),
  DEPTNO NUMBER(2) );
DESC EMP_DDL;


--20 EMP 테이블로 가상의 테이블인 EMP_V3 뷰(VIEW) 테이블을 생성하는 SQL문을 작성하세요.
--   열의 이름은 다음과 같이 정한다. (직원번호, 이름, 직업, 고용일자, 월급, 부서번호)
--관리자 계정으로 권한부여 후 진행
GRANT CREATE VIEW TO SCOTT;

CREATE VIEW EMP_V3
AS
SELECT empno 직원번호, ename 이름, job 직업, hiredate 고용일자, sal 월급, deptno 부서번호
FROM emp;
SELECT * FROM emp_V3;