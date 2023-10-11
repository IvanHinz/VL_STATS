from libraries import *

nest_asyncio.apply()


def get_value(pandas_league_clubs_info, parameter, team_name):
    return float(pandas_league_clubs_info.loc[pandas_league_clubs_info['Team'] == team_name, parameter].values[0])


async def get_info(_league):
    async with aiohttp.ClientSession() as session:
        understat = Understat(session)
        if _league == 'Premier League':
            matches_results = await understat.get_league_results("EPL", "2022")
            league_clubs_info = await understat.get_league_table("EPL", "2022")
        elif _league == 'Bundesliga':
            matches_results = await understat.get_league_results("Bundesliga", "2022")
            league_clubs_info = await understat.get_league_table("Bundesliga", "2022")
        elif _league == 'La Liga':
            matches_results = await understat.get_league_results("La liga", "2022")
            league_clubs_info = await understat.get_league_table("La liga", "2022")
        elif _league == 'Serie A':
            matches_results = await understat.get_league_results("Serie A", "2022")
            league_clubs_info = await understat.get_league_table("Serie A", "2022")
        elif _league == 'League 1':
            matches_results = await understat.get_league_results("League 1", "2022")
            league_clubs_info = await understat.get_league_table("League 1", "2022")
        else:
            matches_results = await understat.get_league_results("RFPL", "2022")
            league_clubs_info = await understat.get_league_table("RFPL", "2022")

        # adapting league_clubs_info to json
        columns = league_clubs_info[0]
        result_league_clubs_info = [dict(zip(columns, row)) for row in league_clubs_info[1:]]

        result_matches_results = matches_results

        matches = []
        for match in result_matches_results:
            new_match = {}
            for item in match.items():
                if item[0] == 'h':
                    new_match.update({"first_title": match[item[0]]["title"]})
                elif item[0] == 'a':
                    new_match.update({"second_title": match[item[0]]["title"]})
                elif item[0] == 'goals':
                    if int(match['goals']['h']) > int(match['goals']['a']):
                        new_match.update({"result": 2})
                    elif int(match['goals']['h']) == int(match['goals']['a']):
                        new_match.update({"result": 1})
                    else:
                        new_match.update({"result": 0})

            new_league_clubs_info = pd.DataFrame(result_league_clubs_info)

            # adding all important parameters of the first team to the DataFrame
            new_match["first xG"] = get_value(new_league_clubs_info, "xG", new_match['first_title'])
            new_match["first NPxG"] = get_value(new_league_clubs_info, "NPxG", new_match['first_title'])
            new_match["first M"] = get_value(new_league_clubs_info, "M", new_match['first_title'])
            new_match["first W"] = get_value(new_league_clubs_info, "W", new_match['first_title'])
            new_match["first D"] = get_value(new_league_clubs_info, "D", new_match['first_title'])
            new_match["first L"] = get_value(new_league_clubs_info, "L", new_match['first_title'])
            new_match["first G"] = get_value(new_league_clubs_info, "G", new_match['first_title'])
            new_match["first GA"] = get_value(new_league_clubs_info, "GA", new_match['first_title'])
            new_match["first PTS"] = get_value(new_league_clubs_info, "PTS", new_match['first_title'])
            new_match["first xPTS"] = get_value(new_league_clubs_info, "xPTS", new_match['first_title'])

            # adding all important parameters of the second team to the DataFrame
            new_match["second xG"] = get_value(new_league_clubs_info, "xG", new_match['second_title'])
            new_match["second NPxG"] = get_value(new_league_clubs_info, "NPxG", new_match['second_title'])
            new_match["second M"] = get_value(new_league_clubs_info, "M", new_match['second_title'])
            new_match["second W"] = get_value(new_league_clubs_info, "W", new_match['second_title'])
            new_match["second D"] = get_value(new_league_clubs_info, "D", new_match['second_title'])
            new_match["second L"] = get_value(new_league_clubs_info, "L", new_match['second_title'])
            new_match["second G"] = get_value(new_league_clubs_info, "G", new_match['second_title'])
            new_match["second GA"] = get_value(new_league_clubs_info, "GA", new_match['second_title'])
            new_match["second PTS"] = get_value(new_league_clubs_info, "PTS", new_match['second_title'])
            new_match["second xPTS"] = get_value(new_league_clubs_info, "xPTS", new_match['second_title'])

            matches.append(new_match)

        data_to_train = pd.DataFrame.from_dict(matches)

        return data_to_train


def get_table(_league):
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    table = loop.run_until_complete(get_info(_league))
    return table
