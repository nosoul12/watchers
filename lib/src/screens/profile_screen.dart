import 'package:flutter/material.dart';
import 'package:watchers/src/screens/fav_screen.dart';
import 'package:watchers/src/screens/watchlist_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String userId;

  const ProfileScreen({
    required this.username,
    required this.email,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Row(
        children: [
          // Left Half - Watchlist, Favorites, Suggested
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profileHeader(),
                  SizedBox(height: 20),
                  _sectionHeader("📚 Watchlist", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => WatchlistScreen()),
                    );
                  }),
                  _horizontalListPlaceholder(),
                  SizedBox(height: 20),
                  _sectionHeader("❤️ Favorites", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FavScreen()),
                    );
                  }),
                  _horizontalListPlaceholder(),
                  SizedBox(height: 20),
                  _sectionHeader("🎬 Suggested", () {}),
                  _horizontalListPlaceholder(),
                ],
              ),
            ),
          ),

          // Right Half - Analytics
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: const Color.fromARGB(255, 5, 13, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("📈 Your Analytics",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  _analyticsCard("🎯 Favorite Genres", "Horror, Action"),
                  _analyticsCard("⏳ Watchlist Remaining", "5 movies"),
                  _analyticsCard("🎞️ Movies Watched", "10 this month"),
                  _analyticsCard("🕒 Watch Time", "24 hours"),
                  _analyticsCard("🧠 Your Taste", "Thrilling, Fast-paced"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileHeader() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.deepPurple.shade100,
              child: Text(
                username.substring(0, 1).toUpperCase(),
                style: TextStyle(fontSize: 32, color: Colors.deepPurple),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(email, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        TextButton(onPressed: onTap, child: Text("View All"))
      ],
    );
  }

  Widget _horizontalListPlaceholder() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, index) => Container(
          width: 120,
          margin: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
          ),
          child: Center(
              child: Icon(Icons.movie, size: 48, color: Colors.grey[600])),
        ),
      ),
    );
  }

  Widget _analyticsCard(String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: Icon(Icons.insights, color: Colors.deepPurple),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
