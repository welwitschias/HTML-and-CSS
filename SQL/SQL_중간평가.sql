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


--1 EMP ���̺��� ����(���� �̸�, �� ��밡�� �� ������ Ÿ��)�� Ȯ���ϴ�
--  ��ɹ��� �ۼ��ϼ���.
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'EMP';


--2 EMP ���̺��� �μ���ȣ(DEPTNO) �� ���� 30�̰� ����(JOB) �� ���� SALESMAN��
--  �����͸� ��µǵ��� ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT * FROM EMP
WHERE deptno = 30 AND job = 'SALESMAN';


--3 EMP ���̺��� �޿�(SAL) �� ���� 2000 �̻� 3000 ������ ��� �����͸�
--  ��ȸ�ϴ� SQL���� �ۼ��ϼ���.
SELECT * FROM EMP
WHERE sal BETWEEN 2000 AND 3000;


--4 EMP ���̺��� �� ������ ���� �����ʹ� ���� �� EMP_TEMP ���̺��� �����ϴ�
--  SQL���� �ۼ��ϼ���.
CREATE TABLE emp_temp
AS
SELECT * FROM emp WHERE 1 != 1;
SELECT * FROM emp_temp;


--5 EMP_TEMP ���̺� ȫ�浿 ����� �߰� �մϴ�.
--  �����ȣ(EMPNO)�� 9999, ����̸�(ENAME)�� ȫ�浿, ��å(JOB)�� PRESIDENT,
--  ���ӻ��(MGR)�� NULL��, �������(HIREDATE)�� 2001�� 1�� 1��, �޿�(SAL)�� 5000,
--  �߰� ����(COMM)�� 1000, �μ� ��ȣ(DEPTNO)�� 10���� �����͸� �߰��ϴ�
--  SQL���� �ۼ��Ͽ� �Է��ϼ���.
INSERT INTO emp_temp
VALUES (9999, 'ȫ�浿', 'PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10);
SELECT * FROM emp_temp;


--6 DEPT ���̺��� �����ؼ� DEPT_TEMP2 ���̺��� �����ϴ� SQL���� �ۼ��ϼ���.
CREATE TABLE dept_temp2
AS
SELECT * FROM dept;
SELECT * FROM dept_temp2;


--7 DEPT_TEMP2 ���̺��� 40�� �μ�(DEPTNO)�� �μ��̸�(DNAME)�� DATABASE�� �����ϰ�
--  ����(LOC)�� SEOUL�� �����ϴ� SQL���� �ۼ��ϼ���. (����� ĸ���Ͽ� �ٿ� �ֽ��ϴ�.)
UPDATE dept_temp2
SET dname = 'DATABASE', loc = 'SEOUL'
WHERE deptno = 40;
SELECT * FROM dept_temp2;


--8 ���̺� �� �ุ �����ؾ� �ϴµ� �߸��ؼ� ��ü ���� ������ ���ȴ�.
--  �̶� Ʈ������� ����ϴ� ��ɾ �ۼ��ϼ���.
ROLLBACK;


--9 EMP ���̺��� ����̸�(ENAME)���� �����Ͱ� �빮���̵� �ҹ����̵� �������
--  SMITH�� ��� ������ ��ȸ�ϴ� SQL���� �ۼ��ϼ���.
-- (��Ʈ: UPPER �Լ��� WHERE ���� ��� �̸��� �빮�ڷ� ���� ���� �˻�)
SELECT *
FROM emp
WHERE UPPER(ename) = 'SMITH';


--10 EMP ���̺��� ��� �̸��� 4���� ������ ��� ������ ��ȸ�ϴ� SQL���� �ۼ��ϼ���.
SELECT * FROM emp
WHERE LENGTH(ename) <= 4;


--11 EMP ���̺��� ��å �̸��� ù���ں��� �� ���� ����ϴ� SQL���� �ۼ��ϼ���.
SELECT SUBSTR(job, 1, 3) FROM emp;


--12 EMP ���̺��� 1981�� 6�� 1�� ���Ŀ� �Ի��� ��� ������ ����ϴ� SQL���� �ۼ��ϼ���.
SELECT * FROM emp
WHERE hiredate >= '1981/06/01';


--13. EMP ���̺��� NVL �Լ��� ����Ͽ� ����� �����ȣ(EMPNO), ����̸�(ENAME),
--    ����(SAL), �߰�����(COMM), �׸��� 1��ġ ������ ���ؼ� ANNSAL ���� ����ϴ� SQL����
--    �ۼ��ϼ���. (��Ʈ : 1�� ������ ����*12 + �߰����� �̴�. )
SELECT empno, ename, sal, comm, sal*12+NVL(comm,0) ANNSAL FROM emp;


-- 14. EMP ���̺��� �ߺ��� ������ ��å(JOB)�� ������ ����ϴ� SQL���� �ۼ��ϼ���.
--     (��Ʈ : DISTINCT �� COUNT �Լ��� �̿��Ͽ� �ߺ��ȵ� ���� ���� ������ ī��Ʈ )
SELECT COUNT(DISTINCT job) FROM emp;


--15. EMP�� DEPT ���̺��� ����(SAL)�� 3000 �̻� �޴� ������� ����̸���
--    �Ҽ� �μ��̸��� ����ϴ� SQL���� �ۼ��ϼ���. (����� ĸ���Ͽ� �ٿ� �ֽ��ϴ�.)
SELECT ename, dname
FROM emp e
JOIN dept d ON d.deptno = e.deptno
WHERE sal >= 3000;


--16 EMP ���̺��� MARTIN���� �޿��� ���� ��������� ����ϴ� SQL���� �ۼ��ϼ���.
--   (�������� ���)
SELECT * FROM emp
WHERE sal < (SELECT sal FROM emp WHERE ename = 'MARTIN');


--17 EMP ���̺��� 30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ���������
--   ����ϴ� SQL���� �ۼ��ϼ���. (������������ ������ ������ ��İ� ������ ������
--   ������� ���� 2���� ��� �ۼ��ϼ���)
-- ������ ������ ���
SELECT * FROM emp
WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno = 30);

-- ������ ������ ���
SELECT * FROM emp
WHERE sal > ALL (SELECT sal FROM emp WHERE deptno = 30);


--18 EMP, SALGRADE ���̺��� �񵿵� �����Ͽ� ����� �޿������ 3����̰�
--   30�� �μ� �Ҽ��� ������� ��� ������ ����ϴ� SQL���� �ۼ��ϼ���.
SELECT * FROM emp
JOIN salgrade ON sal BETWEEN losal AND hisal
WHERE grade = 3 AND deptno = 30;


--19 CREATE ��ɾ ����Ͽ� ���� �� ������ ������ EMP_DDL ���̺��� �����ϴ�
--   SQL���� �ۼ��ϰ� �����ϼ���. �׸��� DESC ��ɾ�� ������ ���̺��� �� ������ Ȯ���ϼ���.
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


--20 EMP ���̺�� ������ ���̺��� EMP_V3 ��(VIEW) ���̺��� �����ϴ� SQL���� �ۼ��ϼ���.
--   ���� �̸��� ������ ���� ���Ѵ�. (������ȣ, �̸�, ����, �������, ����, �μ���ȣ)
--������ �������� ���Ѻο� �� ����
GRANT CREATE VIEW TO SCOTT;

CREATE VIEW EMP_V3
AS
SELECT empno ������ȣ, ename �̸�, job ����, hiredate �������, sal ����, deptno �μ���ȣ
FROM emp;
SELECT * FROM emp_V3;