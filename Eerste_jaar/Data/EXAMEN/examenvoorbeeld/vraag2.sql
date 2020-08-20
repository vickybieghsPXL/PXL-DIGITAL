SELECT i.vak_id, i.boekingsdatum, klant.klant_naam, klant.klant_voornaam
		, ik.kind_voornaam, DECODE(ik.cm_lid, 'J', 'CM lid', 'N', 'geen lid')
FROM inschrijvingen i JOIN klanten klant ON klant.klant_id = i.klant_id 
						JOIN inschrijvingen_kindgegevens ik ON ik.inschr_id = i.inschrijving_id
WHERE klant.klant_id = '&klant_id';