import 'package:flutter/material.dart';
import 'package:watchers/src/screens/search_screen.dart';

class Appt extends StatelessWidget {
  const Appt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Watcher'),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearBar(),
                  ));
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ))
      ],
    );
  }
}
