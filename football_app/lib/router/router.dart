import '../league_page/league_view.dart';

final routes = {
  '/table_page': (context) => const LeagueTable(),
  '/players_page': (context) => const LeaguePlayers(),
  '/prediction_page': (context) => const PredictionPage(),
  '/squad_page': (context) => const TeamPlayers()
};
