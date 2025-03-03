import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:watchers/src/screens/auth_Screen.dart';
import 'package:watchers/src/screens/search_screen.dart';
import 'package:watchers/src/screens/watchlist_screen.dart';
import 'package:watchers/src/screens/fav_screen.dart';

class Appt extends StatelessWidget implements PreferredSizeWidget {
  Appt({super.key});

  FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<bool> _isUserLoggedIn() async {
    String? token = await _storage.read(key: "token");
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isUserLoggedIn(),
      builder: (context, snapshot) {
        bool isLoggedIn = snapshot.data ?? false;

        return AppBar(
          backgroundColor: Colors.black,
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Trending Movies',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('🔥', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
          actions: [
            if (isLoggedIn) ...[
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WatchlistScreen()),
                  );
                },
                icon: Icon(Icons.list, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FavScreen()),
                  );
                },
                icon: Icon(Icons.favorite, color: Colors.white),
              ),
              IconButton(
                onPressed: () async {
                  await _storage.delete(key: "token");
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                  );
                },
                icon: Icon(Icons.logout, color: Colors.white),
              ),
            ] else ...[
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                  );
                },
                icon: Icon(Icons.account_circle_outlined, color: Colors.white),
              ),
            ],
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
