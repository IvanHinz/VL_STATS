from libraries import *

nest_asyncio.apply()


# we will get league table
async def get_league_teams(_league):
    async with aiohttp.ClientSession() as session:
        understat = Understat(session)
        if _league == 'Premier League':
            league_table = await understat.get_league_table("EPL", "2022")
        elif _league == 'Bundesliga':
            league_table = await understat.get_league_table("Bundesliga", "2022")
        elif _league == 'La Liga':
            league_table = await understat.get_league_table("La liga", "2022")
        elif _league == 'Serie A':
            league_table = await understat.get_league_table("Serie A", "2022")
        elif _league == 'Ligue 1':
            league_table = await understat.get_league_table("Ligue 1", "2022")
        else:
            league_table = await understat.get_league_table("RFPL", "2022")
        columns = league_table[0]
        result = [dict(zip(columns, row)) for row in league_table[1:]]

        return json.dumps(result)


# we will get players stats from _league
async def get_league_players(_league):
    async with aiohttp.ClientSession() as session:
        understat = Understat(session)
        if _league == 'Premier League':
            player = await understat.get_league_players("EPL", "2022")
        elif _league == 'Bundesliga':
            player = await understat.get_league_players("Bundesliga", "2022")
        elif _league == 'La Liga':
            player = await understat.get_league_players("La liga", "2022")
        elif _league == 'Serie A':
            player = await understat.get_league_players("Serie A", "2022")
        elif _league == 'Ligue 1':
            player = await understat.get_league_players("Ligue 1", "2022")
        else:
            player = await understat.get_league_players("RFPL", "2022")

        return json.dumps(player)


async def get_team_players(_team):
    async with aiohttp.ClientSession() as session:
        understat = Understat(session)
        player = await understat.get_team_players(_team, "2022")
        return json.dumps(player)


def get_table(_league):
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    table = loop.run_until_complete(get_league_teams(_league))
    return jsonify(table)


def get_players(_league):
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    table = loop.run_until_complete(get_league_players(_league))
    return jsonify(table)


def get_team(_team):
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    squad = loop.run_until_complete(get_team_players(_team))
    return jsonify(squad)
