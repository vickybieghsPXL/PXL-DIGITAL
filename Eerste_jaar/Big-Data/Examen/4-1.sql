/*example
CREATE OR REPLACE TRIGGER bds_emp
     BEFORE DELETE
     ON employees
BEGIN
     IF USER != 'JAN' THEN
     RAISE_APPLICATION_ERROR(-20000,
             'u heeft geen rechten voor deze actie');
     END IF;
END;
*/

CREATE OR REPLACE trigger bus_jobs
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
/

/*Zorg ervoor dat onderstaande controles automatisch gebeuren indien het laagste en/of hoogste
salaris wordt aangepast in de tabel jobs:
 als de gebruiker ‘student’ en/of ‘bezoeker’ deze aanpassing(en) wil doen dan mag dit niet
doorgaan en moet de melding “Je hebt onvoldoende rechten om deze actie uit te voeren!”
verschijnen.
 als een andere gebruiker deze aanpassing(en) wil doen dan mag deze doorgaan maar moet
volgende waarschuwing getoond worden “Ben je zeker dat je het minimum en/of maximum
salaris van één of meerdere jobs wil aanpassen? Indien niet voer dan onmiddellijk een
ROLLBACK uit!”   
Bewaar als trigger_oef1.sql*/