CREATE OR REPLACE TRIGGER bs_oef1
BEFORE UPDATE
ON jobs
BEGIN
    IF USER = 'STUDENT' or USER = 'BEZOEKER' THEN
    RAISE_APPLICATION_ERROR(-20404, 'you are a twat');
    ELSE
    DBMS_OUTPUT.PUT_LINE('ya sure? anders een rollback tyvm');
    END IF;
END;
/