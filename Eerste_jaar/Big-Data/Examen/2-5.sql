CREATE OR REPLACE FUNCTION volgende_vergadering
	(p_datum in date)
return date
AS
	v_volgende_vergadering	date;
BEGIN
	v_volgende_vergadering := next_day(last_day(p_datum), 'MONDAY');
	
	IF to_char(v_volgende_vergadering, 'dd') = 1 AND (to_char(v_volgende_vergadering, 'mm') = 1 or to_char(v_volgende_vergadering, 'mm') = 5) THEN
		v_volgende_vergadering := next_day(last_day(p_datum), 'THUESDAY');
	END IF;
RETURN v_volgende_vergadering;
END;
/

/*Elke eerste maandag van de maand gaat een vergadering door. Schrijf een functie 
‘volgende_vergadering’ die de datum toont van de eerstvolgende vergadering. 
Let op:  1 januari en 1 mei zijn wettelijke feestdagen.  Als de eerste maandag van de maand op 1 van 
deze data valt, dan wordt er vergaderd op dinsdag. */