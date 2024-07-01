import os
import re

import dotenv
import mysql.connector

dotenv.load_dotenv()

db = mysql.connector.connect(
    host=os.getenv("MYSQL_HOST"),
    user=os.getenv("MYSQL_USER"),
    password=os.getenv("MYSQL_PASSWORD")
)

medals = {}
sports = {}
editions = {}

def get_or_create_medal(name):
    cursor = db.cursor()

    if name not in medals:
        cursor.execute("INSERT INTO olympics.medals(name) VALUES(%s)", (name,))
        db.commit()

        medals[name] = { "medalId": cursor.lastrowid, "name": name }
    
    return medals[name]

def get_or_create_sport(name):
    cursor = db.cursor()

    if name not in sports:
        cursor.execute("INSERT INTO olympics.sports(name) VALUES(%s)", (name,))
        db.commit()

        sports[name] = { "sportId": cursor.lastrowid, "name": name }
    
    return sports[name]

def get_or_create_edition(year, season):
    cursor = db.cursor()

    if (year, season) not in editions:
        cursor.execute("INSERT INTO olympics.editions(year, season, title) VALUES(%s, %s, %s)", (year, season, f"{year} {season}"))
        db.commit()

        editions[(year, season)] = { "editionId": cursor.lastrowid, "year": year, "season": season }
    
    return editions[(year, season)]

def convert_feet_and_inches_to_cm(measurement):
    match = re.match("(\d+).*(?:’|')(\d+).*(?:”|\")", measurement)
    return (int(match.group(1)) * 12 + int(match.group(2))) * 2.54

def import_grb_database():
    cursor = db.cursor()

    cursor.execute("INSERT INTO olympics.athletes(athleteId, name, sex, height, weight, noc) SELECT athleteId, name, sex, height, weight, 'GRB' AS noc FROM olympics_grb.athletes;")
    cursor.execute("INSERT INTO olympics.cities(cityId, name) SELECT cityId, name FROM olympics_grb.cities;")
    cursor.execute("INSERT INTO olympics.sports(sportId, name) SELECT sportId, name FROM olympics_grb.sports;")
    cursor.execute("INSERT INTO olympics.events(eventId, sportId, name) SELECT eventId, sportId, name FROM olympics_grb.events;")
    cursor.execute("INSERT INTO olympics.medals(medalId, name) SELECT medalId, name FROM olympics_grb.medals;")
    cursor.execute("INSERT INTO olympics.editions(editionId, year, season, title) SELECT editionId, year, season, title FROM olympics_grb.editions;")
    cursor.execute("INSERT INTO olympics.hosts(editionId, sportId, cityId) SELECT editionId, sportId, cityId FROM olympics_grb.games;")
    cursor.execute("INSERT INTO olympics.participants(athleteId, editionId, age) SELECT athleteId, editionId, age FROM olympics_grb.competitors;")
    cursor.execute("INSERT INTO olympics.results(athleteId, editionId, sportId, eventId, medalId, team) SELECT athleteId, editionId, sportId, eventId, medalId, team FROM olympics_grb.results NATURAL JOIN olympics_grb.members NATURAL JOIN olympics_grb.games;")

    db.commit()

    cursor.execute("SELECT medalId, name FROM olympics.medals")

    for row in cursor.fetchall():
        medals[row[1]] = { "medalId": row[0], "name": row[1] }

    cursor.execute("SELECT sportId, name FROM olympics.sports")

    for row in cursor.fetchall():
        sports[row[1]] = { "sportId": row[0], "name": row[1] }

    cursor.execute("SELECT editionId, year, season, title FROM olympics.editions")

    for row in cursor.fetchall():
        editions[(row[1], row[2])] = { "editionId": row[0], "year": row[1], "season": row[2], "title": row[3] }


def import_usa_database():
    cursor = db.cursor()

    cursor.execute("SELECT olympics_usa.Athlete.id, olympics_usa.Athlete.first_name, olympics_usa.Athlete.last_name, olympics_usa.Athlete.birthday, olympics_usa.Athlete.deceased_date, olympics_usa.Athlete.height, olympics_usa.Athlete.hometown, olympics_usa.Athlete.education, olympics_usa.Athlete.gold_medals, olympics_usa.Athlete.silver_medals, olympics_usa.Athlete.bronze_medals, olympics_usa.Sport.name FROM olympics_usa.Athlete JOIN olympics_usa.Sport ON olympics_usa.Athlete.sport_id = olympics_usa.Sport.id")

    for athlete_row in cursor.fetchall():
        athlete_old_id = athlete_row[0]
        athlete_name = athlete_row[1] + athlete_row[2]
        athlete_date_of_birth = athlete_row[3].date()
        athlete_date_of_death = athlete_row[4].date() if athlete_row[4] else None
        athlete_height = convert_feet_and_inches_to_cm(athlete_row[5]) if athlete_row[5] else None
        athlete_hometown = athlete_row[6]
        athlete_education = athlete_row[7]

        cursor.execute(
            "INSERT INTO olympics.athletes(name, height, dateOfBirth, dateOfDeath, hometown, education, noc) VALUES (%s, %s, %s, %s, %s, %s, 'USA')",
            (athlete_name, athlete_height, athlete_date_of_birth, athlete_date_of_death, athlete_hometown, athlete_education)
        )
        db.commit()

        athlete_new_id = cursor.lastrowid

        cursor.execute(
            "SELECT olympics_usa.Olympics.year, olympics_usa.Olympics.season FROM olympics_usa.Participation JOIN olympics_usa.Olympics ON olympics_usa.Participation.olympics_id = olympics_usa.Olympics.id WHERE olympics_usa.Participation.athlete_id = %s",
            (athlete_old_id,)
        )

        for participation_row in cursor.fetchall():
            edition = get_or_create_edition(participation_row[0], participation_row[1])

            try:
                cursor.execute("INSERT INTO olympics.participants(athleteId, editionId) VALUES(%s, %s)", (athlete_new_id, edition["editionId"]))
                db.commit()
            except Exception as exception:
                print(exception)

        achievements = [
            (athlete_row[8], get_or_create_medal("Gold")),
            (athlete_row[9], get_or_create_medal("Silver")),
            (athlete_row[10], get_or_create_medal("Bronze")),
        ]

        athlete_sport = get_or_create_sport("Canoeing" if athlete_row[11] == "Canoe/Cayak" else athlete_row[11])

        for achivement in achievements:
            amount = achivement[0]
            medal = achivement[1]

            for _ in range(0, amount):
                cursor.execute(
                    "INSERT INTO olympics.results(athleteId, sportId, medalId) VALUES(%s, %s, %s)",
                    (athlete_new_id, athlete_sport["sportId"], medal["medalId"])
                )
        
        db.commit()

import_grb_database()
import_usa_database()
