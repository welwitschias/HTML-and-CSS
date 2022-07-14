-- ============================================================================

-- �μ� Table�� ���(*) �� ��ȸ
SELECT * FROM departments;
-- AS�� ��Ī(���� ����), ��ȸ�� �� �̸��� �˻� ����
SELECT department_name AS �μ��̸� FROM departments;
-- Table���� FROM�� ����, SELECT���� ctrl+space�� �̿��Ͽ� �ڵ����� �� �̸��� �ҷ��´�.
SELECT department_id �μ���ȣ, department_name �μ��̸� FROM departments;

-- ���� Table�� ���� �� ��ȸ
SELECT salary ���� FROM employees;
-- ��ü ���� ���޿� 100 �߰��ؼ� ���ο� �� �����
SELECT last_name �̸�, salary ����, salary+100 ���ʽ����� FROM employees;
-- ��ü ���� ���޿� -10%�ؼ� ���ο� �� �����
SELECT last_name �̸�, salary ����, salary-salary*0.10 ������ FROM employees;

-- ���� 1
SELECT employee_id, first_name, last_name FROM employees;
SELECT first_name, salary, salary*1.1 AS NEWSALARY FROM employees;
SELECT employee_id �����ȣ, first_name �̸�, last_name �� FROM employees;

-- ============================================================================

-- �ߺ��� �� ���� : DISTINCT
SELECT DISTINCT job_id ���� FROM employees;

-- employees Table�� ���� ����
DESC employees;

-- ���� ������(||) : �� ���� ����� ������ �ϳ��� ���� ǥ��
-- ���ڸ� ������ ������ ���� ����ǥ ���(ū ����ǥ �ȵ�)
SELECT employee_id, first_name||' '||last_name FULLNAME FROM employees;

-- ���� 2
SELECT employee_id, first_name||' '||last_name FULLNAME, email||'@company.com' EMAIL
FROM employees;

-- ============================================================================

-- WHERE : ����
-- ������ �� ������ 14000 �̻��� ������ ����
SELECT * FROM employees WHERE salary > 14000;
-- ������ �� ���� King�� ������ ����
SELECT * FROM employees WHERE last_name = 'King'; -- ���ڿ��� ��ҹ��ڸ� ������
-- ������ �� ������� 2002�� 06�� 10�� ������ ������ ����
SELECT * FROM employees WHERE hire_date < '2002/06/10'; -- ���ڿ� ���� ��¥������ �ڵ����� ��ȯ��

-- ���� 3
SELECT * FROM employees WHERE employee_id = 100;
SELECT * FROM employees WHERE first_name = 'David';
SELECT * FROM employees WHERE employee_id <= 105;
SELECT * FROM job_history WHERE start_date > '2006/03/03';
SELECT * FROM departments WHERE location_id != 1700;

-- ============================================================================

-- NOT(1), AND(2), OR(3) : ( )���� �켱 ����, ( )�� �켱���� ����������!
SELECT last_name, department_id, salary FROM employees
WHERE (department_id = 60 OR department_id = 80) AND salary > 10000;
SELECT last_name, department_id, salary FROM employees
WHERE department_id = 60 OR (department_id = 80 AND salary > 10000);

-- ���� 4
SELECT * FROM employees
WHERE salary > 4000 AND job_id = 'IT_PROG';
SELECT * FROM employees
WHERE salary > 4000 AND (job_id = 'IT_PROG' OR job_id = 'FI_ACCOUNT');

-- ============================================================================

-- IN ������ : WHERE �ȿ��� Ư���� ���� ���� ����(OR ���� �� ���� ��ſ� ���)
SELECT * FROM employees WHERE salary = 4000 OR salary = 3000 OR salary = 2700;
SELECT * FROM employees WHERE salary IN (4000, 3000, 2700);

-- ���� 5
SELECT * FROM employees WHERE salary IN (10000, 17000, 24000);
SELECT * FROM employees WHERE department_id NOT IN (30, 50, 80, 100, 110);

-- ============================================================================

-- BETWEEN ������ : A AND B (A�� B�� ���հ�, A�� B�� ����)
SELECT * FROM employees WHERE salary >= 9000 AND salary <= 10000;
SELECT * FROM employees WHERE salary BETWEEN 9000 AND 10000;

-- ���� 6
SELECT * FROM employees WHERE salary BETWEEN 10000 AND 20000;
SELECT * FROM employees WHERE hire_date BETWEEN '2004/01/01' AND '2004/12/31';
SELECT * FROM employees WHERE salary NOT BETWEEN 7000 AND 17000;

-- ============================================================================

-- LIKE ������ : ���ǰ��� ��Ȯ���� ���� �� ���
-- ���ϵ� ī�� : %(��� ����, ���� �� ������� - ���� ��쵵 ����), _(�� ����)

-- ���� B�� �����ϴ� ����� ����
SELECT * FROM employees WHERE last_name LIKE 'B%';
-- ���� �߰��� b�� ���� ����� ����
SELECT * FROM employees WHERE last_name LIKE '%b%';
-- ���� y�� ������ ����� ����
SELECT * FROM employees WHERE last_name LIKE '%y';

-- ���� 7
SELECT * FROM employees WHERE job_id LIKE '%AD%';
SELECT * FROM employees WHERE job_id LIKE 'AD___';
SELECT * FROM employees WHERE phone_number LIKE '%1234';
SELECT * FROM employees WHERE phone_number NOT LIKE '%3%' AND phone_number LIKE '%9';
SELECT * FROM employees
WHERE job_id LIKE '%MGR%' OR job_id LIKE '%ASST%';
--WHERE job_id LIKE IN ('%MGR%', '%ASST%'); -- ���Ұ� : IN �ȿ��� %�� �� �� ����

-- ============================================================================

-- IS NULL : �����Ͱ��� NULL(���� �Է����� ����, 0�̳� ������� �ٸ�)�� ��츦 ��ȸ
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

-- ���� 8
SELECT * FROM employees WHERE manager_id IS NULL;

-- ============================================================================

-- ORDER BY : �࿡ ���� ���� ���� ����
-- ASC : ��������(�⺻ ���� ���, ���� ����), DESC : ��������

-- salary�� ū ��� ������ ����
SELECT * FROM employees ORDER BY salary DESC;
-- salary�� ���� ��� ������ ����
SELECT * FROM employees ORDER BY salary; -- ASC�� ���� ����

-- ������ ���� 2�� �̻��� ���, ù��° �� ���� �� �ι�° �� ������
SELECT department_id, employee_id, first_name, last_name
FROM employees ORDER BY department_id, employee_id;

-- ��Ī���� ������ ������
SELECT department_id, last_name, salary*12 ����
FROM employees ORDER BY ���� DESC;

-- ���� 9-1
SELECT employee_id, first_name, last_name FROM employees
ORDER BY employee_id DESC;
-- ���� 9-2
SELECT * FROM employees
WHERE job_id LIKE '%CLERK%'
ORDER BY salary DESC;
-- ���� 9-3
SELECT employee_id ������ȣ, department_id �μ���ȣ, salary ����
FROM employees
WHERE employee_id BETWEEN 120 AND 150
ORDER BY �μ���ȣ DESC, ���� DESC;

-- ============================================================================