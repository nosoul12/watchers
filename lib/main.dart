import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchers/src/providers/watchlist_provider.dart';
import 'package:watchers/src/screens/home_screen.dart';
import 'package:watchers/src/screens/splash_screen.dart';

import 'package:watchers/src/widgets/bottom_nav_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WatchlistProvider()),
      ],
      child: const WatcherApp(),
    ),
  );
}

class WatcherApp extends StatelessWidget {
  const WatcherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Watcher',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: HomePage(),
    );
  }
}
