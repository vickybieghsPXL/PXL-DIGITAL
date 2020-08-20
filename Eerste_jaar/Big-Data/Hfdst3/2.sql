CREATE OR REPLACE PROCEDURE toon_laatste_emp
IS
        v_laatsteEmp varchar(100);
BEGIN
        SELECT first_name || ' ' || last_name || ' ' ||employee_id || ' ' || hire_date
        INTO v_laatsteEmp
        FROM employees
        where hire_date = (SELECT(max(hire_date)) from employees);
        DBMS_OUTPUT.PUT_LINE(v_laatsteEmp);

END toon_laatste_emp;
/