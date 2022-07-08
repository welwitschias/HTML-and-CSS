-- Q01 �μ���ȣ�� 10���� �μ��� ��� �� �����ȣ, �̸�, ������ ����϶�
SELECT empno, ename, sal FROM emp WHERE deptno = 10;

-- Q02 �����ȣ�� 7369�� ��� �� �̸�, �Ի���, �μ���ȣ�� ����϶�
SELECT ename, hiredate, deptno FROM emp WHERE empno = 7369;

-- Q03 �̸��� ALLEN�� ����� ��� ������ ����϶�
SELECT * FROM emp WHERE ename = 'ALLEN';

-- Q04 �Ի����� 81/02/20�� ����� �̸�, �μ���ȣ, ������ ����϶�
SELECT ename, deptno, sal FROM emp WHERE hiredate = '1981-02-20';

-- Q05 ������ MANAGER�� �ƴ� ����� ��� ������ ����϶�
SELECT * FROM emp WHERE job != 'MANAGER';

-- Q06 �Ի����� 81/04/02���Ŀ� �Ի��� ����� ������ ����϶�
SELECT * FROM emp WHERE hiredate >= '1981-04-02';

-- Q07 �޿��� $800 �̻��� ����� �̸�, �޿�, �μ���ȣ�� ����϶�
SELECT ename, sal, deptno FROM emp WHERE sal >= 800;

-- Q08 �μ���ȣ�� 20�� �̻��� ����� ��� ������ ����϶�
SELECT * FROM emp WHERE deptno >= 20;

-- Q09 �̸��� K�� �����ϴ� ������� ���� �̸��� ���� ����� ��� ������ ����϶�
SELECT * FROM emp WHERE ename >= 'L';

-- Q10 �Ի����� 81/12/09���� ���� �Ի��� ������� ��� ������ ����϶�
SELECT * FROM emp WHERE hiredate < '1981-12-09';

-- Q11 ������ȣ�� 7698���� �۰ų� ���� ������� ������ȣ�� �̸��� ����϶�
SELECT empno, ename FROM emp WHERE empno <= 7698;

-- Q12 �Ի����� 81/04/02���� ���ų� �ʰ� 82/12/09���� ���ų� ���� ����� �̸�, ����, �μ���ȣ�� ����϶�
SELECT ename, sal, deptno FROM emp WHERE hiredate BETWEEN '1981-04-02' AND '1982-12-09';

-- Q13 �޿��� $1,600���� ũ�� $3,000���� ���� ������ �̸�, ����, �޿��� ����϶�
SELECT ename, job, sal FROM emp WHERE sal > 1600 AND sal < 3000;

-- Q14 ������ȣ�� 7654�� 7782 ���̰� �ƴ� ������ ��� ������ ����϶�
SELECT * FROM emp WHERE empno NOT BETWEEN 7654 AND 7782;

-- Q15 �̸��� B�� J������ ��� ������ ������ ����϶�
SELECT * FROM emp WHERE ename BETWEEN 'B' AND 'J';

-- Q16 �Ի����� 81���� �ƴ� ��� ������ ��� ������ ����϶�
SELECT * FROM emp WHERE hiredate NOT BETWEEN '1981-01-01' AND '1981-12-31';
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'YYYY') != '1981';

-- Q17 ������ MANAGER�̰ų� SALESMAN�� ������ ��� ������ ����϶�
SELECT * FROM emp WHERE job = 'MANAGER' OR job = 'SALESMAN';
SELECT * FROM emp WHERE job IN('MANAGER', 'SALESMAN');

-- Q18 �μ���ȣ�� 20, 30���� ������ ��� ������ �̸�, �����ȣ, �μ���ȣ�� ����϶�
SELECT ename, empno, deptno FROM emp WHERE deptno != 20 AND deptno != 30;
SELECT ename, empno, deptno FROM emp WHERE deptno NOT IN(20, 30);

-- Q19 �̸��� S�� �����ϴ� ������ �����ȣ, �̸�, �Ի���, �μ���ȣ�� ����϶�
SELECT empno, ename, hiredate, deptno FROM emp WHERE ename LIKE 'S%';

-- Q20 �Ի����� 81�⵵�� ����� ��� ������ ����϶�
SELECT * FROM emp WHERE hiredate BETWEEN '1981-01-01' AND '1981-12-31';
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'YYYY') = '1981';

-- Q21 �̸� �� S�ڰ� �� �ִ� ����� ��� ������ ����϶�
SELECT * FROM emp WHERE ename LIKE '%S%';

-- Q22 �̸��� M�� �����ϰ� ������ ���ڰ� N�� ����� ��� ������ ����϶� (��, �̸��� ��ü 6�ڸ��̴�.)
SELECT * FROM emp WHERE ename LIKE 'M____N';

-- Q23 �̸��� ù ��° ���ڴ� �������, �� ��° ���ڰ� A�� ����� ������ ����϶�
SELECT * FROM emp WHERE ename LIKE '_A%';

-- Q24 Ŀ�̼��� NULL�� ����� ������ ����϶�
SELECT * FROM emp WHERE comm IS NULL;

-- Q25 Ŀ�̼��� NULL�� �ƴ� ����� ��� ������ ����϶�
SELECT * FROM emp WHERE comm IS NOT NULL;

-- Q26 �μ��� 30�� �μ��̰� �޿��� $1,500 �̻��� ����� �̸�, �μ���ȣ, ������ ����϶�
SELECT ename, deptno, sal FROM emp WHERE deptno = 30 AND sal >= 1500;

-- Q27 �̸��� ù ���ڰ� K�� �����ϰų� �μ���ȣ�� 30�� ����� �����ȣ, �̸�, �μ���ȣ�� ����϶�
SELECT empno, ename, deptno FROM emp WHERE ename LIKE 'K%' OR deptno = 30;

-- Q28 �޿��� $1,500 �̻��̰� �μ���ȣ�� 30���� ��� �� ������ MANAGER�� ����� ������ ����϶�
SELECT * FROM emp WHERE sal >= 1500 AND deptno = 30 AND job = 'MANAGER';

-- Q29 �μ���ȣ�� 30�� ����� ��� ������ ����ϰ� ������ȣ�� �����϶�
SELECT * FROM emp WHERE deptno = 30 ORDER BY empno;

-- Q30 �������� �޿��� ���� ������ �����϶�
SELECT * FROM emp ORDER BY sal DESC;

-- Q31 �μ���ȣ�� ASCENDING SORT�� �� �޿��� ���� ��� ������ ����϶�
SELECT * FROM emp ORDER BY deptno ASC, sal DESC;

-- Q32 �μ���ȣ�� DESCENDING SORT�ϰ�, �̸� ������ ASCENDING SORT �޿� ������ DESCENDING SORT�϶�
SELECT * FROM emp ORDER BY deptno DESC, ename ASC, sal DESC;

-- Q33 10���μ��� ��� �������� �޿��� 13%�� ���ʽ��� �����ϱ�� �Ͽ���. �̸�, �޿�, ���ʽ��ݾ�, �μ���ȣ�� ����϶�
--     (�Ҽ����� �ݿø�)
SELECT ename, sal, ROUND(sal*0.13) BONUS, deptno FROM emp WHERE deptno = 10;

-- Q34 ������ �̸�, �޿�, Ŀ�̼�, �Ѿ�(�޿�+Ŀ�̼�)�� ���Ͽ� �Ѿ��� ���� ������ ����϶�
--     (��, Ŀ�̼��� null�� ����� 0���� �ؼ� ����)
SELECT ename, sal, NVL(comm, 0), sal+NVL(comm, 0) TOTAL FROM emp ORDER BY TOTAL DESC;

-- Q35 �޿��� $1,500���� $3,000 ������ ����� ���ؼ��� �޿��� 15%�� ȸ��� �����ϱ�� �Ͽ���.
--     ��� ����� �̸�, �޿�, ȸ��(�Ҽ����� 2�ڸ����� �ݿø�)�� ����϶�
--     (��, ȸ��� �޷�ǥ��$�� �����ϰ� �Ҽ��� 1�ڸ����� ���)
SELECT ename, sal, TO_CHAR(sal*0.15, '$999,999.9') DUES FROM emp WHERE sal BETWEEN 1500 AND 3000;

-- Q36 ������� 5���� �Ѵ� �μ��� �μ���� ������� ��ȸ�϶� (���� �ʿ�)
SELECT d.dname, COUNT(*)
FROM emp e JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(*) > 5;

-- Q37 ������ �޿��հ谡 5000�� �ʰ��ϴ� �� ������ ���ؼ� ������ �޿� �հ踦 ��ȸ�϶�  
--     (��, �Ǹſ�(SALESMAN)�� ����)
SELECT job, SUM(sal) FROM emp WHERE job != 'SALESMAN'
GROUP BY job
HAVING SUM(sal) > 5000;

-- Q38 ������� �����ȣ(empno), �����(ename), �޿�(sal), �޿����(grade)�� ����϶�
--     (���̺� salgrade �񵿵� ����)
SELECT e.empno, e.ename, e.sal, s.grade
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- Q39 �μ���(deptno)�� ����� ���� Ŀ�̼�(comm)�� ���� ����� ���� ����϶�
SELECT deptno, COUNT(*), COUNT(comm) FROM emp
GROUP BY deptno;

-- Q40 �μ���ȣ(deptno)�� 10�� '�ѹ���', 20�� '���ߺ�', 30�� ������'��� �Ͽ� 
--     �̸�, �μ���ȣ, �μ��� ������ ����϶� (decode �� case �Լ� ���)
SELECT ename, deptno,
    DECODE(deptno, 10, '�ѹ���',
                   20, '���ߺ�',
                   30, '������') DNAME
FROM emp;