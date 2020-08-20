CREATE OR REPLACE TRIGGER aur_emp
	AFTER UPDATE OF salary
	ON employees
	FOR EACH ROW
BEGIN
	IF :NEW.salary < :OLD.salary THEN
		RAISE_APPLICATION_ERROR(-20000, 'Loonsverlaging kan niet!');
	ELSIF :NEW.salary > :OLD.salary * 1.05 THEN
		RAISE_APPLICATION_ERROR(-20000, 'Een loonsverhoging van meer dan 5% is niet toegelaten!');
	END IF;
END;
/
/*Doe al het nodige om er voor te zorgen dat bij het wijzigen van het salaris van een of meerdere
medewerkers de verhoging nooit meer mag zijn dan 5%:  
 melding indien meer dan 5%: “Een loonsverhoging van meer dan 5 % is niet toegelaten”  
 de verhoging mag niet doorgaan  
Een verlaging resulteert in een foutmelding “Loonsverlaging kan niet!” en deze mag dus ook niet
doorgaan.  
Bewaar als trigger_oef4.sql*/


De trigger inhoud laten zien =
select text from user_source where name = 'UPDATE_JOB_HISTORY';