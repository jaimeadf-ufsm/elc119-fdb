import csv
import os
import decimal

import dotenv
import mysql.connector

dotenv.load_dotenv()

db = mysql.connector.connect(
    host=os.getenv("MYSQL_HOST"),
    user=os.getenv("MYSQL_USER"),
    password=os.getenv("MYSQL_PASSWORD"),
    database=os.getenv("MYSQL_DATABASE")
)

athlete_ids = {}
city_ids = {}
sport_ids = {}
event_ids = {}
medal_type_ids = {}
edition_ids = {}
team_ids = {}
membership_ids = {}

def create_athlete(id, name, sex):
    cursor = db.cursor()
    cursor.execute(
        f'INSERT INTO `athletes` (`athleteId`, `name`, `sex`) VALUES (%s, %s, %s)',
        (id, name, sex)
    )
    db.commit()
    cursor.close()

    return id

def create_city(name):
    cursor = db.cursor()
    cursor.execute(
        f'INSERT INTO `cities` (`name`) VALUES (%s)',
        (name,)
    )
    db.commit()
    cursor.close()

    return cursor.lastrowid

def create_sport(name):
    cursor = db.cursor()
    cursor.execute(
        f'INSERT INTO `sports` (`name`) VALUES (%s)',
        (name,)
    )
    db.commit()
    cursor.close()

    return cursor.lastrowid

def create_event(name, sport_id):
    cursor = db.cursor()
    cursor.execute(
        f'INSERT INTO `events` (`name`, `sportId`) VALUES (%s, %s)',
        (name, sport_id)
    )
    db.commit()
    cursor.close()

    return cursor.lastrowid

def create_medal_type(name):
    cursor = db.cursor()
    cursor.execute(
        f'INSERT INTO `medalTypes` (`name`) VALUES (%s)',
        (name,)
    )
    db.commit()
    cursor.close()

    return cursor.lastrowid

def create_edition(year, season, title, city_id):
    cursor = db.cursor()
    cursor.execute(
        f'INSERT INTO `editions` (`year`, `season`, title, `cityId`) VALUES (%s, %s, %s, %s)',
        (year, season, title, city_id)
    )
    db.commit()
    cursor.close()

    return cursor.lastrowid

def create_team(name, edition_id, event_id, medal_type_id):
    cursor = db.cursor()
    cursor.execute(
        f'INSERT INTO `teams` (`name`, `editionId`, `eventId`, `medalTypeId`) VALUES (%s, %s, %s, %s)',
        (name, edition_id, event_id, medal_type_id)
    )
    db.commit()
    cursor.close()

    return cursor.lastrowid

def create_membership(athlete_id, team_id, age, height, weight):
    cursor = db.cursor()
    cursor.execute(
        f'INSERT INTO `memberships` (`athleteId`, `teamId`, `age`, `height`, `weight`) VALUES (%s, %s, %s, %s, %s)',
        (athlete_id, team_id, age, height, weight)
    )
    db.commit()
    cursor.close()

    return (athlete_id, team_id)


with open('data/athlete_events.csv') as file:
    reader = csv.reader(file, delimiter=',', quotechar='"')
    lines = list(reader)

    # row[00] - "ID"
    # row[01] - "Name"
    # row[02] - "Sex"
    # row[03] - "Age"
    # row[04] - "Height"
    # row[05] - "Weight"
    # row[06] - "Team"
    # row[07] - "NOC"
    # row[08] - "Games"
    # row[09] - "Year"
    # row[10] - "Season"
    # row[11] - "City"
    # row[12] - "Sport"
    # row[13] - "Event"
    # row[14] - "Medal"

    for line in lines[1:]:
        line_id = int(line[0])
        line_name = line[1]
        line_sex = line[2]
        line_age = None if line[3] == 'NA' else int(line[3])
        line_height = None if line[4] == 'NA' else decimal.Decimal(line[4])
        line_weight = None if line[5] == 'NA' else decimal.Decimal(line[5])
        line_team = line[6]
        line_noc = line[7]
        line_games = line[8]
        line_year = int(line[9])
        line_season = line[10]
        line_city = line[11]
        line_sport = line[12]
        line_event = line[13]
        line_medal = line[14]

        if line_noc != 'GBR':
            continue

        athelete_id = athlete_ids.get(line_id)
        city_id = city_ids.get(line_city)
        sport_id = sport_ids.get(line_sport)
        event_id = event_ids.get((line_event, line_sport))
        medal_type_id = medal_type_ids.get(line_medal)
        edition_id = edition_ids.get((line_year, line_season))
        team_id = team_ids.get((line_team, line_year, line_season, line_sport, line_event))
        membership_id = membership_ids.get((line_id, line_team, line_year, line_season, line_sport, line_event))

        if not athelete_id:
            athelete_id = create_athlete(line_id, line_name, line_sex)
            athlete_ids[line_id] = athelete_id

        if not city_id:
            city_id = create_city(line_city)
            city_ids[line_city] = city_id

        if not sport_id:
            sport_id = create_sport(line_sport)
            sport_ids[line_sport] = sport_id

        if not event_id:
            event_id = create_event(line_event, sport_id)
            event_ids[(line_event, line_sport)] = event_id

        if not medal_type_id and line_medal != 'NA':
            medal_type_id = create_medal_type(line_medal)
            medal_type_ids[line_medal] = medal_type_id

        if not edition_id:
            edition_id = create_edition(line_year, line_season, line_games, city_id)
            edition_ids[(line_year, line_season)] = edition_id

        if not team_id:
            team_id = create_team(line_team, edition_id, event_id, medal_type_id)
            team_ids[(line_team, line_year, line_season, line_sport, line_event)] = team_id

        if not membership_id:
            membership_ids[(line_id, line_team, line_year, line_season, line_sport, line_event)] = create_membership(athelete_id, team_id, line_age, line_height, line_weight)
