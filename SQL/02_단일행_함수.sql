-- ============================================================================

-- ������ �Լ�
SELECT UPPER('SQL Course'), -- ��� �빮�ڷ� ��ȯ
       LOWER('SQL Course'), -- ��� �ҹ��ڷ� ��ȯ
       INITCAP('SQL Course') -- ù ���ڸ� �빮�ڷ� ��ȯ
FROM dual;  -- dual : Test�� Dummy Table

SELECT CONCAT('Hello', 'World'), -- �ΰ��� ���ڿ��� ����
       SUBSTR('ABCDEFG', 3, 4), -- ���ڿ� ��ȯ(���ڿ�, ������ġ, ��ȯ����)
       LENGTH('ABCDEFG'), -- ���ڿ��� ����
       INSTR('ABCDEFG', 'D'), -- ���ڿ��� ��ġ
       TRIM('   Hello  W o r l d   ')  -- ���ڿ� �յ��� ���� ����(�߰��� ���� �ȵ�)
FROM DUAL;

SELECT job_id, REPLACE(job_id, 'ACCOUNT', 'ACCNT') ������ -- ���ڿ� �ٲٱ�(���ڿ�, ������, ��ȯ��)
FROM employees;

-- ���� 1-1
SELECT department_id, last_name FROM employees
WHERE lower(last_name) = 'higgins'; -- ��ҹ��� �������� ��� ��ȯ�ؼ� ��ȸ����
-- ���� 1-2
SELECT last_name, LOWER(last_name), UPPER(last_name),
       email, INITCAP(email)
FROM employees;
-- ���� 1-3
SELECT job_id, SUBSTR(job_id, 1, 2) FROM employees;

-- ============================================================================

-- ������ �Լ�
SELECT ROUND(15.3456, 2), -- �ݿø�(����, �Ҽ��� �ڸ���)
       ROUND(15.3456, -1), -- -1�� 10�� �ڸ�
       ROUND(15.3456, 0), -- 0�� ����
       ROUND(15.3456), -- �ڸ��� �� ������ ����ó��
       ROUND(15.1, 2), -- �Ҽ��� �ڸ� ���ų� ���ڸ��� �ִ� ��ŭ�� ǥ��
       TRUNC(15.6543, 2), -- ������(����, �Ҽ��� �ڸ���) / 0, -1 �� ROUND�� ����
       MOD(17, 3) -- ������ �� ���ϱ�
FROM dual;

-- ������ȣ�� ¦���� �����鸸 ����
SELECT employee_id, last_name
FROM employees
WHERE MOD(employee_id, 2) = 0
ORDER BY employee_id;

-- ������ȣ�� Ȧ���� �����鸸 ����
SELECT employee_id, last_name
FROM employees
WHERE MOD(employee_id, 2) = 1
ORDER BY employee_id;

-- ���� 2
SELECT salary, ROUND(salary/30, 0), ROUND(salary/30, 1), ROUND(salary/30, -1)
FROM employees;

-- ============================================================================

-- ��¥�� �Լ�
SELECT sysdate ����, sysdate-1 ����, sysdate+1 ���� FROM dual;
-- �ݿø� �ϸ� 1�� �ʱ�ȭ��
SELECT ROUND(sysdate, 'DD') ��, -- �ð�(time)�� �ݿø�
       ROUND(sysdate, 'MM') ��, -- ��(day)�� �ݿø�
       ROUND(sysdate, 'YYYY') �⵵, -- ��(month)�� �ݿø�
       MONTHS_BETWEEN('2021/10/01', '2020/11/01') ��_����, -- �� ��¥ ������ �Ⱓ�� �� ���� ���(�̷�, ����)
       ADD_MONTHS('2021/10/01', 3) ��_���ϱ� -- ������ ������ ���⵵ ����
FROM dual;

-- 90�� �μ� �������� ���ñ����� �ٹ��ϼ�
SELECT last_name, FLOOR((sysdate - hire_date)) �ٹ��ϼ� -- FLOOR : �Ҽ��� ������
FROM employees WHERE department_id = 90;

-- �ٹ������� 200���� �̸��� ��������...
SELECT employee_id, hire_date,
       FLOOR(MONTHS_BETWEEN(sysdate, hire_date)) �ٹ�����,
       ADD_MONTHS(hire_date, 3) "3����_�߰�", -- ��Ī �� ó���� ���ڰ� ���� ū ����ǥ ���
       NEXT_DAY(hire_date, '�ݿ���') ����_�ݿ���, -- ������ ���� ������ ������ ��¥
       LAST_DAY(hire_date) ������_�� -- �������� ���� ���� ������ ��
FROM employees WHERE MONTHS_BETWEEN(sysdate, hire_date) < 200;

-- ���� 3-1
SELECT sysdate, hire_date, FLOOR(MONTHS_BETWEEN(sysdate, hire_date)) �ٹ�����
FROM employees WHERE department_id = 100;
-- ���� 3-2
SELECT hire_date, ADD_MONTHS(hire_date, 3) "3����_���ϱ�", ADD_MONTHS(hire_date, -3) "3����_����"
FROM employees WHERE employee_id BETWEEN 100 AND 106;

-- ============================================================================

-- ��ȯ�� �Լ�
-- ���ڸ� ���ڷ� ��ȯ : TO_CHAR(��ȯ�� ����, 'FORMAT')
SELECT TO_CHAR(12345678, '999,999,999') comma, -- �޸�
       TO_CHAR(123.45678, '999,999,999.99') period, -- �Ҽ���
       TO_CHAR(123.45678, '$999,999,999') dollar, -- �޷�ǥ��
       TO_CHAR(123.45678, 'L999,999,999') local -- ������ȭ(�ѱ��� ��ȭ, �Ϻ��� ��ȭ ��)
FROM dual;
-- ��¥�� ���ڷ� ��ȯ : TO_CHAR(��ȯ�� ��¥, 'FORMAT')
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS') "����ð�(24�ð�)",
       TO_CHAR(sysdate, 'YYYY-MM-DD AM HH:MI:SS') "����ð�(����/����)" -- AM/PM �� �߿� �ϳ��� ����
FROM dual;

-- ���� 4-1
SELECT employee_id, TO_CHAR(hire_date, 'MM/WW') �Ի��
FROM employees WHERE department_id = 100;
-- ���� 4-2
SELECT first_name||' '||last_name �̸�, TO_CHAR(salary, '$999,999,999.99') ����
FROM employees WHERE salary > 10000 ORDER BY salary DESC;

-- ���ڸ� ��¥�� ��ȯ : TO_DATE('��ȯ�� ����', 'FORMAT')
-- ������ Ÿ��_1 CHAR : ���� ���� ���ڿ��� ����, ������ ���̺��� ª�� ���� �����ϸ� ������ ������ �������� ä��
-- ������ Ÿ��_2 VARCHAR2 : ���� ���� ���ڿ��� ����, ������ ���̺��� ª�� ���� �����ϸ� �� ����ŭ�� ����
SELECT TO_DATE('2020-11-17', 'YYYY-MM-DD') FROM dual;

-- ���ڸ� ���ڷ� ��ȯ : TO_NUMBER('��ȯ�� ����')
SELECT TO_NUMBER('01210616') + 10 FROM dual;