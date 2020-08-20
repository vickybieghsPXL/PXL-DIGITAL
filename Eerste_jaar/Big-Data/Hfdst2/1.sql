create or replace function dagen_einde_maand
return number
as
    v_dagen number;
begin
    v_dagen := last_day(sysdate) - sysdate;
    return v_dagen;
end;
/
/* Schrijf een functie ‘dagen_einde_maand’ die berekent hoeveel dagen er liggen tussen nu 
(=systeemdatum) en het einde van deze maand */