CREATE OR REPLACE FUNCTION aantal_dienstjaren
(datum DATE)
RETURN NUMBER
AS
   v_aantal number(2);
BEGIN
   v_aantal := trunc((months_between(sysdate, datum) / 12);
   RETURN v_aantal;
END;
/

/*Schrijf een functie ‘aantal_dienstjaren’ om na te gaan hoe lang een specifieke werknemer reeds in 
dienst is. 
Als parameter wordt datum van indiensttreding van de werknemer meegegeven. 
De functie geeft het aantal volledige dienstjaren terug. */