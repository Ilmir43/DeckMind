import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesNotifier extends AsyncNotifier<Set<String>> {
  FavoritesNotifier();

  static const _key = 'favorite_games';

  @override
  Future<Set<String>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    return ids.toSet();
  }

  Future<void> toggle(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final current = state.value ?? <String>{};
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    state = AsyncData({...current});
    await prefs.setStringList(_key, current.toList());
  }
}

final favoritesProvider = AsyncNotifierProvider<FavoritesNotifier, Set<String>>(() => FavoritesNotifier());
