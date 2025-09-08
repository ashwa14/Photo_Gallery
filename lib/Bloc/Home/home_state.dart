import 'package:equatable/equatable.dart';
import '../../assets/piscum_image.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<PicsumImage> images;
  final String? message;

  const HomeState({
    this.status = HomeStatus.initial,
    this.images = const [],
    this.message,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<PicsumImage>? images,
    String? message,
  }) {
    return HomeState(
      status: status ?? this.status,
      images: images ?? this.images,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, images, message];
}


//
// // import 'package:equatable/equatable.dart';
// //
// // class HomeState extends Equatable {
// //   final List<dynamic> images;
// //   final List<String> favorites;
// //   final bool isLoading;
// //
// //   const HomeState({
// //     this.images = const [],
// //     this.favorites = const [],
// //     this.isLoading = true,
// //   });
// //
// //   HomeState copyWith({
// //     List<dynamic>? images,
// //     List<String>? favorites,
// //     bool? isLoading,
// //   }) {
// //     return HomeState(
// //       images: images ?? this.images,
// //       favorites: favorites ?? this.favorites,
// //       isLoading: isLoading ?? this.isLoading,
// //     );
// //   }
// //
// //   @override
// //   List<Object> get props => [images, favorites, isLoading];
// // }
//
//
// import 'package:equatable/equatable.dart';
//
// class ImageItem {
//   final String id;
//   final String author;
//   final String imageUrl;
//   bool isFavorite;
//
//   ImageItem({
//     required this.id,
//     required this.author,
//     required this.imageUrl,
//     this.isFavorite = false,
//   });
// }
//
// abstract class HomeState extends Equatable {
//   const HomeState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class HomeLoading extends HomeState {}
//
// class HomeLoaded extends HomeState {
//   final List<ImageItem> images;
//
//   const HomeLoaded(this.images);
//
//   @override
//   List<Object?> get props => [images];
// }
//
// class HomeError extends HomeState {
//   final String message;
//
//   const HomeError(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
