PRAGMA foreign_keys=on;

drop table if exists animals;
drop table if exists breeds;
drop table if exists owners;

create table breeds(
	name text primary key
);

insert into breeds (name) values('Golden Retriever');

create table owners(
	id integer primary key autoincrement,
	name text not null,
	address text,
	phone_no text
);

insert into owners (name, address, phone_no) values('José Pires', 'Rua das Flores', '9191919191');

create table animals(
	id integer primary key autoincrement,
	name text,
	breed text not null references breeds,
	owner integer references owners
);
	
	--select(currval('breeds_id_seq')), 	--select(currval('animals_id_seq'))
	
insert into animals(name, breed, owner) values ('Tareco',
	'Golden Retriever',
	1 
)


