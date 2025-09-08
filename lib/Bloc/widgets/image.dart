import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../assets/piscum_image.dart';

class ImageCell extends StatelessWidget {
  final PicsumImage image;

  const ImageCell({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    // compute aspect ratio from server-provided width/height
    final aspect = image.width > 0 && image.height > 0
        ? image.width / image.height
        : 16 / 9;

    // We'll display image to match screen width, height computed from aspect ratio
    final screenWidth = MediaQuery.of(context).size.width;
    final displayHeight = screenWidth / aspect;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          SizedBox(
            width: double.infinity,
            height: displayHeight,
            child: CachedNetworkImage(
              imageUrl: image.downloadUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: displayHeight,
              placeholder: (context, url) => Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Container(
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, size: 48),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Text(
              'Photo by ${image.author}',
              style: const TextStyle(
                fontWeight: FontWeight.w600, // semi-bold
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Text(
              'ID: ${image.id} • Original ${image.width}x${image.height}',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}


//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../Home/detail_screen.dart';
// import '../Home/home_bloc.dart';
// import '../Home/home_event.dart';
// import '../Home/home_state.dart';
//
// class ImageTile extends StatelessWidget {
//   final ImageItem image;
//
//   const ImageTile({super.key, required this.image});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (_) => DetailScreen(
//             imageUrl: image.imageUrl,
//             author: image.author,
//             id: image.id,
//           ),
//         ));
//       },
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: Stack(
//           children: [
//             Hero(
//               tag: "image_${image.id}",
//               child: Image.network(
//                 image.imageUrl,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: double.infinity,
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 padding: const EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.black.withOpacity(0.7), Colors.transparent],
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       child: Text(
//                         image.author,
//                         style: GoogleFonts.montserrat(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         image.isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: Colors.redAccent,
//                       ),
//                       onPressed: () {
//                         context.read<HomeBloc>().add(ToggleFavorite(image.id));
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
