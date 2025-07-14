import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../core/models/game.dart';
import 'game_repository.dart';

class LocalGameRepository implements GameRepository {
  final String assetPath;

  LocalGameRepository({this.assetPath = 'assets/data/games.json'});

  @override
  Future<List<Game>> getGames() async {
    final data = await rootBundle.loadString(assetPath);
    final List<dynamic> jsonList = jsonDecode(data) as List<dynamic>;
    return jsonList.map((e) => Game.fromJson(e as Map<String, dynamic>)).toList();
  }
}
