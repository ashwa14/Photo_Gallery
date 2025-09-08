import 'package:flutter_bloc/flutter_bloc.dart';
import '../../store/piscum.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PicsumRepository picsumRepository;

  HomeBloc({required this.picsumRepository}) : super(const HomeState()) {
    on<FetchImages>(_onFetchImages);
  }

  Future<void> _onFetchImages(FetchImages event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final images = await picsumRepository.fetchImages(limit: 10);
      emit(state.copyWith(status: HomeStatus.success, images: images));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, message: e.toString()));
    }
  }
}
//
//
//
// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'home_event.dart';
// import 'home_state.dart';
//
// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   HomeBloc() : super(const HomeState()) {
//     on<FetchImages>((event, emit) async {
//       emit(state.copyWith(isLoading: true));
//       try {
//         final url = Uri.parse("https://picsum.photos/v2/list?page=1&limit=20");
//         final response = await http.get(url);
//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//           emit(state.copyWith(images: data, isLoading: false));
//         } else {
//           emit(state.copyWith(isLoading: false));
//         }
//       } catch (_) {
//         emit(state.copyWith(isLoading: false));
//       }
//     });
//
//     on<ToggleFavorite>((event, emit) {
//       final updatedFavorites = List<String>.from(state.favorites);
//       if (updatedFavorites.contains(event.id)) {
//         updatedFavorites.remove(event.id);
//       } else {
//         updatedFavorites.add(event.id);
//       }
//       emit(state.copyWith(favorites: updatedFavorites));
//     });
//   }
// }


// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'home_event.dart';
// import 'home_state.dart';
// import 'package:http/http.dart' as http;
//
// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   HomeBloc() : super(HomeLoading()) {
//     on<FetchImages>(_onFetchImages);
//     on<ToggleFavorite>(_onToggleFavorite);
//   }
//
//   Future<void> _onFetchImages(FetchImages event, Emitter<HomeState> emit) async {
//     emit(HomeLoading());
//     try {
//       final url = Uri.parse("https://picsum.photos/v2/list?page=1&limit=15");
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         final images = data.map((e) => ImageItem(
//           id: e['id'],
//           author: e['author'],
//           imageUrl: e['download_url'],
//         )).toList();
//         emit(HomeLoaded(images));
//       } else {
//         emit(const HomeError("Failed to fetch images"));
//       }
//     } catch (e) {
//       emit(HomeError(e.toString()));
//     }
//   }
//
//   void _onToggleFavorite(ToggleFavorite event, Emitter<HomeState> emit) {
//     if (state is HomeLoaded) {
//       final currentState = state as HomeLoaded;
//       final images = currentState.images.map((image) {
//         if (image.id == event.id) {
//           return ImageItem(
//             id: image.id,
//             author: image.author,
//             imageUrl: image.imageUrl,
//             isFavorite: !image.isFavorite,
//           );
//         }
//         return image;
//       }).toList();
//       emit(HomeLoaded(images));
//     }
//   }
// }
