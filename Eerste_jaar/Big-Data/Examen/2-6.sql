CREATE OR REPLACE FUNCTION next_employee_id
RETURN number
AS
	v_emp_id	number(6);
BEGIN
	select MAX(employee_id)
	into v_emp_id
	from employees;
	v_emp_id := v_emp_id + 1;
	RETURN v_emp_id;
END;
/

/*Stel dat er geen sequence is om een id voor nieuwe employees toe te kennen. 
Maak een functie ‘next_employee_id’ die het hoogste employee_id ophaalt, dit ophoogt met 1 en 
die waarde terugstuurt. */