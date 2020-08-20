REM   Script:   creatie tabellen voor sport Hasselt

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO OFF 
CLEAR SCREEN

REM *******************************************************************
REM drop tables
REM *******************************************************************
DROP table reservations cascade constraints;
DROP table subscription_dates cascade constraints;
DROP table activity_dates cascade constraints;
DROP table activities cascade constraints;
DROP table sports cascade constraints;
DROP table locations cascade constraints;
DROP table address_members cascade constraints;
DROP table address_types cascade constraints;
DROP table members cascade constraints;
DROP table addresses cascade constraints;
DROP TABLE zip_codes cascade constraints;
DROP TABLE countries cascade constraints;

Prompt ******  Creating countries table....

CREATE TABLE countries 
    ( country_id                 VARCHAR2(2)
		   CONSTRAINT  cou_PK PRIMARY KEY 
    , country                     VARCHAR2(25)
	           CONSTRAINT  cou_cntry_nn  NOT NULL
    ) ;


Prompt ******  Creating zip_codes table....
-- ook Nederlandse postcodes zijn toegelaten

CREATE TABLE zip_codes
    ( zip_code     VARCHAR2(7)
		   CONSTRAINT  zip_PK PRIMARY KEY 
		   CONSTRAINT  zip_code_chk CHECK (to_number(substr(zip_code,1,4)) >= 1000)
    , city         VARCHAR2(25)
	           CONSTRAINT  zip_city_nn  NOT NULL
    , country_id   VARCHAR2(2)
		   CONSTRAINT  zip_ctry_FK  REFERENCES countries 
	           CONSTRAINT  zip_ctry_nn  NOT NULL
    ) ;

Prompt ******  Creating addresses table ....

CREATE TABLE addresses 
    ( address_id   NUMBER(6) 
                   CONSTRAINT  add_PK PRIMARY KEY
    , street       VARCHAR2(40) 
		   CONSTRAINT  add_str_nn  NOT NULL
    , housenumber  NUMBER(4)
    , letterbox    VARCHAR2(4)
    , zip_code     VARCHAR2(7)
		   CONSTRAINT  add_zip_FK  REFERENCES zip_codes
		   CONSTRAINT  add_zip_nn  NOT NULL
    );

Prompt ******  Creating members table ....

CREATE TABLE members 
     ( national_id       VARCHAR2(11)      
	                 CONSTRAINT  mem_PK PRIMARY KEY 
     , firstname         VARCHAR2(25)
		         CONSTRAINT  mem_fname_nn  NOT NULL
     , lastname          VARCHAR2(25)
		         CONSTRAINT  mem_lname_nn  NOT NULL
     , nationality       VARCHAR2(25) 
     , email             VARCHAR2(40) 
                         CONSTRAINT  mem_email_chk CHECK (email like '%@%.%')
     , sex               VARCHAR2(1)
                         CONSTRAINT  mem_sex_chk CHECK (sex IN ('M', 'V'))
     , national_id_payer VARCHAR2(11)
		         CONSTRAINT  mem_pay_nn  NOT NULL
		         CONSTRAINT  mem_natid_fk  REFERENCES members
     , tijdelijk         NUMBER(3)
     ) ;
	

Prompt ******  Creating address_types ....

CREATE TABLE address_types
    ( address_type        VARCHAR2(1)      
	                  CONSTRAINT  addty_PK PRIMARY KEY 
    , address_description VARCHAR2(25)
		          CONSTRAINT  addty_des_nn  NOT NULL
    ) ;


Prompt ******  Creating address_members table ....

CREATE TABLE address_members
    ( national_id    VARCHAR2(11) 
		     CONSTRAINT  addmem_natid_fk  REFERENCES members
    , address_type   VARCHAR2(1)    
		     CONSTRAINT  addmem_addty_fk  REFERENCES address_types
    , address_id     NUMBER(6) 
	             CONSTRAINT  addmem_addty_nn  NOT NULL
		     CONSTRAINT  addmem_add_fk  REFERENCES addresses
    , CONSTRAINT  addmem_PK PRIMARY KEY(national_id, address_type)
    ) ;
	
Prompt ******  Creating locations table ....

CREATE TABLE locations 
    ( location_id    VARCHAR2(3)      
	             CONSTRAINT  loc_PK PRIMARY KEY 
    , location_name  VARCHAR2(40) 
    , location_info  VARCHAR2(60) 
    , address_id     NUMBER(6) 
		     CONSTRAINT  loc_add_fk  REFERENCES addresses
    );

Prompt ******  Creating sports table ....

CREATE TABLE sports 
    ( sport_type     VARCHAR2(3)      
	             CONSTRAINT  sport_PK PRIMARY KEY 
                     CONSTRAINT  sport_ty_chk CHECK(sport_type = upper(sport_type))
    , sport_name     VARCHAR2(40)
	             CONSTRAINT  sport_name_nn  NOT NULL 
    , description    VARCHAR2(200) 
	             CONSTRAINT  sport_desc_nn  NOT NULL
    );

Prompt ******  Creating activities table ....

CREATE TABLE activities 
    ( sport_id             VARCHAR2(12)      
	                   CONSTRAINT  act_PK PRIMARY KEY 
    , sport_type           VARCHAR2(3)
	                   CONSTRAINT  act_spty_nn  NOT NULL 
		           CONSTRAINT  act_spty_fk  REFERENCES sports 
    , startyear            NUMBER(4) 
	                   CONSTRAINT  act_syear_nn  NOT NULL
    , endyear              NUMBER(4) 
	                   CONSTRAINT  act_eyear_nn  NOT NULL
    , partner              VARCHAR2(40) 
    , location_id          VARCHAR2(3) 
	                   CONSTRAINT  act_locid_nn  NOT NULL
		           CONSTRAINT  act_locid_fk  REFERENCES locations
    , max_participants     NUMBER(3) 
	                   CONSTRAINT  act_max_nn  NOT NULL
                           CONSTRAINT  act_max_chk CHECK(max_participants between 10 and 200)
    , starttime            DATE
	                   CONSTRAINT  act_stime_nn  NOT NULL	
    , endtime              DATE
	                   CONSTRAINT  act_etime_nn  NOT NULL	             
    , price                NUMBER(5, 2) 
	                   CONSTRAINT  act_price_nn  NOT NULL
                           CONSTRAINT  act_price_chk CHECK(price between 0 and 100)
    , subscription_enddate DATE
	                   CONSTRAINT  act_sedate_nn  NOT NULL
    );

Prompt ******  Creating activity_dates table ....

CREATE TABLE activity_dates 
    ( sport_id             VARCHAR2(12) 
		           CONSTRAINT  actdat_spid_fk  REFERENCES activities
    , sport_date           DATE
    , CONSTRAINT actdat_pk PRIMARY key (sport_id, sport_date)
    );

Prompt ******  Creating subscription_dates table ....

CREATE TABLE subscription_dates 
    ( sport_id               VARCHAR2(12) 
		             CONSTRAINT  subdat_spid_fk  REFERENCES activities
    , inhabitant             VARCHAR2(1)
		             CONSTRAINT  subdat_inh_chk  CHECK(inhabitant IN ('H','A')) -- H=hasselaar, A=allen
    , subscription_startdate DATE
    , CONSTRAINT subdat_pk PRIMARY key (sport_id, inhabitant)
    );

Prompt ******  Creating reservations table ....

CREATE TABLE reservations 
    ( national_id    VARCHAR2(11) 
		     CONSTRAINT  res_natid_fk  REFERENCES members
    , sport_id       VARCHAR2(12) 
		     CONSTRAINT  res_spid_fk  REFERENCES activities
    , CONSTRAINT res_pk PRIMARY key (national_id, sport_id)
    );


Prompt ********************************************
Prompt --> insert data into the tables
Prompt ********************************************


Prompt --> insert data into the countries table
INSERT INTO countries VALUES('BE', 'België');
INSERT INTO countries VALUES('NL', 'Nederland');


Prompt --> insert data into the zip_codes table
INSERT INTO zip_codes VALUES(3400, 'Landen', 'BE');
INSERT INTO zip_codes VALUES(3500, 'Hasselt', 'BE');
INSERT INTO zip_codes VALUES(3501, 'Wimmertingen', 'BE');
INSERT INTO zip_codes VALUES(3510, 'Kermt', 'BE');
INSERT INTO zip_codes VALUES(3511, 'Kuringen', 'BE');
INSERT INTO zip_codes VALUES(3512, 'Stevoort', 'BE');
INSERT INTO zip_codes VALUES(3600, 'Genk', 'BE');
INSERT INTO zip_codes VALUES(3700, 'Tongeren', 'BE');
INSERT INTO zip_codes VALUES(3800, 'St-Truiden', 'BE');
INSERT INTO zip_codes VALUES(3850, 'Nieuwerkerken', 'BE');
INSERT INTO zip_codes VALUES('6131 SE', 'Sittard', 'NL');
INSERT INTO zip_codes VALUES('6100 AC', 'Echt', 'NL');


Prompt --> insert data into the addresses table
INSERT INTO addresses VALUES(1, 'Koning Boudewijnlaan', 22, null , 3500);
INSERT INTO addresses VALUES(2, 'Tulpinstraat', 42, null , 3500);

INSERT INTO addresses VALUES(100, 'Lentestraat', 26, null , 3500);
INSERT INTO addresses VALUES(101, 'Elfde-Liniestraat', 26, null , 3500);
INSERT INTO addresses VALUES(102, 'stadswegske', 54, 'b', '6131 SE');
INSERT INTO addresses VALUES(103, 'kerkstraat', 39, null, '6100 AC');
INSERT INTO addresses VALUES(104, 'Elfde-Liniestraat', 18, '1a' , 3500);
INSERT INTO addresses VALUES(105, 'Elfde-Liniestraat', 20, '5d' , 3500);

INSERT INTO addresses  VALUES(	106	,	'Gouverneur Roppesingel'	,	91	,	null	,	3500	);
INSERT INTO addresses  VALUES(	107	,	'Alkenstraat'	,	54	,	'b'	,	3500	);
INSERT INTO addresses  VALUES(	108	,	'Alverbergstraat'	,	183	,	'd'	,	3500	);
INSERT INTO addresses  VALUES(	109	,	'Ambachtsschoolstraat'	,	198	,	null	,	3500	);
INSERT INTO addresses  VALUES(	110	,	'Anne Frankplein'	,	173	,	null	,	3500	);
INSERT INTO addresses  VALUES(	111	,	'Crutzenstraat'	,	45	,	null	,	3500	);
INSERT INTO addresses  VALUES(	112	,	'De Cottereaustraat'	,	57	,	null	,	3500	);
INSERT INTO addresses  VALUES(	113	,	'De Jef-swennenstraat'	,	146	,	null	,	3500	);
INSERT INTO addresses  VALUES(	114	,	'De Libottonstraat'	,	45	,	null	,	3500	);
INSERT INTO addresses  VALUES(	115	,	'De Schiervellaan'	,	179	,	null	,	3500	);
INSERT INTO addresses  VALUES(	116	,	'Deken Habrakenstraat'	,	10	,	null	,	3500	);
INSERT INTO addresses  VALUES(	117	,	'Demerstraat'	,	142	,	null	,	3500	);
INSERT INTO addresses  VALUES(	118	,	'Diepenbekerweg'	,	182	,	null	,	3500	);
INSERT INTO addresses  VALUES(	119	,	'Diepstraat'	,	187	,	'd'	,	3500	);
INSERT INTO addresses  VALUES(	120	,	'Diestersteenweg'	,	95	,	null	,	3500	);
INSERT INTO addresses  VALUES(	121	,	'Beerhoutstraat'	,	128	,	null	,	3500	);
INSERT INTO addresses  VALUES(	122	,	'Berenbroekstraat'	,	120	,	null	,	3500	);
INSERT INTO addresses  VALUES(	123	,	'Bergstraat'	,	63	,	null	,	3500	);
INSERT INTO addresses  VALUES(	124	,	'Berkenlaan'	,	81	,	null	,	3500	);
INSERT INTO addresses  VALUES(	125	,	'Bijvennestraat'	,	92	,	null	,	3500	);
INSERT INTO addresses  VALUES(	126	,	'Blijde-inkomststraat'	,	175	,	'b'	,	3500	);
INSERT INTO addresses  VALUES(	127	,	'Bloemenhofstraat'	,	115	,	'd'	,	3500	);
INSERT INTO addresses  VALUES(	128	,	'Boerenkrijgsingel'	,	102	,	null	,	3500	);
INSERT INTO addresses  VALUES(	129	,	'Bonnefantenstraat'	,	125	,	null	,	3500	);
INSERT INTO addresses  VALUES(	130	,	'Hoogstraat'	,	9	,	null	,	3500	);
INSERT INTO addresses  VALUES(	131	,	'Hoogveld'	,	32	,	'2c'	,	3501	);
INSERT INTO addresses  VALUES(	132	,	'Borggravevijverstraat'	,	113	,	null	,	3510	);
INSERT INTO addresses  VALUES(	133	,	'Bosstraat'	,	8	,	null	,	3511	);
INSERT INTO addresses  VALUES(	134	,	'Botermarkt'	,	31	,	'b'	,	3512	);
INSERT INTO addresses  VALUES(	135	,	'Breestraat'	,	65	,	'd'	,	3500	);
INSERT INTO addresses  VALUES(	136	,	'Burgemeester Bollenstraat'	,	140	,	null	,	3500	);
INSERT INTO addresses  VALUES(	137	,	'Casterhovenstraat'	,	180	,	null	,	3500	);
INSERT INTO addresses  VALUES(	138	,	'Coenestraat'	,	142	,	null	,	3500	);
INSERT INTO addresses  VALUES(	139	,	'Consciencelaan'	,	184	,	'2c'	,	3500	);
INSERT INTO addresses  VALUES(	140	,	'Mevrouwhofstraat'	,	156	,	null	,	3500	);
INSERT INTO addresses  VALUES(	141	,	'Minderbroedersstraat'	,	102	,	null	,	3500	);
INSERT INTO addresses  VALUES(	142	,	'Anne Ruttenstraat'	,	117	,	null	,	3500	);
INSERT INTO addresses  VALUES(	143	,	'Koningin Astridlaan'	,	39	,	null	,	3500	);
INSERT INTO addresses  VALUES(	144	,	'Boomkensstraat'	,	106	,	null	,	3500	);
INSERT INTO addresses  VALUES(	145	,	'Bootstraat'	,	168	,	null	,	3500	);
INSERT INTO addresses  VALUES(	146	,	'Kiewitstraat'	,	176	,	null	,	3500	);
INSERT INTO addresses  VALUES(	147	,	'Kiezelstraat'	,	51	,	null	,	3500	);
INSERT INTO addresses  VALUES(	148	,	'Kingstraat'	,	39	,	null	,	3500	);
INSERT INTO addresses  VALUES(	149	,	'Guido Gezellelaan'	,	40	,	'd'	,	3500	);
INSERT INTO addresses  VALUES(	150	,	'Lammerweg'	,	173	,	'b'	,	3500	);
INSERT INTO addresses  VALUES(	151	,	'Diesterstraat'	,	63	,	'd'	,	3500	);
INSERT INTO addresses  VALUES(	152	,	'Dokter Willemsstraat'	,	131	,	null	,	3500	);
INSERT INTO addresses  VALUES(	153	,	'Dorpsstraat'	,	61	,	null	,	3500	);
INSERT INTO addresses  VALUES(	154	,	'Dr. Willemstraat'	,	52	,	null	,	3500	);
INSERT INTO addresses  VALUES(	155	,	'Ekkelgaarden'	,	113	,	'2c'	,	3500	);
INSERT INTO addresses  VALUES(	156	,	'Elfde Liniestraat'	,	70	,	null	,	3500	);
INSERT INTO addresses  VALUES(	157	,	'Elfenbergstraat'	,	200	,	null	,	3500	);
INSERT INTO addresses  VALUES(	158	,	'Ernest Claesstraat'	,	150	,	null	,	3501	);
INSERT INTO addresses  VALUES(	159	,	'Frans Massystraat'	,	185	,	null	,	3510	);
INSERT INTO addresses  VALUES(	160	,	'Frans Tittelmansstraat'	,	62	,	null	,	3511	);
INSERT INTO addresses  VALUES(	161	,	'Fruitmarkt'	,	73	,	null	,	3512	);
INSERT INTO addresses  VALUES(	162	,	'Gaarveldstraat'	,	187	,	null	,	3500	);
INSERT INTO addresses  VALUES(	163	,	'Gebanne-groezenstraat'	,	50	,	null	,	3500	);
INSERT INTO addresses  VALUES(	164	,	'Bedrijfsstraat'	,	43	,	null	,	3500	);
INSERT INTO addresses  VALUES(	165	,	'Gebrandestraat'	,	111	,	'3e'	,	3500	);
INSERT INTO addresses  VALUES(	166	,	'Genkersteenweg'	,	59	,	'd'	,	3500	);
INSERT INTO addresses  VALUES(	167	,	'Gierkensstraat'	,	197	,	null	,	3500	);
INSERT INTO addresses  VALUES(	168	,	'Gladiolenstraat'	,	84	,	null	,	3500	);
INSERT INTO addresses  VALUES(	169	,	'Kleine Breemstraat'	,	95	,	null	,	3500	);
INSERT INTO addresses  VALUES(	170	,	'Gouverneur Verwilghensingel'	,	128	,	'2c'	,	3500	);
INSERT INTO addresses  VALUES(	171	,	'Grasstraat'	,	167	,	null	,	3500	);
INSERT INTO addresses  VALUES(	172	,	'Grote Baan'	,	110	,	null	,	3500	);
INSERT INTO addresses  VALUES(	173	,	'Kermtstraat'	,	117	,	null	,	3500	);
INSERT INTO addresses  VALUES(	174	,	'Kerselaarstraat'	,	115	,	null	,	3500	);
INSERT INTO addresses  VALUES(	175	,	'Guffenslaan'	,	32	,	null	,	3500	);
INSERT INTO addresses  VALUES(	176	,	'Kwakkelstraat'	,	69	,	null	,	3500	);
INSERT INTO addresses  VALUES(	177	,	'Guido Gezellestraat'	,	49	,	null	,	3500	);
INSERT INTO addresses  VALUES(	178	,	'H Van Veldekessingel 150-'	,	7	,	null	,	3500	);
INSERT INTO addresses  VALUES(	179	,	'Haarbemdenstraat'	,	120	,	null	,	3500	);
INSERT INTO addresses  VALUES(	180	,	'Baupslaan'	,	150	,	'3e'	,	3500	);
INSERT INTO addresses  VALUES(	181	,	'Handelskaai'	,	26	,	'2c'	,	3500	);
INSERT INTO addresses  VALUES(	182	,	'Harmoniestraat'	,	108	,	null	,	3500	);
INSERT INTO addresses  VALUES(	183	,	'Lazarijstraat'	,	103	,	null	,	3500	);
INSERT INTO addresses  VALUES(	184	,	'Koorstraat'	,	69	,	null	,	3500	);
INSERT INTO addresses  VALUES(	185	,	'Hasseltse Beverzakstraat'	,	17	,	null	,	3501	);
INSERT INTO addresses  VALUES(	186	,	'Hasseltse Dreef'	,	74	,	null	,	3510	);
INSERT INTO addresses  VALUES(	187	,	'Havenstraat'	,	84	,	null	,	3511	);
INSERT INTO addresses  VALUES(	188	,	'Aspergerijstraat'	,	148	,	null	,	3512	);
INSERT INTO addresses  VALUES(	189	,	'Havermarkt'	,	186	,	null	,	3500	);
INSERT INTO addresses  VALUES(	190	,	'Hazelarenlaan'	,	93	,	null	,	3500	);
INSERT INTO addresses  VALUES(	191	,	'Heidestraat'	,	166	,	null	,	3500	);
INSERT INTO addresses  VALUES(	192	,	'Heilig-hartplein'	,	31	,	null	,	3500	);
INSERT INTO addresses  VALUES(	193	,	'Hellebeemden'	,	47	,	null	,	3500	);
INSERT INTO addresses  VALUES(	194	,	'Hemelrijk'	,	190	,	null	,	3500	);
INSERT INTO addresses  VALUES(	195	,	'Banneuxstraat'	,	23	,	null	,	3500	);
INSERT INTO addresses  VALUES(	196	,	'Hendrik Van Veldekesingel'	,	140	,	null	,	3500	);
INSERT INTO addresses  VALUES(	197	,	'Herckenrodesingel'	,	189	,	'b'	,	3500	);
INSERT INTO addresses  VALUES(	198	,	'Herkenrodesingel'	,	113	,	'd'	,	3500	);
INSERT INTO addresses  VALUES(	199	,	'Arnold Van Loonlaan'	,	175	,	null	,	3500	);
INSERT INTO addresses  VALUES(	200	,	'Herkerstraat'	,	193	,	null	,	3500	);
INSERT INTO addresses  VALUES(	201	,	'Herkkantstraat'	,	42	,	null	,	3500	);
INSERT INTO addresses  VALUES(	202	,	'Het Dorlik'	,	159	,	null	,	3500	);
INSERT INTO addresses  VALUES(	203	,	'Holrakkerstraat'	,	96	,	null	,	3500	);
INSERT INTO addresses  VALUES(	204	,	'Armand Hertzstraat'	,	153	,	null	,	3500	);
INSERT INTO addresses  VALUES(	205	,	'Hommelheide'	,	74	,	null	,	3500	);
INSERT INTO addresses  VALUES(	206	,	'Hoogheide'	,	199	,	null	,	3500	);
INSERT INTO addresses  VALUES(	207	,	'Vaartstraat'	,	16	,	null	,	3500	);
INSERT INTO addresses  VALUES(	208	,	'Slachthuiskaai'	,	126	,	null	,	3500	);
INSERT INTO addresses  VALUES(	209	,	'Huidevetterslaan'	,	68	,	null	,	3511	);
INSERT INTO addresses  VALUES(	210	,	'Huiserveldstraat'	,	106	,	null	,	3512	);
INSERT INTO addresses  VALUES(	211	,	'Ilgatlaan'	,	145	,	null	,	3500	);
INSERT INTO addresses  VALUES(	212	,	'Jannestraat'	,	41	,	null	,	3500	);
INSERT INTO addresses  VALUES(	213	,	'Jeneverplein'	,	82	,	null	,	3500	);
INSERT INTO addresses  VALUES(	214	,	'Jeugdstraat'	,	72	,	null	,	3500	);
INSERT INTO addresses  VALUES(	215	,	'Kanaalstraat'	,	28	,	null	,	3500	);
INSERT INTO addresses  VALUES(	216	,	'Kannaertsstraat'	,	118	,	null	,	3500	);
INSERT INTO addresses  VALUES(	217	,	'Kannaertstraat'	,	183	,	null	,	3500	);
INSERT INTO addresses  VALUES(	218	,	'Kapelhofstraat'	,	174	,	null	,	3500	);
INSERT INTO addresses  VALUES(	219	,	'Kapelstraat'	,	58	,	null	,	3500	);
INSERT INTO addresses  VALUES(	220	,	'Kastanjelaan'	,	23	,	null	,	3500	);
INSERT INTO addresses  VALUES(	221	,	'Kattegatstraat'	,	130	,	null	,	3500	);
INSERT INTO addresses  VALUES(	222	,	'Grote Markt'	,	26	,	null	,	3500	);
INSERT INTO addresses  VALUES(	223	,	'Grote Negenbundersstraat'	,	85	,	null	,	3500	);
INSERT INTO addresses  VALUES(	224	,	'Overdemerstraat'	,	164	,	null	,	3500	);
INSERT INTO addresses  VALUES(	225	,	'Roode Roosstraat'	,	28	,	null	,	3500	);
INSERT INTO addresses  VALUES(	226	,	'Rozenstraat'	,	8	,	null	,	3500	);
INSERT INTO addresses  VALUES(	227	,	'Kempische Kaai'	,	100	,	null	,	3500	);
INSERT INTO addresses  VALUES(	228	,	'Oudstrijderslaan'	,	152	,	null	,	3500	);
INSERT INTO addresses  VALUES(	229	,	'Voogdijstraat'	,	61	,	'b'	,	3511	);
INSERT INTO addresses  VALUES(	230	,	'Voorstraat'	,	129	,	'd'	,	3512	);
INSERT INTO addresses  VALUES(	231	,	'Kunstlaan'	,	158	,	null	,	3500	);
INSERT INTO addresses  VALUES(	232	,	'Kuringersteenweg'	,	80	,	null	,	3500	);
INSERT INTO addresses  VALUES(	233	,	'Sint-maartenplein'	,	55	,	null	,	3500	);
INSERT INTO addresses  VALUES(	234	,	'Sint-truidersteenweg'	,	140	,	null	,	3500	);
INSERT INTO addresses  VALUES(	235	,	'Lombaardstraat'	,	133	,	null	,	3500	);
INSERT INTO addresses  VALUES(	236	,	'Luchtvaartstraat'	,	150	,	null	,	3500	);
INSERT INTO addresses  VALUES(	237	,	'Koning Boudewijnlaan'	,	159	,	null	,	3500	);
INSERT INTO addresses  VALUES(	238	,	'Kramerslaan'	,	124	,	null	,	3500	);
INSERT INTO addresses  VALUES(	239	,	'Kroonwinningstraat'	,	99	,	null	,	3500	);
INSERT INTO addresses  VALUES(	240	,	'Vliegeneinde'	,	71	,	null	,	3500	);
INSERT INTO addresses  VALUES(	241	,	'Vlindersstraat'	,	55	,	null	,	3500	);
INSERT INTO addresses  VALUES(	242	,	'Volderslaan'	,	197	,	null	,	3500	);
INSERT INTO addresses  VALUES(	243	,	'Maastrichterstraat'	,	41	,	null	,	3500	);
INSERT INTO addresses  VALUES(	244	,	'Manteliusstraat'	,	189	,	null	,	3500	);
INSERT INTO addresses  VALUES(	245	,	'Vorststraat'	,	42	,	null	,	3500	);
INSERT INTO addresses  VALUES(	246	,	'Sint-jozefsstraat'	,	199	,	null	,	3500	);
INSERT INTO addresses  VALUES(	247	,	'Sint-jozefstraat'	,	98	,	null	,	3500	);
INSERT INTO addresses  VALUES(	248	,	'Sint-katarinaplein'	,	100	,	null	,	3500	);
INSERT INTO addresses  VALUES(	249	,	'Pietelbeekstraat'	,	130	,	null	,	3500	);
INSERT INTO addresses  VALUES(	250	,	'Pijpersveldstraat'	,	113	,	null	,	3500	);
INSERT INTO addresses  VALUES(	251	,	'Tulpinstraat'	,	103	,	null	,	3500	);
INSERT INTO addresses  VALUES(	252	,	'Valeriaanstraat'	,	149	,	null	,	3500	);
INSERT INTO addresses  VALUES(	253	,	'Sittardlaan'	,	176	,	null	,	3511	);
INSERT INTO addresses  VALUES(	254	,	'Maastricherstwg'	,	49	,	null	,	3511	);
INSERT INTO addresses  VALUES(	255	,	'Maastrichtersteenweg'	,	51	,	null	,	3512	);
INSERT INTO addresses  VALUES(	256	,	'Sint-corneliusstraat'	,	189	,	null	,	3500	);
INSERT INTO addresses  VALUES(	257	,	'Sint-hubertusplein'	,	105	,	null	,	3500	);
INSERT INTO addresses  VALUES(	258	,	'Martelarenlaan'	,	144	,	null	,	3500	);
INSERT INTO addresses  VALUES(	259	,	'Massinweg'	,	62	,	null	,	3500	);
INSERT INTO addresses  VALUES(	260	,	'Mechelsestraat'	,	81	,	null	,	3500	);
INSERT INTO addresses  VALUES(	261	,	'Meeuwenlaan'	,	188	,	'b'	,	3500	);
INSERT INTO addresses  VALUES(	262	,	'Melbeekstraat'	,	82	,	'd'	,	3500	);
INSERT INTO addresses  VALUES(	263	,	'Meldertstraat'	,	19	,	null	,	3500	);
INSERT INTO addresses  VALUES(	264	,	'Melkvoetstraat'	,	3	,	null	,	3500	);
INSERT INTO addresses  VALUES(	265	,	'Mettestraat'	,	126	,	null	,	3500	);
INSERT INTO addresses  VALUES(	266	,	'Schouterveldstraat'	,	141	,	null	,	3500	);
INSERT INTO addresses  VALUES(	267	,	'Schrijnwerkersstraat'	,	48	,	null	,	3500	);
INSERT INTO addresses  VALUES(	268	,	'Minderbroederstraat'	,	119	,	null	,	3500	);
INSERT INTO addresses  VALUES(	269	,	'Molenpoort'	,	61	,	null	,	3500	);
INSERT INTO addresses  VALUES(	270	,	'Molenstraat'	,	121	,	null	,	3500	);
INSERT INTO addresses  VALUES(	271	,	'Mombeekdreef'	,	156	,	null	,	3500	);
INSERT INTO addresses  VALUES(	272	,	'Monerikstraat'	,	177	,	null	,	3500	);
INSERT INTO addresses  VALUES(	273	,	'Muggenstraat'	,	63	,	null	,	3500	);
INSERT INTO addresses  VALUES(	274	,	'Badderijstraat'	,	49	,	null	,	3500	);
INSERT INTO addresses  VALUES(	275	,	'Bakkerslaan'	,	50	,	null	,	3500	);
INSERT INTO addresses  VALUES(	276	,	'Nieuwe-winningstraat'	,	103	,	null	,	3500	);
INSERT INTO addresses  VALUES(	277	,	'Nieuwstraat'	,	147	,	null	,	3500	);
INSERT INTO addresses  VALUES(	278	,	'Nijverheidspark'	,	7	,	null	,	3511	);
INSERT INTO addresses  VALUES(	279	,	'Olmenstraat'	,	36	,	null	,	3512	);
INSERT INTO addresses  VALUES(	280	,	'Ondernemerspark'	,	50	,	null	,	3500	);
INSERT INTO addresses  VALUES(	281	,	'Oude Heidestraat'	,	199	,	null	,	3500	);
INSERT INTO addresses  VALUES(	282	,	'Oude Kuringerbaan'	,	21	,	null	,	3500	);
INSERT INTO addresses  VALUES(	283	,	'Oude Luikerbaan'	,	83	,	null	,	3500	);
INSERT INTO addresses  VALUES(	284	,	'Oude Truierbaan'	,	70	,	null	,	3500	);
INSERT INTO addresses  VALUES(	285	,	'Scheepvaartkaai'	,	81	,	null	,	3500	);
INSERT INTO addresses  VALUES(	286	,	'Schimpenstraat'	,	77	,	null	,	3500	);
INSERT INTO addresses  VALUES(	287	,	'Paalsteenstraat'	,	5	,	null	,	3500	);
INSERT INTO addresses  VALUES(	288	,	'Paardsdemerstraat'	,	96	,	null	,	3500	);
INSERT INTO addresses  VALUES(	289	,	'Padenstraat'	,	177	,	null	,	3500	);
INSERT INTO addresses  VALUES(	290	,	'Paenhuisstraat'	,	80	,	null	,	3500	);
INSERT INTO addresses  VALUES(	291	,	'Paggestraat'	,	111	,	null	,	3500	);
INSERT INTO addresses  VALUES(	292	,	'Pallekensbergstraat'	,	106	,	null	,	3500	);
INSERT INTO addresses  VALUES(	293	,	'Pastorijstraat'	,	42	,	'b'	,	3500	);
INSERT INTO addresses  VALUES(	294	,	'Pater Adonsstraat'	,	155	,	'd'	,	3500	);
INSERT INTO addresses  VALUES(	295	,	'Paul Bellefroidlaan'	,	43	,	null	,	3500	);
INSERT INTO addresses  VALUES(	296	,	'Pelgrimlaan'	,	182	,	null	,	3500	);
INSERT INTO addresses  VALUES(	297	,	'Persoonstraat'	,	116	,	null	,	3500	);
INSERT INTO addresses  VALUES(	298	,	'Pierre Coxstraat'	,	16	,	null	,	3500	);
INSERT INTO addresses  VALUES(	299	,	'Stokrooieweg'	,	38	,	null	,	3500	);
INSERT INTO addresses  VALUES(	300	,	'Ten Hove'	,	108	,	null	,	3500	);
INSERT INTO addresses  VALUES(	301	,	'Platte Vijversstraat'	,	132	,	null	,	3500	);
INSERT INTO addresses  VALUES(	302	,	'Prins-bisschopssingel'	,	42	,	null	,	3500	);
INSERT INTO addresses  VALUES(	303	,	'Putvennestraat'	,	137	,	null	,	3501	);
INSERT INTO addresses  VALUES(	304	,	'Raamstraat'	,	89	,	null	,	3510	);
INSERT INTO addresses  VALUES(	305	,	'Rapertingenstraat'	,	23	,	null	,	3500	);
INSERT INTO addresses  VALUES(	306	,	'Rechterstraat'	,	39	,	null	,	3500	);
INSERT INTO addresses  VALUES(	307	,	'Research Campus'	,	112	,	null	,	3500	);
INSERT INTO addresses  VALUES(	308	,	'Ridder Portmansstraat'	,	166	,	null	,	3500	);
INSERT INTO addresses  VALUES(	309	,	'Ridderportmansstraat'	,	187	,	null	,	3500	);
INSERT INTO addresses  VALUES(	310	,	'Koning Albertstraat'	,	60	,	null	,	3500	);
INSERT INTO addresses  VALUES(	311	,	'Sasstraat'	,	33	,	null	,	3500	);
INSERT INTO addresses  VALUES(	312	,	'Roeselstraat'	,	127	,	null	,	3500	);
INSERT INTO addresses  VALUES(	313	,	'Schampbergstraat'	,	198	,	null	,	3500	);
INSERT INTO addresses  VALUES(	314	,	'Kempische Steenweg'	,	71	,	null	,	3500	);
INSERT INTO addresses  VALUES(	315	,	'Runksterkiezel'	,	58	,	null	,	3500	);
INSERT INTO addresses  VALUES(	316	,	'Runkstersteenweg'	,	13	,	null	,	3501	);
INSERT INTO addresses  VALUES(	317	,	'Salvatorstraat'	,	195	,	null	,	3510	);
INSERT INTO addresses  VALUES(	318	,	'Singelbeekstraat'	,	38	,	null	,	3511	);
INSERT INTO addresses  VALUES(	319	,	'Schabbestraat'	,	93	,	null	,	3512	);
INSERT INTO addresses  VALUES(	320	,	'Bampslaan'	,	115	,	null	,	3500	);
INSERT INTO addresses  VALUES(	321	,	'Leopoldplein'	,	155	,	null	,	3500	);
INSERT INTO addresses  VALUES(	322	,	'Lisbloemstraat'	,	64	,	null	,	3500	);
INSERT INTO addresses  VALUES(	323	,	'Schoonwinkelstraat'	,	84	,	null	,	3500	);
INSERT INTO addresses  VALUES(	324	,	'Schotelstraat'	,	94	,	null	,	3500	);
INSERT INTO addresses  VALUES(	325	,	'Thonissenlaan'	,	139	,	'b'	,	3500	);
INSERT INTO addresses  VALUES(	326	,	'Kerkhofstraat'	,	139	,	'd'	,	3500	);
INSERT INTO addresses  VALUES(	327	,	'Simpernelstraat'	,	68	,	null	,	3500	);
INSERT INTO addresses  VALUES(	328	,	'Stadsheide'	,	83	,	null	,	3500	);
INSERT INTO addresses  VALUES(	329	,	'Sint-amandusstraat'	,	166	,	null	,	3500	);
INSERT INTO addresses  VALUES(	330	,	'Ridderstraat'	,	164	,	null	,	3500	);
INSERT INTO addresses  VALUES(	331	,	'Rode Rokstraat'	,	27	,	null	,	3500	);
INSERT INTO addresses  VALUES(	332	,	'Universiteitslaan'	,	89	,	null	,	3500	);
INSERT INTO addresses  VALUES(	333	,	'Kortstraat'	,	165	,	null	,	3500	);
INSERT INTO addresses  VALUES(	334	,	'St.truidersteenweg'	,	30	,	null	,	3500	);
INSERT INTO addresses  VALUES(	335	,	'Veldmansbrugstraat'	,	7	,	null	,	3500	);
INSERT INTO addresses  VALUES(	336	,	'Veldstraat'	,	98	,	null	,	3500	);
INSERT INTO addresses  VALUES(	337	,	'Kolmenstraat'	,	38	,	null	,	3500	);
INSERT INTO addresses  VALUES(	338	,	'Kolonel Dusartplein'	,	148	,	null	,	3500	);
INSERT INTO addresses  VALUES(	339	,	'Slagmolenstraat'	,	8	,	null	,	3500	);
INSERT INTO addresses  VALUES(	340	,	'Spaarzaamheidstraat'	,	21	,	null	,	3500	);
INSERT INTO addresses  VALUES(	341	,	'Spalbeekstraat'	,	168	,	null	,	3500	);
INSERT INTO addresses  VALUES(	342	,	'Spechtenlaan'	,	186	,	null	,	3511	);
INSERT INTO addresses  VALUES(	343	,	'Spoorwegstraat'	,	163	,	null	,	3512	);
INSERT INTO addresses  VALUES(	344	,	'St.-truidersteenweg'	,	198	,	null	,	3500	);
INSERT INTO addresses  VALUES(	345	,	'Luikersteenweg'	,	16	,	null	,	3500	);
INSERT INTO addresses  VALUES(	346	,	'Lummense Kiezel'	,	125	,	null	,	3500	);
INSERT INTO addresses  VALUES(	347	,	'Stadsomvaart'	,	109	,	null	,	3500	);
INSERT INTO addresses  VALUES(	348	,	'Lentestraat'	,	72	,	null	,	3500	);
INSERT INTO addresses  VALUES(	349	,	'Steenberg'	,	180	,	null	,	3500	);
INSERT INTO addresses  VALUES(	350	,	'Sterrebos'	,	62	,	null	,	3500	);
INSERT INTO addresses  VALUES(	351	,	'Stevoortse Kiezel'	,	142	,	null	,	3500	);
INSERT INTO addresses  VALUES(	352	,	'Stevoortsekiezel'	,	81	,	null	,	3500	);
INSERT INTO addresses  VALUES(	353	,	'Stokerijstraat'	,	122	,	null	,	3500	);
INSERT INTO addresses  VALUES(	354	,	'Vanmaerlantlaan'	,	100	,	null	,	3500	);
INSERT INTO addresses  VALUES(	355	,	'Trichterheideweg'	,	50	,	null	,	3500	);
INSERT INTO addresses  VALUES(	356	,	'Theresiastraat'	,	101	,	null	,	3500	);
INSERT INTO addresses  VALUES(	357	,	'Stationsplein'	,	16	,	'b'	,	3500	);
INSERT INTO addresses  VALUES(	358	,	'Torenstraat'	,	6	,	'd'	,	3500	);
INSERT INTO addresses  VALUES(	359	,	'Trekschurenstraat'	,	65	,	null	,	3500	);
INSERT INTO addresses  VALUES(	360	,	'Langveldstraat'	,	177	,	null	,	3500	);
INSERT INTO addresses  VALUES(	361	,	'Hassalutdreef'	,	110	,	null	,	3500	);
INSERT INTO addresses  VALUES(	362	,	'Hasseltdreef'	,	120	,	null	,	3500	);
INSERT INTO addresses  VALUES(	363	,	'Van Maerlantstraat'	,	64	,	null	,	3500	);
INSERT INTO addresses  VALUES(	364	,	'Langvennestraat'	,	27	,	null	,	3500	);
INSERT INTO addresses  VALUES(	365	,	'Muntelbeekstraat'	,	80	,	null	,	3500	);
INSERT INTO addresses  VALUES(	366	,	'Nieuwe Heidestraat'	,	96	,	null	,	3500	);
INSERT INTO addresses  VALUES(	367	,	'Via Media'	,	35	,	null	,	3501	);
INSERT INTO addresses  VALUES(	368	,	'Vijversstraat'	,	3	,	null	,	3510	);
INSERT INTO addresses  VALUES(	369	,	'Vissenbroekstraat'	,	75	,	null	,	3500	);
INSERT INTO addresses  VALUES(	370	,	'Vissersstraat'	,	113	,	null	,	3501	);
INSERT INTO addresses  VALUES(	371	,	'Hasseltdreef'	,	76	,	null	,	3510	);



Prompt --> insert data into the members table
INSERT INTO members VALUES('63072845621', 'Carina', 'Medats', 'Belg', 'carina.medats@pxl.be', 'V','63072845621',1);
INSERT INTO members VALUES('04051055671', 'Helena', 'Claes', 'Belg', 'claesh@outlook.be', 'V','63072845621',2);
INSERT INTO members VALUES('65112372496', 'Rudi', 'Claes', 'Belg', null, 'M', '63072845621',3);
INSERT INTO members VALUES('111222333', 'Jolien', 'Emmer', 'Nederlander', 'jolienem@gmail.com', 'V', '111222333',4);
INSERT INTO members VALUES('123456782', 'Piet', 'Haas', 'Nederlander', 'piethaas@gmail.com', 'M', '123456782',5);

INSERT INTO members  VALUES(	'00031415260'	,	'Ann'	,	'Claes'	,	'Belg'	,	'AClaes@telenet.be'	,	'V'	,	'00031415260'	,	6	);
INSERT INTO members  VALUES(	'55111012458'	,	'Marie'	,	'Vandenborre'	,	'Belg'	,	'MVandenborre@telenet.be'	,	'V'	,	'55111012458'	,	7	);
INSERT INTO members  VALUES(	'56051717997'	,	'Lina'	,	'Tilkens'	,	'Belg'	,	'TilkensL@gmail.com'	,	'V'	,	'55111012458'	,	8	);
INSERT INTO members  VALUES(	'04011924840'	,	'Kyril'	,	'Kuppens'	,	'Belg'	,	'KKuppens@hotmail.com'	,	'M'	,	'55111012458'	,	9	);
INSERT INTO members  VALUES(	'55121956832'	,	'Anna'	,	'Borders'	,	'Belg'	,	'BordersAnna@gmail.com'	,	'V'	,	'55121956832'	,	10	);
INSERT INTO members  VALUES(	'57101918592'	,	'Patrick'	,	'Clerinx'	,	'Belg'	,	'ClerinxP@gmail.com'	,	'M'	,	'55121956832'	,	11	);
INSERT INTO members  VALUES(	'05042720734'	,	'Marcel'	,	'Vandenborre'	,	'Belg'	,	'MarcelVandenborre@hotmail.com'	,	'M'	,	'55121956832'	,	12	);
INSERT INTO members  VALUES(	'57061057910'	,	'Rita'	,	'Terriers'	,	'Belg'	,	'RTerriers@telenet.be'	,	'V'	,	'57061057910'	,	13	);
INSERT INTO members  VALUES(	'61021260066'	,	'Christian'	,	'Boes'	,	'Belg'	,	'CBoes@hotmail.com'	,	'M'	,	'57061057910'	,	14	);
INSERT INTO members  VALUES(	'58011512523'	,	'Lotte'	,	'Verstreken'	,	'Belg'	,	'L.Verstreken@telenet.be'	,	'V'	,	'58011512523'	,	15	);
INSERT INTO members  VALUES(	'58082553598'	,	'Roger'	,	'Klimop'	,	'Belg'	,	'R.Klimop@telenet.be'	,	'M'	,	'58011512523'	,	16	);
INSERT INTO members  VALUES(	'58052423709'	,	'Patricia'	,	'Appelmans'	,	'Belg'	,	'PAppelmans@telenet.be'	,	'V'	,	'58052423709'	,	17	);
INSERT INTO members  VALUES(	'72041345234'	,	'An'	,	'Borders'	,	'Belg'	,	'A.Borders@gmail.com'	,	'V'	,	'58052423709'	,	18	);
INSERT INTO members  VALUES(	'55092718473'	,	'Michel'	,	'Boes'	,	'Belg'	,	'MBoes@hotmail.com'	,	'M'	,	'58052423709'	,	19	);
INSERT INTO members  VALUES(	'58091683756'	,	'Annemie'	,	'Jacobs'	,	'Belg'	,	'A.Jacobs@gmail.com'	,	'V'	,	'58091683756'	,	20	);
INSERT INTO members  VALUES(	'62121388288'	,	'Hélène'	,	'Jacquelot'	,	'Belg'	,	'JacquelotH@gmail.com'	,	'V'	,	'58091683756'	,	21	);
INSERT INTO members  VALUES(	'60102886022'	,	'Marc'	,	'Jacquelot'	,	'Belg'	,	'MJacquelot@hotmail.com'	,	'M'	,	'58091683756'	,	22	);
INSERT INTO members  VALUES(	'55061490554'	,	'Valerie'	,	'Jacquelot'	,	'Belg'	,	'VJacquelot@telenet.be'	,	'V'	,	'58091683756'	,	23	);
INSERT INTO members  VALUES(	'59022195086'	,	'Hilde'	,	'Jacobs'	,	'Belg'	,	'H.Jacobs@gmail.com'	,	'V'	,	'59022195086'	,	24	);
INSERT INTO members  VALUES(	'65051811556'	,	'Evelien'	,	'Van Roy'	,	'Belg'	,	'EVan Roy@telenet.be'	,	'V'	,	'59022195086'	,	25	);
INSERT INTO members  VALUES(	'63041710478'	,	'Katrien'	,	'Van Roy'	,	'Belg'	,	'Van RoyK@gmail.com'	,	'V'	,	'59022195086'	,	26	);
INSERT INTO members  VALUES(	'57112092820'	,	'Ivo'	,	'Van Roy'	,	'Belg'	,	'I.Van Roy@gmail.com'	,	'M'	,	'59022195086'	,	27	);
INSERT INTO members  VALUES(	'59111158988'	,	'Eric'	,	'Teerain'	,	'Belg'	,	'E.Teerain@gmail.com'	,	'M'	,	'59111158988'	,	28	);
INSERT INTO members  VALUES(	'77121118024'	,	'Adam'	,	'Teerain'	,	'Belg'	,	'A.Teerain@gmail.com'	,	'M'	,	'59111158988'	,	29	);
INSERT INTO members  VALUES(	'05081027106'	,	'Jonas'	,	'Beervoets'	,	'Belg'	,	'BeervoetsJ@gmail.com'	,	'M'	,	'59111158988'	,	30	);
INSERT INTO members  VALUES(	'60031523828'	,	'Ann'	,	'Witte'	,	'Belg'	,	'A.Witte@telenet.be'	,	'V'	,	'60031523828'	,	31	);
INSERT INTO members  VALUES(	'70022634194'	,	'Marie'	,	'Yilmaz'	,	'Belg'	,	'M.Yilmaz@gmail.com'	,	'V'	,	'60031523828'	,	32	);
INSERT INTO members  VALUES(	'00091129372'	,	'Niels'	,	'Yilmaz'	,	'Belg'	,	'NYilmaz@telenet.be'	,	'M'	,	'60031523828'	,	33	);
INSERT INTO members  VALUES(	'60081612642'	,	'Miet'	,	'Vandenborre'	,	'Belg'	,	'M.Vandenborre@gmail.com'	,	'V'	,	'60081612642'	,	34	);
INSERT INTO members  VALUES(	'60012518235'	,	'Jean'	,	'Terriers'	,	'Belg'	,	'J.Terriers@telenet.be'	,	'M'	,	'60081612642'	,	35	);
INSERT INTO members  VALUES(	'61042335561'	,	'Gert'	,	'Witte'	,	'Belg'	,	'GWitte@hotmail.com'	,	'M'	,	'61042335561'	,	36	);
INSERT INTO members  VALUES(	'61061118830'	,	'André'	,	'De Cuyper'	,	'Belg'	,	'A.De Cuyper@gmail.com'	,	'M'	,	'61061118830'	,	37	);
INSERT INTO members  VALUES(	'58031818116'	,	'Marie'	,	'Borders'	,	'Belg'	,	'MBorders@telenet.be'	,	'V'	,	'61061118830'	,	38	);
INSERT INTO members  VALUES(	'61072297352'	,	'Filip'	,	'Van Roy'	,	'Belg'	,	'FVan Roy@hotmail.com'	,	'M'	,	'61072297352'	,	39	);
INSERT INTO members  VALUES(	'71082714790'	,	'Puck'	,	'Van Roy'	,	'Belg'	,	null	,	'V'	,	'61072297352'	,	40	);
INSERT INTO members  VALUES(	'69012613712'	,	'Emmeline'	,	'Van Roy'	,	'Belg'	,	null	,	'V'	,	'61072297352'	,	41	);
INSERT INTO members  VALUES(	'62092812761'	,	'Lies'	,	'Alberty'	,	'Belg'	,	'LAlberty@hotmail.com'	,	'V'	,	'62092812761'	,	42	);
INSERT INTO members  VALUES(	'81121214427'	,	'Bram'	,	'Geldof'	,	'Belg'	,	'BGeldof@hotmail.com'	,	'M'	,	'62092812761'	,	43	);
INSERT INTO members  VALUES(	'64102381626'	,	'Tom'	,	'Alberty'	,	'Belg'	,	'AlbertyT@gmail.com'	,	'M'	,	'62092812761'	,	44	);
INSERT INTO members  VALUES(	'62102755754'	,	'Nicole'	,	'Tilkens'	,	'Belg'	,	'NTilkens@hotmail.com'	,	'V'	,	'62102755754'	,	45	);
INSERT INTO members  VALUES(	'69052513713'	,	'Piet'	,	'Terriers'	,	'Belg'	,	'P.Terriers@telenet.be'	,	'M'	,	'62102755754'	,	46	);
INSERT INTO members  VALUES(	'63052443262'	,	'Rien'	,	'Aerts'	,	'Belg'	,	'AertsR@gmail.com'	,	'M'	,	'63052443262'	,	47	);
INSERT INTO members  VALUES(	'70111684860'	,	'Jeannine'	,	'Aerts'	,	'Belg'	,	'J.Aerts@gmail.com'	,	'V'	,	'63052443262'	,	48	);
INSERT INTO members  VALUES(	'59071227860'	,	'Kris'	,	'Appelmans'	,	'Belg'	,	'K.Appelmans@gmail.com'	,	'M'	,	'63052443262'	,	49	);
INSERT INTO members  VALUES(	'63072361144'	,	'Marcel'	,	'Clerinx'	,	'Belg'	,	'ClerinxM@gmail.com'	,	'M'	,	'63072361144'	,	50	);
INSERT INTO members  VALUES(	'60092654676'	,	'Willy'	,	'Daenen'	,	'Belg'	,	'W.Daenen@gmail.com'	,	'M'	,	'63072361144'	,	51	);
INSERT INTO members  VALUES(	'64092215617'	,	'Ben'	,	'Yilmaz'	,	'Belg'	,	'BYilmaz@hotmail.com'	,	'M'	,	'64092215617'	,	52	);
INSERT INTO members  VALUES(	'87071112047'	,	'Leen'	,	'Yilmaz'	,	'Belg'	,	'L.Yilmaz@gmail.com'	,	'V'	,	'64092215617'	,	53	);
INSERT INTO members  VALUES(	'65022319068'	,	'Monique'	,	'Geyskens'	,	'Belg'	,	'GeyskensM@gmail.com'	,	'V'	,	'65022319068'	,	54	);
INSERT INTO members  VALUES(	'65031550963'	,	'Matthias'	,	'Klawitter'	,	'Belg'	,	'MKlawitter@telenet.be'	,	'M'	,	'65031550963'	,	55	);
INSERT INTO members  VALUES(	'73032819544'	,	'Paul'	,	'Keuninckx'	,	'Belg'	,	'PKeuninckx@hotmail.com'	,	'M'	,	'65031550963'	,	56	);
INSERT INTO members  VALUES(	'04042815022'	,	'Omer'	,	'Keuninckx'	,	'Belg'	,	'OKeuninckx@hotmail.com'	,	'M'	,	'65031550963'	,	57	);
INSERT INTO members  VALUES(	'65071713475'	,	'Dennis'	,	'Franssen'	,	'Belg'	,	'FranssenD@gmail.com'	,	'M'	,	'65071713475'	,	58	);
INSERT INTO members  VALUES(	'64121730960'	,	'Alice'	,	'Claes'	,	'Belg'	,	'ClaesA@gmail.com'	,	'V'	,	'65071713475'	,	59	);
INSERT INTO members  VALUES(	'66061832038'	,	'Juliette'	,	'Kuppens'	,	'Belg'	,	'JKuppens@telenet.be'	,	'V'	,	'66061832038'	,	60	);
INSERT INTO members  VALUES(	'66092321329'	,	'Alain'	,	'Klawitter'	,	'Belg'	,	'KlawitterA@gmail.com'	,	'M'	,	'66061832038'	,	61	);
INSERT INTO members  VALUES(	'66111538436'	,	'Jules'	,	'Verstreken'	,	'Belg'	,	'VerstrekenJ@gmail.com'	,	'M'	,	'66111538436'	,	62	);
INSERT INTO members  VALUES(	'99081179470'	,	'Nicolas'	,	'Verstreken'	,	'Belg'	,	'N.Verstreken@gmail.com'	,	'M'	,	'66111538436'	,	63	);
INSERT INTO members  VALUES(	'78031138506'	,	'Jean'	,	'Verstreken'	,	'Belg'	,	'J.Verstreken@gmail.com'	,	'M'	,	'66111538436'	,	64	);
INSERT INTO members  VALUES(	'76041488094'	,	'Patricia'	,	'Franssen'	,	'Belg'	,	'PatFranssen@telenet.be'	,	'V'	,	'66111538436'	,	65	);
INSERT INTO members  VALUES(	'67011658664'	,	'Mark'	,	'Kenes'	,	'Belg'	,	'M.Kenes@telenet.be'	,	'M'	,	'67011658664'	,	66	);
INSERT INTO members  VALUES(	'79101114308'	,	'Indra'	,	'De Cuyper'	,	'Belg'	,	'I.De Cuyper@gmail.com'	,	'V'	,	'67011658664'	,	67	);
INSERT INTO members  VALUES(	'67032512634'	,	'Madeleine'	,	'Dox'	,	'Belg'	,	'M.Dox@telenet.be'	,	'V'	,	'67032512634'	,	68	);
INSERT INTO members  VALUES(	'67041813594'	,	'Jan'	,	'Borders'	,	'Belg'	,	'JBorders@telenet.be'	,	'M'	,	'67041813594'	,	69	);
INSERT INTO members  VALUES(	'87022017640'	,	'Elena'	,	'Janssens'	,	'Belg'	,	'E.Janssens@gmail.com'	,	'V'	,	'67041813594'	,	70	);
INSERT INTO members  VALUES(	'67051563300'	,	'Peter'	,	'De Cuyper'	,	'Belg'	,	'P.De Cuyper@telenet.be'	,	'M'	,	'67051563300'	,	71	);
INSERT INTO members  VALUES(	'94021447130'	,	'Philippe'	,	'Franssen'	,	'Belg'	,	'PFranssen@telenet.be'	,	'M'	,	'67051563300'	,	72	);
INSERT INTO members  VALUES(	'91042217878'	,	'Sofia'	,	'Daenen'	,	'Belg'	,	'SDaenen@hotmail.com'	,	'V'	,	'67051563300'	,	73	);
INSERT INTO members  VALUES(	'90122695640'	,	'Matthias'	,	'Daenen'	,	'Belg'	,	'M.Daenen@gmail.com'	,	'M'	,	'67051563300'	,	74	);
INSERT INTO members  VALUES(	'67072419187'	,	'Philippe'	,	'Haest'	,	'Belg'	,	'PHaest@telenet.be'	,	'M'	,	'67072419187'	,	75	);
INSERT INTO members  VALUES(	'85112414665'	,	'Hans'	,	'Haest'	,	'Belg'	,	'HHaest@telenet.be'	,	'M'	,	'67072419187'	,	76	);
INSERT INTO members  VALUES(	'64062436170'	,	'Piet'	,	'Goedeman'	,	'Belg'	,	'PGoedeman@hotmail.com'	,	'M'	,	'67072419187'	,	77	);
INSERT INTO members  VALUES(	'68061583782'	,	'Christophe'	,	'Witte'	,	'Belg'	,	'C.Witte@telenet.be'	,	'M'	,	'68061583782'	,	78	);
INSERT INTO members  VALUES(	'86101542818'	,	'Luc'	,	'Witte'	,	'Belg'	,	'L.Witte@telenet.be'	,	'M'	,	'68061583782'	,	79	);
INSERT INTO members  VALUES(	'68102421448'	,	'Robert'	,	'Kenes'	,	'Belg'	,	'RKenes@telenet.be'	,	'M'	,	'68102421448'	,	80	);
INSERT INTO members  VALUES(	'74071387016'	,	'Sarah'	,	'Kenes'	,	'Belg'	,	'KenesS@gmail.com'	,	'V'	,	'68102421448'	,	81	);
INSERT INTO members  VALUES(	'63022213356'	,	'Niels'	,	'Kenes'	,	'Belg'	,	'NKenes@hotmail.com'	,	'M'	,	'68102421448'	,	82	);
INSERT INTO members  VALUES(	'68112533116'	,	'Elena'	,	'Beervoets'	,	'Belg'	,	'E.Beervoets@telenet.be'	,	'V'	,	'68112533116'	,	83	);
INSERT INTO members  VALUES(	'66122482704'	,	'Guy'	,	'Appelmans'	,	'Belg'	,	'GAppelmans@telenet.be'	,	'M'	,	'68112533116'	,	84	);
INSERT INTO members  VALUES(	'02072574080'	,	'Thomas'	,	'Beervoets'	,	'Belg'	,	'T.Beervoets@telenet.be'	,	'M'	,	'68112533116'	,	85	);
INSERT INTO members  VALUES(	'68121815855'	,	'Noah'	,	'Vanneste'	,	'Belg'	,	'NVanneste@telenet.be'	,	'M'	,	'68121815855'	,	86	);
INSERT INTO members  VALUES(	'96061923114'	,	'Guy'	,	'Vanneste'	,	'Belg'	,	'VannesteG@gmail.com'	,	'M'	,	'68121815855'	,	87	);
INSERT INTO members  VALUES(	'75011319663'	,	'Nathalie'	,	'Tilkens'	,	'Belg'	,	'TilkensN@gmail.com'	,	'V'	,	'68121815855'	,	88	);
INSERT INTO members  VALUES(	'02111820377'	,	'Rita'	,	'Vanneste'	,	'Belg'	,	'RVanneste@telenet.be'	,	'V'	,	'68121815855'	,	89	);
INSERT INTO members  VALUES(	'69031664378'	,	'Jacques'	,	'Geldof'	,	'Belg'	,	'J.Geldof@gmail.com'	,	'M'	,	'69031664378'	,	90	);
INSERT INTO members  VALUES(	'69041519306'	,	'Martine'	,	'Hendrix'	,	'Belg'	,	'M.Hendrix@telenet.be'	,	'V'	,	'69041519306'	,	91	);
INSERT INTO members  VALUES(	'71091374066'	,	'Tom'	,	'Hons'	,	'Belg'	,	'THons@hotmail.com'	,	'M'	,	'69041519306'	,	92	);
INSERT INTO members  VALUES(	'02021514784'	,	'Conrad'	,	'Hendrix'	,	'Belg'	,	'C.Hendrix@telenet.be'	,	'M'	,	'69041519306'	,	93	);
INSERT INTO members  VALUES(	'69082866365'	,	'Eline'	,	'Franssen'	,	'Belg'	,	'E.Franssen@gmail.com'	,	'V'	,	'69082866365'	,	94	);
INSERT INTO members  VALUES(	'70072842968'	,	'Abdul'	,	'Heersel'	,	'Belg'	,	'HeerselA@gmail.com'	,	'M'	,	'70072842968'	,	95	);
INSERT INTO members  VALUES(	'70121521567'	,	'Daniel'	,	'Franssen'	,	'Belg'	,	'D.Franssen@telenet.be'	,	'M'	,	'70121521567'	,	96	);
INSERT INTO members  VALUES(	'92021967894'	,	'Jorben'	,	'Hendrix'	,	'Belg'	,	'HendrixJ@gmail.com'	,	'M'	,	'70121521567'	,	97	);
INSERT INTO members  VALUES(	'05011426648'	,	'Emma'	,	'Hendrix'	,	'Belg'	,	'EHendrix@telenet.be'	,	'V'	,	'70121521567'	,	98	);
INSERT INTO members  VALUES(	'71012865456'	,	'Dirk'	,	'Geyskens'	,	'Belg'	,	'DGeyskens@hotmail.com'	,	'M'	,	'71012865456'	,	99	);
INSERT INTO members  VALUES(	'68021640702'	,	'Ali'	,	'Janssens'	,	'Belg'	,	'JanssensA@gmail.com'	,	'M'	,	'71012865456'	,	100	);
INSERT INTO members  VALUES(	'56011852520'	,	'Pierre'	,	'Janssens'	,	'Belg'	,	'PJanssens@telenet.be'	,	'M'	,	'71012865456'	,	101	);
INSERT INTO members  VALUES(	'71032613832'	,	'Jules'	,	'Teerain'	,	'Belg'	,	'J.Teerain@gmail.com'	,	'M'	,	'71032613832'	,	102	);
INSERT INTO members  VALUES(	'62082618354'	,	'Marc'	,	'Teerain'	,	'Belg'	,	'M.Teerain@gmail.com'	,	'M'	,	'71032613832'	,	103	);
INSERT INTO members  VALUES(	'71051619425'	,	'Anne'	,	'Huyghe'	,	'Belg'	,	'A.Huyghe@gmail.com'	,	'V'	,	'71051619425'	,	104	);
INSERT INTO members  VALUES(	'72022885938'	,	'Olivier'	,	'Klawitter'	,	'Belg'	,	'OKlawitter@hotmail.com'	,	'M'	,	'72022885938'	,	105	);
INSERT INTO members  VALUES(	'90062844974'	,	'Jan'	,	'Klawitter'	,	'Belg'	,	'JKlawitter@hotmail.com'	,	'M'	,	'72022885938'	,	106	);
INSERT INTO members  VALUES(	'72112616093'	,	'Louis'	,	'Verstreken'	,	'Belg'	,	'L.Verstreken@gmail.com'	,	'M'	,	'72112616093'	,	107	);
INSERT INTO members  VALUES(	'72072735272'	,	'Sofia'	,	'Spaelt'	,	'Belg'	,	'SSpaelt@hotmail.com'	,	'V'	,	'72112616093'	,	108	);
INSERT INTO members  VALUES(	'73012713951'	,	'Ali'	,	'Boes'	,	'Belg'	,	'ABoes@hotmail.com'	,	'M'	,	'73012713951'	,	109	);
INSERT INTO members  VALUES(	'87042149286'	,	'Anne'	,	'Huisjes'	,	'Belg'	,	'A.Huisjes@gmail.com'	,	'V'	,	'73012713951'	,	110	);
INSERT INTO members  VALUES(	'73081366534'	,	'Alain'	,	'Haest'	,	'Belg'	,	'HaestA@gmail.com'	,	'M'	,	'73081366534'	,	111	);
INSERT INTO members  VALUES(	'73091915868'	,	'Arthur'	,	'Borders'	,	'Belg'	,	'BordersA@gmail.com'	,	'M'	,	'73091915868'	,	112	);
INSERT INTO members  VALUES(	'73101481767'	,	'Leen'	,	'Huisjes'	,	'Belg'	,	'HuisjesL@gmail.com'	,	'V'	,	'73101481767'	,	113	);
INSERT INTO members  VALUES(	'74022716212'	,	'Liam'	,	'Vandenborre'	,	'Belg'	,	'LVandenborre@hotmail.com'	,	'M'	,	'74022716212'	,	114	);
INSERT INTO members  VALUES(	'81062270846'	,	'Christine'	,	'Tilkens'	,	'Belg'	,	'CTilkens@hotmail.com'	,	'V'	,	'74022716212'	,	115	);
INSERT INTO members  VALUES(	'74041936350'	,	'Lina'	,	'Vanneste'	,	'Belg'	,	'VannesteL@gmail.com'	,	'V'	,	'74041936350'	,	116	);
INSERT INTO members  VALUES(	'74051447500'	,	'Indra'	,	'Terriers'	,	'Belg'	,	'ITerriers@telenet.be'	,	'V'	,	'74051447500'	,	117	);
INSERT INTO members  VALUES(	'79092019901'	,	'Roger'	,	'Kuppens'	,	'Belg'	,	'R.Kuppens@gmail.com'	,	'M'	,	'74051447500'	,	118	);
INSERT INTO members  VALUES(	'74112821805'	,	'Christine'	,	'Huisjes'	,	'Belg'	,	'CHuisjes@hotmail.com'	,	'V'	,	'74112821805'	,	119	);
INSERT INTO members  VALUES(	'72061621686'	,	'David'	,	'Hons'	,	'Belg'	,	'D.Hons@gmail.com'	,	'M'	,	'74112821805'	,	120	);
INSERT INTO members  VALUES(	'00082027726'	,	'Olivia'	,	'Huyghe'	,	'Belg'	,	'O.Huyghe@gmail.com'	,	'V'	,	'74112821805'	,	121	);
INSERT INTO members  VALUES(	'75081914070'	,	'Abdul'	,	'Clerinx'	,	'Belg'	,	'ClerinxA@gmail.com'	,	'M'	,	'75081914070'	,	122	);
INSERT INTO members  VALUES(	'75091467612'	,	'Robert'	,	'Hendrix'	,	'Belg'	,	'RHendrix@telenet.be'	,	'M'	,	'75091467612'	,	123	);
INSERT INTO members  VALUES(	'78052089172'	,	'Ann'	,	'Hons'	,	'Belg'	,	'A.Hons@gmail.com'	,	'V'	,	'75091467612'	,	124	);
INSERT INTO members  VALUES(	'75101016946'	,	'Noah'	,	'Terriers'	,	'Belg'	,	'NTerriers@telenet.be'	,	'M'	,	'75101016946'	,	125	);
INSERT INTO members  VALUES(	'81021713510'	,	'Lotte'	,	'Klimop'	,	'Belg'	,	'LKlimop@hotmail.com'	,	'V'	,	'75101016946'	,	126	);
INSERT INTO members  VALUES(	'75122089468'	,	'Veerle'	,	'Willems'	,	'Belg'	,	'VWillems@telenet.be'	,	'V'	,	'75122089468'	,	127	);
INSERT INTO members  VALUES(	'82082340662'	,	'Michel'	,	'Alberty'	,	'Belg'	,	'AlbertyM@gmail.com'	,	'M'	,	'75122089468'	,	128	);
INSERT INTO members  VALUES(	'57021120159'	,	'Philippe'	,	'Alberty'	,	'Belg'	,	'P.Alberty@telenet.be'	,	'M'	,	'75122089468'	,	129	);
INSERT INTO members  VALUES(	'76021321924'	,	'Jacqueline'	,	'Willems'	,	'Belg'	,	'WillemsJ@gmail.com'	,	'V'	,	'76021321924'	,	130	);
INSERT INTO members  VALUES(	'76032049766'	,	'Bram'	,	'Teerain'	,	'Belg'	,	'B.Teerain@telenet.be'	,	'M'	,	'76032049766'	,	131	);
INSERT INTO members  VALUES(	'76051037428'	,	'Marie'	,	'Goedeman'	,	'Belg'	,	'MGoedeman@telenet.be'	,	'V'	,	'76051037428'	,	132	);
INSERT INTO members  VALUES(	'76071916331'	,	'Lucas'	,	'Alberty'	,	'Belg'	,	'AlbertyL@gmail.com'	,	'M'	,	'76071916331'	,	133	);
INSERT INTO members  VALUES(	'56042323590'	,	'Sarah'	,	'Alberty'	,	'Belg'	,	'AlbertyS@gmail.com'	,	'V'	,	'76071916331'	,	134	);
INSERT INTO members  VALUES(	'00051920853'	,	'Johan'	,	'Alberty'	,	'Belg'	,	'AlbertyJ@gmail.com'	,	'M'	,	'76071916331'	,	135	);
INSERT INTO members  VALUES(	'77062197169'	,	'Marijke'	,	'Waterman'	,	'Belg'	,	'M.Waterman@telenet.be'	,	'V'	,	'77062197169'	,	136	);
INSERT INTO members  VALUES(	'77081419782'	,	'Pierre'	,	'Claes'	,	'Belg'	,	'PClaes@telenet.be'	,	'M'	,	'77081419782'	,	137	);
INSERT INTO members  VALUES(	'83111771924'	,	'Jacqueline'	,	'Claes'	,	'Belg'	,	'ClaesJ@gmail.com'	,	'V'	,	'77081419782'	,	138	);
INSERT INTO members  VALUES(	'07032722574'	,	'Lowie'	,	'Claes'	,	'Belg'	,	'L.Claes@gmail.com'	,	'M'	,	'77081419782'	,	139	);
INSERT INTO members  VALUES(	'77091014189'	,	'An'	,	'Daniels'	,	'Belg'	,	'ADaniels@telenet.be'	,	'V'	,	'77091014189'	,	140	);
INSERT INTO members  VALUES(	'88062663362'	,	'Atakan'	,	'Geyskens'	,	'Belg'	,	'A.Geyskens@gmail.com'	,	'M'	,	'77091014189'	,	141	);
INSERT INTO members  VALUES(	'63111218949'	,	'Jan'	,	'Geldof'	,	'Belg'	,	'JGeldof@hotmail.com'	,	'M'	,	'77091014189'	,	142	);
INSERT INTO members  VALUES(	'77102068690'	,	'Daniel'	,	'Huyghe'	,	'Belg'	,	'D.Huyghe@gmail.com'	,	'M'	,	'77102068690'	,	143	);
INSERT INTO members  VALUES(	'66101715736'	,	'Arthur'	,	'Spaelt'	,	'Belg'	,	'ASpaelt@hotmail.com'	,	'M'	,	'77102068690'	,	144	);
INSERT INTO members  VALUES(	'07071614903'	,	'Magomed'	,	'Huyghe'	,	'Belg'	,	'M.Huyghe@gmail.com'	,	'M'	,	'77102068690'	,	145	);
INSERT INTO members  VALUES(	'78012152032'	,	'Kevin'	,	'Boes'	,	'Belg'	,	'K.Boes@gmail.com'	,	'M'	,	'78012152032'	,	146	);
INSERT INTO members  VALUES(	'78071422043'	,	'Joseph'	,	'Franssen'	,	'Belg'	,	'JFranssen@telenet.be'	,	'M'	,	'78071422043'	,	147	);
INSERT INTO members  VALUES(	'86122561096'	,	'Omer'	,	'Geldof'	,	'Belg'	,	'O.Geldof@telenet.be'	,	'M'	,	'78071422043'	,	148	);
INSERT INTO members  VALUES(	'02041623414'	,	'Victor'	,	'Geldof'	,	'Belg'	,	'V.Geldof@gmail.com'	,	'M'	,	'78071422043'	,	149	);
INSERT INTO members  VALUES(	'79061219102'	,	'Louis'	,	'Boes'	,	'Belg'	,	'LBoes@hotmail.com'	,	'M'	,	'79061219102'	,	150	);
INSERT INTO members  VALUES(	'78041016450'	,	'Jules'	,	'Appelmans'	,	'Belg'	,	'JAppelmans@telenet.be'	,	'M'	,	'79061219102'	,	151	);
INSERT INTO members  VALUES(	'55101312880'	,	'Louise'	,	'Appelmans'	,	'Belg'	,	'AppelmansL@gmail.com'	,	'V'	,	'79061219102'	,	152	);
INSERT INTO members  VALUES(	'79112211244'	,	'Leen'	,	'Janssens'	,	'Belg'	,	'L.Janssens@gmail.com'	,	'V'	,	'79112211244'	,	153	);
INSERT INTO members  VALUES(	'79122169768'	,	'David'	,	'Keuninckx'	,	'Belg'	,	'D.Keuninckx@gmail.com'	,	'M'	,	'79122169768'	,	154	);
INSERT INTO members  VALUES(	'99092128804'	,	'Louise'	,	'Keuninckx'	,	'Belg'	,	'L.Keuninckx@gmail.com'	,	'V'	,	'79122169768'	,	155	);
INSERT INTO members  VALUES(	'80032190250'	,	'Marie'	,	'Huisjes'	,	'Belg'	,	'M.Huisjes@gmail.com'	,	'V'	,	'80032190250'	,	156	);
INSERT INTO members  VALUES(	'92122817283'	,	'Mila'	,	'Huisjes'	,	'Belg'	,	'MHuisjes@hotmail.com'	,	'V'	,	'80032190250'	,	157	);
INSERT INTO members  VALUES(	'80042022162'	,	'Thomas'	,	'Janssens'	,	'Belg'	,	'T.Janssens@gmail.com'	,	'M'	,	'80042022162'	,	158	);
INSERT INTO members  VALUES(	'70062515974'	,	'Adam'	,	'Goedeman'	,	'Belg'	,	'A.Goedeman@telenet.be'	,	'M'	,	'80042022162'	,	159	);
INSERT INTO members  VALUES(	'07022520496'	,	'Eric'	,	'Goedeman'	,	'Belg'	,	'E.Goedeman@telenet.be'	,	'M'	,	'80042022162'	,	160	);
INSERT INTO members  VALUES(	'80051116569'	,	'Victor'	,	'Witte'	,	'Belg'	,	'V.Witte@gmail.com'	,	'M'	,	'80051116569'	,	161	);
INSERT INTO members  VALUES(	'98011121091'	,	'Jacques'	,	'Witte'	,	'Belg'	,	'J.Witte@gmail.com'	,	'M'	,	'80051116569'	,	162	);
INSERT INTO members  VALUES(	'57121412999'	,	'Lowie'	,	'Witte'	,	'Belg'	,	'LWitte@telenet.be'	,	'M'	,	'80051116569'	,	163	);
INSERT INTO members  VALUES(	'80082254298'	,	'Hans'	,	'Clerinx'	,	'Belg'	,	'HClerinx@hotmail.com'	,	'M'	,	'80082254298'	,	164	);
INSERT INTO members  VALUES(	'81112320180'	,	'Liam'	,	'Clerinx'	,	'Belg'	,	'ClerinxL@gmail.com'	,	'M'	,	'80082254298'	,	165	);
INSERT INTO members  VALUES(	'81102120020'	,	'Willy'	,	'Beervoets'	,	'Belg'	,	'W.Beervoets@gmail.com'	,	'M'	,	'81102120020'	,	166	);
INSERT INTO members  VALUES(	'64081221210'	,	'Dirk'	,	'Aerts'	,	'Belg'	,	'DAerts@hotmail.com'	,	'M'	,	'81102120020'	,	167	);
INSERT INTO members  VALUES(	'62011623947'	,	'Tom'	,	'Aerts'	,	'Belg'	,	'T.Aerts@gmail.com'	,	'M'	,	'81102120020'	,	168	);
INSERT INTO members  VALUES(	'82012291328'	,	'Philippe'	,	'Willems'	,	'Belg'	,	'PWillems@telenet.be'	,	'M'	,	'82012291328'	,	169	);
INSERT INTO members  VALUES(	'98102229882'	,	'Mila'	,	'Tilkens'	,	'Belg'	,	'MTilkens@hotmail.com'	,	'V'	,	'82012291328'	,	170	);
INSERT INTO members  VALUES(	'02052620308'	,	'Louise'	,	'Tilkens'	,	'Belg'	,	'L.Tilkens@telenet.be'	,	'V'	,	'82012291328'	,	171	);
INSERT INTO members  VALUES(	'82052122281'	,	'Jozef'	,	'Klimop'	,	'Belg'	,	'J.Klimop@gmail.com'	,	'M'	,	'82052122281'	,	172	);
INSERT INTO members  VALUES(	'82091756564'	,	'Conrad'	,	'Daniels'	,	'Belg'	,	'DanielsC@gmail.com'	,	'M'	,	'82091756564'	,	173	);
INSERT INTO members  VALUES(	'83062314546'	,	'Kevin'	,	'Geyskens'	,	'Belg'	,	'GeyskensK@gmail.com'	,	'M'	,	'83062314546'	,	174	);
INSERT INTO members  VALUES(	'56032412404'	,	'Leen'	,	'Goedeman'	,	'Belg'	,	'LGoedeman@telenet.be'	,	'V'	,	'83062314546'	,	175	);
INSERT INTO members  VALUES(	'00011078392'	,	'François'	,	'Goedeman'	,	'Belg'	,	'FGoedeman@telenet.be'	,	'M'	,	'83062314546'	,	176	);
INSERT INTO members  VALUES(	'83071815776'	,	'Miet'	,	'Daenen'	,	'Belg'	,	'DaenenM@gmail.com'	,	'V'	,	'83071815776'	,	177	);
INSERT INTO members  VALUES(	'83122220139'	,	'Nicole'	,	'Yilmaz'	,	'Belg'	,	'NYilmaz@hotmail.com'	,	'V'	,	'83122220139'	,	178	);
INSERT INTO members  VALUES(	'84012316807'	,	'Mohamed'	,	'Klawitter'	,	'Belg'	,	'KlawitterM@gmail.com'	,	'M'	,	'84012316807'	,	179	);
INSERT INTO members  VALUES(	'61112113237'	,	'Jonas'	,	'Klawitter'	,	'Belg'	,	'J.Klawitter@gmail.com'	,	'M'	,	'84012316807'	,	180	);
INSERT INTO members  VALUES(	'84081792406'	,	'Kris'	,	'Waterman'	,	'Belg'	,	'WatermanK@gmail.com'	,	'V'	,	'84081792406'	,	181	);
INSERT INTO members  VALUES(	'96111417521'	,	'Juliette'	,	'Waterman'	,	'Belg'	,	'JWaterman@telenet.be'	,	'V'	,	'84081792406'	,	182	);
INSERT INTO members  VALUES(	'91031751442'	,	'Nathalie'	,	'Waterman'	,	'Belg'	,	'WatermanN@gmail.com'	,	'V'	,	'84081792406'	,	183	);
INSERT INTO members  VALUES(	'84092441740'	,	'Patrick'	,	'Appelmans'	,	'Belg'	,	'PAppelmans@telenet.be'	,	'M'	,	'84092441740'	,	184	);
INSERT INTO members  VALUES(	'84101858830'	,	'Magomed'	,	'De Cuyper'	,	'Belg'	,	'MDe Cuyper@telenet.be'	,	'M'	,	'84101858830'	,	185	);
INSERT INTO members  VALUES(	'85021873002'	,	'Joseph'	,	'Kuppens'	,	'Belg'	,	'JKuppens@hotmail.com'	,	'M'	,	'85021873002'	,	186	);
INSERT INTO members  VALUES(	'99012015379'	,	'Jorben'	,	'Kuppens'	,	'Belg'	,	'J.Kuppens@gmail.com'	,	'M'	,	'85021873002'	,	187	);
INSERT INTO members  VALUES(	'86082416926'	,	'Emma'	,	'Kenes'	,	'Belg'	,	'EKenes@telenet.be'	,	'V'	,	'85021873002'	,	188	);
INSERT INTO members  VALUES(	'85061720258'	,	'Anna'	,	'Spaelt'	,	'Belg'	,	'SpaeltA@gmail.com'	,	'V'	,	'85061720258'	,	189	);
INSERT INTO members  VALUES(	'88081822638'	,	'François'	,	'Kuppens'	,	'Belg'	,	'FKuppens@telenet.be'	,	'M'	,	'85061720258'	,	190	);
INSERT INTO members  VALUES(	'85071522336'	,	'Jules'	,	'De Cuyper'	,	'Belg'	,	'J.De Cuyper@telenet.be'	,	'M'	,	'85071522336'	,	191	);
INSERT INTO members  VALUES(	'84032222400'	,	'Isabelle'	,	'Daenen'	,	'Belg'	,	'IDaenen@hotmail.com'	,	'V'	,	'85071522336'	,	192	);
INSERT INTO members  VALUES(	'86011722519'	,	'Bart'	,	'Tilkens'	,	'Belg'	,	'TilkensB@gmail.com'	,	'M'	,	'86011722519'	,	193	);
INSERT INTO members  VALUES(	'87051274692'	,	'Josse'	,	'Jacobs'	,	'Belg'	,	'JJacobs@hotmail.com'	,	'M'	,	'87051274692'	,	194	);
INSERT INTO members  VALUES(	'91012479224'	,	'Tineke'	,	'Jacobs'	,	'Belg'	,	'TJacobs@telenet.be'	,	'V'	,	'87051274692'	,	195	);
INSERT INTO members  VALUES(	'89032376958'	,	'Gratia'	,	'De nayer'	,	'Belg'	,	'De nayerG@gmail.com'	,	'V'	,	'87051274692'	,	196	);
INSERT INTO members  VALUES(	'56081581490'	,	'Eva'	,	'Jacobs'	,	'Belg'	,	'E.Jacobs@telenet.be'	,	'V'	,	'87051274692'	,	197	);
INSERT INTO members  VALUES(	'87111023233'	,	'Christophe'	,	'Goedeman'	,	'Belg'	,	'CGoedeman@telenet.be'	,	'M'	,	'87111023233'	,	198	);
INSERT INTO members  VALUES(	'07052824492'	,	'Gabriel'	,	'Geyskens'	,	'Belg'	,	'GGeyskens@hotmail.com'	,	'M'	,	'87111023233'	,	199	);
INSERT INTO members  VALUES(	'88121643896'	,	'André'	,	'Aerts'	,	'Belg'	,	'A.Aerts@gmail.com'	,	'M'	,	'88121643896'	,	200	);
INSERT INTO members  VALUES(	'90092522757'	,	'Nicolas'	,	'Beervoets'	,	'Belg'	,	'N.Beervoets@telenet.be'	,	'M'	,	'88121643896'	,	201	);
INSERT INTO members  VALUES(	'82031216688'	,	'Gabriel'	,	'Aerts'	,	'Belg'	,	'GAerts@hotmail.com'	,	'M'	,	'88121643896'	,	202	);
INSERT INTO members  VALUES(	'59062013118'	,	'Kyril'	,	'Aerts'	,	'Belg'	,	'K.Aerts@gmail.com'	,	'M'	,	'88121643896'	,	203	);
INSERT INTO members  VALUES(	'89021123352'	,	'Jeannine'	,	'Verstreken'	,	'Belg'	,	'J.Verstreken@telenet.be'	,	'V'	,	'89021123352'	,	204	);
INSERT INTO members  VALUES(	'04072620615'	,	'Christiane'	,	'Verstreken'	,	'Belg'	,	'C.Verstreken@gmail.com'	,	'V'	,	'89021123352'	,	205	);
INSERT INTO members  VALUES(	'89041212166'	,	'Veerle'	,	'Spaelt'	,	'Belg'	,	'VSpaelt@hotmail.com'	,	'V'	,	'89041212166'	,	206	);
INSERT INTO members  VALUES(	'04052776236'	,	'Isabelle'	,	'Spaelt'	,	'Belg'	,	'ISpaelt@hotmail.com'	,	'V'	,	'89041212166'	,	207	);
INSERT INTO members  VALUES(	'89052250364'	,	'Paul'	,	'Willems'	,	'Belg'	,	'PWillems@hotmail.com'	,	'M'	,	'89052250364'	,	208	);
INSERT INTO members  VALUES(	'07042675158'	,	'Jozef'	,	'Yilmaz'	,	'Belg'	,	'J.Yilmaz@gmail.com'	,	'M'	,	'89052250364'	,	209	);
INSERT INTO members  VALUES(	'89072117759'	,	'Marie'	,	'Klimop'	,	'Belg'	,	'M.Klimop@gmail.com'	,	'V'	,	'89072117759'	,	210	);
INSERT INTO members  VALUES(	'88102594562'	,	'Rien'	,	'Klimop'	,	'Belg'	,	'Rien.Klimop@telenet.be'	,	'M'	,	'89072117759'	,	211	);
INSERT INTO members  VALUES(	'90112765628'	,	'Ann'	,	'Haest'	,	'Belg'	,	'AHaest@hotmail.com'	,	'V'	,	'90112765628'	,	212	);
INSERT INTO members  VALUES(	'90101617164'	,	'Louise'	,	'Hons'	,	'Belg'	,	'L.Hons@gmail.com'	,	'V'	,	'90112765628'	,	213	);
INSERT INTO members  VALUES(	'04031325570'	,	'Mohamed'	,	'Haest'	,	'Belg'	,	'HaestM@gmail.com'	,	'M'	,	'90112765628'	,	214	);
INSERT INTO members  VALUES(	'91052312285'	,	'Marijke'	,	'Vanneste'	,	'Belg'	,	'VannesteM@gmail.com'	,	'V'	,	'91052312285'	,	215	);
INSERT INTO members  VALUES(	'80011239584'	,	'Marc'	,	'Vandenborre'	,	'Belg'	,	'MVandenborre@hotmail.com'	,	'M'	,	'91052312285'	,	216	);
INSERT INTO members  VALUES(	'05031977314'	,	'Bart'	,	'Vanneste'	,	'Belg'	,	'VannesteB@gmail.com'	,	'M'	,	'91052312285'	,	217	);
INSERT INTO members  VALUES(	'91071223471'	,	'Olivier'	,	'Klawitter'	,	'Belg'	,	'OKlawitter@hotmail.com'	,	'M'	,	'91071223471'	,	218	);
INSERT INTO members  VALUES(	'88091517045'	,	'Olivia'	,	'Franssen'	,	'Belg'	,	'O.Franssen@telenet.be'	,	'V'	,	'91071223471'	,	219	);
INSERT INTO members  VALUES(	'92062796718'	,	'Mark'	,	'Tilkens'	,	'Belg'	,	'MTilkens@telenet.be'	,	'M'	,	'92062796718'	,	220	);
INSERT INTO members  VALUES(	'94111997796'	,	'Eline'	,	'Kuppens'	,	'Belg'	,	'KuppensE@gmail.com'	,	'V'	,	'92062796718'	,	221	);
INSERT INTO members  VALUES(	'05051315141'	,	'Atakan'	,	'Tilkens'	,	'Belg'	,	'TilkensA@gmail.com'	,	'M'	,	'92062796718'	,	222	);
INSERT INTO members  VALUES(	'92102622876'	,	'Christian'	,	'Kenes'	,	'Belg'	,	'C.Kenes@gmail.com'	,	'M'	,	'92102622876'	,	223	);
INSERT INTO members  VALUES(	'92111346052'	,	'Monique'	,	'Kenes'	,	'Belg'	,	'KenesM@gmail.com'	,	'V'	,	'92111346052'	,	224	);
INSERT INTO members  VALUES(	'86091893484'	,	'Gert'	,	'Janssens'	,	'Belg'	,	'GJanssens@telenet.be'	,	'M'	,	'92111346052'	,	225	);
INSERT INTO members  VALUES(	'94061317402'	,	'Alice'	,	'Willems'	,	'Belg'	,	'WillemsA@gmail.com'	,	'V'	,	'94061317402'	,	226	);
INSERT INTO members  VALUES(	'94122722995'	,	'Tom'	,	'Spaelt'	,	'Belg'	,	'TSpaelt@hotmail.com'	,	'M'	,	'94122722995'	,	227	);
INSERT INTO members  VALUES(	'96021098874'	,	'Tom'	,	'Beervoets'	,	'Belg'	,	'TBeervoets@telenet.be'	,	'M'	,	'96021098874'	,	228	);
INSERT INTO members  VALUES(	'98082115498'	,	'Jordy'	,	'Beervoets'	,	'Belg'	,	'J.Beervoets@gmail.com'	,	'M'	,	'96021098874'	,	229	);
INSERT INTO members  VALUES(	'59121018711'	,	'Luc'	,	'Daniels'	,	'Belg'	,	'Luc.Daniels@telenet.be'	,	'M'	,	'96021098874'	,	230	);
INSERT INTO members  VALUES(	'96041172426'	,	'Ben'	,	'Keuninckx'	,	'Belg'	,	'B.Keuninckx@gmail.com'	,	'M'	,	'96041172426'	,	231	);
INSERT INTO members  VALUES(	'96072048208'	,	'Martine'	,	'Hons'	,	'Belg'	,	'M.Hons@gmail.com'	,	'V'	,	'96072048208'	,	232	);
INSERT INTO members  VALUES(	'94071070160'	,	'Jordy'	,	'Huyghe'	,	'Belg'	,	'JHuyghe@telenet.be'	,	'M'	,	'96072048208'	,	233	);
INSERT INTO members  VALUES(	'98091280548'	,	'Christian'	,	'Vandenborre'	,	'Belg'	,	'CVandenborre@hotmail.com'	,	'M'	,	'98091280548'	,	234	);
INSERT INTO members  VALUES(	'85042518042'	,	'Lies'	,	'Tilkens'	,	'Belg'	,	'LTilkens@telenet.be'	,	'V'	,	'98091280548'	,	235	);
INSERT INTO members  VALUES(	'98122333904'	,	'Jan'	,	'Vanneste'	,	'Belg'	,	'J.Vanneste@gmail.com'	,	'M'	,	'98122333904'	,	236	);
INSERT INTO members  VALUES(	'99031020972'	,	'Peter'	,	'Appelmans'	,	'Belg'	,	'peterAppelmans@telenet.be'	,	'M'	,	'99031020972'	,	237	);
INSERT INTO members  VALUES(	'83022421258'	,	'Lucas'	,	'Daniels'	,	'Belg'	,	'LDaniels@telenet.be'	,	'M'	,	'99031020972'	,	238	);
INSERT INTO members  VALUES(	'65042462222'	,	'Johan'	,	'Daniels'	,	'Belg'	,	'JDaniels@telenet.be'	,	'M'	,	'99031020972'	,	239	);
INSERT INTO members  VALUES(	'99101231638'	,	'Dennis'	,	'Spaelt'	,	'Belg'	,	'D.Spaelt@telenet.be'	,	'M'	,	'99101231638'	,	240	);


Prompt --> insert data into the address_types table
INSERT INTO address_types VALUES('D', 'domicilie');
INSERT INTO address_types VALUES('C', 'correspondentie');
INSERT INTO address_types VALUES('K', 'kot');



Prompt --> insert data into the address_members table
INSERT INTO address_members VALUES('63072845621', 'D', 100);
INSERT INTO address_members VALUES('63072845621', 'C', 101);
INSERT INTO address_members VALUES('04051055671', 'D', 100);
INSERT INTO address_members VALUES('65112372496', 'D', 100);

INSERT INTO address_members VALUES('111222333', 'D', 103);
INSERT INTO address_members VALUES('111222333', 'K', 104);

INSERT INTO address_members VALUES('123456782', 'D', 102);
INSERT INTO address_members VALUES('123456782', 'K', 105);

DECLARE
   v_ad_id    address_members.address_id%type := 105;
   v_previous_national_id  members.national_id%type := '0';
   v_counter  number(1);
BEGIN
   FOR rec IN (SELECT * from members 
               WHERE national_id not in ('63072845621','04051055671', '65112372496', '111222333', '123456782')
               ORDER BY national_id_payer)  LOOP
      IF rec.national_id_payer != v_previous_national_id THEN
         v_previous_national_id := rec.national_id_payer;
         v_ad_id := v_ad_id + 1;
      END IF;
      INSERT INTO address_members VALUES(rec.national_id, 'D', v_ad_id);
   END LOOP;
   FOR rec in (SELECT * from members 
               WHERE national_id not in ('63072845621','04051055671', '65112372496', '111222333', '123456782')
               AND to_number(substr(national_id, 1, 2) ) in (1, 0, 99, 98, 97, 96, 95, 94) 
               ORDER BY national_id_payer)  LOOP
      v_ad_id := v_ad_id + 1;
      INSERT INTO address_members VALUES(rec.national_id, 'K', v_ad_id);
   END LOOP;
   v_counter := 0;
   FOR rec IN (SELECT * from members 
               WHERE national_id not in ('63072845621','04051055671', '65112372496', '111222333', '123456782')
               AND mod(tijdelijk, 4) = 0
               ORDER BY national_id_payer)  LOOP
         v_ad_id := v_ad_id + 1;
         INSERT INTO address_members VALUES(rec.national_id, 'C', v_ad_id);
   END LOOP;
END;
/


Prompt --> insert data into the locations table
INSERT INTO locations VALUES('ZW', 'Stedelijk zwembad', 'Kapermolen', 1);
INSERT INTO locations VALUES('ZZW', 'Sportzaaltje zwembad', 'Kapermolen', 1);
INSERT INTO locations VALUES('SK', 'Skatepark', 'Kapermolen', 1);
INSERT INTO locations VALUES('SP', 'Stadspark', 'Stadspark Hasselt aan het Cultuur Centrum', null);
INSERT INTO locations VALUES('K', 'Sportcentrum Kiewit', 'atletiekpiste', 2);
INSERT INTO locations VALUES('KZ', 'Sportcentrum Kiewit', 'sportzaal', 2);
 

Prompt --> insert data into the sports table
INSERT INTO sports VALUES('AF', 'Aquafit', 'Versterken van de spiergroepen en verbeteren van de conditie door middel van ....');
set define off
INSERT INTO sports VALUES('KKF', 'Kick & Fun', 'Houd je van boksen en wil je heerlijk uit je bol gaan...');
set define on
INSERT INTO sports VALUES('KR', 'krolf', 'Initiatie: de spelregels worden uitgelegd... Krolf is een samentrekking van "croquet" en "golf".....');
INSERT INTO sports VALUES('NW', 'nordic walking', 'Initiatie: je wordt ingewijd in de juiste techniek van .....');
INSERT INTO sports VALUES('SB', 'Skateboard', ' De jongeren worden ingedeeld in kleine groepjes en begeleid door jongeren die zelf al jaren skaten. Eens ze de basisvaardigheden meester zijn...');
INSERT INTO sports VALUES('PA', 'Start2padel', 'Padel is een racketsport met ingrediënten uit o.a. tennis en squash. Het is een terugslagspel ...');
INSERT INTO sports VALUES('ZV', 'Zwemmen voor volwassenen', 'Wij bieden zwemles aan in verschillende zwemtechnieken en verschillende niveaugroepen. ');
INSERT INTO sports VALUES('ZG', 'Zwemmen - goud', 'Beginnende zwemmers leren we de basistechnieken van schoolslag aan. Als je al een beetje kan zwemmen, verfijnen we de basistechniek van schoolslag en/of leren we je crawl aan.');
INSERT INTO sports VALUES('P', 'Pilates', 'Pilates is een fitness groepsles, in de 20e eeuw ontwikkeld door de legendarische Joseph Pilates.');
INSERT INTO sports VALUES('Y', 'Lu Jon yoga', 'Lu Jong yoga is zeer toegankelijk, het zijn eenvoudige yoga oefeningen die door iedereen kunnen worden uitgevoerd. Het is een eeuwenoude reeks van oefeningen....');

      

Prompt --> insert data into the activities table
INSERT INTO activities VALUES('19/SB01', 'SB', 2004, 2011, 'vzw Ninja', 'SK', 20, to_date('10:00', 'hh24:mi'), to_date('11:00', 'hh24:mi'), 30, sysdate);
INSERT INTO activities VALUES('20/SB01', 'SB', 2005, 2012, 'vzw Ninja', 'SK', 20, to_date('10:00', 'hh24:mi'), to_date('11:00', 'hh24:mi'), 32, sysdate);
INSERT INTO activities VALUES('20/SB02', 'SB', 2005, 2012, 'vzw Ninja', 'SK', 20, to_date('10:00', 'hh24:mi'), to_date('11:00', 'hh24:mi'), 32, sysdate);

DECLARE
   v_sportid       activities.sport_id%type;
   v_actyear       NUMBER(2);
   v_syear         activities.startyear%type;
   v_eyear         activities.endyear%type;
   v_loc           locations.location_id%type;
   v_price         activities.price%type;
   v_count         NUMBER(2) := 1;
BEGIN 
   FOR rec in (SELECT * from sports WHERE sport_type != 'SB') LOOP
      v_count := 1;
      v_actyear := 19;
      IF rec.sport_type IN ('ZG', 'ZV','AF') THEN
             v_loc := 'ZW';
             v_price := 25;
      ELSIF rec.sport_type = 'KKF' THEN
             v_loc := 'ZZW';
             v_price := 50;
      ELSIF rec.sport_type = 'KR' THEN
             v_loc := 'SP';
             v_price := 0;
      ELSE
             v_loc := 'K';
             v_price := 34;
      END IF;
      WHILE v_count <= 2 LOOP
         v_sportid := v_actyear || '/' || rec.sport_type || '0' || v_count;
         INSERT INTO activities VALUES(v_sportid, rec.sport_type, 1919, 2001, null, v_loc, mod(v_price+1,4)*10, to_date('20:00', 'hh24:mi'), to_date('21:00', 'hh24:mi'), v_price, sysdate);
         v_count := v_count + 1;
      END LOOP;
      v_count := 1;
      v_actyear := 20;
      v_price := trunc(v_price * 1.2);
      WHILE v_count <= 4 LOOP
         v_sportid := v_actyear || '/' || rec.sport_type || '0' || v_count;
         INSERT INTO activities VALUES(v_sportid, rec.sport_type, 1920, 2002, null, v_loc, mod(v_price+1,4)*10, to_date('20:00', 'hh24:mi'), to_date('21:00', 'hh24:mi'), v_price, sysdate);
         v_count := v_count + 1;
      END LOOP;
   END LOOP;
END;
/
UPDATE activities set starttime = starttime - 1.5/24, endtime = endtime - 1.5/24
WHERE sport_id like '%03';
UPDATE activities set starttime = starttime + 0.5/24, endtime = endtime + 0.5/24
WHERE sport_id like '%02';
UPDATE activities set partner = 'krolf Hasselt' where sport_type = 'KR';
UPDATE activities SET location_id = 'KZ'
WHERE substr(sport_id, -1,1) IN ('2', '4') AND sport_id LIKE '%KKF%';
UPDATE activities SET sport_id = sport_id || '*'
WHERE sport_id = '19/KKF02' OR sport_id = '20/KKF03';
UPDATE activities SET sport_id = sport_id || '**' WHERE sport_id = '20/KKF04';



-- inschrijvingseinddatum wordt aangepast nadat de activity dates gevuld zijn

Prompt --> insert data into the activity_dates table
-- SB op zondag (4x)
DECLARE
   v_date1    date := next_day(to_date('01 11 2019', 'dd mm yyyy'), 'sunday');
   v_date2    date := next_day(to_date('20 01 2020', 'dd mm yyyy'), 'sunday');
   v_date3    date := next_day(to_date('01 04 2020', 'dd mm yyyy'), 'sunday');
   v_count    number(1) := 1;
BEGIN
   WHILE v_count <= 4 LOOP
      INSERT INTO activity_dates VALUES('19/SB01', v_date1 + 7 * v_count);
      INSERT INTO activity_dates VALUES('20/SB01', v_date2 + 7 * v_count);
      INSERT INTO activity_dates VALUES('20/SB02', v_date3 + 7 * v_count);
      v_count := v_count + 1;
   END LOOP;
END;
/

-- NW en KR in weekend, telkens 1 keer
DECLARE
   v_date1    date := to_date('01 09 2019', 'dd mm yyyy');
   v_count    number(1);
BEGIN
   FOR rec in (SELECT  * from activities 
               where sport_type IN ('NW', 'KR') 
               ORDER BY substr(sport_id, 1,2), substr(sport_id, -2, 2) ) LOOP
        INSERT INTO activity_dates VALUES(rec.sport_id, v_date1);
        v_date1 := v_date1 + 35;
   END LOOP;
END;
/

-- al de rest op weekdagen, telkens 5 keer
DECLARE
   v_date1    date := to_date('05 08 2019', 'dd mm yyyy');
   v_count    number(1);
BEGIN
   FOR rec in (SELECT  * from activities 
               where sport_type NOT IN ('SB', 'NW', 'KR') and sport_id like '19%'
               ORDER BY substr(sport_id, -2, 2) ) LOOP
      v_count   := 0;
      WHILE v_count <= 4 LOOP
         INSERT INTO activity_dates VALUES(rec.sport_id, v_date1 + 7 * v_count);
         v_count := v_count + 1;
      END LOOP;
      IF to_char(v_date1, 'dy') = 'fri' THEN
         v_date1 := v_date1 + 38;
      ELSE
        v_date1 := v_date1 + 1;
      END IF;
   END LOOP;

   v_date1 := to_date('06 01 2020', 'dd mm yyyy');
   FOR rec in (SELECT  * from activities 
               where sport_type NOT IN ('SB', 'NW', 'KR') and sport_id like '20%'
               ORDER BY substr(sport_id, -2, 2) ) LOOP
      v_count   := 0;
      WHILE v_count <= 4 LOOP
         INSERT INTO activity_dates VALUES(rec.sport_id, v_date1 + 7 * v_count);
         v_count := v_count + 1;
      END LOOP;
      IF to_char(v_date1, 'dy') = 'fri' THEN
         v_date1 := v_date1 + 38;
      ELSE
        v_date1 := v_date1 + 1;
      END IF;
   END LOOP;
END;
/

UPDATE activities a set subscription_enddate = (select min(sport_date) -2
                                                from activity_dates ad
                                                where a.sport_id = ad.sport_id);


Prompt --> insert data into the subscription_dates table
DECLARE
   v_date   DATE;
   v_start  DATE;
BEGIN
   FOR rec in (SELECT * FROM activities) LOOP
      SELECT min(sport_date) INTO v_start
      FROM activity_dates a
      WHERE rec.sport_id = a.sport_id;
      v_date := least(v_start-20, to_date('02 01 2020','dd mm yyyy'));
      INSERT INTO subscription_dates VALUES(rec.sport_id, 'A', v_date);
      IF rec.sport_type like 'Z%' or rec.sport_type like 'P%' THEN
         INSERT INTO subscription_dates VALUES(rec.sport_id, 'H', v_date-2);
      END IF;
   END LOOP;
END;
/

Prompt --> insert data into the reservations table
INSERT INTO reservations (national_id, sport_id)
   select national_id, '19/SB01' from members where national_id like '04%' or national_id like '05%';
INSERT INTO reservations (national_id, sport_id)
   select national_id, '20/SB01' from members where national_id like '07%';
INSERT INTO reservations (national_id, sport_id)
   select national_id, '20/SB02' from members 
   where (national_id like '07%' or national_id like '05%')
   and (national_id like '%4' or national_id like '%6' or national_id like '%8');

DECLARE
   v_national_id     members.national_id%type;
   v_temp            NUMBER(3) := -1;
BEGIN
   FOR rec in (SELECT * from activities
               WHERE sport_type != 'SB') LOOP
      FOR i IN 1 .. rec.max_participants LOOP
         IF v_temp = 239 THEN
            v_temp := 0;
         ELSIF v_temp = 240 THEN
            v_temp := -1;
         END IF;
         SELECT national_id, tijdelijk
         INTO v_national_id, v_temp
         FROM members
         WHERE tijdelijk = v_temp + 2;
         IF v_national_id not like '04%' and v_national_id not like '05%' and v_national_id not like '07%' THEN
            INSERT INTO reservations VALUES(v_national_id, rec.sport_id);
         END IF;
      END LOOP;
   END LOOP;
END;
/

COMMIT;

ALTER TABLE members DROP COLUMN tijdelijk;
