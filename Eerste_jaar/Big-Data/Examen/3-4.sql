CREATE OR REPLACE PROCEDURE minlonen2
	(p_land IN countries.country_name%TYPE, 
	p_minloon IN employees.salary%TYPE,
	p_aantal_aangepast OUT number)
IS

BEGIN
	UPDATE employees
	SET salary = p_minloon
	WHERE department_id IN (select department_id
				from departments
				where location_id in (select location_id
							from locations
							where country_id = (select country_id
										from countries
										where UPPER(country_name) = UPPER(p_land))))
	AND salary < p_minloon;
	p_aantal_aangepast := SQL%rowcount;
END;
/*
DECLARE
	v_aantal		NUMBER(4);
BEGIN
	minlonen2('CANADA', 6250, v_aantal);
	DBMS_OUTPUT.PUT_LINE('Er zijn '|| v_aantal||' rijen bewerkt');
END;
*/
variable b_test number
exec minlonen2('CANADA', 6250, :b_test)




/*Wijzig de procedure uit opdracht 3 zodat het calling programma een melding terugkrijgt van het 
aantal gewijzigde records/rijen en dit afdrukt: 
 via een anoniem block 
 via een bind‐variable */