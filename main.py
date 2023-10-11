from football_stats.prediction import predict
from libraries import *
from football_stats import get_soccer_data

app = Flask(__name__)

# our requests from flutter app
requested_league = []


@app.route('/', methods=['GET'])
def index():
    # by analyzing last post request we will give prediction or league table or players table
    # everything is returned in json format
    if requested_league[-1][-1] == "_" and requested_league[-1][-2] == "_":
        our_data = requested_league[-1].split("_")
        answer = predict(our_data[0], our_data[1], our_data[2])
        return answer
    elif requested_league[-1][-1] == "#":
        return get_soccer_data.get_team(requested_league[-1][:len(requested_league[-1]) - 1])
    elif requested_league[-1][-1] == "_":
        return get_soccer_data.get_players(requested_league[-1][:len(requested_league[-1]) - 1])
    else:
        return get_soccer_data.get_table(requested_league[-1])


@app.route('/', methods=['POST'])
def posting():
    request_data = request.data
    request_data = json.loads(request_data.decode('utf-8'))

    requested_league.append(request_data['name'])


if __name__ == "__main__":
    app.run(debug=True)
    app.run(host='0.0.0.0', port=5000)
