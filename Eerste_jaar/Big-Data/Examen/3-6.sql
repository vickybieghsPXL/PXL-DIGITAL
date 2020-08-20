CREATE OR REPLACE PROCEDURE asterisk_sal
	(p_emp_id	in	employees.employee_id%type,
	p_sterren 	out 	varchar2)
...

*
DECLARE 
	v_sterren	varchar2(25);
BEGIN
	asterisk_sal(100, v_sterren)
	DBMS_OUTPUT.PUT_LINE(v_sterren);
END;
/
*
variable b_sterren varchar2
exec asterisk_sal(100, :b_sterren)

/*Wijzig de procedure uit opdracht 5 zodat het calling program het aantal sterretjes terugkrijgt en dit 
afdrukt: 
 via een anoniem block 
 via een bind‐variable 
Voer dit uit voor personeelslid met nummer 100. */