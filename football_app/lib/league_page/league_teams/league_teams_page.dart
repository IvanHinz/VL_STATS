import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:developer' as developer;
import '../../requests/request.dart';
import 'abstract_team.dart';

class LeagueTable extends StatelessWidget {
  const LeagueTable({super.key});

  @override
  Widget build(BuildContext context) {
    String leagueName = (ModalRoute.of(context)?.settings.arguments) as String;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "$leagueName Table",
          ),
        ),
        body: FutureBuilder<List<Team>>(
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError || snapshot.data == null) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              } else if (snapshot.hasData) {
                List<Team> data = snapshot.data as List<Team>;

                return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Center(
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      dividerThickness: 0.1,
                                      border: TableBorder.all(
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                        color: Colors.white,
                                      ),
                                      horizontalMargin: 5,
                                      columnSpacing: 10,
                                      sortColumnIndex: 2,
                                      sortAscending: true,
                                      rows: data
                                          .map(
                                            (country) => DataRow(
                                              cells: [
                                                DataCell(
                                                  onTap: () => postTeamPlayers(
                                                      context,
                                                      country.teamName),
                                                  Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      country.teamName,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Center(
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        country.matchesPlayed
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      country.won.toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      country.loose.toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      country.draw.toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      country.points.toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      country.xpoints
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      country.goals.toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      country.xG.toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      country.conceded_goals
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      country.xGA.toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      country.NPxG.toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                      columns: [
                                        DataColumn(
                                          label: Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  'Team',
                                                  style: TextStyle(
                                                    color:
                                                        Colors.orange.shade900,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          numeric: false,
                                          tooltip: "Team name",
                                        ),
                                        DataColumn(
                                          label: Text(
                                            textAlign: TextAlign.center,
                                            'Matches',
                                            style: TextStyle(
                                              color: Colors.orange.shade900,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "Matches played",
                                        ),
                                        DataColumn(
                                          label: Text(
                                            textAlign: TextAlign.center,
                                            'Won',
                                            style: TextStyle(
                                              color: Colors.orange.shade900,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "Won matches",
                                        ),
                                        DataColumn(
                                          label: Text(
                                            textAlign: TextAlign.center,
                                            'Draw',
                                            style: TextStyle(
                                              color: Colors.orange.shade900,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "Draw matches",
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  'Loose',
                                                  style: TextStyle(
                                                    color:
                                                        Colors.orange.shade900,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "Loosed matches",
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  'Points',
                                                  style: TextStyle(
                                                    color:
                                                        Colors.orange.shade900,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "Points",
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  'xPoints',
                                                  style: TextStyle(
                                                    color:
                                                        Colors.orange.shade900,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip:
                                              "Points from expected Goals model",
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  'Goals',
                                                  style: TextStyle(
                                                    color:
                                                        Colors.orange.shade900,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "Goals",
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  'xG',
                                                  style: TextStyle(
                                                    color:
                                                        Colors.orange.shade900,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "expected Goals",
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  'GA',
                                                  style: TextStyle(
                                                    color:
                                                        Colors.orange.shade900,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "conceded Goals",
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  'xGA',
                                                  style: TextStyle(
                                                    color:
                                                        Colors.orange.shade900,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "expected conceded Goals",
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  'NPxG',
                                                  style: TextStyle(
                                                    color:
                                                        Colors.orange.shade900,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          numeric: true,
                                          tooltip: "NPxG",
                                        ),
                                      ],
                                    ))))
                      ],
                    ));
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: fetchTeam(),
        ),
      ),
    );
  }
}

Future<List<Team>> fetchTeam() async {
  final response = await http.get(Uri.parse("http://10.0.2.2:5000/"));

  if (response.statusCode == 200) {
    List<Team> teams = [];
    var updateObj = json.decode(json.decode(response.body!)) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    updateObj.forEach((e) {
      teams.add(Team.fromJson(e));
    });
    return teams;
  } else {
    developer.log('Error, Could not load Data.');
    throw Exception('Failed to load Data');
  }
}
