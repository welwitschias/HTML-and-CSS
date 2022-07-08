-- Q01 부서번호가 10번인 부서의 사람 중 사원번호, 이름, 월급을 출력하라
SELECT empno, ename, sal FROM emp WHERE deptno = 10;

-- Q02 사원번호가 7369인 사람 중 이름, 입사일, 부서번호를 출력하라
SELECT ename, hiredate, deptno FROM emp WHERE empno = 7369;

-- Q03 이름이 ALLEN인 사람의 모든 정보를 출력하라
SELECT * FROM emp WHERE ename = 'ALLEN';

-- Q04 입사일이 81/02/20인 사원의 이름, 부서번호, 월급을 출력하라
SELECT ename, deptno, sal FROM emp WHERE hiredate = '1981-02-20';

-- Q05 직업이 MANAGER가 아닌 사람의 모든 정보를 출력하라
SELECT * FROM emp WHERE job != 'MANAGER';

-- Q06 입사일이 81/04/02이후에 입사한 사원의 정보를 출력하라
SELECT * FROM emp WHERE hiredate >= '1981-04-02';

-- Q07 급여가 $800 이상인 사람의 이름, 급여, 부서번호를 출력하라
SELECT ename, sal, deptno FROM emp WHERE sal >= 800;

-- Q08 부서번호가 20번 이상인 사원의 모든 정보를 출력하라
SELECT * FROM emp WHERE deptno >= 20;

-- Q09 이름이 K로 시작하는 사람보다 높은 이름을 가진 사람의 모든 정보를 출력하라
SELECT * FROM emp WHERE ename >= 'L';

-- Q10 입사일이 81/12/09보다 먼저 입사한 사람들의 모든 정보를 출력하라
SELECT * FROM emp WHERE hiredate < '1981-12-09';

-- Q11 직원번호가 7698보다 작거나 같은 사람들의 직원번호와 이름을 출력하라
SELECT empno, ename FROM emp WHERE empno <= 7698;

-- Q12 입사일이 81/04/02보다 같거나 늦고 82/12/09보다 같거나 빠른 사원의 이름, 월급, 부서번호를 출력하라
SELECT ename, sal, deptno FROM emp WHERE hiredate BETWEEN '1981-04-02' AND '1982-12-09';

-- Q13 급여가 $1,600보다 크고 $3,000보다 작은 직원의 이름, 직업, 급여를 출력하라
SELECT ename, job, sal FROM emp WHERE sal > 1600 AND sal < 3000;

-- Q14 직원번호가 7654와 7782 사이가 아닌 직원의 모든 정보를 출력하라
SELECT * FROM emp WHERE empno NOT BETWEEN 7654 AND 7782;

-- Q15 이름이 B와 J사이의 모든 직원의 정보를 출력하라
SELECT * FROM emp WHERE ename BETWEEN 'B' AND 'J';

-- Q16 입사일이 81년이 아닌 모든 직원의 모든 정보를 출력하라
SELECT * FROM emp WHERE hiredate NOT BETWEEN '1981-01-01' AND '1981-12-31';
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'YYYY') != '1981';

-- Q17 직업이 MANAGER이거나 SALESMAN인 직원의 모든 정보를 출력하라
SELECT * FROM emp WHERE job = 'MANAGER' OR job = 'SALESMAN';
SELECT * FROM emp WHERE job IN('MANAGER', 'SALESMAN');

-- Q18 부서번호가 20, 30번을 제외한 모든 직원의 이름, 사원번호, 부서번호를 출력하라
SELECT ename, empno, deptno FROM emp WHERE deptno != 20 AND deptno != 30;
SELECT ename, empno, deptno FROM emp WHERE deptno NOT IN(20, 30);

-- Q19 이름이 S로 시작하는 직원의 사원번호, 이름, 입사일, 부서번호를 출력하라
SELECT empno, ename, hiredate, deptno FROM emp WHERE ename LIKE 'S%';

-- Q20 입사일이 81년도인 사람의 모든 정보를 출력하라
SELECT * FROM emp WHERE hiredate BETWEEN '1981-01-01' AND '1981-12-31';
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'YYYY') = '1981';

-- Q21 이름 중 S자가 들어가 있는 사람만 모든 정보를 출력하라
SELECT * FROM emp WHERE ename LIKE '%S%';

-- Q22 이름이 M로 시작하고 마지막 글자가 N인 사람의 모든 정보를 출력하라 (단, 이름은 전체 6자리이다.)
SELECT * FROM emp WHERE ename LIKE 'M____N';

-- Q23 이름이 첫 번째 문자는 관계없고, 두 번째 문자가 A인 사람의 정보를 출력하라
SELECT * FROM emp WHERE ename LIKE '_A%';

-- Q24 커미션이 NULL인 사람의 정보를 출력하라
SELECT * FROM emp WHERE comm IS NULL;

-- Q25 커미션이 NULL이 아닌 사람의 모든 정보를 출력하라
SELECT * FROM emp WHERE comm IS NOT NULL;

-- Q26 부서가 30번 부서이고 급여가 $1,500 이상인 사람의 이름, 부서번호, 월급을 출력하라
SELECT ename, deptno, sal FROM emp WHERE deptno = 30 AND sal >= 1500;

-- Q27 이름의 첫 글자가 K로 시작하거나 부서번호가 30인 사람의 사원번호, 이름, 부서번호를 출력하라
SELECT empno, ename, deptno FROM emp WHERE ename LIKE 'K%' OR deptno = 30;

-- Q28 급여가 $1,500 이상이고 부서번호가 30번인 사원 중 직업이 MANAGER인 사람의 정보를 출력하라
SELECT * FROM emp WHERE sal >= 1500 AND deptno = 30 AND job = 'MANAGER';

-- Q29 부서번호가 30인 사람의 모든 정보를 출력하고 직원번호로 정렬하라
SELECT * FROM emp WHERE deptno = 30 ORDER BY empno;

-- Q30 직원들의 급여가 많은 순으로 정렬하라
SELECT * FROM emp ORDER BY sal DESC;

-- Q31 부서번호로 ASCENDING SORT한 후 급여가 많은 사람 순으로 출력하라
SELECT * FROM emp ORDER BY deptno ASC, sal DESC;

-- Q32 부서번호가 DESCENDING SORT하고, 이름 순으로 ASCENDING SORT 급여 순으로 DESCENDING SORT하라
SELECT * FROM emp ORDER BY deptno DESC, ename ASC, sal DESC;

-- Q33 10번부서의 모든 직원에게 급여의 13%를 보너스로 지급하기로 하였다. 이름, 급여, 보너스금액, 부서번호를 출력하라
--     (소수점은 반올림)
SELECT ename, sal, ROUND(sal*0.13) BONUS, deptno FROM emp WHERE deptno = 10;

-- Q34 직원의 이름, 급여, 커미션, 총액(급여+커미션)을 구하여 총액이 많은 순서로 출력하라
--     (단, 커미션이 null인 사원도 0으로 해서 포함)
SELECT ename, sal, NVL(comm, 0), sal+NVL(comm, 0) TOTAL FROM emp ORDER BY TOTAL DESC;

-- Q35 급여가 $1,500부터 $3,000 사이의 사원에 대해서만 급여의 15%를 회비로 지불하기로 하였다.
--     모든 사원의 이름, 급여, 회비(소수이하 2자리에서 반올림)를 출력하라
--     (단, 회비는 달러표시$로 시작하고 소수점 1자리까지 출력)
SELECT ename, sal, TO_CHAR(sal*0.15, '$999,999.9') DUES FROM emp WHERE sal BETWEEN 1500 AND 3000;

-- Q36 사원수가 5명이 넘는 부서의 부서명과 사원수를 조회하라 (조인 필요)
SELECT d.dname, COUNT(*)
FROM emp e JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(*) > 5;

-- Q37 직업별 급여합계가 5000을 초과하는 각 직무에 대해서 직무와 급여 합계를 조회하라  
--     (단, 판매원(SALESMAN)은 제외)
SELECT job, SUM(sal) FROM emp WHERE job != 'SALESMAN'
GROUP BY job
HAVING SUM(sal) > 5000;

-- Q38 사원들의 사원번호(empno), 사원명(ename), 급여(sal), 급여등급(grade)을 출력하라
--     (테이블 salgrade 비동등 조인)
SELECT e.empno, e.ename, e.sal, s.grade
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- Q39 부서별(deptno)로 사원의 수와 커미션(comm)을 받은 사원의 수를 출력하라
SELECT deptno, COUNT(*), COUNT(comm) FROM emp
GROUP BY deptno;

-- Q40 부서번호(deptno)가 10은 '총무부', 20은 '개발부', 30은 영업부'라고 하여 
--     이름, 부서번호, 부서명 순으로 출력하라 (decode 나 case 함수 사용)
SELECT ename, deptno,
    DECODE(deptno, 10, '총무부',
                   20, '개발부',
                   30, '영업부') DNAME
FROM emp;