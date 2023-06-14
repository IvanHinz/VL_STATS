import 'dart:math' as math;

class Player {
  final String playerName;
  final String position;
  final String games;
  final String time;
  final String goals;
  final String assists;
  final String shots;
  final String key_passes;
  final double xG;
  final double xA;
  final String yellow_cards;
  final String red_cards;

  Player(
      {required this.playerName,
      required this.position,
      required this.games,
      required this.time,
      required this.goals,
      required this.shots,
      required this.key_passes,
      required this.assists,
      required this.xG,
      required this.xA,
      required this.yellow_cards,
      required this.red_cards});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        playerName: json["player_name"] ?? "NO DATA",
        position: json["position"] ?? "NO DATA",
        games: json["games"] ?? "NO DATA",
        time: json["time"] ?? "NO DATA",
        goals: json["goals"] ?? "NO DATA",
        assists: json["assists"] ?? "NO DATA",
        shots: json["shots"] ?? "NO DATA",
        key_passes: json["key_passes"] ?? "NO DATA",
        xG: roundDouble(double.parse(json['xG']), 2),
        xA: roundDouble(double.parse(json['xA']), 2),
        yellow_cards: json["yellow_cards"] ?? "NO DATA",
        red_cards: json["red_cards"] ?? "NO DATA");
  }
}

double roundDouble(double value, int places) {
  num mod = math.pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
