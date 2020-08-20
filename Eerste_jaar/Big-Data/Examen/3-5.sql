CREATE OR REPLACE PROCEDURE asterisk_sal
	(p_emp_id	in	employees.employee_id%type)
IS
	v_salaris	employees.salary%type;
	v_sterren	VARCHAR2(25) := '';
BEGIN
	select salary
	into v_salaris
	from employees
	where employee_id = p_emp_id;
	
	WHILE v_salaris >= 1000 LOOP
		v_sterren := v_sterren ||'*';
		v_salaris := v_salaris - 1000;
	END LOOP;

	DBMS_OUTPUT.PUT_LINE(v_sterren);
END;
/
/*Maak een procedure (asterisk_sal) die van een opgegeven werknemer (employee_id) het salaris in 
sterretjes afdrukt. Elke ster vertegenwoordigt 1000 euro. 
Deze procedure kan je uitvoeren door aan de SQL‐prompt in te tikken: 
SQL> exec asterisk_sal(100) */