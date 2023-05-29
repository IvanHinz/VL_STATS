import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:football_app/league_page/league_players/abstract_player.dart';
import 'package:http/http.dart' as http;

import '../../features/colors/colors.dart';

class LeaguePlayers extends StatelessWidget {
  const LeaguePlayers({super.key});

  @override
  Widget build(BuildContext context) {
    String leagueName = (ModalRoute.of(context)?.settings.arguments) as String;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("$leagueName Players",
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
                                          dividerThickness: 0.5,
                                          border: TableBorder.all(
                                            width: 5.0,
                                            color: MainColors.cyan,
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
                                                          country.yellowCards
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
                                                          country.redCards
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
            future: fetchPlayer()),
      ),
    );
  }
}

Future<List<Player>> fetchPlayer() async {
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
