-- ===========================================================================

-- 새로운 사용자 만들기 : 관리자만 가능
CREATE USER john IDENTIFIED BY 1234;

-- 접속 권한 주기 : GRANT 권한 TO 유저
GRANT CREATE SESSION TO john;

-- 테이블/뷰 생성 권한 주기
GRANT CREATE TABLE TO john;
GRANT CREATE VIEW TO john;

-- 일일히 권한주기 귀찮으니까 권한들의 묶음 role이 존재
-- CONNECT(접속 관련), RESOURCE(객체/데이터 관련), DBA(관리자)
GRANT CONNECT, RESOURCE TO john;

-- 부여된 권한을 회수하기 : REVOKE 권한 FROM 유저
REVOKE CREATE VIEW FROM john;
REVOKE CREATE TABLE FROM john;
REVOKE CONNECT, RESOURCE FROM john;

-- 계정 삭제(관련된 모든 내용 삭제)
DROP USER john CASCADE;

-- 계정 비밀번호 수정
--ALTER USER 계정명 IDENTIFIED BY 변경할 비밀번호;

-- ===========================================================================

-- PL/SQL → SCOTT 계정으로 진행
-- 주의 : 주석이 명령어랑 같은 줄에 있으면 오류 발생!

-- 스크립트에 출력하기 위한 옵션 명령어
SET SERVEROUTPUT ON;

-- 익명 블록
BEGIN
    DBMS_OUTPUT.PUT_LINE('헬로우 월드!');
END;
/
-- PL/SQL은 ' ; ' 이 아닌 ' / ' 로 명령을 구분함

DECLARE
    message VARCHAR2( 100 ) := '안녕하세요!';
    -- ' := ' 변수에 입력(할당 연산자)
    n NUMBER( 1 ) := 7;
    n_price CONSTANT NUMBER( 4, 2 ) := 12.34;
    -- CONSTANT : 상수 선언, 변할 수 없음
BEGIN
    DBMS_OUTPUT.PUT_LINE( message );
    DBMS_OUTPUT.PUT_LINE( n );
    DBMS_OUTPUT.PUT_LINE( n_price );
END;
/

DECLARE
    v_name EMP.ENAME%TYPE;
    -- v_name을 emp 테이블의 ename 열과 같은 data type으로 지정해줌
BEGIN
    v_name := '홍길동';
    DBMS_OUTPUT.PUT_LINE ( v_name );
END;
/

-- ===========================================================================

-- 프로시저
-- 1
CREATE OR REPLACE PROCEDURE update_sal 
    (in_empno IN NUMBER)      
IS
BEGIN
    UPDATE emp
    SET sal = sal  * 1.1 
    WHERE empno = in_empno;
END update_sal;
/
EXECUTE update_sal( 7369 );
-- EXECUTE : SQL 문장 실행, EXEC로 줄여서 많이 사용

-- 2
CREATE OR REPLACE PROCEDURE adjust_salary
    (in_empno IN emp.empno%TYPE,
     in_percent IN NUMBER)
IS
BEGIN
    -- 직원번호의 임금을 in_percent% 만큼 올림
    UPDATE emp
    SET sal = sal + sal * in_percent / 100
    WHERE empno = in_empno;
END;
/
EXEC adjust_salary( 7839, 50 );

-- 위 1과 2의 실행 결과를 원래대로 돌려주기
UPDATE emp SET sal = 800 WHERE empno = 7369;
UPDATE emp SET sal = 5000 WHERE empno = 7839;
COMMIT;

-- ===========================================================================

-- 반복문
-- test 테이블 만들기
CREATE TABLE TEST 
( ID NUMBER(3),
  NAME VARCHAR2(20),
  START_DATE DATE DEFAULT SYSDATE );

-- test 테이블에 100개의 테스트 데이터 입력
DECLARE
    v_cnt NUMBER := 1;
BEGIN
    -- 반복문 (LOOP ~ END LOOP)
    LOOP
        INSERT INTO test(id, name)
        VALUES(v_cnt, 'test'||to_char(v_cnt));
        v_cnt := v_cnt+1;
        EXIT WHEN v_cnt > 100;
        -- 변수 v_cnt가 100이 넘으면 종료
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('데이터 입력 완료');
    DBMS_OUTPUT.PUT_LINE(v_cnt-1 || '개의 데이터가 입력되었습니다');
END;
/

-- ===========================================================================