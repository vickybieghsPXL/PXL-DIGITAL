CREATE OR REPLACE PROCEDURE grootste_dept
IS  v_hoogsteSalaris  varchar(50);
    v_max number(10);
    v_departementNaam  varchar(50);
    v_id varchar(50);
    v_naam varchar(70);

BEGIN
    SELECT max(count(department_id))
    into v_max 
    from employees
    group by department_id;
    
    select department_id
    into v_id
    from employees
    having count(department_id) = v_max
    group by department_id;

    select department_name
    into v_departementNaam
    from departments
    where department_id = v_id;
    
    select max(salary)
    into v_hoogsteSalaris
    from employees
    where department_id = v_id;

    select first_name || ' ' || last_name
    into v_naam
    from employees
    where salary = v_hoogsteSalaris AND department_id = v_id;

    DBMS_OUTPUT.PUT_LINE(v_naam || ' uit ' || v_departementNaam || ' verdient ' || v_hoogsteSalaris);

END grootste_dept;
/