CREATE OR REPLACE VIEW kla_reizen
	AS SELECT k.klant_id, k.klant_naam, l.landnaam, SUBSTR(k.klant_email, INSTR(k.klant_email, '@')) EMAILSERVICE, i.vak_id
		FROM klanten k JOIN gemeenten g ON g.gemeente_id = k.klant_gemeente_id
						JOIN landen l ON l.land_id = g.land_id
						JOIN inschrijvingen i ON i.klant_id = k.klant_id;