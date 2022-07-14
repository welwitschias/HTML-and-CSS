-- ============================================================================

-- 부서 Table의 모든(*) 열 조회
SELECT * FROM departments;
-- AS는 별칭(생략 가능), 조회할 열 이름만 검색 가능
SELECT department_name AS 부서이름 FROM departments;
-- Table명을 FROM에 적고, SELECT에서 ctrl+space를 이용하여 자동으로 열 이름을 불러온다.
SELECT department_id 부서번호, department_name 부서이름 FROM departments;

-- 직원 Table의 월급 열 조회
SELECT salary 월급 FROM employees;
-- 전체 직원 월급에 100 추가해서 새로운 열 만들기
SELECT last_name 이름, salary 월급, salary+100 보너스월급 FROM employees;
-- 전체 직원 월급에 -10%해서 새로운 열 만들기
SELECT last_name 이름, salary 월급, salary-salary*0.10 새월급 FROM employees;

-- 예제 1
SELECT employee_id, first_name, last_name FROM employees;
SELECT first_name, salary, salary*1.1 AS NEWSALARY FROM employees;
SELECT employee_id 사원번호, first_name 이름, last_name 성 FROM employees;

-- ============================================================================

-- 중복된 값 제거 : DISTINCT
SELECT DISTINCT job_id 직업 FROM employees;

-- employees Table의 정보 보기
DESC employees;

-- 연결 연산자(||) : 각 열의 결과를 연결해 하나의 열로 표현
-- 문자를 연결할 때에는 작은 따옴표 사용(큰 따옴표 안됨)
SELECT employee_id, first_name||' '||last_name FULLNAME FROM employees;

-- 예제 2
SELECT employee_id, first_name||' '||last_name FULLNAME, email||'@company.com' EMAIL
FROM employees;

-- ============================================================================

-- WHERE : 조건
-- 직원들 중 월급이 14000 이상인 직원만 선택
SELECT * FROM employees WHERE salary > 14000;
-- 직원들 중 성이 King인 직원만 선택
SELECT * FROM employees WHERE last_name = 'King'; -- 문자열은 대소문자를 구분함
-- 직원들 중 고용일이 2002년 06월 10일 이전인 직원만 선택
SELECT * FROM employees WHERE hire_date < '2002/06/10'; -- 문자열 안의 날짜형식은 자동으로 변환됨

-- 예제 3
SELECT * FROM employees WHERE employee_id = 100;
SELECT * FROM employees WHERE first_name = 'David';
SELECT * FROM employees WHERE employee_id <= 105;
SELECT * FROM job_history WHERE start_date > '2006/03/03';
SELECT * FROM departments WHERE location_id != 1700;

-- ============================================================================

-- NOT(1), AND(2), OR(3) : ( )안은 우선 순위, ( )로 우선순위 결정해주자!
SELECT last_name, department_id, salary FROM employees
WHERE (department_id = 60 OR department_id = 80) AND salary > 10000;
SELECT last_name, department_id, salary FROM employees
WHERE department_id = 60 OR (department_id = 80 AND salary > 10000);

-- 예제 4
SELECT * FROM employees
WHERE salary > 4000 AND job_id = 'IT_PROG';
SELECT * FROM employees
WHERE salary > 4000 AND (job_id = 'IT_PROG' OR job_id = 'FI_ACCOUNT');

-- ============================================================================

-- IN 연산자 : WHERE 안에서 특정값 여러 개를 선택(OR 여러 번 쓰는 대신에 사용)
SELECT * FROM employees WHERE salary = 4000 OR salary = 3000 OR salary = 2700;
SELECT * FROM employees WHERE salary IN (4000, 3000, 2700);

-- 예제 5
SELECT * FROM employees WHERE salary IN (10000, 17000, 24000);
SELECT * FROM employees WHERE department_id NOT IN (30, 50, 80, 100, 110);

-- ============================================================================

-- BETWEEN 연산자 : A AND B (A와 B의 사잇값, A와 B를 포함)
SELECT * FROM employees WHERE salary >= 9000 AND salary <= 10000;
SELECT * FROM employees WHERE salary BETWEEN 9000 AND 10000;

-- 예제 6
SELECT * FROM employees WHERE salary BETWEEN 10000 AND 20000;
SELECT * FROM employees WHERE hire_date BETWEEN '2004/01/01' AND '2004/12/31';
SELECT * FROM employees WHERE salary NOT BETWEEN 7000 AND 17000;

-- ============================================================================

-- LIKE 연산자 : 조건값이 명확하지 않을 때 사용
-- 와일드 카드 : %(모든 문자, 글자 수 상관없음 - 없는 경우도 포함), _(한 글자)

-- 성이 B로 시작하는 사람만 선택
SELECT * FROM employees WHERE last_name LIKE 'B%';
-- 성의 중간에 b가 들어가는 사람만 선택
SELECT * FROM employees WHERE last_name LIKE '%b%';
-- 성이 y로 끝나는 사람만 선택
SELECT * FROM employees WHERE last_name LIKE '%y';

-- 예제 7
SELECT * FROM employees WHERE job_id LIKE '%AD%';
SELECT * FROM employees WHERE job_id LIKE 'AD___';
SELECT * FROM employees WHERE phone_number LIKE '%1234';
SELECT * FROM employees WHERE phone_number NOT LIKE '%3%' AND phone_number LIKE '%9';
SELECT * FROM employees
WHERE job_id LIKE '%MGR%' OR job_id LIKE '%ASST%';
--WHERE job_id LIKE IN ('%MGR%', '%ASST%'); -- 사용불가 : IN 안에는 %를 쓸 수 없음

-- ============================================================================

-- IS NULL : 데이터값이 NULL(값을 입력하지 않음, 0이나 공백과는 다름)인 경우를 조회
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

-- 예제 8
SELECT * FROM employees WHERE manager_id IS NULL;

-- ============================================================================

-- ORDER BY : 행에 대한 정렬 순서 지정
-- ASC : 오름차순(기본 정렬 방법, 생략 가능), DESC : 내림차순

-- salary가 큰 사람 순서로 정렬
SELECT * FROM employees ORDER BY salary DESC;
-- salary가 작은 사람 순서로 정렬
SELECT * FROM employees ORDER BY salary; -- ASC는 생략 가능

-- 정렬할 열이 2개 이상일 경우, 첫번째 열 정렬 후 두번째 열 정렬함
SELECT department_id, employee_id, first_name, last_name
FROM employees ORDER BY department_id, employee_id;

-- 별칭으로 정렬이 가능함
SELECT department_id, last_name, salary*12 연봉
FROM employees ORDER BY 연봉 DESC;

-- 예제 9-1
SELECT employee_id, first_name, last_name FROM employees
ORDER BY employee_id DESC;
-- 예제 9-2
SELECT * FROM employees
WHERE job_id LIKE '%CLERK%'
ORDER BY salary DESC;
-- 예제 9-3
SELECT employee_id 직원번호, department_id 부서번호, salary 월급
FROM employees
WHERE employee_id BETWEEN 120 AND 150
ORDER BY 부서번호 DESC, 월급 DESC;

-- ============================================================================