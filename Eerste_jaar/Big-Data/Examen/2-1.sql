create or replace function dagen_einde_maand
return varchar2
AS
	v_aantal        varchar2(5);
BEGIN
v_aantal := last_day(sysdate) - sysdate;
RETURN v_aantal;
END;
/