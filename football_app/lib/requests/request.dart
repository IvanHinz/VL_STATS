import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const url = 'http://10.0.2.2:5000';

Future<void> postLeagueTable(BuildContext context, String description) async {
  Navigator.of(context).pushNamed('/table_page', arguments: description);

  await http.post(Uri.parse(url), body: json.encode({'name': description}));
}

Future<void> postLeaguePlayers(BuildContext context, String description) async {
  Navigator.of(context).pushNamed('/players_page', arguments: description);

  await http.post(Uri.parse(url),
      body: json.encode({'name': "${description}_"}));
}

void goToPrediction(BuildContext context, String description) {
  Navigator.of(context).pushNamed('/prediction_page', arguments: description);
}

Future<String> postPrediction(BuildContext context, String league,
    String firstTeam, String secondTeam) async {
  await http.post(Uri.parse(url),
      body: json.encode({'name': "${league}_${firstTeam}_${secondTeam}__"}));

  final response = await http.get(Uri.parse("http://10.0.2.2:5000/"));

  if (response.statusCode == 200) {
    String decodedResponse = json.decode(response.body) as String;
    // ignore: avoid_function_literals_in_foreach_calls
    return decodedResponse;
  } else {
    throw Exception('Failed to load Data');
  }
}
