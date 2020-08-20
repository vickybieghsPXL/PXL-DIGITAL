DROP TABLE artikels CASCADE CONSTRAINTS;

REM   creatie tabel artikels met kolomconstraints

CREATE TABLE artikels
(artikel_id 	varchar2(10) 
	CONSTRAINT art_id_pk PRIMARY KEY
,artikel_naam 	varchar2(30) 
	CONSTRAINT art_nm_nn NOT NULL
,prijs 		NUMBER(8,2)
	CONSTRAINT art_prijs_chk CHECK (prijs > 0.5)
,bestaat_sinds	DATE DEFAULT sysdate
,land_fabricage	CHAR(2) 
	CONSTRAINT art_land_fabr_fk REFERENCES countries)
;

REM creatie tabel artikels met tabelconstraints
REM CREATE TABLE artikels
REM (artikel_id 	varchar2(10)
REM ,artikel_naam 	varchar2(30) NOT NULL
REM ,prijs 		NUMBER(8,2)
REM ,bestaat_sinds	DATE DEFAULT sysdate
REM ,land_fabricage	CHAR(2) 
REM ,CONSTRAINT art_id_pk PRIMARY KEY(artikel_id)
REM ,CONSTRAINT art_prijs_chk CHECK (prijs > 0.5)
REM ,CONSTRAINT art_land_fabr_fk FOREIGN KEY (land_fabricage) REM REFERENCES countries)
REM ;

DROP TABLE magazijn CASCADE CONSTRAINTS;

CREATE TABLE magazijn
(magazijn_id	NUMBER(2) CONSTRAINT mag_id_pk PRIMARY KEY
,magazijn_naam	VARCHAR2(15)
,straat		VARCHAR2(25)
,huisnummer	NUMBER(4)
,gemeente	VARCHAR2(25))
;

DROP TABLE magazijn_artikels CASCADE CONSTRAINTS;

CREATE TABLE magazijn_artikels
(magazijn_id	NUMBER(2) CONSTRAINT mag_art_mag_id_fk 
	REFERENCES magazijn(magazijn_id)
,artikel_id	VARCHAR2(10) CONSTRAINT mag_art_artid_fk
	REFERENCES artikels(artikel_id)
,hoeveelheid NUMBER(4)
,CONSTRAINT mag_art_magid_artid_pk PRIMARY KEY(magazijn_id,artikel_id))
;


