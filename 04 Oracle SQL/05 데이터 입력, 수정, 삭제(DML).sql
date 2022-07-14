-- ===========================================================================

-- 데이터 입력하기 : 하나의 행만을 삽입, 생략된 열은 NULL값이 입력됨
-- 각 열과 VALUES절의 값은 반드시 1:1로 대응해야 함
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (300, 'Game', 100, 1700);
-- 기본키 : 반드시 입력 + 중복입력 불가 + 하나만 있어야 됨
-- departments Table에서 기본키는 department_id
SELECT * FROM departments; -- 위의 데이터가 추가된 것 확인가능
DESC departments; -- NOT NULL은 무조건 입력해야 함

-- 꼭 입력해야 하는 열만 입력
INSERT INTO departments(department_id, department_name)
VALUES (280, 'Music');
SELECT * FROM departments;

-- 전체 열 입력
INSERT INTO employees
VALUES (207, '펭수', '김', 'Peng', '515.129.1234', SYSDATE, 'IT_PROG', 9999, NULL, 205, 300);
SELECT * FROM employees;

-- 예제 1
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (271, 'Sample Dept 1', 200, 1700);
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (272, 'Sample Dept 2', 200, 1700);
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (273, 'Sample Dept 3', 200, 1700);
SELECT * FROM departments;

-- ===========================================================================

-- 데이터 수정하기 : 여러 행의 값을 동시에 수정가능
-- 주의 : WHERE절 생략하면 지정된 열의 모든 행이 수정됨
UPDATE departments
SET manager_id = 200, location_id = 1700
WHERE department_name = 'Music';
SELECT * FROM departments;

UPDATE employees
SET email = 'PENG', phone_number = '010.123.4567', salary = salary * 1.2
WHERE employee_id = 207;
SELECT * FROM employees;

-- 예제 2
UPDATE departments
SET manager_id = 100
WHERE department_id BETWEEN 150 AND 200;
SELECT * FROM departments;

-- ===========================================================================

-- 데이터 삭제하기 : WHERE절의 조건에 해당하는 행 단위로 삭제
DELETE FROM departments
WHERE department_id = 280; -- 주로 기본키를 이용하여 삭제
--WHERE department_name = 'Music';
SELECT * FROM departments;

-- 외래키 삭제 오류
DELETE FROM departments
WHERE department_name = 'Game'; -- 펭수가 Game 부서에 포함되어 있으므로 오류 발생
-- 펭수를 삭제하거나 부서를 옮겨줘야
DELETE FROM employees
WHERE first_name = '펭수';
-- 게임부서 삭제 가능
DELETE FROM departments
WHERE department_name = 'Game';
SELECT * FROM employees;

-- WHERE절이 없으면 모든 행이 삭제됨
DELETE FROM job_history;
SELECT * FROM job_history;
-- WHERE절이 없으면 모든 행이 수정됨
UPDATE employees
SET salary = 100;
SELECT * FROM employees;

-- 이전 COMMIT 상태로 되돌리기
ROLLBACK;
-- 영구저장
COMMIT;

-- ===========================================================================

-- 문자형 데이터 : VARCHAR2(n) - n은 최대 4000바이트
DESC TEST; -- VARCHAR2(20) : 최대 20바이트까지 입력 가능
INSERT INTO test VALUES (1, 'ABCDEFGHIJ1234567890');
--INSERT INTO test VALUES (2, 'ABCDEFGHIJ12345678901'); -- 영어, 숫자 : 1바이트
INSERT INTO test VALUES (2, '가나다라마바');
--INSERT INTO test VALUES (2, '가나다라마바사'); -- 오라클에서 한글 : 3바이트

-- 숫자형 데이터 : NUMBER(P,S) - P(1~38) 전체 자릿수, S 소수점 유효자릿수
DESC TEST; -- NUMBER(1) : 한자리수만 입력 가능
INSERT INTO test VALUES (3, '숫자는한자리', SYSDATE);
--INSERT INTO test VALUES (33, '두자리수'); -- 두자리수이므로 입력 불가

-- 날짜형 데이터 : DATE
INSERT INTO test VALUES (4, '현재날짜입력', SYSDATE);
INSERT INTO test VALUES (5, '문자열로입력', '22/03/07');
INSERT INTO test(id, name) VALUES (6, '날짜안적기');
SELECT * FROM test;

-- ===========================================================================