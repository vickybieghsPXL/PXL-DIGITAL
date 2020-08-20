REM ===============
REM Tabel CURSUSSEN 
REM ===============

drop table cursussen cascade constraints;

create table cursussen
( curs_code         VARCHAR2(4)  constraint C_PK
                            primary key
, curs_omschr 		VARCHAR2(50) constraint C_OMSCHR_NN
                            not null
, curs_type         CHAR(3)      constraint C_TYPE_NN
                            not null
, curs_lengte       NUMBER(2)    constraint C_LENGTE_CHK
					check (curs_lengte between 1 and 10)
, constraint   C_TYPE_CHK   check
                            (curs_type = upper(curs_type))
) ;

REM ==================
REM Tabel UITVOERINGEN
REM ==================

drop table uitvoeringen cascade constraints;

create table uitvoeringen
( cursus      VARCHAR2(4)  constraint U_CURSUS_NN
                           not null
                           constraint U_CURSUS_FK
                           references cursussen(curs_code)
, begindatum  DATE         constraint U_BEGIN_NN
                           not null
, docent      NUMBER(4)    constraint U_DOCENT_FK
                           references employees(employee_id)
, locatie     VARCHAR2(20)
, constraint  U_PK         primary key
                           (cursus,begindatum)
) ;

REM ====================
REM Tabel INSCHRIJVINGEN
REM ====================

drop table inschrijvingen cascade constraints;

create table inschrijvingen
( cursist      NUMBER(4)   constraint I_CURSIST_NN
                           not null
                           constraint I_CURSIST_FK
                           references employees(employee_id)
, cursus       VARCHAR2(4) constraint I_CURSUS_NN
                           not null
, begindatum   DATE        constraint I_BEGIN_NN
                           not null
, evaluatie    NUMBER(1)   constraint I_EVAL_CHK
                           check (evaluatie in (0,1,2,3,4,5))
, constraint   I_PK        primary key
                           (cursist,cursus)
, constraint   I_UITV_FK   foreign key
                           (cursus,begindatum)
                           references uitvoeringen
) ;

