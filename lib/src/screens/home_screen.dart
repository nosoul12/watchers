// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:watchers/src/widgets/movie_card.dart';
// // Import the movie card widget

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Watchers')),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 100,  // Added height constraint to SingleChildScrollView
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.generate(10, (index) {
//                   return Container(
//                     width: 100,
//                     margin: const EdgeInsets.all(8.0),
//                     color: Colors.blue,
//                     child: const Center(child: Text('Movie', style: TextStyle(color: Colors.white))),
//                   );
//                 }),
//               ),
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 childAspectRatio: 2 / 3,  // Adjust the aspect ratio as needed
//               ),
//               itemCount: 10,  // Dummy data count
//               itemBuilder: (context, index) {
//                 return MovieCard(
//                   title: 'Movie $index',
//                   imageUrl: 'https://via.placeholder.com/200x300',  // Dummy data image
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
