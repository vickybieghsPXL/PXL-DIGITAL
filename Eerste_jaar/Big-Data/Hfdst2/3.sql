CREATE OR REPLACE FUNCTION netto
(salaris number)
RETURN VARCHAR2
AS
   v_getal   employees.salary%type; --zelfde TYPE als die van salary
BEGIN
   v_getal := salaris * 0.60;
   return v_getal || ' euro';
end;
/

/* Schrijf een functie ‘netto’ om het netto salaris van een werknemer te berekenen. 
Als parameter wordt het bruto salaris meegegeven. 
De belastingen bedragen 40% van het bruto salaris. 
Het netto salaris moet teruggegeven worden als vb 9,456.55 euro*/