REM   Script:   creatie tabellen voor puntenadministratie PXL

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
DROP table performance_dates cascade constraints;
DROP table actors cascade constraints;
DROP table performances cascade constraints;
DROP table performance_actors cascade constraints;
DROP table reservations cascade constraints;
DROP table subscribers cascade constraints;
DROP table reservation_spectators cascade constraints;
DROP table spectators cascade constraints;
DROP table reservation_performances cascade constraints;
DROP TABLE rehearsals cascade constraints;
DROP TABLE locations cascade constraints;
DROP TABLE zip_codes cascade constraints;
DROP TABLE rehearsal_actors cascade constraints;



Prompt ******  Creating zip_codes table....

CREATE TABLE zip_codes
    ( zip_code                 NUMBER(4)
		   CONSTRAINT  zip_PK PRIMARY KEY 
		   CONSTRAINT  zip_code_chk CHECK (zip_code >= 1000)
    , city                     VARCHAR2(25)
	       CONSTRAINT  zip_city_nn  NOT NULL
    ) ;


Prompt ******  Creating locations table ....

CREATE TABLE locations
    ( location_id              NUMBER(2) 
           CONSTRAINT  loc_PK PRIMARY KEY
    , address                  VARCHAR2(25) 
		   CONSTRAINT  loc_addr_nn  NOT NULL
	, zip_code                 NUMBER(4) 
		   CONSTRAINT  loc_zip_FK  REFERENCES zip_codes
		   CONSTRAINT  loc_zip_nn  NOT NULL
    );


Prompt ******  Creating performances table ....

CREATE TABLE performances 
    ( theatre_performance      VARCHAR2(40)
    , season                   VARCHAR2(25) 
    , producer                 VARCHAR2(25) 
		   CONSTRAINT perf_prod_nn  NOT NULL
    , description     		   VARCHAR2(250) 
		   CONSTRAINT perf_desc_nn  NOT NULL
	, price_ticket             NUMBER(5, 2)
	       CONSTRAINT perf_price_chk CHECK (price_ticket >= 5 AND price_ticket < 50)
    , CONSTRAINT  perf_PK PRIMARY KEY(theatre_performance, season)
	) ;
	

Prompt ******  Creating actors table ....

CREATE TABLE actors
    ( actor_id    NUMBER(4)      
	       CONSTRAINT  actor_PK PRIMARY KEY 
	, actor_name VARCHAR2(25)
		   CONSTRAINT  actor_name_nn  NOT NULL
	, actor_firstname VARCHAR2(25)
		   CONSTRAINT  actor_fname_nn  NOT NULL
	, known_from VARCHAR2(100)
    ) ;


Prompt ******  Creating performance_actors table ....

CREATE TABLE performance_actors
    ( theatre_performance      VARCHAR2(40)
    , season                   VARCHAR2(25) 
    , actor_id                 NUMBER(4) 
	       CONSTRAINT  perfact_act_nn  NOT NULL
		   CONSTRAINT  perfact_act_FK  REFERENCES actors
    , CONSTRAINT  perfact_PK PRIMARY KEY(theatre_performance, season, actor_id)
    , CONSTRAINT  perfact_FK FOREIGN KEY(theatre_performance, season) REFERENCES performances	
    ) ;
	

Prompt ******  Creating performance_dates table ....

CREATE TABLE performance_dates
    ( theatre_performance      VARCHAR2(40)
    , season                   VARCHAR2(25) 
    , date_time                DATE
	       CONSTRAINT  perfdat_dat_nn  NOT NULL
    , CONSTRAINT  perfdat_PK PRIMARY KEY(theatre_performance, date_time)
    , CONSTRAINT  perfdat_FK FOREIGN KEY(theatre_performance, season) REFERENCES performances
    ) ;


Prompt ******  Creating subscribers table ....

CREATE TABLE subscribers
     ( subscriber_id           NUMBER(8)      
	       CONSTRAINT  subscr_PK PRIMARY KEY 
	 , subscriber_name         VARCHAR2(25)
		   CONSTRAINT  subscr_name_nn  NOT NULL
	 , subscriber_firstname    VARCHAR2(25)
		   CONSTRAINT  subscr_fname_nn  NOT NULL
     , address                 VARCHAR2(25) 
		   CONSTRAINT  subscr_addr_nn  NOT NULL
	 , zip_code                NUMBER(4) 
		   CONSTRAINT  subscr_zip_FK  REFERENCES zip_codes
		   CONSTRAINT  subscr_zip_nn  NOT NULL
     , telephone               VARCHAR2(25) 
	 , email                   VARCHAR2(40)
	       CONSTRAINT  subscr_email_chk CHECK (email like '%@%.%')
     ) ;
	

Prompt ******  Creating reservations table ....

CREATE TABLE reservations
     ( reservation_id         NUMBER(8)
	 	   CONSTRAINT  res_PK PRIMARY KEY 
		   CONSTRAINT  res_id_chk CHECK (reservation_id >= 10000000)
	 , subscriber_id          NUMBER(8)
		   CONSTRAINT  res_subscr_FK  REFERENCES subscribers
 		   CONSTRAINT  res_subscr_nn  NOT NULL
     , comments                VARCHAR2(250)
	 ) ;
	
	   
Prompt ******  Creating spectators table ....

CREATE TABLE spectators
     ( spectator_id            NUMBER(8)      
	       CONSTRAINT  spec_PK PRIMARY KEY 
	 , spectator_name          VARCHAR2(25)
		   CONSTRAINT  spec_name_nn  NOT NULL
	 , spectator_firstname     VARCHAR2(25)
		   CONSTRAINT  spec_fname_nn  NOT NULL
	 ) ;


Prompt ******  Creating reservation_spectators table ....

CREATE TABLE reservation_spectators
     ( reservation_id          NUMBER(8)
	 	   CONSTRAINT resspec_res_FK REFERENCES reservations
	 , spectator_id            NUMBER(8)   
	 	   CONSTRAINT resspec_spec_FK REFERENCES spectators
	 , CONSTRAINT resspec_PK PRIMARY KEY(reservation_id, spectator_id)
     ) ;


Prompt ******  Creating reservation_performances table ....

CREATE TABLE reservation_performances
     ( reservation_id          NUMBER(8)
	 	   CONSTRAINT resperf_res_FK REFERENCES reservations
	 , theatre_performance     VARCHAR2(40)
     , date_time               DATE
	       CONSTRAINT resperf_dat_nn  NOT NULL
    , CONSTRAINT resperf_PK PRIMARY KEY(reservation_id, theatre_performance)
	, CONSTRAINT resperf_FK FOREIGN KEY(theatre_performance, date_time) REFERENCES performance_dates
    ) ;
	
	
Prompt ******  Creating rehearsals table ....

CREATE TABLE rehearsals
     ( theatre_performance     VARCHAR2(40)
     , date_starttime          DATE
	       CONSTRAINT reh_sdat_nn  NOT NULL
     , date_endtime            DATE
	       CONSTRAINT reh_edat_nn  NOT NULL	
     , location_id             NUMBER(2) 
		   CONSTRAINT reh_loc_nn  NOT NULL
		   CONSTRAINT reh_loc_FK REFERENCES locations		   
    , CONSTRAINT  reh_PK PRIMARY KEY(theatre_performance, date_starttime)
    ) ;
	

Prompt ******  Creating rehearsal_actors table ....

CREATE TABLE rehearsal_actors
     ( theatre_performance     VARCHAR2(40)
     , date_starttime          DATE
	 , actor_id                NUMBER(4) 
	       CONSTRAINT rehact_act_nn  NOT NULL	
	       CONSTRAINT rehact_act_FK  REFERENCES actors	
    , CONSTRAINT  rehact_PK PRIMARY KEY(date_starttime, actor_id)
    , CONSTRAINT  rehact_FK FOREIGN KEY(theatre_performance, date_starttime) REFERENCES rehearsals
    ) ;

COMMIT;

Prompt --> insert data into the zip_codes table
INSERT INTO zip_codes VALUES(3400, 'Landen');
INSERT INTO zip_codes VALUES(3500, 'Hasselt');
INSERT INTO zip_codes VALUES(3600, 'Genk');
INSERT INTO zip_codes VALUES(3700, 'Tongeren');
INSERT INTO zip_codes VALUES(3800, 'St-Truiden');
INSERT INTO zip_codes VALUES(3850, 'Nieuwerkerken');


Prompt --> insert data into the locations table
INSERT INTO locations VALUES(1, 'Rijschoolstraat 51', 3800);
INSERT INTO locations VALUES(2, 'Kerkstraat 21', 3850);


Prompt --> insert data into the performances table
INSERT INTO performances VALUES('Mama breekt uit!', '2016 - 2017', 'Het Prethuis', 'Mama voelt zich slavin van het huis.  Ze is het grondig beu', 18.5);

INSERT INTO performances VALUES('Vriendinnen', '2017 - 2018', 'Roxy Theaterproducties', 'Zussen kunnen de beste vriendinnen zijn... of niet.', 12);
INSERT INTO performances VALUES('Stilte voor de storm', '2017 - 2018', 'Loge 10 theaterproducties', 'Ria is haar baas meer dan beu.  Voorlopig houdt ze zich nog in, maar hoe lang nog???', 21);
INSERT INTO performances VALUES('De IT-er', '2017 - 2018', 'Roxy Theaterproducties', 'Bert geeft zich uit voor gediplomeerd informaticus.  Op een dag wordt hij uitgestuurd naar een bedrijf waar een vroegere klasgenoot van hem werkt...', 14);
INSERT INTO performances VALUES('De eerste minister', '2017 - 2018', 'Roxy Theaterproducties', 'De eerste minister leeft voor zijn werk, heeft nergens tijd voor, is erg nuchter...tot hij op een dag een nieuwe secretaresse krijgt', 12);

INSERT INTO performances VALUES('Verhuur: een vreemd koppel', '2018 - 2019', 'M-Theater', 'Zes vriendinnen spelen elke vrijdagavond Trivial Pursuit in het appartement van Marie. Op één van deze avonden vertelt Floor dat haar huwelijk voorbij is.', 9);
INSERT INTO performances VALUES('Een inspecteur belt aan', '2018 - 2019', 'Loge 10 theaterproducties', 'Het verlovingsfeest bij de familie Birling wordt ruw verstoord wanneer een inspecteur aanbelt.', 18);
INSERT INTO performances VALUES('De Quaghebeurs', '2018 - 2019', 'Roxy Theaterproducties', 'Een funeraire komedie! Willy Quaghebeur, eigenaar van de Brasserie Petit Paris, komt te overlijden. De vier kinderen worden op de hoogte gebracht....', 16);
INSERT INTO performances VALUES('Vriendinnen', '2018 - 2019', 'Paljas producties', 'gaat over een levenslange vriendschap tussen Maria en Florentine. We volgen beide vrouwen vanaf hun jeugdjaren (vlak na WO II) tot....', 15);
INSERT INTO performances VALUES('Stilte, we draaien!', '2018 - 2019', 'Loge 10 theaterproducties', 'Een filmploeg is neergestreken in het theater voor het draaien van een langspeelfilm. Vandaag nemen ze de scène op waarin de bedrogen echtgenoot een voorstelling stillegt om de minnaar van zijn vrouw te vermoorden.', 21);
INSERT INTO performances VALUES('De reunie', '2018 - 2019', 'Roxy Theaterproducties', 'Het Virgo Fidelisinstituuut organiseert een grote reunie naar aanleiding van het 150 jaar bestaan van de school.', 14);
INSERT INTO performances VALUES('Guernica', '2018 - 2019', 'Roxy Theaterproducties', 'Een man in een Spaanse luchthaven. Zijn schoenen kwijtgespeeld bij de controle. Vrije wereld? Mijn voeten!', 12);
INSERT INTO performances VALUES('Blind getrouwd', '2018 - 2019', 'Het Prethuis', 'Marc en Francine maken zich grote zorgen over het liefdesleven van hun dochter. Steeds komt ze thuis met een jongen die niet echt naar de zin is ....', 18);
INSERT INTO performances VALUES('Oude koeien aan de Costa Del Sol', '2018 - 2019', 'Paljas producties', 'Rita en Nicole, twee lustige weduwen, zijn dringend aan vakantie toe...', 15);
INSERT INTO performances VALUES('Taxi taxi', '2018 - 2019', 'Roxy Theaterproducties', 'Taxichauffeur John leidt al jaren een dubbelleven. Hij is immers samen met twee vrouwen.', 15);


Prompt --> insert data into the performance_dates table
INSERT INTO performance_dates VALUES('Mama breekt uit!', '2016 - 2017', to_date('20170420 20:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Mama breekt uit!', '2016 - 2017', to_date('20170422 20:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Mama breekt uit!', '2016 - 2017', to_date('20170424 20:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Mama breekt uit!', '2016 - 2017', to_date('20170426 20:00', 'yyyymmdd hh24:mi'));

INSERT INTO performance_dates VALUES('Vriendinnen', '2017 - 2018', to_date('20171126 20:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Vriendinnen', '2017 - 2018', to_date('20171127 20:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Stilte voor de storm', '2017 - 2018', to_date('20180122 20:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Stilte voor de storm', '2017 - 2018', to_date('20180125 20:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('De IT-er', '2017 - 2018', to_date('20180316 20:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('De IT-er', '2017 - 2018', to_date('20180318 20:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('De eerste minister', '2017 - 2018', to_date('20180528 20:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('De eerste minister', '2017 - 2018', to_date('20180529 20:00', 'yyyymmdd hh24:mi'));

INSERT INTO performance_dates VALUES('Verhuur: een vreemd koppel', '2018 - 2019', to_date('20181001 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Verhuur: een vreemd koppel', '2018 - 2019', to_date('20181002 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Verhuur: een vreemd koppel', '2018 - 2019', to_date('20181003 15:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Een inspecteur belt aan', '2018 - 2019', to_date('20181116 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Een inspecteur belt aan', '2018 - 2019', to_date('20181117 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Een inspecteur belt aan', '2018 - 2019', to_date('20181118 15:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Een inspecteur belt aan', '2018 - 2019', to_date('20181123 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Een inspecteur belt aan', '2018 - 2019', to_date('20181124 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Een inspecteur belt aan', '2018 - 2019', to_date('20181125 15:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('De Quaghebeurs', '2018 - 2019', to_date('20181206 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('De Quaghebeurs', '2018 - 2019', to_date('20181207 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('De Quaghebeurs', '2018 - 2019', to_date('20181208 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('De Quaghebeurs', '2018 - 2019', to_date('20181209 15:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Vriendinnen', '2018 - 2019', to_date('20190118 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Vriendinnen', '2018 - 2019', to_date('20190119 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Vriendinnen', '2018 - 2019', to_date('20190120 15:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Stilte, we draaien!', '2018 - 2019', to_date('20190202 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Stilte, we draaien!', '2018 - 2019', to_date('20190203 15:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Stilte, we draaien!', '2018 - 2019', to_date('20190204 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('De reunie', '2018 - 2019', to_date('20190301 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('De reunie', '2018 - 2019', to_date('20190302 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('De reunie', '2018 - 2019', to_date('20190303 15:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Guernica', '2018 - 2019', to_date('20190321 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Guernica', '2018 - 2019', to_date('20190322 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Guernica', '2018 - 2019', to_date('20190323 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Blind getrouwd', '2018 - 2019', to_date('20190524 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Blind getrouwd', '2018 - 2019', to_date('20190525 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Blind getrouwd', '2018 - 2019', to_date('20190526 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Oude koeien aan de Costa Del Sol', '2018 - 2019', to_date('20190426 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Oude koeien aan de Costa Del Sol', '2018 - 2019', to_date('20190427 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Oude koeien aan de Costa Del Sol', '2018 - 2019', to_date('20190428 15:00', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Taxi taxi', '2018 - 2019', to_date('20190510 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Taxi taxi', '2018 - 2019', to_date('20190511 20:15', 'yyyymmdd hh24:mi'));
INSERT INTO performance_dates VALUES('Taxi taxi', '2018 - 2019', to_date('20190517 20:15', 'yyyymmdd hh24:mi'));


Prompt --> insert data into the actors table
INSERT INTO actors VALUES(1, 'Jacobs', 'Mish', null);
INSERT INTO actors VALUES(2, 'Jaels', 'Hedwige', null);
INSERT INTO actors VALUES(3, 'Deroose', 'Annicka', null);
INSERT INTO actors VALUES(4, 'Smets', 'Maaike', null);
INSERT INTO actors VALUES(5, 'Briers', 'Jurgen', null);
INSERT INTO actors VALUES(6, 'Degeling', 'Guy', null);
INSERT INTO actors VALUES(7, 'Crooberghs', 'Andrea', null);
INSERT INTO actors VALUES(8, 'Pira', 'Ann', 'Thuis');
INSERT INTO actors VALUES(9, 'Vandenheuvel', 'Loes', 'FC De kampioenen');
INSERT INTO actors VALUES(10, 'Roers', 'Ben', null);
INSERT INTO actors VALUES(11, 'Jacobs', 'Karin', null);
INSERT INTO actors VALUES(12, 'Goris', 'Erik', null);
INSERT INTO actors VALUES(13, 'Jamers', 'Raf', null);
INSERT INTO actors VALUES(14, 'Reekmans', 'Cynthia', 'Miss Belgian Beauty');
INSERT INTO actors VALUES(15, 'Caas', 'Kevin', null);
INSERT INTO actors VALUES(16, 'Daecke', 'Bart', null);
INSERT INTO actors VALUES(17, 'Tolms', 'Bert', null);
INSERT INTO actors VALUES(18, 'Torfs', 'Thomas', null);
INSERT INTO actors VALUES(19, 'Hulmans', 'Kurt', null);
INSERT INTO actors VALUES(20, 'Bhus', 'Jef', null);



Prompt --> insert data into the performance_actors table
DECLARE
  letter    VARCHAR2(1);
  letternr  NUMBER := 7;
BEGIN
  FOR trec in (SELECT theatre_performance, season FROM performances) LOOP
    letter := substr(trec.theatre_performance, letternr, 1);
	IF letter = ' ' OR letter = ',' OR letter = 'e' OR letter = 'o' THEN
	   letter := 't';
	ELSIF letter = 's' THEN
	   letter := 'k';
	END IF;
	INSERT INTO performance_actors 
	   SELECT trec.theatre_performance, trec.season, a.actor_id
	   FROM actors a
	   WHERE lower(a.actor_name) like '%' || lower(letter) || '%';
  END LOOP;
END;
/

Prompt --> insert data into the subscribers table
INSERT INTO subscribers VALUES(	1	, 	'Vandenborre'	, 	'Marie'	,	'sparstraat 15'	,	3600	,	'089/258741'	,	null	);
INSERT INTO subscribers VALUES(	2	, 	'Alberty'	, 	'Philippe'	,	'oude luikerbaan 71'	,	3500	,	'011/258741'	,	null	);
INSERT INTO subscribers VALUES(	3	, 	'Appelmans'	, 	'Kris'	,	'kerkstraat 55'	,	3600	,	'089/258741'	,	null	);
INSERT INTO subscribers VALUES(	4	, 	'Witte'	, 	'Gert'	,	'lindestraat 71'	,	3500	,	'011/299741'	,	null	);
INSERT INTO subscribers VALUES(	5	, 	'Aerts'	, 	'Rien'	,	'winterstraat 6'	,	3700	,	'012/258741'	,	'raerts@telenet.be'	);
INSERT INTO subscribers VALUES(	6	, 	'Klawitter'	, 	'Matthias'	,	'lentestraat 7'	,	3800	,	'011/256641'	,	null	);
INSERT INTO subscribers VALUES(	7	, 	'Kenes'	, 	'Mark'	,	'sparrestraat 71'	,	3600	,	'089/258793'	,	null	);
INSERT INTO subscribers VALUES(	8	, 	'Franssen'	, 	'Eline'	,	'dorpstraat 14'	,	3500	,	'011/451236'	,	null	);
INSERT INTO subscribers VALUES(	9	, 	'Hons'	, 	'Tom'	,	'koestraat 17'	,	3700	,	'012/451237'	,	null	);
INSERT INTO subscribers VALUES(	10	, 	'Huisjes'	, 	'Leen'	,	'wolvenstraat 27'	,	3800	,	'011/451238'	,	null	);
INSERT INTO subscribers VALUES(	11	, 	'Willems'	, 	'Veerle'	,	'heistraat 37'	,	3600	,	'089/451239'	,	'vwillems@gmail.com'	);
INSERT INTO subscribers VALUES(	12	, 	'Waterman'	, 	'Marijke'	,	'elfde liniestraat 7'	,	3500	,	'011/451240'	,	null	);
INSERT INTO subscribers VALUES(	13	, 	'Janssens'	, 	'Leen'	,	'grote straat 47'	,	3700	,	'012/451241'	,	null	);
INSERT INTO subscribers VALUES(	14	, 	'Klimop'	, 	'Lotte'	,	'lange straat 69'	,	3800	,	'011/451242'	,	'klimmer@outlook.com'	);
INSERT INTO subscribers VALUES(	15	, 	'Daenen'	, 	'Miet'	,	'nieuwstraat 32'	,	3600	,	'089/451243'	,	null	);
INSERT INTO subscribers VALUES(	16	, 	'Tilkens'	, 	'Lies'	,	'kromme straat 21'	,	3500	,	'011/451244'	,	'liest@hotmail.com'	);
INSERT INTO subscribers VALUES(	17	, 	'Tilkens'	, 	'Louise'	,	'bosstraat 214'	,	3700	,	'012/451245'	,	null	);
INSERT INTO subscribers VALUES(	18	, 	'Claes'	, 	'Lowie'	,	'schoolstraat 97'	,	3800	,	'011/451246'	,	null	);
INSERT INTO subscribers VALUES(	19	, 	'Kuppens'	, 	'Kyril'	,	'demerstraat 61'	,	3600	,	'089/451247'	,	null	);
INSERT INTO subscribers VALUES(	20	, 	'Beervoets'	, 	'Jonas'	,	'rode kruisstraat 72'	,	3500	,	'011/451248'	,	null	);
INSERT INTO subscribers VALUES(	21	, 	'Yilmaz'	, 	'Niels'	,	'casterstraat 22'	,	3700	,	'012/451249'	,	'deniels@gmail.com'	);
INSERT INTO subscribers VALUES(	22	, 	'Spaelt'	, 	'Dennis'	,	'st janstraat 103'	,	3800	,	'011/451250'	,	null	);
INSERT INTO subscribers VALUES(	23	, 	'Vanneste'	, 	'Jan'	,	'hoogstraat 46'	,	3600	,	'089/451251'	,	'nestej@pxl.be'	);
INSERT INTO subscribers VALUES(	24	, 	'Goedeman'	, 	'Piet'	,	'beekstraat 7'	,	3500	,	'011/451252'	,	null	);
INSERT INTO subscribers VALUES(	25	, 	'Verstreken'	, 	'Jules'	,	'hendriksstraat 7'	,	3850	,	'011/451253'	,	null	);
INSERT INTO subscribers VALUES(	26	, 	'Janssens'	, 	'Ali'	,	'ossekopstraat 6'	,	3850	,	'011/451254'	,	null	);
INSERT INTO subscribers VALUES(	27	, 	'Heersel'	, 	'Abdul'	,	'putstraat 97'	,	3850	,	'011/451255'	,	'abdul.heersel@telenet.be'	);
INSERT INTO subscribers VALUES(	28	, 	'Borders'	, 	'An'	,	'sasstraat 53'	,	3850	,	'011/451256'	,	null	);
INSERT INTO subscribers VALUES(	29	, 	'Terriers'	, 	'Indra'	,	'holle straat 19'	,	3850	,	'011/451257'	,	null	);
INSERT INTO subscribers VALUES(	30	, 	'Teerain'	, 	'Bram'	,	'kerkstraat 27'	,	3850	,	'011/451258'	,	null	);
INSERT INTO subscribers VALUES(	31	, 	'Boes'	, 	'Kevin'	,	'weerstandsplein 2'	,	3800	,	'011/451259'	,	'boeske@telenet.be'	);
INSERT INTO subscribers VALUES(	32	, 	'Clerinx'	, 	'Hans'	,	'groenplaats 3'	,	3850	,	'011/451260'	,	null	);
INSERT INTO subscribers VALUES(	33	, 	'Daniels'	, 	'Conrad'	,	'casterstraat 12'	,	3500	,	'011/451261'	,	'dendaniel@gmail.com'	);
INSERT INTO subscribers VALUES(	34	, 	'De Cuyper'	, 	'Magomed'	,	'koningin Astridlaan 14'	,	3850	,	'011/451262'	,	null	);
INSERT INTO subscribers VALUES(	35	, 	'Geldof'	, 	'Omer'	,	'kapelstraat 77'	,	3800	,	'011/451263'	,	null	);
INSERT INTO subscribers VALUES(	36	, 	'Geyskens'	, 	'Atakan'	,	'huidevetterstraat 18'	,	3850	,	'011/451264'	,	null	);
INSERT INTO subscribers VALUES(	37	, 	'Haest'	, 	'Ann'	,	'luikersteenweg 128'	,	3500	,	'011/451265'	,	null	);
INSERT INTO subscribers VALUES(	38	, 	'Hendrix'	, 	'Jorben'	,	'hasseltweg 39'	,	3850	,	'011/451266'	,	null	);
INSERT INTO subscribers VALUES(	39	, 	'Huyghe'	, 	'Jordy'	,	'nieuwe weg 44'	,	3800	,	'011/451267'	,	null	);
INSERT INTO subscribers VALUES(	40	, 	'Keuninckx'	, 	'Ben'	,	'bakkerstraat 45'	,	3800	,	'011/451268'	,	null	);




Prompt --> insert data into the spectators table
INSERT INTO spectators VALUES(	1	, 	'Vandenborre'	, 	'Marie'	);
INSERT INTO spectators VALUES(	2	, 	'Alberty'	, 	'Philippe'	);
INSERT INTO spectators VALUES(	3	, 	'Appelmans'	, 	'Kris'	);
INSERT INTO spectators VALUES(	4	, 	'Witte'	, 	'Gert'	);
INSERT INTO spectators VALUES(	5	, 	'Aerts'	, 	'Rien'	);
INSERT INTO spectators VALUES(	6	, 	'Klawitter'	, 	'Matthias'	);
INSERT INTO spectators VALUES(	7	, 	'Kenes'	, 	'Mark'	);
INSERT INTO spectators VALUES(	8	, 	'Franssen'	, 	'Eline'	);
INSERT INTO spectators VALUES(	9	, 	'Hons'	, 	'Tom'	);
INSERT INTO spectators VALUES(	10	, 	'Huisjes'	, 	'Leen'	);
INSERT INTO spectators VALUES(	11	, 	'Willems'	, 	'Veerle'	);
INSERT INTO spectators VALUES(	12	, 	'Waterman'	, 	'Marijke'	);
INSERT INTO spectators VALUES(	13	, 	'Janssens'	, 	'Leen'	);
INSERT INTO spectators VALUES(	14	, 	'Klimop'	, 	'Lotte'	);
INSERT INTO spectators VALUES(	15	, 	'Daenen'	, 	'Miet'	);
INSERT INTO spectators VALUES(	16	, 	'Tilkens'	, 	'Lies'	);
INSERT INTO spectators VALUES(	17	, 	'Tilkens'	, 	'Louise'	);
INSERT INTO spectators VALUES(	18	, 	'Claes'	, 	'Lowie'	);
INSERT INTO spectators VALUES(	19	, 	'Kuppens'	, 	'Kyril'	);
INSERT INTO spectators VALUES(	20	, 	'Beervoets'	, 	'Jonas'	);
INSERT INTO spectators VALUES(	21	, 	'Yilmaz'	, 	'Niels'	);
INSERT INTO spectators VALUES(	22	, 	'Spaelt'	, 	'Dennis'	);
INSERT INTO spectators VALUES(	23	, 	'Vanneste'	, 	'Jan'	);
INSERT INTO spectators VALUES(	24	, 	'Goedeman'	, 	'Piet'	);
INSERT INTO spectators VALUES(	25	, 	'Verstreken'	, 	'Jules'	);
INSERT INTO spectators VALUES(	26	, 	'Janssens'	, 	'Ali'	);
INSERT INTO spectators VALUES(	27	, 	'Heersel'	, 	'Abdul'	);
INSERT INTO spectators VALUES(	28	, 	'Borders'	, 	'An'	);
INSERT INTO spectators VALUES(	29	, 	'Terriers'	, 	'Indra'	);
INSERT INTO spectators VALUES(	30	, 	'Teerain'	, 	'Bram'	);
INSERT INTO spectators VALUES(	31	, 	'Boes'	, 	'Kevin'	);
INSERT INTO spectators VALUES(	32	, 	'Clerinx'	, 	'Hans'	);
INSERT INTO spectators VALUES(	33	, 	'Daniels'	, 	'Conrad'	);
INSERT INTO spectators VALUES(	34	, 	'De Cuyper'	, 	'Magomed'	);
INSERT INTO spectators VALUES(	35	, 	'Geldof'	, 	'Omer'	);
INSERT INTO spectators VALUES(	36	, 	'Geyskens'	, 	'Atakan'	);
INSERT INTO spectators VALUES(	37	, 	'Haest'	, 	'Ann'	);
INSERT INTO spectators VALUES(	38	, 	'Hendrix'	, 	'Jorben'	);
INSERT INTO spectators VALUES(	39	, 	'Huyghe'	, 	'Jordy'	);
INSERT INTO spectators VALUES(	40	, 	'Keuninckx'	, 	'Ben'	);
						
						
						
INSERT INTO spectators VALUES(	41	, 	'ABELS'	, 	'Albert'	);
INSERT INTO spectators VALUES(	42	, 	'ACKERMANS'	, 	'Jozef'	);
INSERT INTO spectators VALUES(	43	, 	'Adams'	, 	'Servaas'	);
INSERT INTO spectators VALUES(	44	, 	'ADAMS'	, 	'Alice'	);
INSERT INTO spectators VALUES(	45	, 	'Adams'	, 	'Malak'	);
INSERT INTO spectators VALUES(	46	, 	'ADRIAENS'	, 	'Adam'	);
INSERT INTO spectators VALUES(	47	, 	'Aelbrecht'	, 	'Mathis'	);
INSERT INTO spectators VALUES(	48	, 	'AELBRECHTS'	, 	'Noor'	);
INSERT INTO spectators VALUES(	49	, 	'AELVOET'	, 	'Johan'	);
INSERT INTO spectators VALUES(	50	, 	'Aerts'	, 	'Georges'	);
INSERT INTO spectators VALUES(	51	, 	'Aerts'	, 	'Mohamed'	);
INSERT INTO spectators VALUES(	52	, 	'AERTS'	, 	'Julien'	);
INSERT INTO spectators VALUES(	53	, 	'AERTS'	, 	'Emma'	);
INSERT INTO spectators VALUES(	54	, 	'AERTS'	, 	'Englebert'	);
INSERT INTO spectators VALUES(	55	, 	'Aerts'	, 	'Olivia'	);
INSERT INTO spectators VALUES(	56	, 	'AERTS'	, 	'Alice'	);
INSERT INTO spectators VALUES(	57	, 	'Aesloos'	, 	'Malak'	);
INSERT INTO spectators VALUES(	58	, 	'AKKERMANS'	, 	'Adam'	);
INSERT INTO spectators VALUES(	59	, 	'ALBERT'	, 	'Leon'	);
INSERT INTO spectators VALUES(	60	, 	'Alberts'	, 	'Jozef'	);
INSERT INTO spectators VALUES(	61	, 	'Allaert'	, 	'Jade'	);
INSERT INTO spectators VALUES(	62	, 	'ALLAERT'	, 	'Mathis'	);
INSERT INTO spectators VALUES(	63	, 	'Allaerts'	, 	'Constant'	);
INSERT INTO spectators VALUES(	64	, 	'Allaerts'	, 	'Alexander'	);
INSERT INTO spectators VALUES(	65	, 	'Allaerts'	, 	'Jos'	);
INSERT INTO spectators VALUES(	66	, 	'ALLAERTS'	, 	'Noah'	);
INSERT INTO spectators VALUES(	67	, 	'Alphonse'	, 	'Joseph'	);
INSERT INTO spectators VALUES(	68	, 	'Ameel'	, 	'Richard'	);
INSERT INTO spectators VALUES(	69	, 	'AMTER'	, 	'Michel'	);
INSERT INTO spectators VALUES(	70	, 	'Amter'	, 	'Bart'	);
INSERT INTO spectators VALUES(	71	, 	'Amter'	, 	'Henri'	);
INSERT INTO spectators VALUES(	72	, 	'andendries'	, 	'Georges'	);
INSERT INTO spectators VALUES(	73	, 	'ANDRES'	, 	'Jan'	);
INSERT INTO spectators VALUES(	74	, 	'Andries'	, 	'Victor'	);
INSERT INTO spectators VALUES(	75	, 	'ANDRIES'	, 	'Jean'	);
INSERT INTO spectators VALUES(	76	, 	'Andries'	, 	'Marc'	);
INSERT INTO spectators VALUES(	77	, 	'Andries'	, 	'Maurice'	);
INSERT INTO spectators VALUES(	78	, 	'Anmel'	, 	'Nathan'	);
INSERT INTO spectators VALUES(	79	, 	'Anthonis'	, 	'Jozef'	);
INSERT INTO spectators VALUES(	80	, 	'Neyens'	, 	'Liam'	);
INSERT INTO spectators VALUES(	81	, 	'Antonis'	, 	'Louis'	);
INSERT INTO spectators VALUES(	82	, 	'Antonis'	, 	'Maurice'	);
INSERT INTO spectators VALUES(	83	, 	'Antonneau'	, 	'Jules'	);
INSERT INTO spectators VALUES(	84	, 	'Antoon'	, 	'Louise'	);
INSERT INTO spectators VALUES(	85	, 	'APPELMANS'	, 	'Giulia'	);
INSERT INTO spectators VALUES(	86	, 	'APPELMANS'	, 	'Mia'	);
INSERT INTO spectators VALUES(	87	, 	'Appermans'	, 	'Willy'	);
INSERT INTO spectators VALUES(	88	, 	'Arend'	, 	'Alphonse'	);
INSERT INTO spectators VALUES(	89	, 	'Arend'	, 	'Emma'	);
INSERT INTO spectators VALUES(	90	, 	'ARMEE'	, 	'Armand'	);
INSERT INTO spectators VALUES(	91	, 	'ARNALSTEEN'	, 	'Olivia'	);
INSERT INTO spectators VALUES(	92	, 	'Arnauts'	, 	'Willy'	);
INSERT INTO spectators VALUES(	93	, 	'ARNOU'	, 	'Louise'	);
INSERT INTO spectators VALUES(	94	, 	'ARNOU'	, 	'Pierre'	);
INSERT INTO spectators VALUES(	95	, 	'Arnouts'	, 	'Joseph'	);
INSERT INTO spectators VALUES(	96	, 	'ARTOIS'	, 	'Rayan'	);
INSERT INTO spectators VALUES(	97	, 	'ARTOOS'	, 	'Youssef'	);
INSERT INTO spectators VALUES(	98	, 	'ASSELBERGH'	, 	'Guillaume'	);
INSERT INTO spectators VALUES(	99	, 	'Audiens'	, 	'Benny'	);
INSERT INTO spectators VALUES(	100	, 	'AUSLOOS'	, 	'Marcel'	);
INSERT INTO spectators VALUES(	101	, 	'Ausloos'	, 	'Gabriel'	);
INSERT INTO spectators VALUES(	102	, 	'AUSLOOS'	, 	'Antoine'	);
INSERT INTO spectators VALUES(	103	, 	'Ausloos'	, 	'Jan'	);
INSERT INTO spectators VALUES(	104	, 	'AYOUBI'	, 	'Liam'	);
INSERT INTO spectators VALUES(	105	, 	'Paulus'	, 	'Noah'	);
INSERT INTO spectators VALUES(	106	, 	'Papen'	, 	'Mila'	);
INSERT INTO spectators VALUES(	107	, 	'Maes'	, 	'Arthur'	);
INSERT INTO spectators VALUES(	108	, 	'Baelus'	, 	'Lina'	);
INSERT INTO spectators VALUES(	109	, 	'Baeten'	, 	'Guy'	);
INSERT INTO spectators VALUES(	110	, 	'Baets'	, 	'Daniel'	);
INSERT INTO spectators VALUES(	111	, 	'BAILLEU'	, 	'Emma'	);
INSERT INTO spectators VALUES(	112	, 	'Bailleul'	, 	'Olivia'	);
INSERT INTO spectators VALUES(	113	, 	'Balthazaar'	, 	'Gust'	);
INSERT INTO spectators VALUES(	114	, 	'BAMS'	, 	'Wim'	);
INSERT INTO spectators VALUES(	115	, 	'BANCKAERTS'	, 	'Martin'	);
INSERT INTO spectators VALUES(	116	, 	'Bankaerts'	, 	'Sofia'	);
INSERT INTO spectators VALUES(	117	, 	'Baptist'	, 	'Jan'	);
INSERT INTO spectators VALUES(	118	, 	'Baras'	, 	'Louis'	);
INSERT INTO spectators VALUES(	119	, 	'BARAS'	, 	'Henri'	);
INSERT INTO spectators VALUES(	120	, 	'Baras'	, 	'Nour'	);
INSERT INTO spectators VALUES(	121	, 	'BARETTE'	, 	'Alfred'	);
INSERT INTO spectators VALUES(	122	, 	'BARRAS'	, 	'Jozef'	);
INSERT INTO spectators VALUES(	123	, 	'Bartier'	, 	'Ella'	);
INSERT INTO spectators VALUES(	124	, 	'Bastiaensen'	, 	'Henri'	);
INSERT INTO spectators VALUES(	125	, 	'Bastien'	, 	'Filip'	);
INSERT INTO spectators VALUES(	126	, 	'Bastin'	, 	'Guillaume'	);
INSERT INTO spectators VALUES(	127	, 	'Bastyns'	, 	'Lucas'	);
INSERT INTO spectators VALUES(	128	, 	'Batteur'	, 	'Finn'	);
INSERT INTO spectators VALUES(	129	, 	'Bauchau'	, 	'Michel'	);
INSERT INTO spectators VALUES(	130	, 	'Bauchau'	, 	'Mila'	);
INSERT INTO spectators VALUES(	131	, 	'Baudot'	, 	'Alice'	);
INSERT INTO spectators VALUES(	132	, 	'Baudot'	, 	'Victor'	);
INSERT INTO spectators VALUES(	133	, 	'Bausen'	, 	'Alfons'	);
INSERT INTO spectators VALUES(	134	, 	'BAUWENS'	, 	'Guillaume'	);
INSERT INTO spectators VALUES(	135	, 	'Bavin'	, 	'Odile.'	);
INSERT INTO spectators VALUES(	136	, 	'BAVIN'	, 	'Aya'	);
INSERT INTO spectators VALUES(	137	, 	'Vaels'	, 	'Sarah'	);
INSERT INTO spectators VALUES(	138	, 	'Vaels'	, 	'Marc'	);
INSERT INTO spectators VALUES(	139	, 	'Beckers'	, 	'Herwig'	);
INSERT INTO spectators VALUES(	140	, 	'Beckers'	, 	'Paul'	);
INSERT INTO spectators VALUES(	141	, 	'Beckers'	, 	'Jean'	);
INSERT INTO spectators VALUES(	142	, 	'Beckers'	, 	'Edmond'	);
INSERT INTO spectators VALUES(	143	, 	'BECKERS'	, 	'Pierre'	);
INSERT INTO spectators VALUES(	144	, 	'Beckers'	, 	'Arthur'	);
INSERT INTO spectators VALUES(	145	, 	'BEEKEN'	, 	'Remy'	);
INSERT INTO spectators VALUES(	146	, 	'BEELEN'	, 	'Louis'	);
INSERT INTO spectators VALUES(	147	, 	'Beelen'	, 	'Lars'	);
INSERT INTO spectators VALUES(	148	, 	'Beelen'	, 	'Jens'	);
INSERT INTO spectators VALUES(	149	, 	'BEELEN'	, 	'Danny'	);
INSERT INTO spectators VALUES(	150	, 	'BEERENS'	, 	'Elise'	);
INSERT INTO spectators VALUES(	151	, 	'BEERSAERTS'	, 	'Rene'	);
INSERT INTO spectators VALUES(	152	, 	'Beesemans'	, 	'Marie'	);
INSERT INTO spectators VALUES(	153	, 	'BEESEMANS'	, 	'Jozef'	);
INSERT INTO spectators VALUES(	154	, 	'Beetens'	, 	'Pierre'	);
INSERT INTO spectators VALUES(	155	, 	'Behets'	, 	'Jean'	);
INSERT INTO spectators VALUES(	156	, 	'BEHETS'	, 	'Emma'	);
INSERT INTO spectators VALUES(	157	, 	'BEHETS'	, 	'Johnny'	);
INSERT INTO spectators VALUES(	158	, 	'Behets'	, 	'Jozef'	);
INSERT INTO spectators VALUES(	159	, 	'Behets'	, 	'Elise'	);
INSERT INTO spectators VALUES(	160	, 	'Kleyne'	, 	'Jozef'	);
INSERT INTO spectators VALUES(	161	, 	'BELEK'	, 	'Hdir'	);
INSERT INTO spectators VALUES(	162	, 	'BELEN'	, 	'Constant'	);
INSERT INTO spectators VALUES(	163	, 	'BELET'	, 	'Noor'	);
INSERT INTO spectators VALUES(	164	, 	'Bellen'	, 	'Louis'	);
INSERT INTO spectators VALUES(	165	, 	'BENSELINCK'	, 	'Laurent'	);
INSERT INTO spectators VALUES(	166	, 	'Berckmans'	, 	'Gilbert'	);
INSERT INTO spectators VALUES(	167	, 	'Bergers'	, 	'Yasmine'	);
INSERT INTO spectators VALUES(	168	, 	'Berges'	, 	'Olivia'	);
INSERT INTO spectators VALUES(	169	, 	'Berges'	, 	'Jean'	);
INSERT INTO spectators VALUES(	170	, 	'Berges'	, 	'Albert'	);
INSERT INTO spectators VALUES(	171	, 	'Berges'	, 	'Jan'	);
INSERT INTO spectators VALUES(	172	, 	'BERGES'	, 	'Lina'	);
INSERT INTO spectators VALUES(	173	, 	'Berges'	, 	'Jacques'	);
INSERT INTO spectators VALUES(	174	, 	'Berges'	, 	'Jan'	);
INSERT INTO spectators VALUES(	175	, 	'Berghen'	, 	'Frans'	);
INSERT INTO spectators VALUES(	176	, 	'BERGMAN'	, 	'Gunnar'	);
INSERT INTO spectators VALUES(	177	, 	'Berinckx'	, 	'Leon'	);
INSERT INTO spectators VALUES(	178	, 	'BERNARD'	, 	'Jozef'	);
INSERT INTO spectators VALUES(	179	, 	'Berrewaert'	, 	'Willem'	);
INSERT INTO spectators VALUES(	180	, 	'Bert'	, 	'Alfred'	);
INSERT INTO spectators VALUES(	181	, 	'BERT'	, 	'Lewis'	);
INSERT INTO spectators VALUES(	182	, 	'BERTELS'	, 	'Mathis'	);
INSERT INTO spectators VALUES(	183	, 	'BERTELS'	, 	'Jean'	);
INSERT INTO spectators VALUES(	184	, 	'Berthels'	, 	'Edward'	);
INSERT INTO spectators VALUES(	185	, 	'Bervaes'	, 	'Edmond'	);
INSERT INTO spectators VALUES(	186	, 	'BERVAES'	, 	'Elena'	);
INSERT INTO spectators VALUES(	187	, 	'BERVAES'	, 	'Franz'	);
INSERT INTO spectators VALUES(	188	, 	'BEUCKENOOGHE'	, 	'Andre'	);
INSERT INTO spectators VALUES(	189	, 	'BEULEKENS'	, 	'Juliette'	);
INSERT INTO spectators VALUES(	190	, 	'Beulens'	, 	'Sofia'	);
INSERT INTO spectators VALUES(	191	, 	'Beulens'	, 	'Fras'	);
INSERT INTO spectators VALUES(	192	, 	'Beullekens'	, 	'Emma'	);
INSERT INTO spectators VALUES(	193	, 	'BEULLENS'	, 	'Edmond'	);
INSERT INTO spectators VALUES(	194	, 	'BEULLENS'	, 	'Alice'	);
INSERT INTO spectators VALUES(	195	, 	'Beullens'	, 	'Malak'	);
INSERT INTO spectators VALUES(	196	, 	'BEULLENS'	, 	'Adam'	);
INSERT INTO spectators VALUES(	197	, 	'BEULLENS'	, 	'Mohamed'	);
INSERT INTO spectators VALUES(	198	, 	'BEULS'	, 	'Georges'	);
INSERT INTO spectators VALUES(	199	, 	'Billen'	, 	'Richard'	);
INSERT INTO spectators VALUES(	200	, 	'BILS'	, 	'Marc'	);
INSERT INTO spectators VALUES(	201	, 	'BINNARD'	, 	'Olivia'	);
INSERT INTO spectators VALUES(	202	, 	'BIRK'	, 	'Georg'	);
INSERT INTO spectators VALUES(	203	, 	'BIRONT'	, 	'Felix'	);
INSERT INTO spectators VALUES(	204	, 	'BIRONT'	, 	'Jan'	);
INSERT INTO spectators VALUES(	205	, 	'Biront'	, 	'Gabriel'	);
INSERT INTO spectators VALUES(	206	, 	'Biront'	, 	'Hugo'	);
INSERT INTO spectators VALUES(	207	, 	'Biront'	, 	'Louis'	);
INSERT INTO spectators VALUES(	208	, 	'BLAES'	, 	'Guillaume'	);
INSERT INTO spectators VALUES(	209	, 	'Blanchart'	, 	'Lucie'	);
INSERT INTO spectators VALUES(	210	, 	'BLANCHART'	, 	'Liam'	);
INSERT INTO spectators VALUES(	211	, 	'Blanpain'	, 	'Pierre'	);
INSERT INTO spectators VALUES(	212	, 	'Blockx'	, 	'Rudy'	);
INSERT INTO spectators VALUES(	213	, 	'Bodart'	, 	'Paul'	);
INSERT INTO spectators VALUES(	214	, 	'BODDAERD'	, 	'Alexander'	);
INSERT INTO spectators VALUES(	215	, 	'Boeckx'	, 	'Lea'	);
INSERT INTO spectators VALUES(	216	, 	'BOEDTS'	, 	'Jan'	);
INSERT INTO spectators VALUES(	217	, 	'Boelens'	, 	'Albert'	);
INSERT INTO spectators VALUES(	218	, 	'BOELENS'	, 	'Alice'	);
INSERT INTO spectators VALUES(	219	, 	'BOELENS'	, 	'Lucie'	);
INSERT INTO spectators VALUES(	220	, 	'BOELS'	, 	'Leon'	);
INSERT INTO spectators VALUES(	221	, 	'Boffé'	, 	'Em'	);
INSERT INTO spectators VALUES(	222	, 	'BOFFE'	, 	'Lambert'	);
INSERT INTO spectators VALUES(	223	, 	'Bogaerts'	, 	'Adam'	);
INSERT INTO spectators VALUES(	224	, 	'Bogaerts'	, 	'Arthur'	);
INSERT INTO spectators VALUES(	225	, 	'Bogaerts'	, 	'Felix'	);
INSERT INTO spectators VALUES(	226	, 	'Bogaerts'	, 	'Frans'	);
INSERT INTO spectators VALUES(	227	, 	'BOGAERTS'	, 	'Gabriel'	);
INSERT INTO spectators VALUES(	228	, 	'Boghe'	, 	'Edmond'	);
INSERT INTO spectators VALUES(	229	, 	'Boghe'	, 	'Jacques'	);
INSERT INTO spectators VALUES(	230	, 	'BOGHE'	, 	'Henri'	);
INSERT INTO spectators VALUES(	231	, 	'Boghe'	, 	'Patrick'	);
INSERT INTO spectators VALUES(	232	, 	'BOGHE'	, 	'Louise'	);
INSERT INTO spectators VALUES(	233	, 	'Boghe'	, 	'Giulia'	);
INSERT INTO spectators VALUES(	234	, 	'Bolen'	, 	'Mia'	);
INSERT INTO spectators VALUES(	235	, 	'BOLLENS'	, 	'Camille'	);
INSERT INTO spectators VALUES(	236	, 	'BOLLENS'	, 	'Victor'	);
INSERT INTO spectators VALUES(	237	, 	'BOMBAERS'	, 	'Arthur'	);
INSERT INTO spectators VALUES(	238	, 	'BONGAERTS'	, 	'Laurent'	);
INSERT INTO spectators VALUES(	239	, 	'Boogaerts'	, 	'Jean'	);
INSERT INTO spectators VALUES(	240	, 	'Boogaerts'	, 	'Herman'	);
INSERT INTO spectators VALUES(	241	, 	'BOON'	, 	'Liam'	);
INSERT INTO spectators VALUES(	242	, 	'Boon'	, 	'Eduard'	);
INSERT INTO spectators VALUES(	243	, 	'Boon'	, 	'Jan'	);
INSERT INTO spectators VALUES(	244	, 	'Boon'	, 	'Jules'	);
INSERT INTO spectators VALUES(	245	, 	'Boon'	, 	'Franz'	);
INSERT INTO spectators VALUES(	246	, 	'BOON'	, 	'Jan'	);
INSERT INTO spectators VALUES(	247	, 	'BOON'	, 	'Frans'	);
INSERT INTO spectators VALUES(	248	, 	'Swaenen'	, 	'Paul'	);
INSERT INTO spectators VALUES(	249	, 	'Swaenen'	, 	'Guil.'	);
INSERT INTO spectators VALUES(	250	, 	'Swaenen'	, 	'Jean'	);
INSERT INTO spectators VALUES(	251	, 	'Swaenen'	, 	'Eduard'	);
INSERT INTO spectators VALUES(	252	, 	'Boon'	, 	'Frans'	);
INSERT INTO spectators VALUES(	253	, 	'Boone'	, 	'Noah'	);
INSERT INTO spectators VALUES(	254	, 	'BOONE'	, 	'Antoine'	);
INSERT INTO spectators VALUES(	255	, 	'Boonen'	, 	'Leon'	);
INSERT INTO spectators VALUES(	256	, 	'Borgers'	, 	'Toine'	);
INSERT INTO spectators VALUES(	257	, 	'Borgers'	, 	'Louis'	);
INSERT INTO spectators VALUES(	258	, 	'BORREMANS'	, 	'Lucas'	);
INSERT INTO spectators VALUES(	259	, 	'Borremans'	, 	'Jules'	);
INSERT INTO spectators VALUES(	260	, 	'BOSMAN'	, 	'Charles'	);
INSERT INTO spectators VALUES(	261	, 	'Bosmans'	, 	'David'	);
INSERT INTO spectators VALUES(	262	, 	'Bosmans'	, 	'Fritz'	);
INSERT INTO spectators VALUES(	263	, 	'Bosmans'	, 	'Hans'	);
INSERT INTO spectators VALUES(	264	, 	'Bosmans'	, 	'Louis'	);
INSERT INTO spectators VALUES(	265	, 	'BOSMANS'	, 	'Charles'	);
INSERT INTO spectators VALUES(	266	, 	'Bosmans'	, 	'Marcel'	);
INSERT INTO spectators VALUES(	267	, 	'BOSMANS'	, 	'Jules'	);
INSERT INTO spectators VALUES(	268	, 	'BOSMANS'	, 	'Paul'	);
INSERT INTO spectators VALUES(	269	, 	'Bosmans'	, 	'Charles'	);
INSERT INTO spectators VALUES(	270	, 	'BOSMANS'	, 	'Augustin'	);
INSERT INTO spectators VALUES(	271	, 	'BOSSU'	, 	'Henri'	);
INSERT INTO spectators VALUES(	272	, 	'Bossu'	, 	'Alfred'	);
INSERT INTO spectators VALUES(	273	, 	'CLAES'	, 	'Frans'	);
INSERT INTO spectators VALUES(	274	, 	'CLAES'	, 	'Hendrik'	);
INSERT INTO spectators VALUES(	275	, 	'Claes'	, 	'Marcel'	);
INSERT INTO spectators VALUES(	276	, 	'Claessens'	, 	'Felix'	);
INSERT INTO spectators VALUES(	277	, 	'Claessens'	, 	'Eug'	);
INSERT INTO spectators VALUES(	278	, 	'CLAEYS'	, 	'Pierre'	);
INSERT INTO spectators VALUES(	279	, 	'Claeys'	, 	'Harry'	);
INSERT INTO spectators VALUES(	280	, 	'Clasens'	, 	'Rene'	);
INSERT INTO spectators VALUES(	281	, 	'Clays'	, 	'Jade'	);
INSERT INTO spectators VALUES(	282	, 	'Clement'	, 	'Albert'	);
INSERT INTO spectators VALUES(	283	, 	'Cleremand'	, 	'Andre'	);
INSERT INTO spectators VALUES(	284	, 	'Cleremans'	, 	'Gabriel'	);
INSERT INTO spectators VALUES(	285	, 	'CLERIX'	, 	'Rene'	);
INSERT INTO spectators VALUES(	286	, 	'CLEYNHENS'	, 	'Victor'	);
INSERT INTO spectators VALUES(	287	, 	'CLYNMANS'	, 	'Eugène'	);
INSERT INTO spectators VALUES(	288	, 	'Cnops'	, 	'Fernand'	);
INSERT INTO spectators VALUES(	289	, 	'CNOPS'	, 	'Mohamed'	);
INSERT INTO spectators VALUES(	290	, 	'COBBAERT'	, 	'Jean-Pierre'	);
INSERT INTO spectators VALUES(	291	, 	'COBER'	, 	'Joseph'	);
INSERT INTO spectators VALUES(	292	, 	'COCKX'	, 	'Wilfried'	);
INSERT INTO spectators VALUES(	293	, 	'COCKX'	, 	'Georges'	);
INSERT INTO spectators VALUES(	294	, 	'COCKX'	, 	'Jean-Baptiste'	);
INSERT INTO spectators VALUES(	295	, 	'COECKELBERGH'	, 	'Amir'	);
INSERT INTO spectators VALUES(	296	, 	'Coeckelberghs'	, 	'Felix'	);
INSERT INTO spectators VALUES(	297	, 	'Coeckelberghs'	, 	'Victor'	);
INSERT INTO spectators VALUES(	298	, 	'Coeckelbergs'	, 	'Camiel'	);
INSERT INTO spectators VALUES(	299	, 	'Coen'	, 	'August'	);
INSERT INTO spectators VALUES(	300	, 	'COEN'	, 	'Imran'	);
INSERT INTO spectators VALUES(	301	, 	'Coen'	, 	'Yanis'	);
INSERT INTO spectators VALUES(	302	, 	'Coenen'	, 	'Lambert'	);
INSERT INTO spectators VALUES(	303	, 	'COLLAER'	, 	'Lucien'	);
INSERT INTO spectators VALUES(	304	, 	'Collaer'	, 	'Jan'	);
INSERT INTO spectators VALUES(	305	, 	'COLLAER'	, 	'Félix'	);
INSERT INTO spectators VALUES(	306	, 	'Collaer'	, 	'Louis'	);
INSERT INTO spectators VALUES(	307	, 	'Collaer'	, 	'Pierre'	);
INSERT INTO spectators VALUES(	308	, 	'COLLAER'	, 	'Frans'	);
INSERT INTO spectators VALUES(	309	, 	'Collaer'	, 	'Noah'	);
INSERT INTO spectators VALUES(	310	, 	'Collaer'	, 	'Willy'	);
INSERT INTO spectators VALUES(	311	, 	'COMPERNOL'	, 	'Geert'	);
INSERT INTO spectators VALUES(	312	, 	'Contrijn'	, 	'Emiel'	);
INSERT INTO spectators VALUES(	313	, 	'COOMANS'	, 	'Walter'	);
INSERT INTO spectators VALUES(	314	, 	'Coopmans'	, 	'Fernand'	);
INSERT INTO spectators VALUES(	315	, 	'Cooremans'	, 	'Ed.'	);
INSERT INTO spectators VALUES(	316	, 	'Cooremans'	, 	'Emile'	);
INSERT INTO spectators VALUES(	317	, 	'Coosemans'	, 	'André'	);
INSERT INTO spectators VALUES(	318	, 	'Coosemans'	, 	'Jules'	);
INSERT INTO spectators VALUES(	319	, 	'COOSEMANS'	, 	'Gustaaf'	);
INSERT INTO spectators VALUES(	320	, 	'Coosemans'	, 	'Ferdinand'	);
INSERT INTO spectators VALUES(	321	, 	'COPPENS'	, 	'Nathan'	);
INSERT INTO spectators VALUES(	322	, 	'Coquyt'	, 	'Alexander'	);
INSERT INTO spectators VALUES(	323	, 	'Cordeman'	, 	'Edward'	);
INSERT INTO spectators VALUES(	324	, 	'CORDEMANS'	, 	'Michel'	);
INSERT INTO spectators VALUES(	325	, 	'CORNELISSEN'	, 	'Victor'	);
INSERT INTO spectators VALUES(	326	, 	'Corstjens'	, 	'Dirk'	);
INSERT INTO spectators VALUES(	327	, 	'CORTOOS'	, 	'Noah'	);
INSERT INTO spectators VALUES(	328	, 	'Cortoos'	, 	'Bob'	);
INSERT INTO spectators VALUES(	329	, 	'COSTERMANS'	, 	'Jean-Pierre'	);
INSERT INTO spectators VALUES(	330	, 	'COSTERS'	, 	'Joseph'	);
INSERT INTO spectators VALUES(	331	, 	'Costers'	, 	'Wilfried'	);
INSERT INTO spectators VALUES(	332	, 	'COSTROP'	, 	'Georges'	);
INSERT INTO spectators VALUES(	333	, 	'Costrop'	, 	'Jean-Baptiste'	);
INSERT INTO spectators VALUES(	334	, 	'COSTROP'	, 	'Edward'	);
INSERT INTO spectators VALUES(	335	, 	'Couet'	, 	'Michel'	);
INSERT INTO spectators VALUES(	336	, 	'Cox'	, 	'Etienne'	);
INSERT INTO spectators VALUES(	337	, 	'Crab'	, 	'Emmanuel'	);
INSERT INTO spectators VALUES(	338	, 	'Crab'	, 	'Jacques'	);
INSERT INTO spectators VALUES(	339	, 	'Palmers'	, 	'Clement'	);
INSERT INTO spectators VALUES(	340	, 	'Crabbe'	, 	'Wilfried'	);
INSERT INTO spectators VALUES(	341	, 	'CRABBE'	, 	'Julien'	);
INSERT INTO spectators VALUES(	342	, 	'Crabbe'	, 	'Charel'	);
INSERT INTO spectators VALUES(	343	, 	'Crabbe'	, 	'Felix'	);
INSERT INTO spectators VALUES(	344	, 	'CRABE'	, 	'Antoine'	);
INSERT INTO spectators VALUES(	345	, 	'CREMERS'	, 	'Leon'	);
INSERT INTO spectators VALUES(	346	, 	'CREMERS'	, 	'Toine'	);
INSERT INTO spectators VALUES(	347	, 	'Cremers'	, 	'Tilly'	);
INSERT INTO spectators VALUES(	348	, 	'Cremers'	, 	'Mathis'	);
INSERT INTO spectators VALUES(	349	, 	'Cremers'	, 	'Constant'	);
INSERT INTO spectators VALUES(	350	, 	'Creteur'	, 	'Alexander'	);
INSERT INTO spectators VALUES(	351	, 	'CROMBEZ'	, 	'Jos'	);
INSERT INTO spectators VALUES(	352	, 	'CROMBOOM'	, 	'Rudi'	);
INSERT INTO spectators VALUES(	353	, 	'CUIPERS'	, 	'Veerle'	);
INSERT INTO spectators VALUES(	354	, 	'Cumps'	, 	'Julien'	);
INSERT INTO spectators VALUES(	355	, 	'CUYPERS'	, 	'Leon'	);
INSERT INTO spectators VALUES(	356	, 	'CUYPERS'	, 	'Andre'	);
INSERT INTO spectators VALUES(	357	, 	'CUYPERS'	, 	'Frans'	);
INSERT INTO spectators VALUES(	358	, 	'Cuypers'	, 	'Jan'	);
INSERT INTO spectators VALUES(	359	, 	'Cuypers'	, 	'Henri'	);
INSERT INTO spectators VALUES(	360	, 	'Cuypers'	, 	'Rien'	);
INSERT INTO spectators VALUES(	361	, 	'Cuyt'	, 	'Jeanine'	);
INSERT INTO spectators VALUES(	362	, 	'Cypers'	, 	'Frans'	);
INSERT INTO spectators VALUES(	363	, 	'D Hollander'	, 	'Dree'	);
INSERT INTO spectators VALUES(	364	, 	'Vaes'	, 	'Elly'	);
INSERT INTO spectators VALUES(	365	, 	'Dacosse'	, 	'Patty'	);
INSERT INTO spectators VALUES(	366	, 	'DAEGHSEL'	, 	'Henri'	);
INSERT INTO spectators VALUES(	367	, 	'DAELEMANS'	, 	'Michel'	);
INSERT INTO spectators VALUES(	368	, 	'DAELHEM'	, 	'Jean'	);
INSERT INTO spectators VALUES(	369	, 	'DAEMS'	, 	'Rik'	);
INSERT INTO spectators VALUES(	370	, 	'DAHLEM'	, 	'Fanny'	);
INSERT INTO spectators VALUES(	371	, 	'DAHLEM'	, 	'Gustaaf'	);
INSERT INTO spectators VALUES(	372	, 	'DAHLEM'	, 	'Camille'	);
INSERT INTO spectators VALUES(	373	, 	'Dalcq'	, 	'Jean'	);
INSERT INTO spectators VALUES(	374	, 	'Daman'	, 	'Auguste'	);
INSERT INTO spectators VALUES(	375	, 	'Daman'	, 	'Guillaume'	);
INSERT INTO spectators VALUES(	376	, 	'Daman'	, 	'Michel'	);
INSERT INTO spectators VALUES(	377	, 	'Daman'	, 	'Luc'	);
INSERT INTO spectators VALUES(	378	, 	'DANCKAERTS'	, 	'Bart'	);
INSERT INTO spectators VALUES(	379	, 	'DANIELS'	, 	'Louis'	);
INSERT INTO spectators VALUES(	380	, 	'Daneels'	, 	'Guilliaume'	);
INSERT INTO spectators VALUES(	381	, 	'DANIELS'	, 	'Andreas'	);
INSERT INTO spectators VALUES(	382	, 	'DANVOYE'	, 	'Leo'	);
INSERT INTO spectators VALUES(	383	, 	'DARCHE'	, 	'Danny'	);
INSERT INTO spectators VALUES(	384	, 	'DAS'	, 	'Erik'	);
INSERT INTO spectators VALUES(	385	, 	'Davans'	, 	'Elza'	);
INSERT INTO spectators VALUES(	386	, 	'Davans'	, 	'Chris'	);
INSERT INTO spectators VALUES(	387	, 	'DAVID'	, 	'Pierre'	);
INSERT INTO spectators VALUES(	388	, 	'De Guise'	, 	'Nina'	);
INSERT INTO spectators VALUES(	389	, 	'DE BACKER'	, 	'Randy'	);
INSERT INTO spectators VALUES(	390	, 	'De Backer'	, 	'Erik'	);
INSERT INTO spectators VALUES(	391	, 	'DE BAERDEMAEKER'	, 	'Geert'	);
INSERT INTO spectators VALUES(	392	, 	'De Baets'	, 	'Albert'	);
INSERT INTO spectators VALUES(	393	, 	'DE BAETS'	, 	'Christian'	);
INSERT INTO spectators VALUES(	394	, 	'De Baker'	, 	'Ronny'	);
INSERT INTO spectators VALUES(	395	, 	'De Bal'	, 	'Julien'	);
INSERT INTO spectators VALUES(	396	, 	'De Bast'	, 	'Tom'	);
INSERT INTO spectators VALUES(	397	, 	'DE BECKER'	, 	'Xavier'	);
INSERT INTO spectators VALUES(	398	, 	'De Becker'	, 	'Manu'	);
INSERT INTO spectators VALUES(	399	, 	'DE BECKER'	, 	'Gert'	);
INSERT INTO spectators VALUES(	400	, 	'De Becker'	, 	'Jean-Pierre'	);
INSERT INTO spectators VALUES(	401	, 	'DE BECKER'	, 	'Zita'	);
INSERT INTO spectators VALUES(	402	, 	'DE BELVA'	, 	'Henri'	);
INSERT INTO spectators VALUES(	403	, 	'DE BIE'	, 	'Jef'	);
INSERT INTO spectators VALUES(	404	, 	'DE BIE'	, 	'Jean'	);
INSERT INTO spectators VALUES(	405	, 	'De Boer'	, 	'Livin'	);
INSERT INTO spectators VALUES(	406	, 	'DE BOER'	, 	'Frans'	);
INSERT INTO spectators VALUES(	407	, 	'De Boes'	, 	'Julien'	);
INSERT INTO spectators VALUES(	408	, 	'De Bontridder'	, 	'Albert'	);
INSERT INTO spectators VALUES(	409	, 	'De Bontridder'	, 	'Maurice'	);
INSERT INTO spectators VALUES(	410	, 	'DE BRAUWER'	, 	'Fien'	);
INSERT INTO spectators VALUES(	411	, 	'De Brouwer'	, 	'Iris'	);
INSERT INTO spectators VALUES(	412	, 	'De Brouwer'	, 	'Hans'	);
INSERT INTO spectators VALUES(	413	, 	'DE BRUYN'	, 	'Jean'	);
INSERT INTO spectators VALUES(	414	, 	'De Buck'	, 	'Vital'	);
INSERT INTO spectators VALUES(	415	, 	'De Buck'	, 	'Danny'	);
INSERT INTO spectators VALUES(	416	, 	'DE CAT'	, 	'Geert'	);
INSERT INTO spectators VALUES(	417	, 	'De Clerq'	, 	'Jo'	);
INSERT INTO spectators VALUES(	418	, 	'DE COENE'	, 	'Marcel'	);
INSERT INTO spectators VALUES(	419	, 	'de Corbeek over Loo'	, 	'Dieudonné'	);
INSERT INTO spectators VALUES(	420	, 	'De Cort'	, 	'Guy'	);
INSERT INTO spectators VALUES(	421	, 	'De Coster'	, 	'Rita'	);
INSERT INTO spectators VALUES(	422	, 	'De Craan'	, 	'Fran'	);
INSERT INTO spectators VALUES(	423	, 	'DE CRAAN.'	, 	'Jan-Baptiste'	);
INSERT INTO spectators VALUES(	424	, 	'De Crean'	, 	'Henri'	);
INSERT INTO spectators VALUES(	425	, 	'DE CREMER'	, 	'Frieda'	);
INSERT INTO spectators VALUES(	426	, 	'DE FONSKES'	, 	'Manu'	);
INSERT INTO spectators VALUES(	427	, 	'De Ganck'	, 	'Michel'	);
INSERT INTO spectators VALUES(	428	, 	'DE GAUW'	, 	'Frans'	);
INSERT INTO spectators VALUES(	429	, 	'DE GAUW'	, 	'Frans'	);
INSERT INTO spectators VALUES(	430	, 	'DE GEETER'	, 	'Bart'	);
INSERT INTO spectators VALUES(	431	, 	'DE GELDER'	, 	'François'	);
INSERT INTO spectators VALUES(	432	, 	'De Gendt'	, 	'Dirk'	);
INSERT INTO spectators VALUES(	433	, 	'DE GROODT'	, 	'Armand'	);
INSERT INTO spectators VALUES(	434	, 	'DE GUISE'	, 	'Gert'	);
INSERT INTO spectators VALUES(	435	, 	'De Hertoghe'	, 	'Paul'	);
INSERT INTO spectators VALUES(	436	, 	'DE HERTOGHE'	, 	'Jean-Pierre'	);
INSERT INTO spectators VALUES(	437	, 	'DE KEYSER'	, 	'Zita'	);
INSERT INTO spectators VALUES(	438	, 	'De Koninck'	, 	'Joren'	);
INSERT INTO spectators VALUES(	439	, 	'DE LANDSHEERE'	, 	'Jean'	);
INSERT INTO spectators VALUES(	440	, 	'De Langhe'	, 	'Arthur'	);
INSERT INTO spectators VALUES(	441	, 	'DE LEEUW'	, 	'Henri'	);
INSERT INTO spectators VALUES(	442	, 	'DE LEEUW'	, 	'Jef'	);
INSERT INTO spectators VALUES(	443	, 	'De Meirsman'	, 	'Jo'	);
INSERT INTO spectators VALUES(	444	, 	'DE MEIRSMAN'	, 	'Jean'	);
INSERT INTO spectators VALUES(	445	, 	'De Meirsman'	, 	'Mimi'	);
INSERT INTO spectators VALUES(	446	, 	'De Mey'	, 	'Livin'	);
INSERT INTO spectators VALUES(	447	, 	'De Meyer'	, 	'Jan'	);
INSERT INTO spectators VALUES(	448	, 	'De Mol'	, 	'Henri'	);
INSERT INTO spectators VALUES(	449	, 	'DE MUNTER'	, 	'Felix'	);
INSERT INTO spectators VALUES(	450	, 	'DE MUNTER'	, 	'Ludo'	);
INSERT INTO spectators VALUES(	451	, 	'De Paepe'	, 	'Guido'	);
INSERT INTO spectators VALUES(	452	, 	'De Pauw'	, 	'Lodewijk'	);
INSERT INTO spectators VALUES(	453	, 	'DE PAUW'	, 	'Yves'	);
INSERT INTO spectators VALUES(	454	, 	'DE PRIJCK'	, 	'Jo'	);
INSERT INTO spectators VALUES(	455	, 	'De Puydt'	, 	'Frans'	);
INSERT INTO spectators VALUES(	456	, 	'De Raymaeker'	, 	'Julien'	);
INSERT INTO spectators VALUES(	457	, 	'De Reyt'	, 	'Georges'	);
INSERT INTO spectators VALUES(	458	, 	'EVERS'	, 	'Albert'	);
INSERT INTO spectators VALUES(	459	, 	'Evrard'	, 	'Marc'	);
INSERT INTO spectators VALUES(	460	, 	'Exelmans'	, 	'Julien'	);
INSERT INTO spectators VALUES(	461	, 	'Eyckmans'	, 	'Frans'	);
INSERT INTO spectators VALUES(	462	, 	'EYSKENS'	, 	'Maurice'	);
INSERT INTO spectators VALUES(	463	, 	'FAES'	, 	'Fons'	);
INSERT INTO spectators VALUES(	464	, 	'FAGOT'	, 	'Jean'	);
INSERT INTO spectators VALUES(	465	, 	'FANNES'	, 	'August'	);
INSERT INTO spectators VALUES(	466	, 	'Fannes'	, 	'Iris'	);
INSERT INTO spectators VALUES(	467	, 	'Fannes'	, 	'Hans'	);
INSERT INTO spectators VALUES(	468	, 	'Fannes'	, 	'Germain'	);
INSERT INTO spectators VALUES(	469	, 	'Fannes'	, 	'Niels'	);
INSERT INTO spectators VALUES(	470	, 	'Fedyna'	, 	'Fien'	);
INSERT INTO spectators VALUES(	471	, 	'Feremans'	, 	'Wino'	);
INSERT INTO spectators VALUES(	472	, 	'FERON'	, 	'Vital'	);
INSERT INTO spectators VALUES(	473	, 	'FESTRAETS'	, 	'Leander'	);
INSERT INTO spectators VALUES(	474	, 	'Feyaerts'	, 	'Hugo'	);
INSERT INTO spectators VALUES(	475	, 	'FEYAERTS'	, 	'Danny'	);
INSERT INTO spectators VALUES(	476	, 	'Feyaerts'	, 	'Geert'	);
INSERT INTO spectators VALUES(	477	, 	'Struiven'	, 	'Jo'	);
INSERT INTO spectators VALUES(	478	, 	'Stox'	, 	'Marcel'	);
INSERT INTO spectators VALUES(	479	, 	'VanOs'	, 	'Guy'	);
INSERT INTO spectators VALUES(	480	, 	'Van Diest'	, 	'Gaby'	);

Prompt --> insert data into the reservations table  (and first spectators in RESERVATION_SPECTATORS)
DECLARE
  tussenaantal    NUMBER := 1;
  telrec          NUMBER := 0;
  res_id          NUMBER := 16170001;
BEGIN
  FOR srec in (SELECT * from subscribers) LOOP
	telrec := telrec + 1;
	INSERT INTO reservations VALUES(res_id, srec.subscriber_id, null);
	INSERT INTO reservation_spectators VALUES(res_id, srec.subscriber_id);
    res_id := res_id + 1;
	EXIT WHEN telrec = 30;
  END LOOP;
  res_id := 17180001;
  telrec := 0;
  FOR srec in (SELECT * from subscribers) LOOP
	telrec := telrec + 1;
	IF telrec = tussenaantal THEN
	    INSERT INTO reservations VALUES(res_id, srec.subscriber_id, null);
		INSERT INTO reservation_spectators VALUES(res_id, srec.subscriber_id);
		res_id := res_id + 1;
		telrec := 0;
    END IF;
	IF substr(to_char(res_id), 7, 2) = 20 THEN
		tussenaantal := 2;
	END IF;
  END LOOP;
  res_id := 18190001;
  telrec := 0;
  FOR srec in (SELECT * from subscribers) LOOP
	telrec := telrec + 1;
	IF telrec >= 10 THEN
	    INSERT INTO reservations VALUES(res_id, srec.subscriber_id, null);
		INSERT INTO reservation_spectators VALUES(res_id, srec.subscriber_id);
		res_id := res_id + 1;
    END IF;
  END LOOP;
END;
/

UPDATE reservations SET comments = 'rolstoelgebruiker' WHERE MOD(subscriber_id, 15) = 6;
UPDATE reservations SET comments = 'graag een plaats dicht bij toilet' WHERE MOD(subscriber_id, 23) = 6;


Prompt --> insert other spectatordata into the RESERVATION_SPECTATORS
DECLARE
   spectator_teller        NUMBER   := 41;
   tussenaantal            NUMBER   := 1;
   aantal_per_reservatie   NUMBER   := 0;
BEGIN
   FOR rec in (SELECT * FROM reservations) LOOP
      aantal_per_reservatie := MOD(rec.subscriber_id , 3) + 1;
	  FOR i in 1..aantal_per_reservatie LOOP
	     INSERT INTO reservation_spectators VALUES(rec.reservation_id, spectator_teller);
		 spectator_teller := spectator_teller + 1;
		 IF spectator_teller > 480 THEN
		    spectator_teller := 41;
	     END IF;
	  END LOOP;
   END LOOP;
END;
/

Prompt --> insert data into RESERVATION_PERFORMANCES : 2016
DECLARE
   onder NUMBER := 16170001;
   boven NUMBER := 16170008;
BEGIN
   FOR rec in (SELECT * FROM performance_dates WHERE season = '2016 - 2017') LOOP
      INSERT INTO reservation_performances
	     SELECT reservation_id, rec.theatre_performance, rec.date_time
	     FROM reservations
		 WHERE  reservation_id BETWEEN onder AND boven;
	  onder := onder + 8;
	  boven := boven + 8;
   END LOOP;
  END;
  /
  
Prompt --> insert data into RESERVATION_PERFORMANCES : 2017
DECLARE
   deeltal NUMBER := 2;
   welke NUMBER := 1;
BEGIN
   FOR rec in (SELECT * FROM performance_dates WHERE season = '2017 - 2018') LOOP
      IF welke = 1 THEN
	           INSERT INTO reservation_performances
	              SELECT reservation_id, rec.theatre_performance, rec.date_time
	              FROM reservations
		          WHERE  reservation_id like '1718%' AND MOD(reservation_id, deeltal) = 1;
			   welke := 2;
	  ELSE
	  	       INSERT INTO reservation_performances
	              SELECT reservation_id, rec.theatre_performance, rec.date_time
	              FROM reservations
		          WHERE  reservation_id like '1718%' AND MOD(reservation_id, deeltal) != 1;
	           welke := 1;
			   deeltal := deeltal + 1;
	  END IF;
   END LOOP;
  END;
  /
  
Prompt --> insert data into RESERVATION_PERFORMANCES : 2018
DECLARE
   teller        NUMBER   := 6;
BEGIN
   FOR rrec in (SELECT * FROM reservations WHERE reservation_id like '1819%') LOOP
	    FOR prec in (SELECT * FROM performance_dates WHERE season = '2018 - 2019') LOOP
		   IF teller = 6 THEN
	           INSERT INTO reservation_performances VALUES(rrec.reservation_id, prec.theatre_performance, prec.date_time);
			   teller := 1;
		   ELSE
		       teller := teller + 1;
	       END IF;
	    END LOOP;
   END LOOP;
END;
/

Prompt --> insert data into rehearsals
DECLARE
   teller        NUMBER;
   rehearsal_day DATE;
   rehearsal_day_mon DATE;
   location NUMBER;
   CURSOR c_performances is 
      SELECT theatre_performance, season, MIN(date_time) performance_day 
	  FROM performance_dates
      GROUP BY theatre_performance, season ;
BEGIN
   FOR rec in c_performances LOOP
	    teller := 2;
		rehearsal_day := rec.performance_day - 40.17;
	    WHILE rehearsal_day < rec.performance_day LOOP
		   IF rehearsal_day > rec.performance_day - 3 THEN
		      location := 1;
		   ELSE
		      location := 2;
		   END IF;
		   IF to_char(rehearsal_day, 'dy') = 'mon' THEN
		       rehearsal_day_mon := to_date(to_char(rehearsal_day, 'ddmmyyyy')||'09', 'ddmmyyhh24');
	           INSERT INTO rehearsals VALUES(rec.theatre_performance, rehearsal_day_mon, rehearsal_day_mon + 1/6, 1);
			   INSERT INTO rehearsals VALUES(rec.theatre_performance, rehearsal_day_mon + 1/6+1/24, rehearsal_day_mon + 3/6, location);
		   ELSIF teller = 2 THEN
			   INSERT INTO rehearsals VALUES(rec.theatre_performance, rehearsal_day, rehearsal_day + 1/6, location);
			   teller := 1;
		   ELSE
			   teller := 2;
		   END IF;
	       rehearsal_day := rehearsal_day + 1;
	    END LOOP;
   END LOOP;
END;
/

Prompt --> insert data into rehearsal_actors
DECLARE
   teller NUMBER := 1;
   aantalacteurs NUMBER;
BEGIN
   FOR rec in (SELECT * FROM rehearsals) LOOP
   	  SELECT count(*) INTO aantalacteurs FROM performance_actors  p
		         WHERE  p.theatre_performance = rec.theatre_performance
				 AND rec.date_starttime BETWEEN to_date('01-09-'||substr(p.season, 1, 4), 'dd-mm-yyyy') 
				                        AND to_date('30-07-'||substr(p.season, 8, 4), 'dd-mm-yyyy');
      IF rec.location_id = 1 OR aantalacteurs <= 3 THEN
	     	INSERT INTO rehearsal_actors
	              SELECT rec.theatre_performance, rec.date_starttime, actor_id
	              FROM performance_actors p
		          WHERE  p.theatre_performance = rec.theatre_performance
				  AND  rec.date_starttime BETWEEN to_date('01-09-'||substr(p.season, 1, 4), 'dd-mm-yyyy') 
				                          AND to_date('30-07-'||substr(p.season, 8, 4), 'dd-mm-yyyy');
	  ELSE
	     FOR arec in (SELECT * FROM performance_actors 
		              WHERE  theatre_performance = rec.theatre_performance
				      AND rec.date_starttime BETWEEN to_date('01-09-'||substr(season, 1, 4), 'dd-mm-yyyy')
					                         AND to_date('30-07-'||substr(season, 8, 4), 'dd-mm-yyyy')) LOOP
			IF teller > aantalacteurs OR teller = 4 THEN
			   teller := 1;
			END IF;
			IF teller = 1 THEN
			   INSERT INTO rehearsal_actors VALUES(rec.theatre_performance, rec.date_starttime, arec.actor_id);
			END IF;
			teller := teller + 1;
		 END LOOP;
	  END IF;
   END LOOP;
END;
/

COMMIT;
