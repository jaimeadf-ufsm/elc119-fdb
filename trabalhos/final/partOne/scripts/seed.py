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

        self.cache[key] = self.insert(data)

        return self.cache[key]    
    
    def ensure_values_match(self, base, reference):
        for key, value in base.items():
            if reference.get(key) != value:
                raise ValueError(f'Value mismatch for key {key}: {value} != {reference.get(key)}. (Base: {base}, Reference: {reference})')

class AthleteTable(ConsistentTable):
    def make_key(self, data):
        return data['athleteId']

    def insert(self, data):
        self.cursor.execute(
            'INSERT INTO athletes(athleteId, name, sex, height, weight) VALUES(%s, %s, %s, %s, %s)',
            (data['athleteId'], data['name'], data['sex'], data['height'], data['weight'])
        )
        self.db.commit()

        return data
    
class CityTable(ConsistentTable):
    def make_key(self, data):
        return data['name']

    def insert(self, data):
        self.cursor.execute(
            'INSERT INTO cities(name) VALUES(%s)',
            (data['name'],)
        )
        self.db.commit()

        return {
            'cityId': self.cursor.lastrowid,
            **data
        }
    
class SportTable(ConsistentTable):
    def make_key(self, data):
        return data['name']

    def insert(self, data):
        self.cursor.execute(
            'INSERT INTO sports(name) VALUES(%s)',
            (data['name'],)
        )
        self.db.commit()

        return {
            'sportId': self.cursor.lastrowid,
            **data
        }

class EventTable(ConsistentTable):
    def make_key(self, data):
        return data['name']

    def insert(self, data):
        self.cursor.execute(
            'INSERT INTO events(sportId, name) VALUES(%s, %s)',
            (data['sportId'], data['name'])
        )
        self.db.commit()

        return {
            'eventId': self.cursor.lastrowid,
            **data
        }

class MedalTable(ConsistentTable):
    def make_key(self, data):
        return data['name']

    def insert(self, data):
        self.cursor.execute(
            'INSERT INTO medals(name) VALUES(%s)',
            (data['name'],)
        )
        self.db.commit()

        return {
            'medalId': self.cursor.lastrowid,
            **data
        }
    
class EditionTable(ConsistentTable):
    def make_key(self, data):
        return (data['year'], data['season'])

    def insert(self, data):
        self.cursor.execute(
            'INSERT INTO editions(year, season, title) VALUES(%s, %s, %s)',
            (data['year'], data['season'], data['title'])
        )
        self.db.commit()

        return {
            'editionId': self.cursor.lastrowid,
            **data
        }

class GameTable(ConsistentTable):
    def make_key(self, data):
        return (data['editionId'], data['sportId'], data['cityId'])

    def insert(self, data):
        self.cursor.execute(
            'INSERT INTO games(editionId, sportId, cityId) VALUES(%s, %s, %s)',
            (data['editionId'], data['sportId'], data['cityId'])
        )
        self.db.commit()

        return {
            'gameId': self.cursor.lastrowid,
            **data
        }

class ResultTable(ConsistentTable):
    def make_key(self, data):
        return data['resultId']

    def insert(self, data):
        self.cursor.execute(
            'INSERT INTO results(resultId, athleteId, gameId, eventId, medalId) VALUES(%s, %s, %s, %s, %s)',
            (data['resultId'], data['athleteId'], data['gameId'], data['eventId'], data['medalId'])
        )
        self.db.commit()

        return data

class CompetitorTable(ConsistentTable):
    def make_key(self, data):
        return (data['athleteId'], data['editionId'])

    def insert(self, data):
        self.cursor.execute(
            'INSERT INTO competitors(athleteId, editionId, age) VALUES(%s, %s, %s)',
            (data['athleteId'], data['editionId'], data['age'])
        )
        self.db.commit()

        return data

class MemberTable(ConsistentTable):
    def make_key(self, data):
        return (data['athleteId'], data['gameId'], data['eventId'])

    def insert(self, data):
        self.cursor.execute(
            'INSERT INTO members(athleteId, gameId, eventId, team) VALUES(%s, %s, %s, %s)',
            (data['athleteId'], data['gameId'], data['eventId'], data['team'])
        )
        self.db.commit()

        return data

athlete_table = AthleteTable(db)
city_table = CityTable(db)
sport_table = SportTable(db)
event_table = EventTable(db)
medal_table = MedalTable(db)
edition_table = EditionTable(db)
game_table = GameTable(db)
competitor_table = CompetitorTable(db)
result_table = ResultTable(db)
member_table = MemberTable(db)

with open('data/athlete_events.csv') as file:
    reader = csv.reader(file, delimiter=',', quotechar='"')

    for index, row in enumerate(reader):
        if index == 0:
            continue

        row_id = int(row[0])
        row_name = row[1]
        row_sex = row[2]
        row_age = None if row[3] == 'NA' else int(row[3])
        row_height = None if row[4] == 'NA' else decimal.Decimal(row[4])
        row_weight = None if row[5] == 'NA' else decimal.Decimal(row[5])
        row_team = row[6]
        row_noc = row[7]
        row_games = row[8]
        row_year = int(row[9])
        row_season = row[10]
        row_city = row[11]
        row_sport = row[12]
        row_event = row[13]
        row_medal = row[14]
        
        if row_noc != 'GBR':
            continue

        try:
            athlete = athlete_table.get_or_insert({
                'athleteId': row_id,
                'name': row_name,
                'sex': row_sex,
                'height': row_height,
                'weight': row_weight
            })

            city = city_table.get_or_insert({
                'name': row_city
            })

            sport = sport_table.get_or_insert({
                'name': row_sport
            })

            event = event_table.get_or_insert({
                'sportId': sport['sportId'],
                'name': row_event
            })

            medal = None if row_medal == 'NA' else medal_table.get_or_insert({
                'name': row_medal
            })

            edition = edition_table.get_or_insert({
                'year': row_year,
                'season': row_season,
                'title': row_games
            })

            game = game_table.get_or_insert({
                'editionId': edition['editionId'],
                'sportId': sport['sportId'],
                'cityId': city['cityId']
            })

            competitor = competitor_table.get_or_insert({
                'athleteId': athlete['athleteId'],
                'editionId': edition['editionId'],
                'age': row_age
            })

            member = member_table.get_or_insert({
                'athleteId': athlete['athleteId'],
                'gameId': game['gameId'],
                'eventId': event['eventId'],
                'team': row_team
            })

            result = result_table.get_or_insert({
                'resultId': index,
                'gameId': game['gameId'],
                'athleteId': athlete['athleteId'],
                'eventId': event['eventId'],
                'medalId': medal['medalId'] if medal else None
            })
        except Exception as e:
            print(f'Exception on line {index}: {e}')