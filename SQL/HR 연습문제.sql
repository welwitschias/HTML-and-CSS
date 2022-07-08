--Q01 departments ���̺� �ִ� manager_id �� employees ���̺��� employee_id�� �̿��Ͽ�
--   �����Ͽ� �μ���, �Ŵ�����ȣ, �Ŵ����̸�, ��ȭ��ȣ�� ��Ÿ�����.
SELECT d.department_name, d.manager_id, e.last_name||' '||e.first_name "FULL_NAME", e.phone_number
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id;

--Q02 ������ �̿��Ͽ� ������� ������ȣ, �������, ����, ��å)�� ����Ͻÿ�.
SELECT e.employee_id, e.hire_date, j.job_id, j.job_title
FROM employees e
JOIN jobs j ON e.job_id = j.job_id;

--Q03 ��å�� 'Sales Manager'�� ������� �Ի�⵵ �׷� ��? ��� �޿��� ����Ͻÿ�.
--   (�Ի�⵵�� �������� �������� ����)
SELECT TO_CHAR(e.hire_date, 'YYYY'), ROUND(AVG(e.salary))
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE j.job_title = 'Sales Manager'
GROUP BY TO_CHAR(e.hire_date, 'YYYY')
ORDER BY TO_CHAR(e.hire_date, 'YYYY');

--Q04 ������ ���ÿ� �ִ� ��� �μ� �������� ��ձ޿��� ��ȸ�ϰ��� �Ѵ�. 
--   ��ձ޿��� ���� ���� ���ú��� ���ø�(city)�� ��տ���, �ش� ������ �������� ����Ͻÿ�.
--   ��, ���ÿ� �ٹ��ϴ� ������ 10�� �̻��� ���� �����ϰ� ��ȸ�Ͻÿ�.
SELECT l.city, ROUND(AVG(e.salary)), COUNT(*)
FROM departments d
JOIN locations l ON d.location_id = l.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city
HAVING COUNT(*) < 10
ORDER BY AVG(e.salary);
   
--Q05 �ڽ��� �Ŵ������� �޿��� ���� �޴� �������� ��, �޿��� �Ŵ����� ��, �޿��� ����϶�.
SELECT e.employee_id, e.last_name, e.salary, m.last_name, m.salary
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;

--Q01 �μ��� ������
SELECT d.department_name, COUNT(*)
FROM employees e
JOIN departments d ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY COUNT(*) DESC;

--Q02 �μ��� ��� �޿�
SELECT d.department_name, ROUND(AVG(e.salary), -1) AVG_SAL
FROM employees e
JOIN departments d ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY AVG_SAL DESC;

--Q03 ��å�� ��� �޿�(��� �޿� ���� ���� 7�� ��å��)
SELECT j.job_title, ROUND(AVG(e.salary)) AVG_SAL
FROM employees e
JOIN jobs j ON j.job_id = e.job_id
GROUP BY j.job_title
ORDER BY AVG_SAL DESC;

--Q04 �ڽ��� �Ŵ������� �� ���� �޿��� �޴� ��� ���
SELECT e.employee_id, e.last_name, e.salary
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;

--Q05 Job Title�� Sales Representative�� ���� �߿���
--   �޿��� 9,000 ~ 10,000�� �������� �̸��� �޿��� ����Ͻÿ�.
SELECT first_name||' '||last_name full_name, e.salary
FROM employees e
JOIN jobs j ON j.job_id = e.job_id
WHERE j.job_title = 'Sales Representative' AND e.salary BETWEEN 9000 AND 10000
ORDER BY e.salary DESC;

--Q06 �޿� ������ ���� ���� ���޼����� �޿� ������ ����Ͻÿ�.
--   (��, �޿� ������ 30,000 �̻��� ���޸� ����� ��)
SELECT j.job_title, SUM(e.salary) TOTAL
FROM employees e
JOIN jobs j ON j.job_id = e.job_id
GROUP BY j.job_title
HAVING SUM(e.salary) >= 30000
ORDER BY TOTAL DESC;

--Q07 �� ���ú� ��� �޿��� ���� ������ ���� 3�� ���ø� ����Ͻÿ�.
SELECT l.city, ROUND(AVG(e.salary)) AVG_SAL
FROM employees e
JOIN departments d ON d.department_id = e.department_id
JOIN locations l ON l.location_id = d.location_id
GROUP BY l.city
ORDER BY AVG_SAL DESC;

--Q08 ��å(Job Title)�� 'Sales Manager'�� ������� �Ի�⵵(hire_date)�� ��� �޿��� ����Ͻÿ�.
--    ��½� �⵵�� �������� �������� �����Ͻÿ�.
SELECT TO_CHAR(e.hire_date, 'YYYY'), ROUND(AVG(e.salary))
FROM employees e
JOIN jobs j ON j.job_id = e.job_id
WHERE j.job_title = 'Sales Manager'
GROUP BY TO_CHAR(e.hire_date, 'YYYY')
ORDER BY TO_CHAR(e.hire_date, 'YYYY');

--Q09 �� ����(city)�� �ִ� ��� �μ� �������� ��ձ޿��� ��ȸ�ϰ��� �Ѵ�. 
--    ��ձ޿��� ���� ���� ���ú��� ���ø�(city)�� ��տ���, �ش� ������ �������� ����Ͻÿ�. 
--    (��, ���ÿ� �ٹ��ϴ� ������ 10�� �̻��� ���� �����ϰ� ��ȸ�Ͻÿ�.)
SELECT l.city, ROUND(AVG(e.salary)) AVG_SAL, COUNT(*)
FROM employees e
JOIN departments d ON d.department_id = e.department_id
JOIN locations l ON l.location_id = d.location_id
GROUP BY l.city
HAVING COUNT(*) < 10
ORDER BY AVG_SAL;

--Q10 ��Public Accountant���� ��å(job_title)���� ���ſ� �ٹ��� ���� �ִ� ��� ����� ����� �̸��� ����Ͻÿ�. 
--    (���� ��Public Accountant���� ��å(job_title)���� �ٹ��ϴ� ����� ������� �ʴ´�)
SELECT e.employee_id, e.last_name
FROM jobs j
JOIN job_history jh ON jh.job_id = j.job_id
JOIN employees e ON e.employee_id = jh.employee_id
WHERE j.job_title = 'Public Accountant' AND e.job_id != j.job_id;