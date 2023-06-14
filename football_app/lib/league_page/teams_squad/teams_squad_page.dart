import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:football_app/league_page/teams_squad/abstract_squad.dart';
import 'package:http/http.dart' as http;

import '../../features/colors/colors.dart';

class TeamPlayers extends StatelessWidget {
  const TeamPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    String clubName = (ModalRoute.of(context)?.settings.arguments) as String;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("$clubName Players",
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: FutureBuilder<List<Player>>(
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
                  List<Player> data = snapshot.data as List<Player>;
                  return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 10.0),
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
                                          rows: data
                                              .map((country) => DataRow(cells: [
                                                    DataCell(
                                                      Center(
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          country.playerName
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          country.position
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          country.games
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          country.time
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          country.goals
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          country.assists
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          country.shots
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          country.key_passes
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          country.xA.toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          country.yellow_cards
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          country.red_cards
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ]))
                                              .toList(),
                                          columns: [
                                            DataColumn(
                                              label: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Player',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .orange.shade900,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              numeric: false,
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Position',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .orange.shade900,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Games',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .orange.shade900,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Minutes played',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .orange.shade900,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Goals',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .orange.shade900,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Assists',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .orange.shade900,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Shots',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .orange.shade900,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Key Passes',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .orange.shade900,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'xG',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .orange.shade900,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'xA',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .orange.shade900,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Yellow cards',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .orange.shade900,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              numeric: true,
                                            ),
                                            DataColumn(
                                              label: Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Red cards',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .orange.shade900,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              numeric: true,
                                            ),
                                          ],
                                        ))))
                          ]));
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            future: fetchSquad()),
      ),
    );
  }
}

Future<List<Player>> fetchSquad() async {
  final response = await http.get(Uri.parse("http://10.0.2.2:5000/"));

  if (response.statusCode == 200) {
    List<Player> players = [];
    var updateObj = json.decode(json.decode(response.body!)) as List;
    // ignore: avoid_function_literals_in_foreach_calls
    updateObj.forEach((e) {
      players.add(Player.fromJson(e));
    });
    return players;
  } else {
    developer.log('Error, Could not load Data.');
    throw Exception('Failed to load Data');
  }
}
