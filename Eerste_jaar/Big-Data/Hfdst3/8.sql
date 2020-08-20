CREATE OR REPLACE PROCEDURE country_dept
        (p_id varchar2)
AS
    v_counter NUMBER(10);
BEGIN

    for locaties in(select location_id from locations where country_id = p_id) LOOP
        for departementen in(select department_name from departments
                            where location_id = locaties.location_id) LOOP
                            DBMS_OUTPUT.PUT_LINE(departementen.department_name);                            
                            END LOOP;
                            END LOOP;



    if locaties.location_id IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('geen departments');
    END IF;
    
END;
/