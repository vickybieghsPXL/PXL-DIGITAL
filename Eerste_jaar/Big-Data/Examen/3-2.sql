CREATE OR REPLACE PROCEDURE grootste_dept
AS
	v_department_id		employees.department_id%type;
	v_first_name		employees.first_name%type;
	v_last_name		employees.last_name%type;
	v_salary		employees.salary%type;
	v_department_name	departments.department_name%type;
BEGIN
	SELECT department_id, department_name
	into v_department_id, v_department_name
	from departments d join employees e
	using (department_id)
	group by department_id, department_name
	having COUNT(e.employee_id) = (select MAX(COUNT(*)) from employees group by department_id);
	
	SELECT first_name, last_name, salary
	INTO v_first_name, v_last_name, v_salary
	from employees e join departments d
	using (department_id)
	where department_name = v_department_name AND
	e.salary = (select MAX(salary) from employees where department_id = v_department_id);

	DBMS_OUTPUT.PUT_LINE('Departemtent: '||v_department_name ||' Hoogste salaris: '|| v_first_name ||' '||v_last_name||' '||v_salary);
END;
/
/*Schrijf een procedure (grootste_dept) die de departementsnaam van het departement met de 
meeste employees opzoekt en van dit departement de naam afdrukt samen met de naam, voornaam 
en het salaris van de employee uit dit departement met het hoogste salaris.  
Deze procedure kan je uitvoeren door op de SQL‐prompt in te tikken: 
SQL> exec grootste_dept 
*/