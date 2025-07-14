import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/game.dart';
import 'game_repository.dart';
import 'local_game_repository.dart';

final gameRepositoryProvider = Provider<GameRepository>((ref) => LocalGameRepository());

final gamesProvider = FutureProvider<List<Game>>((ref) {
  final repo = ref.watch(gameRepositoryProvider);
  return repo.getGames();
});
