CREATE OR REPLACE FUNCTION bruto_jaarloon
(p_employee NUMBER)
RETURN NUMBER
as
    v_loon number(5);

BEGIN
    SELECT salary * (1 + NVL(commission_pct, 0))
    into v_loon 
    from employees
    where employee_id = p_employee;

    return v_loon ;
end;
/