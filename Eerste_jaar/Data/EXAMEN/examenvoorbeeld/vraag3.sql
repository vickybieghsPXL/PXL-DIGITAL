CREATE TABLE med_info2017
	(	klant_id			VARCHAR2(20)
			CONSTRAINT med17_kl_id_fk references klanten(klant_id)
	,	registratie_datum	DATE
	,	info				VARCHAR2(100)
			CONSTRAINT med17_in_nn NOT NULL
	, 	datum_attest		DATE
			CONSTRAINT med17_dat_att_ck	CHECK (TO_CHAR(datum_attest, 'YYYY') = '2017')
			CONSTRAINT med17_dat_att_nn NOT NULL
	,
		CONSTRAINT med17_kl_id_reg_dat_pk PRIMARY KEY (klant_id, registratie_datum)
	);