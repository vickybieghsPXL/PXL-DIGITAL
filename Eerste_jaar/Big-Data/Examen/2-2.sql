create or replace function aantal_dienstjaren(p_hire_date employees.hire_date%type)
return number
as 
begin
    RETURN TRUNC(months_between(sysdate, p_hire_date)/12);
end;
/

/*Schrijf een functie ‘aantal_dienstjaren’ om na te gaan hoe lang een specifieke werknemer reeds in 
dienst is. 
Als parameter wordt datum van indiensttreding van de werknemer meegegeven. 
De functie geeft het aantal volledige dienstjaren terug. */