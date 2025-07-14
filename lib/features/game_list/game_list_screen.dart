import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/providers.dart';
import '../favorites/favorites_notifier.dart';
import 'package:go_router/go_router.dart';

class GameListScreen extends ConsumerStatefulWidget {
  const GameListScreen({super.key});

  @override
  ConsumerState<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends ConsumerState<GameListScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final gamesAsync = ref.watch(gamesProvider);
    final favoritesAsync = ref.watch(favoritesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Игры'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.push('/favorites'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Поиск',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => query = value.toLowerCase()),
            ),
          ),
          Expanded(
            child: gamesAsync.when(
              data: (games) {
                final filtered = games
                    .where((g) => g.name.toLowerCase().contains(query))
                    .toList();
                final favorites = favoritesAsync.value ?? <String>{};
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final game = filtered[index];
                    final fav = favorites.contains(game.id);
                    return ListTile(
                      leading: const Icon(Icons.casino),
                      title: Text(game.name),
                      subtitle: Text(game.shortDescription),
                      trailing: Icon(
                        fav ? Icons.favorite : Icons.favorite_border,
                        color: fav ? Colors.red : null,
                      ),
                      onTap: () => context.push('/game/${game.id}'),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Ошибка: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
