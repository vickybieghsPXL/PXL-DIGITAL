CREATE OR REPLACE PROCEDURE landen
    (    p_country_id             IN         countries.country_id%TYPE    ,
        p_amount_of_employees     OUT     NUMBER                        )
AS
    v_count NUMBER(5);
BEGIN
    FOR rec IN (    SELECT c.country_name, l.postal_code, l.city, l.location_id
                    FROM countries c JOIN locations l ON c.country_id = l.country_id    
                    WHERE c.country_id = p_country_id                                    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('==> ' || rec.country_name || ' - ' || rec.postal_code || ' ' || rec.city);
        FOR rec2 IN (    SELECT department_id, department_name FROM departments WHERE location_id = rec.location_id    )
        LOOP
            SELECT COUNT(employee_id)
            INTO v_count
            FROM employees
            WHERE department_id = rec2.department_id;
            IF v_count <> 0 THEN
                DBMS_OUTPUT.PUT_LINE(rec2.department_name || ': ' || v_count || ' werknemers');
                p_amount_of_employees := p_amount_of_employees + v_count;
            END IF;
        END LOOP;
    END LOOP;
END;
/

DECLARE
    v_amount_of_employees     NUMBER(5);
BEGIN
    landen('US', v_amount_of_employees);
    DBMS_OUTPUT.PUT_LINE(v_amount_of_employees);
END;
/


/*CREATE OR REPLACE trigger bus_jobs
	before update of min_salary,max_salary
   	on jobs
BEGIN
   	IF user in ('STUDENT','BEZOEKER') THEN
      		raise_application_error(-20000, 'Je hebt onvoldoende rechten om deze actie uit te voeren!');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Ben je zeker dat je het minimum en/of maximum salaris van een of meerdere jobs
wil aanpassen? Indien niet voer dan een ROLLBACK uit!');
   	END IF;
END;
/*/