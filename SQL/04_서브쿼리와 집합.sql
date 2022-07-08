-- ============================================================================

-- ���� ���� : ���� ������ ���ԵǾ� �ִ� �� �ϳ��� SELECT�� (���� �������� ���� �����)
-- ���� ���� SELECT���� �����ؾ� ���� �� �ִ� ����� �ϳ��� ��ø�� SELECT������ ���� ���� �� ����
-- ���� : ������ ���� ���� ��� �� ���� ������ ����� ���ϴ� �����Ϳ� ���� �ϳ��� ��µǾ�� ��
-- Popp �������� �� �ʰ� ���� ������ ã��
SELECT last_name, hire_date FROM employees
WHERE hire_date > (SELECT hire_date FROM employees WHERE last_name = 'Popp');
-- ���ϴ� �����Ͱ� hire_date�� �����ϰ�, ������� 1����
-- WHERE hire_date > (SELECT hire_date FROM employees WHERE last_name = 'Smith');
-- ������ ���� ������ ������� 2���� ������ �߻�

-- �׷��Լ��� ����� ���������� ���
SELECT last_name, job_id, salary FROM employees
WHERE salary = (SELECT min(salary) FROM employees);

-- ���� 1-1
SELECT last_name, salary FROM employees
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Abel');
-- ���� 1-2
SELECT employee_id, last_name, department_id, salary FROM employees
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Bull')
AND department_id = (SELECT department_id FROM employees WHERE last_name = 'Bull');
-- ���� 1-3
SELECT last_name, salary, manager_id FROM employees
WHERE manager_id = (SELECT employee_id FROM employees WHERE last_name = 'Russell');
-- ���� 1-4
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM jobs WHERE job_title = 'Stock Manager');

-- ============================================================================

-- ������ �������� : �������� ����� ���� ���� ������ ���
SELECT MIN(salary) FROM employees GROUP BY department_id; -- �μ��� ��������
-- IN ������ : ���� ������ ������� 2�� �̻��� ��, ������� �ϳ��� ��ġ�ϸ� ��
SELECT department_id, employee_id, last_name FROM employees
WHERE salary IN (SELECT MIN(salary) FROM employees GROUP BY department_id)
ORDER BY department_id;
-- job_id�� 'IT_PROG'�� �ƴϸ鼭 'IT_PROG' �������� �޿��� ���� ������
-- ANY ������(�� �����ڿ� ���� ���) : ���� ������ ������� �ϳ��� ������(OR) ��
SELECT employee_id, last_name, salary FROM employees
WHERE salary < ANY(SELECT salary FROM employees WHERE job_id = 'IT_PROG')
AND job_id != 'IT_PROG'
ORDER BY salary DESC;
-- ALL ������(�� �����ڿ� ���� ���) : ���� ������ ������� ��� ������(AND) ��
SELECT employee_id, last_name, salary FROM employees
WHERE salary < ALL(SELECT salary FROM employees WHERE job_id = 'IT_PROG')
AND job_id != 'IT_PROG'
ORDER BY salary DESC;

-- ���� 2-1
SELECT employee_id, first_name, job_id, salary FROM employees
WHERE manager_id IN (SELECT manager_id FROM employees WHERE department_id = 20)
AND department_id != 20;
-- ���� 2-2
SELECT employee_id, last_name, job_id, salary FROM employees
WHERE salary < ANY(SELECT salary FROM employees WHERE job_id = 'ST_MAN');
-- ���� 2-3
SELECT employee_id, last_name, job_id, salary FROM employees
WHERE salary < ALL(SELECT salary FROM employees WHERE job_id = 'IT_PROG');

-- ============================================================================

-- ���߿� �������� : ���� ���� �÷��� �˻�, �� ��� �÷��� 1:1 �����ؾ� ��
-- Bruce ������ manager_id�� job_id�� ���� ����
SELECT employee_id, first_name, job_id, salary, manager_id FROM employees
WHERE (manager_id, job_id)
IN (SELECT manager_id, job_id FROM employees WHERE first_name = 'Bruce')
AND first_name != 'Bruce';
-- �� �μ����� ���� �޿��� �޴� ����
SELECT department_id, employee_id, first_name, salary FROM employees
WHERE (department_id, salary)
IN (SELECT department_id, MIN(salary) FROM employees GROUP BY department_id)
ORDER BY department_id;

-- ���� 3
SELECT first_name, job_id, salary, department_id FROM employees
WHERE (job_id, salary)
IN (SELECT job_id, MIN(salary) FROM employees GROUP BY job_id)
ORDER BY salary DESC;

-- ============================================================================

-- ���� ������
-- UNION : ������(�ߺ� ����), UNION ALL : ������(�ߺ� ����), INTERSECT : ������, MINUS : ������
-- ���� : �� SELECT���� �÷� ������ ������ Ÿ��(����, ��¥, ...)�� ��ġ�ؾ� ��
SELECT employee_id, job_id FROM employees
UNION -- �ߺ� ����
SELECT employee_id, job_id FROM job_history;

SELECT employee_id, job_id FROM employees
UNION ALL -- �ߺ� ����
SELECT employee_id, job_id FROM job_history;

SELECT employee_id, job_id FROM employees
INTERSECT
SELECT employee_id, job_id FROM job_history;

SELECT employee_id, job_id FROM employees
MINUS
SELECT employee_id, job_id FROM job_history;

-- ���� 4-1
SELECT department_id FROM employees
UNION
SELECT department_id FROM departments;
-- ���� 4-2
SELECT department_id FROM employees
UNION ALL
SELECT department_id FROM departments;
-- ���� 4-3
SELECT department_id FROM employees
INTERSECT
SELECT department_id FROM departments;
-- ���� 4-4
SELECT department_id FROM departments
MINUS
SELECT department_id FROM employees;

-- ============================================================================