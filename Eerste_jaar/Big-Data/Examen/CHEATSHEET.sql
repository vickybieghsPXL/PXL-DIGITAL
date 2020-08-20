 PL/SQL CHEATSHEET
=-=-=-=-=-=-=-=-=-=
/* Types */
DATE
NUMBER
VARCHAR2(maxlengte)
BOOLEAN

Type overnemen van de vorige variabele: %TYPE ==> v_getal 	NUMBER(4,1)
												  v_getal2	v_getal%TYPE
												  
Waarde toekennen aan een variabele: v_waarde2 := v_waarde1



/* FUNCTIES */
	--
	
	CREATE OR REPLACE FUNCTION {functienaam}
		(v_{parameterNaam}	{type},
		 v_{parameterNaam}	{type}) 
	RETURN {type} -- HIER NOOIT LENGTE MEEGEVEN				
	AS	
		v_{variabelenaam}	{type}(lengte); --lengte is niet verplicht
		v_{variabelenaam}	{type}(lengte); --lengte is niet verplicht
	BEGIN
		{FUNCTIE HIER}
	END;
	
	--
	
	FUNCTIE GEBRUIKEN : SELECT functieNaam(Parameter) FROM tabel;
		VANUIT ANDERE FUNCTIE: v_var := functieNaam(parameter);
		
	FUNCTIE VERWIJDEREN : DROP FUNCTION {functieNaam} 
	
	KIJKEN WELKE FUNCTIES ER AANWEZIG ZIJN:
	
	SELECT object_name
	FROM user_objects
	WHERE object_type = 'FUNCTION';
	
	CODE BEKIJKEN VAN EEN BESTAANDE FUNCTIE:
	
	SELECT text
	FROM user_source
	WHERE name = '{functieNaam}';

		
/* IF ELSE */

	IF v_var > 10 AND v_var2 = 'IDK' THEN
		/* doe iets */
		
	ELSEIF v_char > 5 OR v_var2 = 'IDK' THEN
		/* doe iets anders */
		
	ELSE
		/* doe nog iets anders */
		
	END IF;
	
	
/* SELECT */

	SELECT veld1, veld2
	INTO v_veld1, v_veld2
	FROM tabel;

/* PROCEDURES */

	--
	
	CREATE OR REPLACE PROCEDURE {procedureNaam}
		(v_{parameterNaam} IN	{type},
		 v_{parameterNaam} OUT	{type}) 
	IS
		v_{variabelenaam}	{type}[:= '100'];
	BEGIN
		/* wat je moet doen */
		DBMS_OUTPUT.PUT_LINE(...);
	END {procedureNaam};
	
	Prodecure oproepen: exec {procedureNaam}
	 VANUIT ANDERE PROCEDURE: {procedureNaam}

/* LOOPS */

	LOOP
	/* doe iets */
	END LOOP;
	
	OF
	
	WHILE v_var <= 100 LOOP
		...
		v_var = v_var + 10;
	END LOOP;
	
	OF
	
	FOR i IN 1..10 LOOP
		...
	END LOOP;
	
	OF
	
	FOR rec IN (SELECT * FROM table WHERE x = x)
	LOOP
		...
	END LOOP;
	
	
	Procedure verwijderen: DROP PROCEDURE {procedureNaam}
	
	Kijken welke procedures er zijn: 

	SELECT object_name
	FROM user_objects
	WHERE object_type = 'PROCEDURE';
	
	Code van procedure bekijken:
	
	SELECT text
	FROM user_source
	WHERE name = '{Procedurenaam}';
	
/* TRIGGERS */

	CREATE OR REPLACE TRIGGER {triggernaam}
	BEFORE/AFTER
	DELETE/INSERT/UPDATE [OR ...] ON {tabelnaam}
	[FOR EACH ROW [WHEN (...)]]		==> bij de WHEN geen : bij OLD en NEW
	DECLARE
		v_{variabelenaam}	{type};
		v_{variabelenaam}	{type};
	BEGIN
		IF DELETING THEN
			...
		ELSE
			...
		END IF;
		RAISE_APPLICATION_ERROR(code, '{output}');
		...
	END {triggernaam};
	
	naamgeving: b = before / a = after
				d = delete / i = insert / u = update
				s = statement trigger (1x) / r = row trigger (meerdere keren)
				
	Nieuwe kolomwaarden op te bragen: 
	:NEW.{kolomnaam}
	:OLD.{kolomnaam} ==> enkel bij update
	
	Welke triggers bestaan er?
		SELECT object_name, created, status
		FROM user_objects
		WHERE object_type = 'TRIGGER';
	
	code van trigger:
		SELECT line, text
		FROM user_source
		WHERE name = '{triggernaam}';
		
	DROP TRIGGER {triggernaam}
	
	ALTER TABLE {tabelnaam} ENABLE/DISABLE ALL TRIGGERS
