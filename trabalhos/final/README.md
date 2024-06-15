# Normalização

## 1FN
Result (**ID**, Name, Sex, Age, Height, Weight, **Team**, **NOC**, Games, **Year**, **Season**, City, **Sport**, **Event**, Medal)
![1FN](./models/olimpiadas_inicial.png)

## 2FN e 3FN

- Athlete(**ID**, Name, Sex)
- Game(**Season**, **Year**, Title, City)
- Team(**Season**, **Year**, **Sport**, **Event**, **Name**, Medal)
    -(**Season**, **Year**) referencia Game
- Member(**ID**, **Season**, **Year**, **Sport**, **Event**, **Name**, Age, Height, Weight
    - **ID** referencia Athlete
    - (**Season**, **Year**, **Sport**, **Event**, **Name**) referencia Team
![2FN](./models/olimpiadas_2fn.png)


### Dependências funcionais

- Athlete: **ID** -> Name, Sex
- Game: **Season**, **Year** -> Games, City
- Team: **Team**, **Season**, **Year**, **Sport**, **Event** -> Medal
- Membership: **ID**, **Team**, **Team**, **Season**, **Year**, **Sport**, **Event** -> Age, Height, Weight


# Modelo final

- Athlete(**athleteId**, name, sex)
- City(**cityId**, name)
- Sport(**sportId**, name)
- Event(**eventId**, sportId, name)
    - **sportId** referencia Sport
- MedalType(**medalId**, name)
- Edition(**editionId**, cityId, year, season, title)
    - **cityId** referencia City
- Team(**teamId**, name, editionId, eventId, medalTypeId)
    - **editionId** referencia Edition
    - **eventId** referencia Event
    - **medalTypeId** referencia MedalType
- Member(**athleteId**, **teamId**, age, height, weight)
    - **athleteId** referencia Athlete
    - **teamId** referencia Team
![Final](./models/olimpiadas_final.png)
