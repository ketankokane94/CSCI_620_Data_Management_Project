create table Title 
(tconst nvarchar(10), 
ordering int, 
primary_title varchar(300), 
title_type varchar(100), 
is_adult boolean, 
average_rating float, 
original_title varchar(300), 
runtime_minutes int, 
start_year int, 
regional_title varchar(300), 
end_year int, 
regional_title_description varchar(1000), 
PRIMARY KEY(tconst, ordering));

create table Title_genres 
(tconst nvarchar(10), 
ordering int, 
genres varchar(100), 
PRIMARY KEY(tconst, ordering, genres), 
FOREIGN KEY (tconst, ordering) REFERENCES Title(tconst, ordering));

create table Person 
(nconst nvarchar(10), 
primary_name varchar(100), 
birth_year int, 
death_year int, 
PRIMARY KEY(nconst));

create table Person_primary_profession 
(nconst nvarchar(10), 
primary_profession varchar(100), 
PRIMARY KEY(nconst, primary_profession),
FOREIGN KEY (nconst) REFERENCES person(nconst));

create table Person_known_fortitle 
(nconst nvarchar(10), 
tconst nvarchar(10), 
ordering int, 
PRIMARY KEY(nconst, tconst, ordering), 
FOREIGN KEY(nconst) REFERENCES Person(nconst), 
FOREIGN KEY(tconst, ordering) REFERENCES Title(tconst, ordering));

create table Pricipal_cast_character 
(tconst nvarchar(10),
ordering int, 
nconst nvarchar(10),
character_played varchar(100), 
PRIMARY KEY(tconst, nconst, ordering, character_played), 
FOREIGN KEY (tconst, ordering) REFERENCES Title(tconst, ordering), 
FOREIGN KEY (nconst) REFERENCES Person(nconst));

create table Episode_name
(parent_tconst nvarchar(10), 
tconst nvarchar(10),
ordering int,
season_number int,
episode_number int,
PRIMARY KEY(parent_tconst, tconst, ordering),
FOREIGN KEY(parent_tconst) REFERENCES Title(tconst),
FOREIGN KEY(tconst, ordering) REFERENCES Title(tconst, ordering)); 