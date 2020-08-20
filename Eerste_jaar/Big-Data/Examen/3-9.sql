CREATE OR REPLACE PROCEDURE oef9
    (    p_department_id     IN      departments.department_id%TYPE    ,
        p_percent              IN         NUMBER                            )
AS
    v_department_name departments.department_name%TYPE;
    v_counter NUMBER(5);
BEGIN
    SELECT department_name
    INTO v_department_name
    FROM departments
    WHERE department_id = p_department_id;
    
    DBMS_OUTPUT.PUT_LINE('Het gekozen departement is: ' || v_department_name);
    DBMS_OUTPUT.PUT_LINE('<--> ' || RPAD('ID', 5) || RPAD('LAST NAME', 40) || RPAD('SALARY', 20));
    FOR rec IN (    SELECT last_name, employee_id, salary FROM employees WHERE department_id = p_department_id    ) 
    LOOP
        DBMS_OUTPUT.PUT_LINE('<--> ' || RPAD(rec.employee_id, 5) || RPAD(rec.last_name, 40) || RPAD(rec.salary, 20));
        
        UPDATE employees
        SET salary = salary + salary * p_percent
        WHERE employee_id = rec.employee_id;
        
        v_counter := v_counter + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('===================================================');
    DBMS_OUTPUT.PUT_LINE('Aantal salarisverhogingen: ' || v_counter);
    DBMS_OUTPUT.PUT_LINE('===================================================');
    DBMS_OUTPUT.PUT_LINE('Situatie na wijziging');
    
    FOR rec IN (    SELECT last_name, employee_id, salary FROM employees WHERE department_id = p_department_id    ) 
    LOOP
        DBMS_OUTPUT.PUT_LINE('<--> ' || RPAD(rec.employee_id, 5) || RPAD(rec.last_name, 40) || RPAD(rec.salary, 20));
    END LOOP;
END;
/

/*Maak een procedure die het volgende doet: 
 Vanuit het calling programma wordt een department_id en een percentage voor loonsverhoging 
meegegeven 
 van dit departement wordt bovenaan de lijst de naam van het departement (‘Het gekozen 
departement is: …….[naam departement]) afgedrukt en daaronder alle werknemers(naam en id) 
die er werken met hun huidige salaris 
 deze werknemers krijgen een loonsverhoging  volgens het meegegeven percentage 
 na een blanco regel wordt het aantal salarisverhogingen afgedrukt voorafgegaan door de tekst 
“Aantal salarisverhogingen : ………” 
 op een nieuwe regel wordt volgende titel afgedrukt: “SITUATIE NA WIJZIGING.” En daaronder 
worden alle werknemers met hun nieuwe salaris afgedrukt. */