import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<dynamic> _images = [];
  bool _loading = true;
  int _page = 1;
  Set<String> _favoriteIds = {}; // Stores favorite image IDs
  bool _showFavoritesOnly = false; // Toggle to show only favorites

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages({bool refresh = false}) async {
    if (refresh) {
      setState(() {
        _page = 1;
        _images.clear();
        _loading = true;
      });
    }
    final url = Uri.parse("https://picsum.photos/v2/list?page=$_page&limit=15");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        if (refresh) {
          _images = json.decode(response.body);
        } else {
          _images.addAll(json.decode(response.body));
        }
        _loading = false;
        _page++;
      });
    } else {
      setState(() {
        _loading = false;
      });
      throw Exception("Failed to load images");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> displayImages = _showFavoritesOnly
        ? _images.where((img) => _favoriteIds.contains(img["id"])).toList()
        : _images;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          _showFavoritesOnly ? "Favorites" : "Photo Gallery",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(
              _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
              color: _showFavoritesOnly ? Colors.red : Colors.black54,
            ),
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
              });
            },
          )
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : displayImages.isEmpty
          ? Center(
        child: Text(
          _showFavoritesOnly
              ? "No favorites yet!"
              : "No images to display!",
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      )
          : RefreshIndicator(
        onRefresh: () => _fetchImages(refresh: true),
        child: GridView.builder(
          itemCount: displayImages.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
            MediaQuery.of(context).size.width > 600 ? 3 : 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final item = displayImages[index];
            final imageUrl = item["download_url"];
            final author = item["author"];
            final id = item["id"];

            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 400 + (index * 50)),
              curve: Curves.easeOutBack,
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) => Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Transform.translate(
                  offset: Offset(0, (1 - value) * 30),
                  child: child,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DetailScreen(
                      imageUrl: imageUrl,
                      author: author,
                      id: id,
                    ),
                  ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Hero(
                        tag: "image_$id",
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  author,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_favoriteIds.contains(id)) {
                                      _favoriteIds.remove(id);
                                    } else {
                                      _favoriteIds.add(id);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black45,
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  child: Icon(
                                    _favoriteIds.contains(id)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: _favoriteIds.contains(id)
                                        ? Colors.red
                                        : Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Detail page
class DetailScreen extends StatelessWidget {
  final String imageUrl;
  final String author;
  final String id;

  const DetailScreen({
    super.key,
    required this.imageUrl,
    required this.author,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: "image_$id",
              child: InteractiveViewer(
                child: Image.network(imageUrl, fit: BoxFit.contain),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Text(
          "By $author (ID: $id)",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:shimmer/shimmer.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import '../Home/detail_screen.dart';
// // import '../Home/home_bloc.dart';
// // import '../Home/home_event.dart';
// // import '../Home/home_state.dart';
// //
// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (_) => HomeBloc()..add(FetchImages()),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: Text(
// //             "Photo Gallery",
// //             style: GoogleFonts.montserrat(
// //               fontWeight: FontWeight.w600,
// //               color: Colors.black87,
// //             ),
// //           ),
// //           backgroundColor: Colors.white,
// //           centerTitle: true,
// //           elevation: 4,
// //         ),
// //         body: BlocBuilder<HomeBloc, HomeState>(
// //           builder: (context, state) {
// //             if (state.isLoading) {
// //               return GridView.builder(
// //                 padding: const EdgeInsets.all(12),
// //                 itemCount: 6,
// //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                   crossAxisCount: 2,
// //                   crossAxisSpacing: 12,
// //                   mainAxisSpacing: 12,
// //                   childAspectRatio: 0.75,
// //                 ),
// //                 itemBuilder: (context, index) => Shimmer.fromColors(
// //                   baseColor: Colors.grey[300]!,
// //                   highlightColor: Colors.grey[100]!,
// //                   child: Container(
// //                     color: Colors.white,
// //                     margin: const EdgeInsets.all(4),
// //                   ),
// //                 ),
// //               );
// //             }
// //             return RefreshIndicator(
// //               onRefresh: () async {
// //                 context.read<HomeBloc>().add(FetchImages());
// //               },
// //               child: GridView.builder(
// //                 padding: const EdgeInsets.all(12),
// //                 itemCount: state.images.length,
// //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                   crossAxisCount:
// //                   MediaQuery.of(context).size.width > 600 ? 3 : 2,
// //                   crossAxisSpacing: 12,
// //                   mainAxisSpacing: 12,
// //                   childAspectRatio: 0.75,
// //                 ),
// //                 itemBuilder: (context, index) {
// //                   final item = state.images[index];
// //                   final id = item['id'];
// //                   final url = item['download_url'];
// //                   final author = item['author'];
// //                   final isFav = state.favorites.contains(id);
// //
// //                   return GestureDetector(
// //                     onTap: () => Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (_) => DetailScreen(
// //                           imageUrl: url,
// //                           author: author,
// //                           id: id,
// //                         ),
// //                       ),
// //                     ),
// //                     child: Stack(
// //                       children: [
// //                         Hero(
// //                           tag: "image_$id",
// //                           child: ClipRRect(
// //                             borderRadius: BorderRadius.circular(16),
// //                             child: Image.network(url, fit: BoxFit.cover),
// //                           ),
// //                         ),
// //                         Positioned(
// //                           top: 8,
// //                           right: 8,
// //                           child: GestureDetector(
// //                             onTap: () {
// //                               context.read<HomeBloc>().add(ToggleFavorite(id));
// //                             },
// //                             child: Icon(
// //                               isFav ? Icons.favorite : Icons.favorite_border,
// //                               color: isFav ? Colors.red : Colors.white,
// //                               size: 28,
// //                             ),
// //                           ),
// //                         ),
// //                         Positioned(
// //                           bottom: 0,
// //                           left: 0,
// //                           right: 0,
// //                           child: Container(
// //                             padding: const EdgeInsets.all(6),
// //                             decoration: BoxDecoration(
// //                               gradient: LinearGradient(
// //                                 colors: [
// //                                   Colors.black.withOpacity(0.7),
// //                                   Colors.transparent
// //                                 ],
// //                                 begin: Alignment.bottomCenter,
// //                                 end: Alignment.topCenter,
// //                               ),
// //                               borderRadius: const BorderRadius.vertical(
// //                                   bottom: Radius.circular(16)),
// //                             ),
// //                             child: Text(
// //                               author,
// //                               style: GoogleFonts.montserrat(
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.w600,
// //                                 fontSize: 14,
// //                               ),
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../Home/home_bloc.dart';
// import '../Home/home_event.dart';
// import '../Home/home_state.dart';
// import '../widgets/image.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => HomeBloc()..add(FetchImages()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Photo Gallery"),
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black87,
//           elevation: 4,
//         ),
//         body: BlocBuilder<HomeBloc, HomeState>(
//           builder: (context, state) {
//             if (state is HomeLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is HomeError) {
//               return Center(child: Text(state.message));
//             } else if (state is HomeLoaded) {
//               final images = state.images;
//               return RefreshIndicator(
//                 onRefresh: () async => context.read<HomeBloc>().add(FetchImages()),
//                 child: GridView.builder(
//                   padding: const EdgeInsets.all(12),
//                   itemCount: images.length,
//                   physics: const BouncingScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     childAspectRatio: 0.75,
//                   ),
//                   itemBuilder: (context, index) {
//                     return ImageTile(image: images[index]);
//                   },
//                 ),
//               );
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
// }
