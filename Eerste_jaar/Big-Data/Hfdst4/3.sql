CREATE OR REPLACE TRIGGER audis_lonen
AFTER UPDATE OR DELETE OR INSERT
ON employees 
BEGIN 
    IF UPDATING AND TO_CHAR(SYSDATE, 'DAY') = 'MONDAY' AND TO_CHAR(SYSDATE, 'hh24') 
    > 9 AND TO_CHAR(SYSDATE, 'hh24') < 17 THEN
        DBMS_OUTPUT.PUT_LINE('yas queen');
    ELSIF DELETING AND TO_CHAR(SYSDATE, 'DAY') = 'SATURDAY' OR TO_CHAR(SYSDATE, 'DAY') = 'SUNDAY' THEN
         RAISE_APPLICATION_ERROR(-21999, 'nah man its weekend');
    ELSE 
        RAISE_APPLICATION_ERROR(-20254, 'ja da mag nie he');
    END IF;
END;
/