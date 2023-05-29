import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const url = 'http://10.0.2.2:5000';

Future<void> postLeagueTable(BuildContext context, String description) async {
  Navigator.of(context).pushNamed('/table_page', arguments: description);

  // ignore: unused_local_variable
  final response =
      await http.post(Uri.parse(url), body: json.encode({'name': description}));
}

Future<void> postLeaguePlayers(BuildContext context, String description) async {
  Navigator.of(context).pushNamed('/players_page', arguments: description);

  // ignore: unused_local_variable
  final response = await http.post(Uri.parse(url),
      body: json.encode({'name': "${description}_"}));
}
