CREATE OR REPLACE FUNCTION schrikkeljaar
	(p_jaar in number)
return varchar2
AS
	v_jaar	NUMBER(4);
BEGIN
	v_jaar := p_jaar;
	IF MOD(v_jaar, 4) = 0 THEN
		IF MOD(v_jaar, 100) <> 0 THEN
			return v_jaar || ' is een schrikkeljaar';
		ELSIF MOD(v_jaar, 400) = 0 THEN
			return v_jaar || ' is een schrikkeljaar';
		ELSE
			return v_jaar || ' is geen schrikkeljaar';
		END IF;
	ELSE
		return v_jaar || ' is geen schrikkeljaar';
	END IF;
END;
/

/*a) Schrijf een functie ‘schrikkeljaar’ om na te gaan of het huidige jaar een schrikkeljaar is of niet. 
De functie geeft terug ‘het jaar xxx is een schrikkeljaar’ of ‘het jaar xxx is geen schrikkeljaar’. */