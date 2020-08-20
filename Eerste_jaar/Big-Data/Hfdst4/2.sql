CREATE OR REPLACE TRIGGER audis_history
AFTER delete or update or insert
ON job_history
BEGIN
    IF DELETING THEN
        INSERT INTO log_history VALUES (USER, SYSDATE, 'DELETE');
    ELSIF UPDATING THEN
        INSERT INTO log_history VALUES (USER, SYSDATE, 'UPDATE');
    ELSE 
        INSERT INTO log_history VALUES (USER, SYSDATE, 'INSERT');
    END IF;
END;
/
