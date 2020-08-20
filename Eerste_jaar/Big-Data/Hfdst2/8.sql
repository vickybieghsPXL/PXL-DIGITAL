create or replace function naam_hoofd
return varchar2
as 
    v_max number(30);
    v_naam varchar2(10);
BEGIN
    SELECT MAX(COUNT(department_id))
    INTO v_max
    FROM employees
    GROUP BY department_id;

    SELECT first_name  || ' ' || last_name 
    INTO v_naam
    FROM employees
    WHERE department_id = (SELECT department_id
                            FROM employees
                            GROUP BY department_id
                            HAVING COUNT(department_id) = v_max)
    AND job_id like '%MAN%';

    RETURN v_naam;

end;
/
