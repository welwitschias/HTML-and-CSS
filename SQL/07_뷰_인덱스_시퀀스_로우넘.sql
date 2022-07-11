-- ===========================================================================

-- ��(view) : ������ ���̺�
-- ������ �� �����
CREATE VIEW EMP_V1
AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id
FROM employees;
SELECT * FROM emp_v1;

-- �信 ������ �Է� �� �����δ� �並 ���� �� ����� ���̺� �Էµ�
INSERT INTO EMP_V1
VALUES(33, '���', '��', 'Peng', SYSDATE, 'IT_PROG');
SELECT * FROM employees WHERE employee_id = 33;

-- ������ �� �����
-- �׷��Լ��� ����� ��� DML(�������� �Է�, ����, ����) ��� �Ұ�
CREATE OR REPLACE VIEW �μ���_����_���� -- OR REPLACE : �並 �������� �ʰ� ������ �� ����
AS
SELECT department_id �μ���ȣ, count(*) ������, MAX(salary) �ְ�޿�, MIN(salary) �����޿�, ROUND(AVG(salary)) ��ձ޿�
FROM employees
GROUP BY department_id
ORDER BY department_id;
SELECT * FROM �μ���_����_����;

-- �б⸸ ������ �� (90�� �μ� �������� �б� ���� ��)
CREATE OR REPLACE VIEW emp90_read
AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id
FROM employees
WHERE department_id = 90
WITH READ ONLY;
SELECT * FROM emp90_read;
-- �б� �����̹Ƿ� DML ��� �ȵ�
DELETE FROM emp90_read; -- ���� �Ұ�
INSERT INTO emp90_read VALUES (777, '����', '��', 'Mong', '22/05/07', 'IT_PROG'); -- �Է� �Ұ�

-- ===========================================================================

-- �ε��� ��ȸ�ϱ� : �⺻Ű ���� �ڵ����� �ε����� ������
SELECT * FROM all_ind_columns WHERE table_name = 'DEPARTMENTS';
SELECT * FROM all_ind_columns WHERE table_name = 'MEMBERS';

-- �ε��� �ǽ��� ���̺� �����
CREATE TABLE members
( member_id INT,
  first_name VARCHAR2(100) NOT NULL,
  last_name VARCHAR2(100) NOT NULL,
  gender CHAR(1) NOT NULL,
  dob DATE NOT NULL,
  email VARCHAR2(255) NOT NULL,
  PRIMARY KEY(member_id) );
SELECT * FROM members ORDER BY member_id;

-- full_name���� �˻�
EXPLAIN PLAN FOR
SELECT * FROM members
WHERE last_name LIKE 'A%' AND first_name LIKE 'M%';
-- SQL ���� ���� Ȯ��
SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

-- �ε��� �����
CREATE INDEX members_last_name_i ON members(last_name);

-- �ε��� �����ϱ�
DROP INDEX members_last_name_i;

-- ��Ƽ �ε��� (���� ���� ���� ���� �ε���)
CREATE INDEX members_name_i ON members(last_name, first_name);

-- ===========================================================================

-- ������ : ������(UNIQUE) ���� �������ִ� ����Ŭ ��ü, ���� �⺻Ű ������ ���
-- ������ �����
CREATE SEQUENCE ������1; -- �⺻ : 1�� ����, 1�� ����

-- ������ �����ϱ�
DROP SEQUENCE ������1;

-- ������ ���� Ȯ��
SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME = '������1';

-- ������ ����
SELECT ������1.NEXTVAL FROM DUAL; -- .NEXTVAL : ���� ������ ���� �����(1�� ����)
SELECT ������1.CURRVAL FROM DUAL; -- .CURRVAL : ���� ������ ���� �����

-- �������� �̿��ؼ� ������ id�� �Է��غ���
CREATE TABLE ����
( emp_id NUMBER(6) PRIMARY KEY,
  emp_name VARCHAR2(50) NOT NULL );

CREATE SEQUENCE ������2
START WITH 100000 -- 100000���� ����
INCREMENT BY 10; -- 10�� ����

INSERT INTO ���� VALUES (������2.NEXTVAL, '����');
INSERT INTO ���� VALUES (������2.NEXTVAL, '����');
INSERT INTO ���� VALUES (������2.NEXTVAL, '����');
INSERT INTO ���� VALUES (������2.NEXTVAL, '����');
INSERT INTO ���� VALUES (������2.NEXTVAL, '����');
SELECT * FROM ����;

-- ������ id�� ������1�� ������Ʈ �غ���
UPDATE ���� SET emp_id = ������1.NEXTVAL;

-- ===========================================================================

-- ROWNUM : SELECT�� �����Ϳ� �Ϸù�ȣ�� ���̴� ��
-- ���� n�ุ ����ϱ�
SELECT ROWNUM, employees.* FROM employees WHERE ROWNUM <= 7;

-- �߰��� n�ุ ����ϱ� - �������� �̿�
SELECT E.* FROM (SELECT ROWNUM RN, employees.* FROM employees) E
WHERE RN BETWEEN 5 AND 10; -- ROWNUM�� RN���� ��Ī�� ��� ��� ��µ�

-- ���� �� �����Űܼ� �߰��ุ ����ϱ�
SELECT ROWNUM, A.*
FROM (SELECT employee_id, last_name, salary FROM employees ORDER BY salary DESC) A
WHERE ROWNUM <= 10;

-- ===========================================================================