CREATE OR REPLACE PROCEDURE minumumlonen
	(p_land IN countries.country_name%TYPE, p_minloon IN employees.salary%TYPE)
AS

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
	DBMS_OUTPUT.PUT_LINE('Aantal rijen aangepast: '|| sql%rowcount);
END;
/

/*Schrijf een procedure (minimumlonen) die ervoor zorgt dat als in een bepaald land nieuwe wetgeving 
van kracht gaat ivm minimumlonen, de eventueel nodige salarisaanpassingen van de employees 
gemakkelijk in de databank doorgevoerd kunnen worden.   
Invoerparameters: de landnaam en het nieuwe minimumloon dat daar vanaf nu geldig is. 
Bewaar deze procedure als proc_minimumlonen.sql om in opdracht 4 te kunnen wijzigen. 
Deze procedure kan je uitvoeren door aan de SQL‐prompt in te tikken: 
SQL> exec minimumlonen(‘Canada’,6250) 
Controleer vooraf even of er een employee is uit Canada die minder verdient dan 6250. En check dan 
achteraf of er een aanpassing heeft plaatsgevonden. */