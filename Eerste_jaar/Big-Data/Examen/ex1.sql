CREATE OR REPLACE PROCEDURE plan_1tin_zit2
    (    p_year     IN     NUMBER    )
AS
    v_exam_date     DATE     := TO_DATE('1508', 'DDMM') + 2;
BEGIN
    FOR rec IN (    SELECT olodcode
                    FROM olods
                    WHERE olodcode LIKE '%1TIN%'    )
    LOOP
        WHILE TO_CHAR(v_exam_date, 'DY') = 'SUN' OR TO_CHAR(v_exam_date, 'DY') = 'SAT' LOOP
            v_exam_date := v_exam_date + 1;
        END LOOP;
        
        INSERT INTO examendatum_olod (acjaar, examenmaand, olodcode, exdatum)
        VALUES (p_year - 1 || ' - ' || p_year, 'aug-sep', rec.olodcode, v_exam_date);
        
        v_exam_date := v_exam_date + 1;
    END LOOP;
END;
/