from flask import Flask, jsonify, request
import get_soccer_data
import json

app = Flask(__name__)

requested_league = []


@app.route('/', methods=['GET'])
def index():
    if requested_league[-1][-1] == "_":
        return get_soccer_data.get_players(requested_league[-1][:len(requested_league[-1]) - 1])
    else:
        return get_soccer_data.get_table(requested_league[-1])  # returning key-value pair in json format


@app.route('/', methods=['POST'])
def posting():
    request_data = request.data
    request_data = json.loads(request_data.decode('utf-8'))

    requested_league.append(request_data['name'])


if __name__ == "__main__":
    app.run(debug=True)  # debug will allow changes without shutting down the server
    app.run(host='0.0.0.0', port=5000)
