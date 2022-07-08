-- ============================================================================

-- 서브 쿼리 : 메인 쿼리에 포함되어 있는 또 하나의 SELECT문 (메인 쿼리보다 먼저 실행됨)
-- 여러 번의 SELECT문을 수행해야 얻을 수 있는 결과를 하나의 중첩된 SELECT문으로 쉽게 얻을 수 있음
-- 주의 : 단일행 서브 쿼리 사용 시 서브 쿼리의 결과가 비교하는 데이터와 같고 하나만 출력되어야 함
-- Popp 직원보다 더 늦게 고용된 직원들 찾기
SELECT last_name, hire_date FROM employees
WHERE hire_date > (SELECT hire_date FROM employees WHERE last_name = 'Popp');
-- 비교하는 데이터가 hire_date로 동일하고, 결과값이 1개임
-- WHERE hire_date > (SELECT hire_date FROM employees WHERE last_name = 'Smith');
-- 단일행 서브 쿼리의 결과값이 2개라서 오류가 발생

-- 그룹함수의 결과를 서브쿼리로 사용
SELECT last_name, job_id, salary FROM employees
WHERE salary = (SELECT min(salary) FROM employees);

-- 예제 1-1
SELECT last_name, salary FROM employees
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Abel');
-- 예제 1-2
SELECT employee_id, last_name, department_id, salary FROM employees
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Bull')
AND department_id = (SELECT department_id FROM employees WHERE last_name = 'Bull');
-- 예제 1-3
SELECT last_name, salary, manager_id FROM employees
WHERE manager_id = (SELECT employee_id FROM employees WHERE last_name = 'Russell');
-- 예제 1-4
SELECT * FROM employees
WHERE job_id = (SELECT job_id FROM jobs WHERE job_title = 'Stock Manager');

-- ============================================================================

-- 다중행 서브쿼리 : 서브쿼리 결과가 여러 개의 행으로 출력
SELECT MIN(salary) FROM employees GROUP BY department_id; -- 부서별 최저월급
-- IN 연산자 : 서브 쿼리의 결과값이 2개 이상일 때, 결과값이 하나라도 일치하면 참
SELECT department_id, employee_id, last_name FROM employees
WHERE salary IN (SELECT MIN(salary) FROM employees GROUP BY department_id)
ORDER BY department_id;
-- job_id가 'IT_PROG'가 아니면서 'IT_PROG' 직원보다 급여가 적은 직원들
-- ANY 연산자(비교 연산자와 같이 사용) : 서브 쿼리의 결과값이 하나라도 맞으면(OR) 참
SELECT employee_id, last_name, salary FROM employees
WHERE salary < ANY(SELECT salary FROM employees WHERE job_id = 'IT_PROG')
AND job_id != 'IT_PROG'
ORDER BY salary DESC;
-- ALL 연산자(비교 연산자와 같이 사용) : 서브 쿼리의 결과값이 모두 맞으면(AND) 참
SELECT employee_id, last_name, salary FROM employees
WHERE salary < ALL(SELECT salary FROM employees WHERE job_id = 'IT_PROG')
AND job_id != 'IT_PROG'
ORDER BY salary DESC;

-- 예제 2-1
SELECT employee_id, first_name, job_id, salary FROM employees
WHERE manager_id IN (SELECT manager_id FROM employees WHERE department_id = 20)
AND department_id != 20;
-- 예제 2-2
SELECT employee_id, last_name, job_id, salary FROM employees
WHERE salary < ANY(SELECT salary FROM employees WHERE job_id = 'ST_MAN');
-- 예제 2-3
SELECT employee_id, last_name, job_id, salary FROM employees
WHERE salary < ALL(SELECT salary FROM employees WHERE job_id = 'IT_PROG');

-- ============================================================================

-- 다중열 서브쿼리 : 여러 개의 컬럼을 검색, 비교 대상 컬럼과 1:1 대응해야 함
-- Bruce 직원의 manager_id와 job_id가 같은 직원
SELECT employee_id, first_name, job_id, salary, manager_id FROM employees
WHERE (manager_id, job_id)
IN (SELECT manager_id, job_id FROM employees WHERE first_name = 'Bruce')
AND first_name != 'Bruce';
-- 각 부서별로 최저 급여를 받는 직원
SELECT department_id, employee_id, first_name, salary FROM employees
WHERE (department_id, salary)
IN (SELECT department_id, MIN(salary) FROM employees GROUP BY department_id)
ORDER BY department_id;

-- 예제 3
SELECT first_name, job_id, salary, department_id FROM employees
WHERE (job_id, salary)
IN (SELECT job_id, MIN(salary) FROM employees GROUP BY job_id)
ORDER BY salary DESC;

-- ============================================================================

-- 집합 연산자
-- UNION : 합집합(중복 제거), UNION ALL : 합집합(중복 포함), INTERSECT : 교집합, MINUS : 차집합
-- 주의 : 두 SELECT문의 컬럼 개수와 데이터 타입(문자, 날짜, ...)이 일치해야 함
SELECT employee_id, job_id FROM employees
UNION -- 중복 제거
SELECT employee_id, job_id FROM job_history;

SELECT employee_id, job_id FROM employees
UNION ALL -- 중복 포함
SELECT employee_id, job_id FROM job_history;

SELECT employee_id, job_id FROM employees
INTERSECT
SELECT employee_id, job_id FROM job_history;

SELECT employee_id, job_id FROM employees
MINUS
SELECT employee_id, job_id FROM job_history;

-- 예제 4-1
SELECT department_id FROM employees
UNION
SELECT department_id FROM departments;
-- 예제 4-2
SELECT department_id FROM employees
UNION ALL
SELECT department_id FROM departments;
-- 예제 4-3
SELECT department_id FROM employees
INTERSECT
SELECT department_id FROM departments;
-- 예제 4-4
SELECT department_id FROM departments
MINUS
SELECT department_id FROM employees;

-- ============================================================================