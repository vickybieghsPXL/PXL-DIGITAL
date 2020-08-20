CREATE OR REPLACE FUNCTION hoofd_meeste_werkn
return varchar2
AS
	v_aantal	number;
	v_first		employees.first_name%type;
	v_last		employees.last_name%type;
	v_manager_id	employees.manager_id%type;
	v_dep_id	employees.department_id%type;
BEGIN
	select department_id, COUNT(employee_id)
	into v_dep_id, v_aantal
	from employees
	group by department_id
	having COUNT(employee_id) = (select MAX(COUNT(employee_id)) from employees group by department_id);

	select manager_id
	into v_manager_id
	from departments
	where department_id = v_dep_id;
	
	select first_name, last_name
	into v_first, v_last
	from employees
	where employee_id = v_manager_id;
	
	return v_first||' '||v_last;
END;
/

/*Maak een functie die de naam en voornaam teruggeeft van de persoon die hoofd is van de afdeling 
waar de meeste werknemers werken. */