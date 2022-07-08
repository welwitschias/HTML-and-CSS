-- ===========================================================================

-- ������ �Է��ϱ� : �ϳ��� �ุ�� ����, ������ ���� NULL���� �Էµ�
-- �� ���� VALUES���� ���� �ݵ�� 1:1�� �����ؾ� ��
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (300, 'Game', 100, 1700);
-- �⺻Ű : �ݵ�� �Է� + �ߺ��Է� �Ұ� + �ϳ��� �־�� ��
-- departments Table���� �⺻Ű�� department_id
SELECT * FROM departments; -- ���� �����Ͱ� �߰��� �� Ȯ�ΰ���
DESC departments; -- NOT NULL�� ������ �Է��ؾ� ��

-- �� �Է��ؾ� �ϴ� ���� �Է�
INSERT INTO departments(department_id, department_name)
VALUES (280, 'Music');
SELECT * FROM departments;

-- ��ü �� �Է�
INSERT INTO employees
VALUES (207, '���', '��', 'Peng', '515.129.1234', SYSDATE, 'IT_PROG', 9999, NULL, 205, 300);
SELECT * FROM employees;

-- ���� 1
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (271, 'Sample Dept 1', 200, 1700);
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (272, 'Sample Dept 2', 200, 1700);
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (273, 'Sample Dept 3', 200, 1700);
SELECT * FROM departments;

-- ===========================================================================

-- ������ �����ϱ� : ���� ���� ���� ���ÿ� ��������
-- ���� : WHERE�� �����ϸ� ������ ���� ��� ���� ������
UPDATE departments
SET manager_id = 200, location_id = 1700
WHERE department_name = 'Music';
SELECT * FROM departments;

UPDATE employees
SET email = 'PENG', phone_number = '010.123.4567', salary = salary * 1.2
WHERE employee_id = 207;
SELECT * FROM employees;

-- ���� 2
UPDATE departments
SET manager_id = 100
WHERE department_id BETWEEN 150 AND 200;
SELECT * FROM departments;

-- ===========================================================================

-- ������ �����ϱ� : WHERE���� ���ǿ� �ش��ϴ� �� ������ ����
DELETE FROM departments
WHERE department_id = 280; -- �ַ� �⺻Ű�� �̿��Ͽ� ����
--WHERE department_name = 'Music';
SELECT * FROM departments;

-- �ܷ�Ű ���� ����
DELETE FROM departments
WHERE department_name = 'Game'; -- ����� Game �μ��� ���ԵǾ� �����Ƿ� ���� �߻�
-- ����� �����ϰų� �μ��� �Ű����
DELETE FROM employees
WHERE first_name = '���';
-- ���Ӻμ� ���� ����
DELETE FROM departments
WHERE department_name = 'Game';
SELECT * FROM employees;

-- WHERE���� ������ ��� ���� ������
DELETE FROM job_history;
SELECT * FROM job_history;
-- WHERE���� ������ ��� ���� ������
UPDATE employees
SET salary = 100;
SELECT * FROM employees;

-- ���� COMMIT ���·� �ǵ�����
ROLLBACK;
-- ��������
COMMIT;

-- ===========================================================================

-- ������ ������ : VARCHAR2(n) - n�� �ִ� 4000����Ʈ
DESC TEST; -- VARCHAR2(20) : �ִ� 20����Ʈ���� �Է� ����
INSERT INTO test VALUES (1, 'ABCDEFGHIJ1234567890');
--INSERT INTO test VALUES (2, 'ABCDEFGHIJ12345678901'); -- ����, ���� : 1����Ʈ
INSERT INTO test VALUES (2, '�����ٶ󸶹�');
--INSERT INTO test VALUES (2, '�����ٶ󸶹ٻ�'); -- ����Ŭ���� �ѱ� : 3����Ʈ

-- ������ ������ : NUMBER(P,S) - P(1~38) ��ü �ڸ���, S �Ҽ��� ��ȿ�ڸ���
DESC TEST; -- NUMBER(1) : ���ڸ����� �Է� ����
INSERT INTO test VALUES (3, '���ڴ����ڸ�', SYSDATE);
--INSERT INTO test VALUES (33, '���ڸ���'); -- ���ڸ����̹Ƿ� �Է� �Ұ�

-- ��¥�� ������ : DATE
INSERT INTO test VALUES (4, '���糯¥�Է�', SYSDATE);
INSERT INTO test VALUES (5, '���ڿ����Է�', '22/03/07');
INSERT INTO test(id, name) VALUES (6, '��¥������');
SELECT * FROM test;

-- ===========================================================================