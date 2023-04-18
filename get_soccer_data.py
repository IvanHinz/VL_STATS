import pandas as pd
from flask import jsonify

from understatapi import UnderstatClient
from understat import Understat
import asyncio
import json

import aiohttp
import nest_asyncio

nest_asyncio.apply()


async def main(_league):
    async with aiohttp.ClientSession() as session:
        understat = Understat(session)
        if _league == 'Premier League':
            player = await understat.get_league_table("EPL", "2022")
        elif _league == 'Bundesliga':
            player = await understat.get_league_table("Bundesliga", "2022")
        elif _league == 'La Liga':
            player = await understat.get_league_table("La liga", "2022")
        else:
            player = await understat.get_league_table("RFPL", "2022")
        columns = player[0]
        result = [dict(zip(columns, row)) for row in player[1:]]

        print(json.dumps(result))
        return json.dumps(result)


def get_table(_league):
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    table = loop.run_until_complete(main(_league))
    return jsonify(table)


