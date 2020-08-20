INSERT INTO inschrijvingen
VALUES (inschrijving_id_seq.NEXTVAL, 144, 2012, sysdate, 0);

INSERT INTO inschrijvingen_kindgegevens
	SELECT 83, kind_voornaam, kind_naam, geboortedatum, lengte, schoenmaat, cm_lid
	FROM inschrijvingen_kindgegevens
	WHERE inschr_id = 45
		AND TO_CHAR(geboortedatum, 'fmYYYY') = '2007';
		
DELETE FROM inschrijvingen_kindgegevens
WHERE inschr_id = 83;
DELETE FROM inschrijvingen
WHERE inschrijving_id = (SELECT MAX(inschrijving_id) FROM inschrijvingen);