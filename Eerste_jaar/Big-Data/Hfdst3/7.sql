CREATE OR REPLACE PROCEDURE landenlijst

AS
    v_aantal number(4);
BEGIN
SELECT COUNT(country_name) into v_aantal from countries;
        for land in(select country_name from countries)
        LOOP DBMS_OUTPUT.PUT_LINE(land.country_name);
        END LOOP;
DBMS_OUTPUT.PUT_LINE('we hebben connecties in ' || v_aantal || ' landen.');


END;
/