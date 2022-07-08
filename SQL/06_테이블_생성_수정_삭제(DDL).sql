-- ===========================================================================

-- ���� : ���̺��� ����, �����ϴ� ���� �ٷ� COMMIT��, ROLLBACK �Ұ�
-- ���̺� ����
CREATE TABLE �׽�Ʈ 
( ���� NUMBER,
  ���ڿ� VARCHAR2(100),
  ��¥ DATE DEFAULT SYSDATE );  -- Column_Name Data_Type [DEFAULT Default_Value]

-- ���̺� �̸� ���� �� ���ǻ���
-- 1. ���ڷ� �����ؾ� ��(���ڷ� ���� �Ұ�)
-- 2. ���̺� �̸��� 30����Ʈ ����
-- 3. ��밡���� ���ڴ� A-Z, a-z, _, $, # (- ���Ұ�) / �ѱ� ����
-- 4. ������ �ٸ� ���̺�� �̸��� ������ �ȵ�
-- 5. SQL ��ɾ ����ϸ� �ȵ�(SELECT, FROM, WHERE, ...)

INSERT INTO �׽�Ʈ VALUES (1, '�ϳ�', SYSDATE);
INSERT INTO �׽�Ʈ VALUES (2, '�ο�', SYSDATE);
INSERT INTO �׽�Ʈ VALUES (3, '����', SYSDATE);
INSERT INTO �׽�Ʈ VALUES (4, '�׿�', SYSDATE);
SELECT * FROM �׽�Ʈ;

-- ���̺� ����
DROP TABLE TEST;
DROP TABLE �׽�Ʈ;

-- ���� 1-1
CREATE TABLE SAMPLE_PRODUCT
( PRODUCT_ID NUMBER,
  PRODUCT_NAME VARCHAR2(20),
  MENU_DATE DATE );
-- ���� 1-2
DROP TABLE SAMPLE_PRODUCT;
DESC SAMPLE_PRODUCT;

-- ===========================================================================

-- �������� ����
-- �÷� ���� ���� : �÷��� �����ϸ鼭 ���� ����
CREATE TABLE emp
( eno       NUMBER(3) CONSTRAINT emp_eno_pk PRIMARY KEY, 
  emp_name  VARCHAR2(20) );
-- ���̺� ���� ���� : ���̺� ���� �������� ����, NOT NULL�� �Ұ�(�÷� ������ ����)
CREATE TABLE emp
( eno       NUMBER(3),
  emp_name  VARCHAR2(20),
  CONSTRAINT emp_eno_pk PRIMARY KEY (eno) );
DESC emp;
DROP TABLE emp;

-- �������� ����
DROP TABLE emp CASCADE CONSTRAINT;

-- NOT NULL : NULL�� ��� ����, UNIQUE : �ߺ��� �� ��� ����(NULL���� �����)
CREATE TABLE emp1
( eno       NUMBER(3) CONSTRAINT emp1_eno_pk PRIMARY KEY,
  emp_name  VARCHAR2(20) CONSTRAINT emp1_ename_nn NOT NULL,
  email     varchar2(30),
  CONSTRAINT emp1_email_uk UNIQUE (email) );
DESC emp1;
INSERT INTO emp1 VALUES (100, '�浿', 'hong@naver.com');
INSERT INTO emp1 VALUES (101, '���', 'peng@naver.com');
--INSERT INTO emp1 VALUES (101, NULL, 'peng@naver.com'); -- NULL���� ���� ����
--INSERT INTO emp1 VALUES (101, '���', 'hong@naver.com'); -- �浿���� �̸��ϰ� ���Ƽ� ����
SELECT * FROM emp1;
DROP TABLE emp1;

-- CHECK : �������� ������ ����(WHERE���� �����ϰ� ���� ������)
CREATE TABLE emp2
( eno       NUMBER(3),
  emp_name  VARCHAR2(20),
  sal       number(10),
  CONSTRAINT emp_sal_check CHECK (sal > 1000) ); -- sal���� ������������ 1000���� ū ������ ��
DESC emp2;
INSERT INTO emp2 VALUES (200, '����', 1200);
INSERT INTO emp2 VALUES (201, '����', 1500);
--INSERT INTO emp VALUES (201, '����', 800); -- 1000 ���Ͽ��� ����
SELECT * FROM emp2;
DROP TABLE emp2;

-- ���������� �̸����� ���̺� ����
CREATE TABLE emp3
( eno      NUMBER(4) PRIMARY KEY,
  ename    VARCHAR2(20) NOT NULL,
  password VARCHAR2(13) UNIQUE CHECK (LENGTH(password) >= 8),
  gender   VARCHAR2(6) CHECK (gender IN ('����', '����')) );
DESC emp3;
INSERT INTO emp3 VALUES (1000, '�հ�', '12345678', '����');
INSERT INTO emp3 VALUES (1010, '���', '789123456', '����');
SELECT * FROM emp3;
DROP TABLE emp3;

-- ���� 2
CREATE TABLE members
( member_id  NUMBER(2) PRIMARY KEY,
  first_name VARCHAR2(50) NOT NULL,
  last_name  VARCHAR2(50) NOT NULL,
  gender     VARCHAR2(5) CHECK (gender IN ('Man', 'Woman')),
  birth_day  DATE DEFAULT SYSDATE,
  email      VARCHAR2(200) UNIQUE NOT NULL );
DESC members;
INSERT INTO members VALUES (01, '�浿', 'ȫ', 'Man', '1972-11-13', ' ');
INSERT INTO members VALUES (02, '����', '��', 'Woman', '1985-06-26', '  ');
SELECT * FROM members;
DROP TABLE members;

-- ===========================================================================

-- �⺻Ű, �ܷ�Ű �����
CREATE TABLE dept
( dno   NUMBER(4),
  dname VARCHAR2(20),
  CONSTRAINT dept_dno_pk PRIMARY KEY(dno) );

CREATE TABLE emp
( eno       NUMBER(4) PRIMARY KEY,
  emp_name  VARCHAR2(20),
  sal       NUMBER(10),
  dno       NUMBER(4),
  FOREIGN KEY (dno) REFERENCES dept (dno) ); -- �ܷ�Ű�� ���̺� ���������� ��������

INSERT INTO dept VALUES (10, '����');
INSERT INTO dept VALUES (20, '����');
INSERT INTO dept VALUES (30, 'ȸ��');
INSERT INTO dept VALUES (40, '����');
INSERT INTO dept VALUES (50, '����');
SELECT * FROM dept;
DROP TABLE dept;

INSERT INTO emp VALUES (1010, 'ö��', 100, 10);
INSERT INTO emp VALUES (1020, '����', 200, 20);
INSERT INTO emp VALUES (1030, '�ͱ�', 250, 30);
INSERT INTO emp VALUES (1040, '����', 350, 40);
INSERT INTO emp VALUES (1050, '¯��', 500, 50);
SELECT * FROM emp;
DROP TABLE emp;

-- �������� ��ȸ�ϱ�
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'EMP'; -- ���̺���� �빮�ڷ� ����� ��
-- CONSTRAINT_TYPE : P(�⺻Ű), R(�ܷ�Ű), U(����ũ), C(NOT NULL, CHECK)
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'DEPT';

-- ===========================================================================