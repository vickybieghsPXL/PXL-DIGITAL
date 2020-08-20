CREATE OR REPLACE TRIGGER aur_sal
    AFTER UPDATE OF salary ON employees
    FOR EACH ROW
    WHEN (OLD.hire_date < TO_DATE('01-01-1995', 'dd-MM-yyyy'))
BEGIN
    IF :OLD.salary * .05 > :NEW.salary - :OLD.salary THEN
        RAISE_APPLICATION_ERROR(-20000, 'Een loonsverhoging van meer dan 5% mag niet!');
    ELSIF :OLD.salary > :NEW.salary THEN
        RAISE_APPLICATION_ERROR(-20000, 'Een loonsverlaging mag niet!');
    END IF;
END;
/
/*Pas de oplossing van oefening 4 zodanig aan dat deze trigger enkel werkt als het gaat om de
medewerkers die aangeworven zijn vóór 01‐01‐1995.  
Bewaar als trigger_oef5.sql.*/