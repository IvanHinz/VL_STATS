import pandas as pd
from flask import jsonify

from understatapi import UnderstatClient
from understat import Understat
import asyncio
import json

import aiohttp
import nest_asyncio

nest_asyncio.apply()


async def get_league_teams(_league):
    async with aiohttp.ClientSession() as session:
        understat = Understat(session)
        if _league == 'Premier League':
            league_table = await understat.get_league_table("EPL", "2022")
        elif _league == 'Bundesliga':
            league_table = await understat.get_league_table("Bundesliga", "2022")
        elif _league == 'La Liga':
            league_table = await understat.get_league_table("La liga", "2022")
        else:
            league_table = await understat.get_league_table("RFPL", "2022")
        columns = league_table[0]
        result = [dict(zip(columns, row)) for row in league_table[1:]]

        return json.dumps(result)


async def get_league_players(_league):
    async with aiohttp.ClientSession() as session:
        understat = Understat(session)
        if _league == 'Premier League':
            player = await understat.get_league_players("EPL", "2022")
        elif _league == 'Bundesliga':
            player = await understat.get_league_players("Bundesliga", "2022")
        elif _league == 'La Liga':
            player = await understat.get_league_players("La liga", "2022")
        else:
            player = await understat.get_league_players("RFPL", "2022")

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
