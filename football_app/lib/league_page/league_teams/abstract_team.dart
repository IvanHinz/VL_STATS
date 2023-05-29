class Team {
  final String teamName;
  final int matchesPlayed;
  final int won;
  final int draw;
  final int loose;
  final int points;
  final double xpoints;
  final int goals;
  final double xG;
  final int conceded_goals;
  final double xGA; // expected conceded goals
  final double NPxG;
  // final int NPxGA;
  // final int NPxGD;
  // final int PPDA;
  // final int OPPDA;
  // final int DC;
  // final int ODC;

  Team({
    required this.teamName,
    required this.matchesPlayed,
    required this.won,
    required this.draw,
    required this.loose,
    required this.points,
    required this.xpoints,
    required this.goals,
    required this.xG,
    required this.conceded_goals,
    required this.xGA,
    required this.NPxG,
    // required this.NPxGA,
    // required this.NPxGD,
    // required this.PPDA,
    // required this.OPPDA,
    // required this.DC,
    // required this.ODC,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamName: json['Team'],
      matchesPlayed: json['M'],
      won: json['W'],
      draw: json["D"],
      loose: json['L'],
      points: json['PTS'],
      xpoints: json['xPTS'],
      goals: json['G'],
      xG: json['xG'],
      conceded_goals: json['GA'],
      xGA: json['xGA'],
      NPxG: json['NPxG'],
      // NPxGA: json['NPxGA'],
      // NPxGD: json['NPxGD'],
      // PPDA: json['PPDA'],
      // OPPDA: json['OPPDA'],
      // DC: json['DC'],
      // ODC: json['ODC'],
    );
  }
}
