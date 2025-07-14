import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/favorites/favorites_screen.dart';
import 'features/game_detail/game_detail_screen.dart';
import 'features/game_list/game_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: DeckMindApp()));
}

class DeckMindApp extends ConsumerWidget {
  const DeckMindApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const GameListScreen(),
          routes: [
            GoRoute(
              path: 'game/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return GameDetailScreen(gameId: id);
              },
            ),
            GoRoute(
              path: 'favorites',
              builder: (_, __) => const FavoritesScreen(),
            ),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      title: 'DeckMind',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru'), Locale('en')],
    );
  }
}
