

create table toys (
	productnummer number primary key,
	naam varchar2(15) not null,
	prijs number,
	CONSTRAINT moet_prijs_hebben CHECK (prijs > 0)
	)
	
create table solden (
	productnummer number,
	korting number,
	constraint productnummer primary key toys(productnummer, naam),
	constraint FK_NAAM foreign key naam references toys(naam)
	)