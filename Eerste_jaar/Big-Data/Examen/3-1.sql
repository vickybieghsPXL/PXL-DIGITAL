/* uitvoeren -> exec procedure_naam of execute*/

CREATE OR REPLACE PROCEDURE toon_laatste_emp
IS
	v_employee_id	employees.employee_id%type;
	v_last_name	employees.last_name%type;
	v_hire_date	employees.hire_date%type;
BEGIN
	SELECT employee_id, last_name, hire_date
	into v_employee_id, v_last_name, v_hire_date
	from employees
	where hire_date = (select MAX(hire_date) from employees);
	DBMS_OUTPUT.PUT_LINE(v_employee_id ||' '|| v_last_name ||' '|| v_hire_date);
END;
/

/*Schrijf een procedure ‘toon_laatste_emp’ die in de medewerkerstabel zoekt naar de laatst 
aangeworven medewerker. Toon het nummer, de naam en de aanwervingsdatum van deze 
medewerker.   
Alvorens de procedure uit te voeren, geef je het volgende in: 
UPDATE employees 
SET hire_date = '20‐apr‐00' 
WHERE employee_id =173; 
Deze procedure kan je uitvoeren door op de SQL‐prompt in te tikken: 
SQL> exec toon_laatste_emp */