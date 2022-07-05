-- ============================================================================

-- 문자형 함수
SELECT UPPER('SQL Course'), -- 모두 대문자로 변환
       LOWER('SQL Course'), -- 모두 소문자로 변환
       INITCAP('SQL Course') -- 첫 문자만 대문자로 변환
FROM dual;  -- dual : Test용 Dummy Table

SELECT CONCAT('Hello', 'World'), -- 두개의 문자열을 연결
       SUBSTR('ABCDEFG', 3, 4), -- 문자열 반환(문자열, 시작위치, 반환갯수)
       LENGTH('ABCDEFG'), -- 문자열의 길이
       INSTR('ABCDEFG', 'D'), -- 문자열의 위치
       TRIM('   Hello  W o r l d   ')  -- 문자열 앞뒤의 공백 제거(중간은 제거 안됨)
FROM DUAL;

SELECT job_id, REPLACE(job_id, 'ACCOUNT', 'ACCNT') 적용결과 -- 문자열 바꾸기(문자열, 기존값, 변환값)
FROM employees;

-- 예제 1-1
SELECT department_id, last_name FROM employees
WHERE lower(last_name) = 'higgins'; -- 대소문자 섞여있을 경우 변환해서 조회가능
-- 예제 1-2
SELECT last_name, LOWER(last_name), UPPER(last_name),
       email, INITCAP(email)
FROM employees;
-- 예제 1-3
SELECT job_id, SUBSTR(job_id, 1, 2) FROM employees;

-- ============================================================================

-- 숫자형 함수
SELECT ROUND(15.3456, 2), -- 반올림(숫자, 소수점 자릿수)
       ROUND(15.3456, -1), -- -1은 10의 자리
       ROUND(15.3456, 0), -- 0은 정수
       ROUND(15.3456), -- 자릿수 안 적으면 정수처리
       ROUND(15.1, 2), -- 소수점 자리 없거나 모자르면 있는 만큼만 표시
       TRUNC(15.6543, 2), -- 버리기(숫자, 소수점 자릿수) / 0, -1 등 ROUND랑 동일
       MOD(17, 3) -- 나머지 값 구하기
FROM dual;

-- 직원번호가 짝수인 직원들만 정렬
SELECT employee_id, last_name
FROM employees
WHERE MOD(employee_id, 2) = 0
ORDER BY employee_id;

-- 직원번호가 홀수인 직원들만 정렬
SELECT employee_id, last_name
FROM employees
WHERE MOD(employee_id, 2) = 1
ORDER BY employee_id;

-- 예제 2
SELECT salary, ROUND(salary/30, 0), ROUND(salary/30, 1), ROUND(salary/30, -1)
FROM employees;

-- ============================================================================

-- 날짜형 함수
SELECT sysdate 오늘, sysdate-1 어제, sysdate+1 내일 FROM dual;
-- 반올림 하면 1로 초기화됨
SELECT ROUND(sysdate, 'DD') 일, -- 시간(time)을 반올림
       ROUND(sysdate, 'MM') 월, -- 일(day)을 반올림
       ROUND(sysdate, 'YYYY') 년도, -- 월(month)을 반올림
       MONTHS_BETWEEN('2021/10/01', '2020/11/01') 월_차이, -- 두 날짜 사이의 기간을 월 수로 계산(미래, 과거)
       ADD_MONTHS('2021/10/01', 3) 월_더하기 -- 음수를 넣으면 빼기도 가능
FROM dual;

-- 90번 부서 직원들의 오늘까지의 근무일수
SELECT last_name, FLOOR((sysdate - hire_date)) 근무일수 -- FLOOR : 소수점 버리기
FROM employees WHERE department_id = 90;

-- 근무월수가 200개월 미만인 직원들의...
SELECT employee_id, hire_date,
       FLOOR(MONTHS_BETWEEN(sysdate, hire_date)) 근무월수,
       ADD_MONTHS(hire_date, 3) "3개월_추가", -- 별칭 맨 처음에 숫자가 오면 큰 따옴표 사용
       NEXT_DAY(hire_date, '금요일') 다음_금요일, -- 기준일 이후 지정한 요일의 날짜
       LAST_DAY(hire_date) 마지막_날 -- 기준일이 속한 달의 마지막 날
FROM employees WHERE MONTHS_BETWEEN(sysdate, hire_date) < 200;

-- 예제 3-1
SELECT sysdate, hire_date, FLOOR(MONTHS_BETWEEN(sysdate, hire_date)) 근무월수
FROM employees WHERE department_id = 100;
-- 예제 3-2
SELECT hire_date, ADD_MONTHS(hire_date, 3) "3개월_더하기", ADD_MONTHS(hire_date, -3) "3개월_빼기"
FROM employees WHERE employee_id BETWEEN 100 AND 106;

-- ============================================================================

-- 변환형 함수
-- 숫자를 문자로 변환 : TO_CHAR(변환할 숫자, 'FORMAT')
SELECT TO_CHAR(12345678, '999,999,999') comma, -- 콤마
       TO_CHAR(123.45678, '999,999,999.99') period, -- 소숫점
       TO_CHAR(123.45678, '$999,999,999') dollar, -- 달러표시
       TO_CHAR(123.45678, 'L999,999,999') local -- 지역통화(한국은 원화, 일본은 엔화 등)
FROM dual;
-- 날짜를 문자로 변환 : TO_CHAR(변환할 날짜, 'FORMAT')
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS') "현재시간(24시간)",
       TO_CHAR(sysdate, 'YYYY-MM-DD AM HH:MI:SS') "현재시간(오전/오후)" -- AM/PM 둘 중에 하나만 적음
FROM dual;

-- 예제 4-1
SELECT employee_id, TO_CHAR(hire_date, 'MM/WW') 입사월
FROM employees WHERE department_id = 100;
-- 예제 4-2
SELECT first_name||' '||last_name 이름, TO_CHAR(salary, '$999,999,999.99') 월급
FROM employees WHERE salary > 10000 ORDER BY salary DESC;

-- 문자를 날짜로 변환 : TO_DATE('변환할 문자', 'FORMAT')
-- 문자형 타입_1 CHAR : 고정 길이 문자열을 저장, 지정된 길이보다 짧은 값을 저장하면 나머지 공간은 여백으로 채움
-- 문자형 타입_2 VARCHAR2 : 가변 길이 문자열을 저장, 지정된 길이보다 짧은 값을 저장하면 그 값만큼만 저장
SELECT TO_DATE('2020-11-17', 'YYYY-MM-DD') FROM dual;

-- 문자를 숫자로 변환 : TO_NUMBER('변환할 문자')
SELECT TO_NUMBER('01210616') + 10 FROM dual;