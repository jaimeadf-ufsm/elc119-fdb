import os
import re
import decimal

import dotenv
import mysql.connector

dotenv.load_dotenv()

db = mysql.connector.connect(
    host=os.getenv('MYSQL_HOST'),
    user=os.getenv('MYSQL_USER'),
    password=os.getenv('MYSQL_PASSWORD')
)

def import_grb_database():
    cursor = db.cursor()

    cursor.execute("INSERT INTO olympics.athlete(athleteId, name, sex, height, weight, noc) SELECT athleteId, name, sex, height, weight, 'GRB' AS noc FROM olympics_grb.athletes")
    cursor.execute('INSERT INTO olympics.city(cityId, name) SELECT cityId, name FROM olympics_grb.cities')
    cursor.execute('INSERT INTO olympics.sport(sportId, name) SELECT sportId, name FROM olympics_grb.sports')
    cursor.execute('INSERT INTO olympics.event(eventId, sportId, name) SELECT eventId, sportId, name FROM olympics_grb.events')
    cursor.execute('INSERT INTO olympics.medal(medalId, name) SELECT medalId, name FROM olympics_grb.medals')
    cursor.execute('INSERT INTO olympics.edition(editionId, year, season, alternateTitle) SELECT editionId, year, season, title FROM olympics_grb.editions')
    cursor.execute('INSERT INTO olympics.host(editionId, sportId, cityId) SELECT editionId, sportId, cityId FROM olympics_grb.games')
    cursor.execute('INSERT INTO olympics.participant(athleteId, editionId, age) SELECT DISTINCT athleteId, editionId, sportId, age FROM olympics_grb.results NATURAL JOIN olympics_grb.games NATURAL JOIN olympics_grb.competitors')
    cursor.execute('INSERT INTO olympics.result(athleteId, editionId, sportId, eventId, medalId, team) SELECT athleteId, editionId, sportId, eventId, medalId, team FROM olympics_grb.results NATURAL JOIN olympics_grb.members NATURAL JOIN olympics_grb.games')

    db.commit()

def import_usa_database():
    cursor = db.cursor()

    def convert_feet_and_inches_to_cm(measurement):
        match = re.match("(\\d+).*(?:’|')(\\d+).*(?:”|\')", measurement)
        return (int(match.group(1)) * 12 + int(match.group(2))) * decimal.Decimal('2.54')
    
    def update_or_create_city(name):
        cursor.execute('SELECT cityId FROM olympics.city WHERE name = %s', (name,))
        row = cursor.fetchone()

        if row is None:
            cursor.execute('INSERT INTO olympics.city(name) VALUES(%s)', (name,))
            db.commit()

            return cursor.lastrowid

        return row[0]
    
    def update_or_create_sport(name):
        cursor.execute('SELECT sportId FROM olympics.sport WHERE name = %s', (name,))
        row = cursor.fetchone()

        if row is None:
            cursor.execute('INSERT INTO olympics.sport(name) VALUES(%s)', (name,))
            db.commit()

            return cursor.lastrowid

        return row[0]

    def update_or_create_medal(name):
        cursor.execute('SELECT medalId FROM olympics.medal WHERE name = %s', (name,))
        row = cursor.fetchone()

        if row is None:
            cursor.execute('INSERT INTO olympics.medal(name) VALUES(%s)', (name,))
            db.commit()

            return cursor.lastrowid

        return row[0]
        
    def update_or_create_edition(year, season, alternate_title, official_title, country):
        cursor.execute(
            'SELECT editionId FROM olympics.edition WHERE year = %s AND season = %s',
            (year, season)
        )

        row = cursor.fetchone()

        if row is None:
            cursor.execute(
                'INSERT INTO olympics.edition(year, season, alternateTitle, officialTitle, country)' +
                ' VALUES(%s, %s, %s, %s, %s)',
                (year, season, alternate_title, official_title, country)
            )
            db.commit()

            return cursor.lastrowid

        cursor.execute(
            'UPDATE olympics.edition SET officialTitle = %s, country = %s WHERE editionId = %s',
            (official_title, country, row[0])
        )
        db.commit()

        return row[0]
    
    def update_or_create_host(edition_id, sport_id, city):
        cursor.execute('SELECT * FROM olympics.host WHERE editionId = %s AND sportId = %s', (edition_id, sport_id))
        row = cursor.fetchone()

        if row is None:
            city_id = update_or_create_city(city)

            cursor.execute('INSERT INTO olympics.host(editionId, sportId, cityId) VALUES(%s, %s, %s)', (edition_id, sport_id, city_id))
            db.commit()


    new_sport_ids = {}
    new_edition_ids = {}

    new_medal_ids = {
        'Gold': update_or_create_medal('Gold'),
        'Silver': update_or_create_medal('Silver'),
        'Bronze': update_or_create_medal('Bronze'),
    }


    cursor.execute('SELECT id, name FROM olympics_usa.Sport')

    for sport_row in cursor.fetchall():
        sport_id = sport_row[0]
        sport_name = sport_row[1]

        new_sport_ids[sport_id] = update_or_create_sport('Canoeing' if sport_name == 'Canoe/Kayak' else sport_name)


    cursor.execute('SELECT id, edition, country, season, year FROM olympics_usa.Olympics')

    for olympics_row in cursor.fetchall():
        olympics_id = olympics_row[0]
        olympics_edition = olympics_row[1]
        olympics_country = olympics_row[2]
        olympics_season = olympics_row[3]
        olympics_year = olympics_row[4]

        new_edition_ids[olympics_id] = update_or_create_edition(
            olympics_year,
            olympics_season,
            f'{olympics_year} {olympics_season}',
            olympics_edition,
            olympics_country
        )


    cursor.execute(
        'SELECT id, first_name, last_name, birthday, deceased_date, height, hometown, education, gold_medals, silver_medals, bronze_medals, sport_id' +
        ' FROM olympics_usa.Athlete'
    )

    for athlete_row in cursor.fetchall():
        athlete_id = athlete_row[0]
        athlete_name = f'{athlete_row[1]} {athlete_row[2]}'
        athlete_date_of_birth = athlete_row[3].date()
        athlete_date_of_death = athlete_row[4].date() if athlete_row[4] else None
        athlete_height = convert_feet_and_inches_to_cm(athlete_row[5]) if athlete_row[5] else None
        athlete_hometown = athlete_row[6]
        athlete_education = athlete_row[7]
        athlete_gold_medals = athlete_row[8]
        athlete_silver_medals = athlete_row[9]
        athlete_bronze_medals = athlete_row[10]
        athlete_sport_id = athlete_row[11]

        new_athlete_sport_id = new_sport_ids[athlete_sport_id]

        cursor.execute(
            'INSERT INTO olympics.athlete(name, height, dateOfBirth, dateOfDeath, hometown, education, noc)' +
            " VALUES (%s, %s, %s, %s, %s, %s, 'USA')",
            (athlete_name, athlete_height, athlete_date_of_birth, athlete_date_of_death, athlete_hometown, athlete_education)
        )
        db.commit()

        new_athlete_id = cursor.lastrowid

        cursor.execute(
            'SELECT DISTINCT Olympics.id, Olympics.city FROM olympics_usa.Participation' +
            ' JOIN olympics_usa.Olympics ON Olympics.id = Participation.olympics_id' +
            ' WHERE athlete_id = %s',
            (athlete_id,)
        )

        for participation_row in cursor.fetchall():
            olympics_id = participation_row[0]
            olympics_city = participation_row[1]

            new_edition_id = new_edition_ids[olympics_id]

            cursor.execute(
                'INSERT INTO olympics.participant(athleteId, editionId, sportId) VALUES(%s, %s, %s)',
                (new_athlete_id, new_edition_id, new_athlete_sport_id)
            )
            db.commit()

            update_or_create_host(new_edition_id, new_athlete_sport_id, olympics_city)

        achievements = [
            (athlete_gold_medals, new_medal_ids['Gold']),
            (athlete_silver_medals, new_medal_ids['Silver']),
            (athlete_bronze_medals, new_medal_ids['Bronze']),
        ]

        for achivement in achievements:
            amount = achivement[0]
            medal_id = achivement[1]

            for _ in range(0, amount):
                cursor.execute(
                    'INSERT INTO olympics.result(athleteId, sportId, medalId) VALUES(%s, %s, %s)',
                    (new_athlete_id, new_athlete_sport_id, medal_id)
                )
        
        db.commit()

import_grb_database()
import_usa_database()
