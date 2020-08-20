CREATE OR REPLACE PROCEDURE landenlijst
IS
	v_aantal	integer(4) :=0;
BEGIN
	for rec in (select country_name from countries)
	loop
		DBMS_OUTPUT.PUT_LINE(rec.country_name);
		v_aantal := v_aantal + 1;
	end loop;
	DBMS_OUTPUT.PUT_LINE('We hebben connecties in '|| v_aantal||' landen');
end;
/
/*Maak een procedure (landenlijst) die alle landen uit de tabel countries in een lijst afdrukt en druk op 
het einde van de lijst ook als volgt af over hoeveel landen  het gaat: “We hebben connecties in 
……..landen.’ 
Deze procedure kan je uitvoeren door aan de SQL‐prompt in te tikken: 
SQL> exec landenlijst */