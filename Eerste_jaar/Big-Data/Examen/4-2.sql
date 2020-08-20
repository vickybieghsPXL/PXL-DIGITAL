create table log_history
(log_user	varchar2(30),
 log_datum	date,
 log_tijd	timestamp,
 log_actie	varchar2(15))
/

CREATE OR REPLACE TRIGGER aiud_jhis
AFTER insert or update or delete
ON job_history
DECLARE
	v_log_actie	log_history.log_actie%type;
BEGIN
	IF deleting THEN
		v_log_actie := 'DELETE';
	ELSIF updating THEN
		v_log_actie := 'UPDATE';
	ELSE
		v_log_actie := 'INSERT';	
	END IF;

	INSERT INTO log_history
	VALUES(user, sysdate, systimestamp, v_log_actie);
	
	DBMS_OUTPUT.PUT_LINE('De tabel is bijgewerkt');
END;
/

/*Schrijf een database trigger waardoor bijgehouden wordt wie, wanneer, welke bewerking (insert,
update of delete) op de tabel job_history heeft uitgevoerd. Maak daarvoor de tabel log_history aan
met de volgende kolommen: log_user, log_datum, log_tijd, log_actie.  
Bewaar als trigger_oef2.sql.*/