CREATE OR REPLACE PROCEDURE testloop
AS

BEGIN
    FOR emprec IN(SELECT department_id, first_name, last_name
                  FROM employees
                  ORDER BY department_id) LOOP
        DBMS_OUTPUT.PUT_LINE(lpad(emprec.department_id, 4,' ')  || rpad(emprec.first_name, 30, ' ')
                             || rpad(emprec.last_name,30, ' '));          
    END LOOP;              
END;
/