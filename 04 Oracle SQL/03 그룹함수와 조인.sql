-- ============================================================================

-- ���� �Լ�
SELECT ROUND(AVG(salary)) ��հ�,
       MAX(salary) �ִ�,
       MIN(salary) �ּڰ�,
       SUM(salary) �հ�,
       COUNT(salary) ������ -- (*)�� ��쿡�� NULL���� ����
FROM employees WHERE job_id LIKE '%REP%';

SELECT COUNT(commission_pct), -- NULL�� ����
       COUNT(*), -- NULL�� ����
       AVG(commission_pct), -- NULL�� �����ϰ� ��� ���
       AVG(NVL(commission_pct, 0)) -- NULL�� 0���� ó���ϰ� ��� ���
FROM employees;

SELECT COUNT(DISTINCT department_id) FROM employees; -- �ߺ��� �μ� �� ����

-- ============================================================================

-- GROUP BY �� : Ư�� �׷����� ����� �׷� �Լ��� ���
SELECT department_id, ROUND(AVG(salary)) FROM employees
GROUP BY department_id
-- department_id�� group�� �������ֹǷ� SELECT���� department_id�� �;���
-- ���� job_id ���� ���� ���� �߻�, ���� �Լ��� ��� ����
ORDER BY department_id;
-- group���� ���� ���� ��
SELECT department_id, job_id, ROUND(AVG(salary)) FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

-- ���� 1-1
SELECT department_id, COUNT(*), MAX(salary), MIN(salary), SUM(salary), ROUND(AVG(salary))
FROM employees GROUP BY department_id ORDER BY SUM(salary) DESC;
-- ���� 1-2
SELECT department_id, job_id, COUNT(*), SUM(salary)
FROM employees GROUP BY department_id, job_id ORDER BY department_id;
-- ���� 1-3
SELECT ROUND(AVG(MAX(salary))) �ְ�������, ROUND(AVG(MIN(salary))) �����������,
--       TO_CHAR(AVG(MAX(salary)), '999,999.99'), TO_CHAR(AVG(MIN(salary)), '999,999.99')
FROM employees GROUP BY department_id;

-- ============================================================================

-- HAVING �� : WHERE ���� �ݴ�� ���� �Լ��� ����� �� ����
SELECT department_id �μ���, COUNT(*) �����
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5; -- ����� 5���� �Ѵ� �μ��� ����

-- ���� 2-1
SELECT job_id, SUM(salary) FROM employees
WHERE job_id != 'AC_MGR'
GROUP BY job_id
HAVING AVG(salary) > 10000
ORDER BY SUM(salary) DESC;
-- ���� 2-2
SELECT department_id, ROUND(AVG(salary)) FROM employees
WHERE department_id != 40
GROUP BY department_id
HAVING AVG(salary) <= 7000
ORDER BY AVG(salary) DESC;
-- ���� 2-3
SELECT job_id, SUM(salary) FROM employees
WHERE job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING SUM(salary) >= 13000
ORDER BY SUM(salary) DESC;

-- ============================================================================

-- JOIN : 2�� �̻��� Table�� �����Ͽ� �����͸� �˻�
-- �ּ� �ϳ��� ���� Table���� ����(����)�ϰ� �־�� JOIN ����
-- 2���� Table JOIN
SELECT e.employee_id ������ȣ, e.last_name �̸�, d.department_id �μ���ȣ, d.department_name �μ���
FROM employees e -- �� �ַ� ��Ī���� �����ؼ� ���
JOIN departments d
    ON e.department_id = d.department_id;
-- 3���� Table JOIN
SELECT employee_id, city, department_name -- ������ ���̸� Table(%.) ���� ����
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id -- e�� d Table�� department_id ���� �����ϰ� ����
JOIN locations l
    ON d.location_id = l.location_id; -- d�� l Table�� location_id ���� �����ϰ� ����
-- WHERE �� �߰� : JOIN �ڿ�
SELECT e.employee_id, e.last_name, d.department_id, d.location_id
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE d.department_id = 50 AND e.salary > 5000;

-- ���� 3
SELECT d.department_name, l.city, c.country_name
FROM departments d
JOIN locations l
    ON d.location_id = l.location_id
JOIN countries c
    ON l.country_id = c.country_id
WHERE l.city IN('Seattle', 'London') AND c.country_name LIKE 'United%';

-- ============================================================================

-- Self JOIN : ���� Table �ȿ��� JOIN
SELECT e.last_name ����, m.last_name �Ŵ���
FROM employees e
JOIN employees m
    ON e.manager_id = m.employee_id;
 
-- ===========================================================================

-- Outer JOIN : JOIN ���ǿ� ��ġ���� �ʴ� �����ͱ��� ��� ����� ��, ������ �� �����ʹ� NULL ó��
-- LEFT : ���� Table(FROM �ڿ� ���� Table)�� �����Ͱ� ��� ����
SELECT e.last_name ����, e.department_id �μ���ȣ, d.department_name �μ���
FROM employees e 
LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id;
-- RIGHT : ������ Table(JOIN �ڿ� ���� Table)�� �����Ͱ� ��� ����
SELECT e.last_name ����, e.department_id �μ���ȣ, d.department_name �μ���
FROM employees e 
RIGHT OUTER JOIN departments d
    ON e.department_id = d.department_id;
-- FULL : ���� Table�� ��� �����Ͱ� ����
SELECT e.last_name ����, e.department_id �μ���ȣ, d.department_name �μ���
FROM employees e 
FULL OUTER JOIN departments d
    ON e.department_id = d.department_id;

-- ���� 4
SELECT c.country_name, c.country_id, l.location_id, l.city
FROM countries c
LEFT OUTER JOIN locations l
    ON c.country_id = l.country_id
ORDER BY l.location_id DESC;

-- ===========================================================================

-- Cross JOIN : ���� �ٸ� Table���� ��� ����� �����Ŵ, �׽�Ʈ�� Table ���� �� �ַ� ���
SELECT c.country_name, r.region_name
FROM countries c
CROSS JOIN regions r;

-- ===========================================================================