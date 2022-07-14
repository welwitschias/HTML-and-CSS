-- ============================================================================

-- 집계 함수
SELECT ROUND(AVG(salary)) 평균값,
       MAX(salary) 최댓값,
       MIN(salary) 최솟값,
       SUM(salary) 합계,
       COUNT(salary) 직원수 -- (*)일 경우에는 NULL값도 포함
FROM employees WHERE job_id LIKE '%REP%';

SELECT COUNT(commission_pct), -- NULL값 제외
       COUNT(*), -- NULL값 포함
       AVG(commission_pct), -- NULL값 제외하고 평균 계산
       AVG(NVL(commission_pct, 0)) -- NULL값 0으로 처리하고 평균 계산
FROM employees;

SELECT COUNT(DISTINCT department_id) FROM employees; -- 중복된 부서 수 제거

-- ============================================================================

-- GROUP BY 절 : 특정 그룹으로 나누어서 그룹 함수를 사용
SELECT department_id, ROUND(AVG(salary)) FROM employees
GROUP BY department_id
-- department_id로 group을 나누어주므로 SELECT에도 department_id가 와야함
-- 만약 job_id 등이 오면 오류 발생, 집계 함수는 사용 가능
ORDER BY department_id;
-- group열이 여러 개일 때
SELECT department_id, job_id, ROUND(AVG(salary)) FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

-- 예제 1-1
SELECT department_id, COUNT(*), MAX(salary), MIN(salary), SUM(salary), ROUND(AVG(salary))
FROM employees GROUP BY department_id ORDER BY SUM(salary) DESC;
-- 예제 1-2
SELECT department_id, job_id, COUNT(*), SUM(salary)
FROM employees GROUP BY department_id, job_id ORDER BY department_id;
-- 예제 1-3
SELECT ROUND(AVG(MAX(salary))) 최고월급평균, ROUND(AVG(MIN(salary))) 최저월급평균,
--       TO_CHAR(AVG(MAX(salary)), '999,999.99'), TO_CHAR(AVG(MIN(salary)), '999,999.99')
FROM employees GROUP BY department_id;

-- ============================================================================

-- HAVING 절 : WHERE 절과 반대로 집계 함수를 사용할 수 있음
SELECT department_id 부서명, COUNT(*) 사원수
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5; -- 사원수 5명이 넘는 부서만 선택

-- 예제 2-1
SELECT job_id, SUM(salary) FROM employees
WHERE job_id != 'AC_MGR'
GROUP BY job_id
HAVING AVG(salary) > 10000
ORDER BY SUM(salary) DESC;
-- 예제 2-2
SELECT department_id, ROUND(AVG(salary)) FROM employees
WHERE department_id != 40
GROUP BY department_id
HAVING AVG(salary) <= 7000
ORDER BY AVG(salary) DESC;
-- 예제 2-3
SELECT job_id, SUM(salary) FROM employees
WHERE job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING SUM(salary) >= 13000
ORDER BY SUM(salary) DESC;

-- ============================================================================

-- JOIN : 2개 이상의 Table을 연결하여 데이터를 검색
-- 최소 하나의 열이 Table끼리 공유(참조)하고 있어야 JOIN 가능
-- 2개의 Table JOIN
SELECT e.employee_id 직원번호, e.last_name 이름, d.department_id 부서번호, d.department_name 부서명
FROM employees e -- 길어서 주로 별칭으로 지정해서 사용
JOIN departments d
    ON e.department_id = d.department_id;
-- 3개의 Table JOIN
SELECT employee_id, city, department_name -- 고유한 열이면 Table(%.) 생략 가능
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id -- e와 d Table은 department_id 열을 공유하고 있음
JOIN locations l
    ON d.location_id = l.location_id; -- d와 l Table은 location_id 열을 공유하고 있음
-- WHERE 절 추가 : JOIN 뒤에
SELECT e.employee_id, e.last_name, d.department_id, d.location_id
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE d.department_id = 50 AND e.salary > 5000;

-- 예제 3
SELECT d.department_name, l.city, c.country_name
FROM departments d
JOIN locations l
    ON d.location_id = l.location_id
JOIN countries c
    ON l.country_id = c.country_id
WHERE l.city IN('Seattle', 'London') AND c.country_name LIKE 'United%';

-- ============================================================================

-- Self JOIN : 같은 Table 안에서 JOIN
SELECT e.last_name 직원, m.last_name 매니저
FROM employees e
JOIN employees m
    ON e.manager_id = m.employee_id;
 
-- ===========================================================================

-- Outer JOIN : JOIN 조건에 일치하지 않는 데이터까지 모두 출력해 줌, 부족한 쪽 데이터는 NULL 처리
-- LEFT : 왼쪽 Table(FROM 뒤에 오는 Table)의 데이터가 모두 포함
SELECT e.last_name 직원, e.department_id 부서번호, d.department_name 부서명
FROM employees e 
LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id;
-- RIGHT : 오른쪽 Table(JOIN 뒤에 오는 Table)의 데이터가 모두 포함
SELECT e.last_name 직원, e.department_id 부서번호, d.department_name 부서명
FROM employees e 
RIGHT OUTER JOIN departments d
    ON e.department_id = d.department_id;
-- FULL : 양쪽 Table의 모든 데이터가 포함
SELECT e.last_name 직원, e.department_id 부서번호, d.department_name 부서명
FROM employees e 
FULL OUTER JOIN departments d
    ON e.department_id = d.department_id;

-- 예제 4
SELECT c.country_name, c.country_id, l.location_id, l.city
FROM countries c
LEFT OUTER JOIN locations l
    ON c.country_id = l.country_id
ORDER BY l.location_id DESC;

-- ===========================================================================

-- Cross JOIN : 서로 다른 Table들의 모든 행들을 연결시킴, 테스트용 Table 만들 때 주로 사용
SELECT c.country_name, r.region_name
FROM countries c
CROSS JOIN regions r;

-- ===========================================================================