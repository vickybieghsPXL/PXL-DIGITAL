CREATE OR REPLACE PROCEDURE ASTERISK_SAL
    (p_id number)
AS
    v_salaris number(10);
    v_ster varchar2(100);
BEGIN
    select salary into v_salaris from employees where employee_id = p_id;

        WHILE v_salaris >= 1000 LOOP
        v_ster := v_ster || '*';
        v_salaris := v_salaris - 1000;
        END LOOP;
    DBMS_OUTPUT.PUT_LINE(p_id || ' ' || v_ster);
END;
/