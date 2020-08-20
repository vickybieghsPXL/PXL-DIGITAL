CREATE OR REPLACE PROCEDURE country_dept
	(p_landid	in	countries.country_id%type)
IS
	v_max	number(5) := 0;
BEGIN
	select count(location_id)
	into v_max
	from departments join locations using(location_id)
	where country_id = p_landid;
	
	if v_max = 0 then
		DBMS_OUTPUT.PUT_LINE('er zijn geen departementen gevestigd in het land met id '||p_landid);
	else
		for rec in (
		select department_name
		from departments d join locations l using(location_id)
		where country_id = p_landid)
		loop
			DBMS_OUTPUT.PUT_LINE(rec.department_name);
		end loop;
	end if;
END;
/
/*Maak een procedure die kan opgeroepen worden met de naam “country_dept” en die een land_id 
mee krijgt vanuit het calling programma. 
Deze procedure moet alle departementnamen gevestigd in dit land onder elkaar afdrukken. 
Indien er geen enkel departement gevestigd is in dit land dan moet er worden afgedrukt: “Er zijn 
geen departementen gevestigd in het land met id ……[land_id]”. */