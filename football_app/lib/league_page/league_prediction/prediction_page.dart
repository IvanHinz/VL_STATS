import 'package:flutter/material.dart';
import 'package:football_app/requests/request.dart';
import '../../features/colors_view.dart';
import 'dart:developer' as developer;
import 'league_clubs.dart';
import 'dart:math';

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => PredictionPageState();
}

class PredictionPageState extends State<PredictionPage> {
  String? firstTeam = "No team", secondTeam = "No team";

  String prediction_status = "";

  List<String> teams = [];

  @override
  void initState() {
    super.initState();
    prediction_status = "No prediction available";
  }

  String? firstteamId;
  String? secondteamId;

  @override
  Widget build(BuildContext context) {
    String leagueName = (ModalRoute.of(context)?.settings.arguments) as String;
    if (leagueName == "Premier League") {
      teams = premierLeagueTeams;
    } else if (leagueName == "La Liga") {
      teams = laLigaTeams;
    } else if (leagueName == "Bundesliga") {
      teams = bundesligaTeams;
    } else if (leagueName == "Serie A") {
      teams = serieATeams;
    } else if (leagueName == "Ligue 1") {
      teams = ligue1Teams;
    } else {
      teams = rplTeams;
    }
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "$leagueName prediction",
          ),
        ),
        // ignore: sized_box_for_whitespace
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Center(
                child: Container(
                    width: 300,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: Colors.red,
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          child: DropdownButton<String>(
                            isDense: true,
                            dropdownColor: MainColors.lightBlue,
                            value: firstTeam,
                            onChanged: (String? value) {
                              setState(() {
                                prediction_status = "No prediction available";
                                if (secondTeam == value &&
                                    secondTeam != teams[0]) {
                                  firstTeam = teams[0];
                                } else {
                                  firstTeam = value;
                                }
                              });
                            },
                            items: teams
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: Colors.red,
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          child: DropdownButton<String>(
                            isDense: true,
                            dropdownColor: MainColors.lightBlue,
                            value: secondTeam,
                            onChanged: (String? value) {
                              setState(() {
                                prediction_status = "No prediction available";
                                if (firstTeam == value &&
                                    firstTeam != teams[0]) {
                                  secondTeam = teams[0];
                                } else {
                                  secondTeam = value;
                                }
                              });
                            },
                            items: teams
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                            onPressed: () async {
                              String result;
                              double answer;
                              developer.log(firstTeam as String);
                              developer.log(secondTeam as String);
                              result = await postPrediction(context, leagueName,
                                  firstTeam as String, secondTeam as String);
                              developer.log(result);
                              answer = double.parse(result);

                              setState(() {
                                if (answer >= 2.0) {
                                  prediction_status =
                                      "$firstTeam will definitely win $secondTeam";
                                } else if (answer >= 1.5 && answer < 2.0) {
                                  final String prob =
                                      (roundDouble(answer - 1.5, 2) * 2.0)
                                          .toString();
                                  prediction_status =
                                      "$firstTeam will win $secondTeam with $prob probability";
                                } else if (answer < 1.5 && answer >= 0.5) {
                                  prediction_status =
                                      "Draw between $firstTeam and $secondTeam";
                                } else if (answer > 0.0 && answer < 0.5) {
                                  final String prob =
                                      (roundDouble(0.5 - answer, 2) * 2.0)
                                          .toString();
                                  prediction_status =
                                      "$firstTeam will lose $secondTeam with $prob probability";
                                } else {
                                  prediction_status =
                                      "$firstTeam will definitely lose $secondTeam";
                                }
                              });
                            },
                            child: const Text(
                              'Guess who will win!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            )),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                            padding: const EdgeInsets.only(
                                top: 25, left: 10, right: 10),
                            color: Theme.of(context).colorScheme.background,
                            child: Text(prediction_status,
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.white)))
                      ],
                    )))));
  }
}
