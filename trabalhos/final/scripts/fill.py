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

class ConsistentTable:
    def __init__(self, db):
        self.db = db
        self.cursor = db.cursor()
        self.cache = {}

    def get_or_insert(self, data):
        key = self.make_key(data)
        cached = self.cache.get(key)

        if cached:
            self.ensure_values_match(data, cached)
            return cached

        self.cache[key] = self.insert(data);

        return self.cache[key]    
    
    def ensure_values_match(self, base, reference):
        for key, value in base.items():
            if reference.get(key) != value:
                raise ValueError(f'Value mismatch for key {key}: {value} != {reference.get(key)}. (Base: {base}, Reference: {reference})')
                
class AthleteTable(ConsistentTable):
    def make_key(self, data):
        return data['id']

    def insert(self, data):
        self.cursor.execute(
            f'INSERT INTO `athletes` (`athleteId`, `name`, `sex`) VALUES (%s, %s, %s)',
            (data['id'], data['name'], data['sex'])
        )
        self.db.commit()

        return {
            'id': data['id'],
            'name': data['name'],
            'sex': data['sex']
        }
    
class CityTable(ConsistentTable):
    def make_key(self, data):
        return data['name']

    def insert(self, data):
        self.cursor.execute(
            f'INSERT INTO `cities` (`name`) VALUES (%s)',
            (data['name'],)
        )
        self.db.commit()

        return {
            'id': self.cursor.lastrowid,
            'name': data['name']
        }
    
class SportTable(ConsistentTable):
    def make_key(self, data):
        return data['name']

    def insert(self, data):
        self.cursor.execute(
            f'INSERT INTO `sports` (`name`) VALUES (%s)',
            (data['name'],)
        )
        self.db.commit()

        return {
            'id': self.cursor.lastrowid,
            'name': data['name']
        }
    
class EventTable(ConsistentTable):
    def make_key(self, data):
        return (data['name'], data['sport_id'])

    def insert(self, data):
        self.cursor.execute(
            f'INSERT INTO `events` (`name`, `sportId`) VALUES (%s, %s)',
            (data['name'], data['sport_id'])
        )
        self.db.commit()

        return {
            'id': self.cursor.lastrowid,
            'name': data['name'],
            'sport_id': data['sport_id']
        }
    
class MedalTypeTable(ConsistentTable):
    def make_key(self, data):
        return data['name']

    def insert(self, data):
        self.cursor.execute(
            f'INSERT INTO `medalTypes` (`name`) VALUES (%s)',
            (data['name'],)
        )
        self.db.commit()

        return {
            'id': self.cursor.lastrowid,
            'name': data['name']
        }

class EditionTable(ConsistentTable):
    def make_key(self, data):
        return (data['year'], data['season'])

    def insert(self, data):
        self.cursor.execute(
            f'INSERT INTO `editions` (`year`, `season`, title, `cityId`) VALUES (%s, %s, %s, %s)',
            (data['year'], data['season'], data['title'], data['city_id'])
        )
        self.db.commit()

        return {
            'id': self.cursor.lastrowid,
            'year': data['year'],
            'season': data['season'],
            'title': data['title'],
            'city_id': data['city_id']
        }
    
class TeamTable(ConsistentTable):
    def make_key(self, data):
        return (data['name'], data['edition_id'], data['event_id'], data['medal_type_id'])

    def insert(self, data):
        self.cursor.execute(
            f'INSERT INTO `teams` (`name`, `editionId`, `eventId`, `medalTypeId`) VALUES (%s, %s, %s, %s)',
            (data['name'], data['edition_id'], data['event_id'], data['medal_type_id'])
        )
        self.db.commit()

        return {
            'id': self.cursor.lastrowid,
            'name': data['name'],
            'edition_id': data['edition_id'],
            'event_id': data['event_id'],
            'medal_type_id': data['medal_type_id']
        }
    
class MembershipTable(ConsistentTable):
    def make_key(self, data):
        return (data['athlete_id'], data['team_id'])

    def insert(self, data):
        self.cursor.execute(
            f'INSERT INTO `memberships` (`athleteId`, `teamId`, `age`, `height`, `weight`) VALUES (%s, %s, %s, %s, %s)',
            (data['athlete_id'], data['team_id'], data['age'], data['height'], data['weight'])
        )
        self.db.commit()

        return {
            'athlete_id': data['athlete_id'],
            'team_id': data['team_id'],
            'age': data['age'],
            'height': data['height'],
            'weight': data['weight']
        }

athlete_table = AthleteTable(db)
city_table = CityTable(db)
sport_table = SportTable(db)
event_table = EventTable(db)
medal_type_table = MedalTypeTable(db)
edition_table = EditionTable(db)
team_table = TeamTable(db)
membership_table = MembershipTable(db)

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

        athlete = athlete_table.get_or_insert({
            'id': line_id,
            'name': line_name,
            'sex': line_sex
        })
        
        city = city_table.get_or_insert({
            'name': line_city
        });
        
        sport = sport_table.get_or_insert({
            'name': line_sport
        });
        
        event = event_table.get_or_insert({
            'name': line_event,
            'sport_id': sport['id']
        });
        
        medal_type = medal_type_table.get_or_insert({
            'name': line_medal
        }) if line_medal != 'NA' else None;
        
        edition = edition_table.get_or_insert({
            'year': line_year,
            'season': line_season,
            'title': line_games,
            'city_id': city['id']
        });
        
        team = team_table.get_or_insert({
            'name': line_team,
            'edition_id': edition['id'],
            'event_id': event['id'],
            'medal_type_id': medal_type['id'] if medal_type else None
        });

        membership_table.get_or_insert({
            'athlete_id': athlete['id'],
            'team_id': team['id'],
            'age': line_age,
            'height': line_height,
            'weight': line_weight
        });