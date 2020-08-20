CREATE OR REPLACE TRIGGER
BEFORE delete or update of salary
ON employees
BEGIN
	IF deleting THEN
		IF (to_char(sysdate, 'DAY') = 'SATURDAY' OR to_char(sysdate, 'DAY') = 'SUNDAY') THEN
			RAISE_APPLICATION_ERROR(-20000, 'In het weekend kunnen er geen employees verwijderd worden')
		END IF;
	ELSE
		IF !(to_char(sysdate, 'DAY') = 'MONDAY' AND to_char(sysdate, 'hh24:mi:ss') between '9:00' and '17:00')
			RAISE_APPLICATION_ERROR(-20000, 'De lonen kunnen enkel op maandag tussen 9 en 17uur aangepast worden')
		END IF;
	END IF;
END;
/

/*Schrijf een trigger die ervoor zorgt :
 dat maandlonen enkel op maandag tussen 9:00 en 17:00 kunnen aangepast worden.
 dat in het weekend geen employees verwijderd of toegevoegd kunnen worden.
Bewaar als trigger_oef3.sql
Tip: om de tijd uit de systeemdatum te halen gebruik je de functie to_char met als formaat
‘hh24:mi:ss’.*/