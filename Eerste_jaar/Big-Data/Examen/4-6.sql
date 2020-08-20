CREATE OR REPLACE TRIGGER triggerName
BEFORE INSERT OR UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Eerste puntje
    :NEW.job_id := UPPER(:NEW.job_id);
    :NEW.first_name := INITCAP(:NEW.first_name);
    :NEW.last_name := INITCAP(:NEW.first_name);
    
    -- Tweede puntje
    IF INSERTING AND :NEW.hire_date < sysdate THEN
        RAISE_APPLICATION_ERROR(-20000, 'You can\t hire someone in the past!');
    END IF;
    
    -- Derde puntje
    IF UPDATING AND :NEW.job_id LIKE '%MAN%' AND :OLD.job_id NOT IN ('AD_PRES', 'AD_VP') THEN
        :NEW.salary := :OLD.salary * 1.05;
    END IF;
END;
/

/*Doe al het nodige om er voor te zorgen dat:
 bij het toevoegen of wijzigen in de tabel employees het job_id automatisch naar hoofdletters
wordt geconverteerd en de naam en voornaam enkel begint met een hoofdletter
 bij het toevoegen bij de hire_date nooit een datum in het verleden kan worden ingegeven
 medewerkers die promoveren en een managersfunctie krijgen, automatisch een
salarisverhoging krijgen van 5%. Het moet wel degelijk om een promotie gaan. Iemand die
president of vice president was en manager wordt, krijgt geen verhoging. Gebruik hiervoor
het job_id.  
Sla op als trigger_oef6.sql.*/