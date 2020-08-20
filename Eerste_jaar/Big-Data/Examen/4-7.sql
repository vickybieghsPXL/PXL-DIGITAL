CREATE OR REPLACE TRIGGER bidr_employees
BEFORE INSERT OR DELETE ON employees
FOR EACH ROW
DECLARE
    v_chef_name employees.last_name%TYPE;
    v_chef_first_name employees.first_name%TYPE;
BEGIN
    IF INSERTING THEN
        IF :NEW.manager_id = NULL THEN
            SELECT manager_id
            INTO :NEW.manager_id
            FROM departments
            WHERE department_id = :NEW.department_id;
            
            SELECT first_name, last_name
            INTO v_chef_first_name, v_chef_name
            FROM employees
            WHERE employee_id = :NEW.manager_id;
            
            DBMS_OUTPUT.PUT_LINE('De chef word ' || v_chef_name || ' ' || v_chef_first_name);
        END IF;
        IF :NEW.hire_date = NULL THEN
            :NEW.hire_date := NEXT_DAY(:NEW.hire_date, 'Monday');
        END IF;
        IF :NEW.salary = NULL THEN
            :NEW.salary := 1000;
            DBMS_OUTPUT.PUT_LINE('Het salaris van ' || :NEW.last_name || ' ' || :NEW.first_name || ' wordt 1000');
        END IF;
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('Dit is per maand een besparing van ' || :OLD.salary || ' euro');
    END IF;
END;
/
/*Zorg ervoor dat bij de creatie van een nieuwe employee volgende controles gebeuren:
 als geen manager_id wordt ingevoerd, wordt automatisch de manager van het departement  
waar deze persoon aan toegewezen wordt, de directe chef.  Toon in dat geval als melding op
het scherm “de chef wordt [de naam en de voornaam van de chef].”
 als er geen hire_date werd ingevuld dan wordt dit automatisch de eerstvolgende maandag
na de huidige datum.
 als geen salary werd opgegeven, wordt dit automatisch 1000.  Druk in dat geval af “het
salaris van employee [ naam employee] wordt 1000”.
Als een employee verwijderd wordt, verschijnt een melding “dit is per maand een besparing van [xxx]
euro”, (waarbij je de xxx vervangt door het maandloon van deze employee).
Bewaar als trigger_oef7.sql.*/