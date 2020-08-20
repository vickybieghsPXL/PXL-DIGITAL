SELECT vakantie_id, vakantie_type, TO_CHAR(van, 'YYYY MON DD') "Datum vertrek"
FROM vakanties
WHERE TO_CHAR(van, 'fmMONTH') IN ('JULY', 'APRIL')
	AND verbl_id = (SELECT verbl_id FROM verblijfplaatsen WHERE UPPER(verbl_naam) = 'TER HEIDE');