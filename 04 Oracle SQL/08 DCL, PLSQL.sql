-- ===========================================================================

-- ���ο� ����� ����� : �����ڸ� ����
CREATE USER john IDENTIFIED BY 1234;

-- ���� ���� �ֱ� : GRANT ���� TO ����
GRANT CREATE SESSION TO john;

-- ���̺�/�� ���� ���� �ֱ�
GRANT CREATE TABLE TO john;
GRANT CREATE VIEW TO john;

-- ������ �����ֱ� �������ϱ� ���ѵ��� ���� role�� ����
-- CONNECT(���� ����), RESOURCE(��ü/������ ����), DBA(������)
GRANT CONNECT, RESOURCE TO john;

-- �ο��� ������ ȸ���ϱ� : REVOKE ���� FROM ����
REVOKE CREATE VIEW FROM john;
REVOKE CREATE TABLE FROM john;
REVOKE CONNECT, RESOURCE FROM john;

-- ���� ����(���õ� ��� ���� ����)
DROP USER john CASCADE;

-- ���� ��й�ȣ ����
--ALTER USER ������ IDENTIFIED BY ������ ��й�ȣ;

-- ===========================================================================

-- PL/SQL �� SCOTT �������� ����
-- ���� : �ּ��� ��ɾ�� ���� �ٿ� ������ ���� �߻�!

-- ��ũ��Ʈ�� ����ϱ� ���� �ɼ� ��ɾ�
SET SERVEROUTPUT ON;

-- �͸� ���
BEGIN
    DBMS_OUTPUT.PUT_LINE('��ο� ����!');
END;
/
-- PL/SQL�� ' ; ' �� �ƴ� ' / ' �� ����� ������

DECLARE
    message VARCHAR2( 100 ) := '�ȳ��ϼ���!';
    -- ' := ' ������ �Է�(�Ҵ� ������)
    n NUMBER( 1 ) := 7;
    n_price CONSTANT NUMBER( 4, 2 ) := 12.34;
    -- CONSTANT : ��� ����, ���� �� ����
BEGIN
    DBMS_OUTPUT.PUT_LINE( message );
    DBMS_OUTPUT.PUT_LINE( n );
    DBMS_OUTPUT.PUT_LINE( n_price );
END;
/

DECLARE
    v_name EMP.ENAME%TYPE;
    -- v_name�� emp ���̺��� ename ���� ���� data type���� ��������
BEGIN
    v_name := 'ȫ�浿';
    DBMS_OUTPUT.PUT_LINE ( v_name );
END;
/

-- ===========================================================================

-- ���ν���
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
-- EXECUTE : SQL ���� ����, EXEC�� �ٿ��� ���� ���

-- 2
CREATE OR REPLACE PROCEDURE adjust_salary
    (in_empno IN emp.empno%TYPE,
     in_percent IN NUMBER)
IS
BEGIN
    -- ������ȣ�� �ӱ��� in_percent% ��ŭ �ø�
    UPDATE emp
    SET sal = sal + sal * in_percent / 100
    WHERE empno = in_empno;
END;
/
EXEC adjust_salary( 7839, 50 );

-- �� 1�� 2�� ���� ����� ������� �����ֱ�
UPDATE emp SET sal = 800 WHERE empno = 7369;
UPDATE emp SET sal = 5000 WHERE empno = 7839;
COMMIT;

-- ===========================================================================

-- �ݺ���
-- test ���̺� �����
CREATE TABLE TEST 
( ID NUMBER(3),
  NAME VARCHAR2(20),
  START_DATE DATE DEFAULT SYSDATE );

-- test ���̺� 100���� �׽�Ʈ ������ �Է�
DECLARE
    v_cnt NUMBER := 1;
BEGIN
    -- �ݺ��� (LOOP ~ END LOOP)
    LOOP
        INSERT INTO test(id, name)
        VALUES(v_cnt, 'test'||to_char(v_cnt));
        v_cnt := v_cnt+1;
        EXIT WHEN v_cnt > 100;
        -- ���� v_cnt�� 100�� ������ ����
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('������ �Է� �Ϸ�');
    DBMS_OUTPUT.PUT_LINE(v_cnt-1 || '���� �����Ͱ� �ԷµǾ����ϴ�');
END;
/

-- ===========================================================================