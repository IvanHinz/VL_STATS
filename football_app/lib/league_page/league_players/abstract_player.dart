import 'dart:math' as math;

class Player {
  final String playerName;
  final int games;
  final int time;
  final int goals;
  final double xG;
  final int assists;
  final double xA;
  final int yellowCards;
  final int redCards;

  Player({
    required this.playerName,
    required this.games,
    required this.time,
    required this.goals,
    required this.xG,
    required this.assists,
    required this.xA,
    required this.yellowCards,
    required this.redCards,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      playerName: json["player_name"] ?? "NO DATA",
      games: int.parse(json["games"]),
      time: int.parse(json["time"]),
      goals: int.parse(json["goals"]),
      xG: roundDouble(double.parse(json["xG"]), 2),
      assists: int.parse(json["assists"]),
      xA: roundDouble(double.parse(json["xA"]), 2),
      yellowCards: int.parse(json["yellow_cards"]),
      redCards: int.parse(json["red_cards"]),
    );
  }
}

double roundDouble(double value, int places) {
  num mod = math.pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
