import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/providers.dart';
import '../favorites/favorites_notifier.dart';

class GameDetailScreen extends ConsumerWidget {
  final String gameId;

  const GameDetailScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesAsync = ref.watch(gamesProvider);
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(),
      body: gamesAsync.when(
        data: (games) {
          final game = games.firstWhere((g) => g.id == gameId);
          final isFav = favoritesAsync.value?.contains(gameId) ?? false;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const Icon(Icons.casino, size: 200),
                const SizedBox(height: 16),
                Text(game.name, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(game.description),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                  label: Text(isFav ? 'Убрать из избранного' : 'Добавить в избранное'),
                  onPressed: () async {
                    await ref.read(favoritesProvider.notifier).toggle(gameId);
                  },
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Ошибка: $e')),
      ),
    );
  }
}
