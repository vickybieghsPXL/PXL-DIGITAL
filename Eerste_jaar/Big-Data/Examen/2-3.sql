/*A*/
CREATE OR REPLACE FUNCTION netto
	(p_bruto in NUMBER)
return varchar2
AS
BEGIN
	RETURN to_char(p_bruto * 0.60, '99,999.00') ||' euro';
END;
/
/*B*/
CREATE OR REPLACE FUNCTION netto
	(p_sal employees.salary%type)
RETURN VARCHAR2
AS
	v_netto		employees.salary%type;
BEGIN
	IF p_sal <= 10000 THEN
		v_netto := p_sal * 0.6;
	ELSIF p_sal < 16000 THEN
		v_netto := 10000 * 0.6 + (p_sal - 10000) * 0.5;
	ELSE
		v_netto := 10000 * 0.6 + 6000 * 0.5 + (p_sal - 16000) * 0.4;
	END IF;
RETURN to_char(v_netto, '99,999.00') || 'euro';
END;
/

/*a) Schrijf een functie ‘netto’ om het netto salaris van een werknemer te berekenen. 
Als parameter wordt het bruto salaris meegegeven. 
De belastingen bedragen 40% van het bruto salaris. 
Het netto salaris moet teruggegeven worden als vb 9,456.55 euro. 

b) Herschrijf de functie ‘netto’ zodat de belastingen in schijven berekend worden.   
Op de eerste 10 000 euro betaal je 40% belastingen, op de volgende 6 000 euro betaal je 50% 
belastingen en op de hoogste inkomensschijf betaal je 60% belastingen. */