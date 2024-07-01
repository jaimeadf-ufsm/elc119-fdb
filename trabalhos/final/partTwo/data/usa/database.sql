DROP DATABASE IF EXISTS `olympics_usa` ;

CREATE DATABASE `olympics_usa`;
USE `olympics_usa`;

-- Criando tabelas

CREATE TABLE Sport (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    season VARCHAR(255) NOT NULL
);

CREATE TABLE Athlete (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    birthday DATETIME NOT NULL,
    deceased_date DATETIME, 
    height VARCHAR(255), 
    hometown VARCHAR(255) NOT NULL,
    education VARCHAR(255), 
    gold_medals INT NOT NULL,
    silver_medals INT NOT NULL,
    bronze_medals INT NOT NULL,
    sport_id INT NOT NULL,
    FOREIGN KEY (sport_id) REFERENCES Sport(id)
);

CREATE TABLE Olympics (
    id INT PRIMARY KEY AUTO_INCREMENT,
    edition VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    season VARCHAR(255) NOT NULL
);

CREATE TABLE Participation (
    id INT PRIMARY KEY AUTO_INCREMENT,
    athlete_id INT,
    olympics_id INT,
    FOREIGN KEY (athlete_id) REFERENCES Athlete(id),
    FOREIGN KEY (olympics_id) REFERENCES Olympics(id)
);


-- Inserir dados de Olimpiadas

INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('I Olimpíada','Grécia','Atenas',1896,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('II Olimpíada','França','Paris',1900,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('III Olimpíada','Estados Unidos','Saint Louis',1904,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('Edição especial','Grécia','Atenas',1906,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('IV Olimpíada','Grã-Bretanha','Londres',1908,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('V Olimpíada','Suécia','Estocolmo',1912,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('VII Olimpíada','Bélgica','Antuérpia',1920,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('VIII Olimpíada','França','Paris',1924,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('IX Olimpíada','Países Baixos','Amesterdão',1928,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('X Olimpíada','Estados Unidos','Los Angeles',1932,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XI Olimpíada','Alemanha','Berlim',1936,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XIV Olimpíada','Grã-Bretanha','Londres',1948,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XV Olimpíada','Finlândia','Helsinque',1952,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XVI Olimpíada','Austrália','Melbourne',1956,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XVII Olimpíada','Itália','Roma',1960,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XVIII Olimpíada','Japão','Tóquio',1964,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XIX Olimpíada','México','Cidade do México',1968,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XX Olimpíada','Alemanha Ocidental','Munique',1972,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXI Olimpíada','Canadá','Montreal',1976,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXII Olimpíada','União Soviética','Moscou',1980,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXIII Olimpíada','Estados Unidos','Los Angeles',1984,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXIV Olimpíada','Coreia do Sul','Seul',1988,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXV Olimpíada','Espanha','Barcelona',1992,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXVI Olimpíada','Estados Unidos','Atlanta',1996,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXVII Olimpíada','Austrália','Sydney',2000,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXVIII Olimpíada','Grécia','Atenas',2004,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXIX Olimpíada','China','Pequim',2008,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXX Olimpíada','Grã-Bretanha','Londres',2012,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXXI Olimpíada','Brasil','Rio de Janeiro',2016,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXXII Olimpíada','Japão','Tóquio',2020,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXXIII Olimpíada','França','Paris',2024,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXXIV Olimpíada','Estados Unidos','Los Angeles',2028,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXXV Olimpíada','Austrália','Brisbane',2032,'Summer');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('I Olimpíada','França','Chamonix',1924,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('II Olimpíada','Suíça','São Moritz',1928,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('III Olimpíada','Estados Unidos','Lake Placid',1932,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('IV Olimpíada','Alemanha','Garmisch-Partenkirchen',1936,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('V Olimpíada','Suíça','São Moritz',1948,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('VI Olimpíada','Noruega','Oslo',1952,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('VII Olimpíada','Itália','Cortina d''Ampezzo',1956,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('VIII Olimpíada','Estados Unidos','Squaw Valley',1960,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('IX Olimpíada','Áustria','Innsbruck',1964,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('X Olimpíada','França','Grenoble',1968,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XI Olimpíada','Japão','Sapporo',1972,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XII Olimpíada','Áustria','Innsbruck',1976,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XIII Olimpíada','Estados Unidos','Lake Placid',1980,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XIV Olimpíada','Jugoslávia','Sarajevo',1984,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XV Olimpíada','Canadá','Calgary',1988,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XVI Olimpíada','França','Albertville',1992,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XVII Olimpíada','Noruega','Lillehammer',1994,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XVIII Olimpíada','Japão','Nagano',1998,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XIX Olimpíada','Estados Unidos','Salt Lake City',2002,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XX Olimpíada','Itália','Turim',2006,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXI Olimpíada','Canadá','Vancouver',2010,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXII Olimpíada','Rússia','Sóchi',2014,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXIII Olimpíada','Coreia do Sul','Pyeongchang',2018,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXIV Olimpíada','China','Pequim',2022,'Winter');
INSERT INTO olympics_usa.Olympics (edition,country,city,`year`,season) VALUES ('XXV Olimpíada','lia','Milão-Cortina',2026,'Winter');

-- Inserir dados de Esportes

INSERT INTO olympics_usa.Sport (name,season) VALUES ('Figure Skating','Winter');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Softball','Summer');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Taekwondo','Summer');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Volleyball','Summer');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Basketball','Summer');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Swimming','Summer');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Track and Field','Summer');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Fencing','Summer');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Boxing','Summer');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Baseball','Summer');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Skeleton','Winter');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Water Polo','Summer');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Ice Hockey','Winter');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Curling','Winter');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Canoe/Kayak','Summer');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Snowboarding','Winter');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Wrestling','Summer');
INSERT INTO olympics_usa.Sport (name,season) VALUES ('Shooting','Summer');

-- Inserir dados de Atletas

INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Jeremy','Abbott',38,'1985-06-05 00:00:00',NULL,'5’10”','Aspen, CO',NULL,0,0,1,1);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Monica','Abbott',38,'1985-07-28 00:00:00',NULL,'6''3"','Salinas, CA','North Salinas High School Tennessee - 2007',0,2,0,2);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Nia','Abdallah',40,'1984-01-24 00:00:00',NULL,'5''9"','Houston, TX','George Washington Carver High School for Applied Technology, Engineering and the Arts American Sports University',0,1,0,3);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Rachael','Adams',33,'1990-06-03 00:00:00',NULL,'6''2"','Cincinnati, OH','Mount Notre Dame (Cincinnati, Ohio) University of Texas',0,0,1,4);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Bam','Adebayo',26,'1997-07-18 00:00:00',NULL,'6''9"','Newark, NJ','University of Kentucky',1,0,0,5);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Nathan','Adrian',35,'1988-12-07 00:00:00',NULL,'6''6"','Bremerton, WA','Bremerton High School (Bremerton, Wash.) ‘06 University of California – Berkeley ‘12, Public Health',5,1,2,6);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Ali','Aguilar',28,'1995-08-28 00:00:00',NULL,'5''7"','Orangevale, CA','Washington - 2017',0,1,0,2);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Morolake','Akinosun',29,'1994-05-17 00:00:00',NULL,'5''4"','Aurora, IL','Waubonsie Valley High School (Aurora, Ill.) ‘12 University of Texas ’16, Exercise Science',1,0,0,7);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Foluke','Akinradewo Gunderson',36,'1987-10-05 00:00:00',NULL,'6''3"','Fort Lauderdale, FL','Stanford University ‘09, Human Biology',1,1,1,4);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Monica','Aksamit',34,'1990-02-18 00:00:00',NULL,'6''0"','Matawan, NJ','Matawan Regional High School (Matawan, N.J.) ''08 Penn State University ’16, Kinesiology',0,0,1,8);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Tenley','Albright',88,'1935-07-18 00:00:00',NULL,NULL,'Newton Center, MA','Radcliffe College; Harvard Medical School',1,1,0,1);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Muhammad','Ali',74,'1942-01-17 00:00:00','2016-06-03 00:00:00',NULL,'Louisville, KY','Louisville Central High School (Louisiana, Ky.)',1,0,0,9);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Nia','Ali',35,'1988-10-22 00:00:00',NULL,'5''6"','Philadelphia, PA','University of Southern California ',0,1,0,7);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Nick','Allen',25,'1998-10-08 00:00:00',NULL,'5''8"','San Diego, CA','Parker High School (San Diego, Calif.) ‘17 ',0,1,0,10);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Valarie','Allman',29,'1995-02-23 00:00:00',NULL,NULL,'Longmont, CO','Stanford University ''17, Product Design',1,0,0,7);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Matt','Anderson',37,'1987-04-18 00:00:00',NULL,'6''10"','West Seneca, NY','Pennsylvania State University',0,0,1,4);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Haley','Anderson',32,'1991-11-20 00:00:00',NULL,'5''10"','Granite Bay, CA','Granite Bay High School (Granite Bay, Calif.) ''09 University of Southern California ’13, Communications',0,1,0,6);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Michael','Andrew',25,'1999-04-18 00:00:00',NULL,'6''6"','Encinitas, CA',NULL,1,0,0,6);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Carmelo','Anthony',39,'1984-05-29 00:00:00',NULL,'6''8"','New York, NY','Oak Hill Academy (Mouth of Wilson, Va.) ‘02 Syracuse University',3,0,1,5);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Matt','Antoine',39,'1985-04-02 00:00:00',NULL,'6''3"','Prairie du Chien, WI',' California University of Pennsylvania',0,0,1,11);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Zach','Apple',27,'1997-04-23 00:00:00',NULL,'6''7"','Trenton, OH','Indiana University ''19, Exercise Science',2,0,0,6);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Valerie','Arioto',35,'1989-04-10 00:00:00',NULL,'5''7"','Pleasanton, CA','Foothill High School California - 2012',0,1,0,2);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Evelyn','Ashford',67,'1957-04-15 00:00:00',NULL,NULL,'Roseville, CA','Roseville High School (Roseville, Calif.) UCLA',4,1,0,7);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Ariel','Atkins',27,'1996-07-30 00:00:00',NULL,'5''8"','Dallas, TX','University of Texas ',1,0,0,5);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Seimone','Augustus',40,'1984-04-30 00:00:00',NULL,'6''1"','Baton Rouge, LA','Capitol High School (Baton Rouge, La.) ''02 Louisiana State University ''05, General Studies',3,0,0,5);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Tyler','Austin',32,'1991-09-06 00:00:00',NULL,'6''2"','Conyers, GA','Heritage High School (Conyers, Ga.) ‘10',0,1,0,10);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Tony','Azevedo',42,'1981-11-21 00:00:00',NULL,'6''1"','Long Beach, CA','Wilson High School (Long Beach, Calif.) ‘00 Stanford University ‘05, International Relations',0,1,0,12);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Shirley','Babashoff',67,'1957-01-31 00:00:00',NULL,NULL,'Fountain Valley, CA','Fountain Valley High School (Fountain Valley, Calif.)',3,6,0,6);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('David','Backes',40,'1984-05-01 00:00:00',NULL,'6''3"','Minneapolis, MN','Spring Lake Park High School Minnesota State-Mankato',0,1,0,13);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Scott','Baird',73,'1951-05-07 00:00:00',NULL,NULL,'Bemidji, MN',NULL,0,0,1,14);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Kathleen','Baker',27,'1997-02-28 00:00:00',NULL,'5''8"','Winston Salem, NC','Forsyth Country Day School (Lewisville, N.C.); Homeschooled ‘15 University of California, Berkeley ‘19, Public Health',1,1,0,6);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Lloy','Ball',52,'1972-02-17 00:00:00',NULL,'6''8 (203cm)"','Fort Wayne, IN','Woodlan High School (Indiana) IPFW',1,0,0,4);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Kayla','Banwarth',35,'1989-01-21 00:00:00',NULL,'5''10"','Dubuque, IA','Wahlert Catholic High School University of Nebraska ''12, English',0,0,1,4);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Cayla','Barnes',25,'1999-01-07 00:00:00',NULL,'5''2"','Eastvale, CA','Boston College ',1,1,0,13);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Harrison','Barnes',31,'1992-05-30 00:00:00',NULL,'6''8"','Ames, IA','Ames High School (Ames, Iowa) ‘10 University of North Carolina',1,0,0,5);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Tianna','Bartoletta',38,'1985-08-30 00:00:00',NULL,'5''6"','Tampa, FL','Elyria High School (Elyria, Ohio) ‘03 University of Tennessee ‘07, Social Work',3,0,0,7);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Michelle','Bartsch-Hackley',34,'1990-02-12 00:00:00',NULL,'6''3"','Champaign, IL','University of Illinois ',1,0,0,4);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Evan','Bates',35,'1989-02-23 00:00:00',NULL,'6''1"','Northville, MI','University of Michigan ',1,0,0,1);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Nick','Baumgartner',42,'1981-12-17 00:00:00',NULL,'6''0"','Iron River, MI','West Iron County High School',1,0,0,16);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Bruce','Baumgartner',63,'1960-11-02 00:00:00',NULL,NULL,'Haledon, NJ','Manchester Regional High School (Haledon, N.J.) Indiana State University, Oklahoma State University',2,1,1,17);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Shane','Baz',24,'1999-06-17 00:00:00',NULL,'6''2"','Cypress, TX','Concordia Lutheran High School (Tomball, Texas) ‘17 ',0,1,0,10);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Bob','Beamon',77,'1946-08-29 00:00:00',NULL,NULL,'Jamaica, NY','Jamaica High School (Jamaica, N.Y.) North Carolina Agricultural and Technical College',1,0,0,7);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Bowe','Becker',26,'1997-07-07 00:00:00',NULL,NULL,'Reno, NV','Faith Lutheran High School ‘15 University of Minnesota ''19',1,0,0,6);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Kenny','Bednarek',25,'1998-10-14 00:00:00',NULL,'6''2"','Rice Lake, WI','Indian Hills Community College ',0,1,0,7);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Elizabeth','Beisel',31,'1992-08-18 00:00:00',NULL,'5''6"','Saunderstown, RI','North Kingstown High School (North Kingstown, R.I.) ‘10 University of Florida ‘14, Telecommunications',0,1,1,6);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Kacey','Bellamy',37,'1987-04-22 00:00:00',NULL,'5''7"','Westfield, MA','Berkshire School ''05 University of New Hampshire ''09',1,2,0,13);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Norman','Bellingham',59,'1964-12-23 00:00:00',NULL,NULL,'Rockville, MD',NULL,1,0,0,15);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Rai','Benjamin',26,'1997-07-27 00:00:00',NULL,'6''3"','Mount Vernon, NY','University of Southern California',1,1,0,7);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Joan','Benoit',67,'1957-05-16 00:00:00',NULL,NULL,'Cape Elizabeth, ME','Cape Elizabeth High School (Cape Elizabeth, Maine) North Carolina State University, Bowdoin College',1,0,0,7);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Gunnar','Bentz',28,'1996-01-03 00:00:00',NULL,'6''5"','Atlanta, GA','University of Georgia ',1,0,0,6);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Laura','Berg',49,'1975-01-06 00:00:00',NULL,'5''6"','Santa Fe Springs, CA','Santa Fe Springs High School Fresno State',3,1,0,2);
INSERT INTO olympics_usa.Athlete (first_name,last_name,age,birthday,deceased_date,height,hometown,education,gold_medals,silver_medals,bronze_medals,sport_id) VALUES ('Madelynn','Bernau',26,'1998-01-06 00:00:00',NULL,'5''6"','Waterford, WI','Waterford Union High School (Waterford, Wis.) ‘16 Martin Methodist College ‘20, Biology/Pre-veterinary Science',0,0,1,18);


-- Inserir dados de Participação

INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (1,54);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (1,55);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (2,27);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (2,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (3,26);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (4,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (5,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (6,27);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (6,28);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (6,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (7,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (8,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (9,28);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (9,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (9,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (10,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (11,39);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (11,40);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (12,15);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (13,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (14,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (15,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (16,28);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (16,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (16,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (17,28);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (17,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (17,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (18,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (19,26);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (19,27);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (19,28);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (19,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (20,55);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (20,56);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (21,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (22,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (23,19);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (23,21);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (23,22);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (23,23);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (24,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (25,27);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (25,28);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (25,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (26,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (27,25);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (27,26);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (27,27);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (27,28);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (27,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (28,18);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (28,19);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (29,54);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (29,55);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (30,53);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (31,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (32,24);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (32,25);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (32,26);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (32,27);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (33,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (34,56);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (34,57);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (35,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (36,28);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (36,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (37,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (38,54);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (38,55);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (38,56);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (38,57);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (39,54);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (39,55);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (39,56);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (39,57);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (40,21);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (40,22);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (40,23);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (40,24);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (40,22);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (40,23);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (40,24);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (41,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (42,17);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (43,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (44,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (45,27);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (45,28);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (45,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (46,54);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (46,55);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (46,56);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (47,21);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (47,22);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (47,23);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (48,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (49,21);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (49,21);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (50,29);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (50,30);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (51,24);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (51,25);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (51,26);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (51,27);
INSERT INTO olympics_usa.Participation (athlete_id,olympics_id) VALUES (52,30);

