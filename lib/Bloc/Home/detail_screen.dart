// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// //
// // class DetailScreen extends StatelessWidget {
// //   final String imageUrl;
// //   final String author;
// //   final String id;
// //
// //   const DetailScreen({
// //     super.key,
// //     required this.imageUrl,
// //     required this.author,
// //     required this.id,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: Stack(
// //         children: [
// //           Center(
// //             child: Hero(
// //               tag: "image_$id",
// //               child: InteractiveViewer(
// //                 child: Image.network(imageUrl, fit: BoxFit.contain),
// //               ),
// //             ),
// //           ),
// //           Positioned(
// //             top: 40,
// //             left: 20,
// //             child: CircleAvatar(
// //               backgroundColor: Colors.black54,
// //               child: IconButton(
// //                 icon: const Icon(Icons.arrow_back, color: Colors.white),
// //                 onPressed: () => Navigator.pop(context),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       bottomNavigationBar: Container(
// //         color: Colors.white,
// //         padding: const EdgeInsets.all(16),
// //         child: Text(
// //           "Captured by $author (ID: $id)",
// //           textAlign: TextAlign.center,
// //           style: GoogleFonts.montserrat(
// //             fontWeight: FontWeight.w500,
// //             fontSize: 16,
// //             color: Colors.black87,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class DetailScreen extends StatelessWidget {
//   final String imageUrl;
//   final String author;
//   final String id;
//
//   const DetailScreen({
//     super.key,
//     required this.imageUrl,
//     required this.author,
//     required this.id,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           Center(
//             child: Hero(
//               tag: "image_$id",
//               child: InteractiveViewer(
//                 child: Image.network(imageUrl, fit: BoxFit.contain),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 40,
//             left: 20,
//             child: CircleAvatar(
//               backgroundColor: Colors.black54,
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back, color: Colors.white),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         color: Colors.white,
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         child: Text(
//           "By $author (ID: $id)",
//           style: GoogleFonts.montserrat(
//             fontWeight: FontWeight.w500,
//             fontSize: 16,
//             color: Colors.black87,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
