CREATE OR REPLACE TRIGGER bis_inschrijven
BEFORE
INSERT ON klas_perstudent_perolod
FOR EACH ROW
BEGIN
    IF sysdate > TO_DATE(SUBSTR(:NEW.acjaar, -4, 4) || '0109', 'YYYYDDMM') THEN
        RAISE_APPLICATION_ERROR(-20000, 'U kan zich niet inschrijven voor een acjaar dat al voorbij is');
    END IF;
END;
/