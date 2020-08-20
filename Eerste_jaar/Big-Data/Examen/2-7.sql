CREATE OR REPLACE FUNCTION jaarloon
	(p_emp_id employees.employee_id%type)
RETURN NUMBER
AS
	v_sal		employees.salary%type;
	v_comm		employees.commission_pct%type;
	v_jaarsal	number;
BEGIN
	SELECT salary, commission_pct
	INTO v_sal, v_comm
	FROM employees
	WHERE employee_id = p_emp_id;
	v_jaarsal := (v_sal + v_sal * NVL(v_comm, 0)) * 12;
	RETURN v_jaarsal;
END;
/

/*Maak een functie voor de berekening van het (bruto)jaarloon van een werknemer. 
Houd hierbij rekening met het commissiepercentage. 
Als parameter komt het employee_id van de werknemer binnen. */