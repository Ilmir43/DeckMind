import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/providers.dart';
import 'favorites_notifier.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);
    final gamesAsync = ref.watch(gamesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: favoritesAsync.when(
        data: (ids) {
          return gamesAsync.when(
            data: (games) {
              final filtered = games.where((g) => ids.contains(g.id)).toList();
              if (filtered.isEmpty) {
                return const Center(child: Text('Нет избранных игр'));
              }
              return ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final game = filtered[index];
                  return ListTile(
                    leading: const Icon(Icons.casino),
                    title: Text(game.name),
                    onTap: () => context.push('/game/${game.id}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => ref.read(favoritesProvider.notifier).toggle(game.id),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Ошибка: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Ошибка: $e')),
      ),
    );
  }
}
